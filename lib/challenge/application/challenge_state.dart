part of 'challenge_cubit.dart';

abstract class ChallengeState extends Equatable {
  const ChallengeState({
    this.modifiedChallenge,
    this.freshChallenge,
  });

  /// Challenge that load from datasource.
  final Challenge? freshChallenge;

  /// Draft challenge that users are editing.
  final Challenge? modifiedChallenge;

  @override
  List<Object?> get props => [freshChallenge, modifiedChallenge];
}

class ChallengeInitial extends ChallengeState {}

class ChallengeInProgress extends ChallengeState {}

class ChallengeFresh extends ChallengeState {
  const ChallengeFresh(Challenge freshChallenge)
      : super(freshChallenge: freshChallenge);
}

class ChallengeModified extends ChallengeState {
  const ChallengeModified(Challenge modifiedChallenge, Challenge freshChallenge)
      : super(
            freshChallenge: freshChallenge,
            modifiedChallenge: modifiedChallenge);
}
