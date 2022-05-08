part of 'challenge_cubit.dart';

abstract class ChallengeState extends Equatable {
  const ChallengeState({
    this.failure,
  });

  final ChallengeFailure? failure;

  bool get isWritable {
    return !(this is ChallengeInitial || this is ChallengeInProgress);
  }

  @override
  List<Object?> get props => [failure];
}

class ChallengeInitial extends ChallengeState {
  const ChallengeInitial({ChallengeFailure? failure}) : super(failure: failure);

  ChallengeInitial copyWith({
    ChallengeFailure? failure,
  }) {
    return ChallengeInitial(
      failure: failure ?? this.failure,
    );
  }
}

class ChallengeInProgress extends ChallengeState {
  const ChallengeInProgress({this.challenge});

  /// The challenge that user see on UI before IO operations occur.
  final Challenge? challenge;
}

class ChallengeLoaded extends ChallengeState {
  const ChallengeLoaded({
    this.modifiedChallenge,
    this.freshChallenge,
    ChallengeFailure? failure,
  }) : super(failure: failure);

  /// Challenge that load from datasource.
  final Challenge? freshChallenge;

  /// Draft challenge that users are editing.
  final Challenge? modifiedChallenge;

  @override
  List<Object?> get props => [freshChallenge, modifiedChallenge, super.props];

  /// Check if [modifiedChallenge] is different with fresh challenge or not.
  ///
  /// Only execute write operation if different.
  @override
  bool get isWritable {
    if (failure != null && failure is ChallengeInvalidToWrite) {
      return false;
    }

    return super.isWritable &&
        modifiedChallenge != null &&
        modifiedChallenge!.description != freshChallenge?.description;
  }

  bool get isFresh {
    return modifiedChallenge == null;
  }

  ChallengeLoaded copyWith({
    Challenge? freshChallenge,
    Challenge? modifiedChallenge,
    ChallengeFailure? failure,
  }) {
    return ChallengeLoaded(
      freshChallenge: freshChallenge ?? this.freshChallenge,
      modifiedChallenge: modifiedChallenge ?? this.modifiedChallenge,
      failure: failure ?? this.failure,
    );
  }
}
