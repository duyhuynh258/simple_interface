import 'package:simple_interface/challenge/domain/challenge.dart';

abstract class ChallengeStorage {
  Future<Challenge?> read();

  Future<void> save(Challenge challenge);

  Future<void> clear();
}
