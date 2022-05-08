import 'package:dartz/dartz.dart';
import 'package:simple_interface/challenge/domain/challenge.dart';
import 'package:simple_interface/challenge/domain/challenge_failure.dart';
import 'package:simple_interface/challenge/infrastructure/challenge_storage/challenge_storage.dart';

class ChallengeRepository {
  ChallengeRepository(this._challengeStorage);

  /// Service to get challenge from internal storage.
  final ChallengeStorage _challengeStorage;

  /// Get the challenge.
  ///
  /// Return [Challenge] if success otherwise [ChallengeFailure].
  Future<Either<ChallengeFailure, Challenge>> getChallenge() async {
    try {
      final Challenge? challenge = await _challengeStorage.read();
      if (challenge == null) {
        return left(const ChallengeNotFound());
      }
      return right(challenge);
    } catch (e) {
      return left(const StorageFailure());
    }
  }

  // Save the challenge.
  ///
  /// Return [Unit] if success otherwise [ChallengeFailure].
  Future<Either<ChallengeFailure, Unit>> saveChallenge(
      Challenge challenge) async {
    try {
      _challengeStorage.save(challenge);
      return right(unit);
    } catch (e) {
      return left(const StorageFailure());
    }
  }
}
