import 'package:dartz/dartz.dart';
import 'package:simple_interface/do_challenge/domain/challenge.dart';
import 'package:simple_interface/do_challenge/domain/challenge_failure.dart';

class ChallengeRepository {
  /// Get the challenge.
  ///
  /// Return [Challenge] if success otherwise [ChallengeFailure].
  Future<Either<ChallengeFailure, Challenge>> getChallenge() {}

  // Save the challenge.
  ///
  /// Return [Unit] if success otherwise [ChallengeFailure].
  Future<Either<ChallengeFailure, Unit>> saveChallenge(Challenge challenge) {}
}
