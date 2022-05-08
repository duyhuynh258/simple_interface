import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_interface/challenge/domain/challenge.dart';
import 'package:simple_interface/challenge/domain/challenge_failure.dart';
import 'package:simple_interface/challenge/infrastructure/challenge_repository.dart';

part 'challenge_state.dart';

class ChallengeCubit extends Cubit<ChallengeState> {
  ChallengeCubit(this._challengeRepository) : super(const ChallengeInitial());

  final ChallengeRepository _challengeRepository;

  Challenge? get _freshChallenge => (state as ChallengeLoaded?)?.freshChallenge;

  Challenge? get _modifiedChallenge =>
      (state as ChallengeLoaded?)?.freshChallenge;

  void onChallengeDescriptionUpdate(String description) {
    if (_modifiedChallenge?.description == description) {
      // Not changed
      return;
    }
    emit(
      ChallengeLoaded(
        freshChallenge: _freshChallenge,
        modifiedChallenge: Challenge(
          description: description,
        ),
      ),
    );
  }

  Future<void> onRead() async {
    final modifiedChallenge = _modifiedChallenge;
    final freshChallenge = _freshChallenge;
    emit(ChallengeInProgress(challenge: modifiedChallenge));

    final failureOrChallenge = await _challengeRepository.getChallenge();

    failureOrChallenge.fold((ChallengeFailure failure) {
      // Failure
      emit(
        ChallengeLoaded(
          freshChallenge: freshChallenge,
          modifiedChallenge: modifiedChallenge,
          failure: failure,
        ),
      );
    }, (Challenge challenge) {
      // Success
      emit(ChallengeLoaded(freshChallenge: challenge));
    });
  }

  /// When user click write button.
  Future<void> onWrite() async {
    if (_modifiedChallenge == null) {
      _emitFailure(const ChallengeInvalidToWrite());
      return;
    }

    final challengeToWrite = _modifiedChallenge!;

    final writeFailureOrSuccess =
        await _challengeRepository.saveChallenge(challengeToWrite);

    writeFailureOrSuccess.fold((ChallengeFailure failure) {
      _emitFailure(failure);
    }, (_) {
      emit(
        ChallengeLoaded(
          freshChallenge: challengeToWrite,
        ),
      );
    });
  }

  void _emitFailure(ChallengeFailure failure) {
    if (state is ChallengeInitial) {
      emit((state as ChallengeInitial).copyWith(failure: failure));
    } else if (state is ChallengeLoaded) {
      emit((state as ChallengeLoaded).copyWith(failure: failure));
    }
  }
}
