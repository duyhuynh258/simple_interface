import 'package:simple_interface/do_challenge/domain/challenge.dart';

abstract class ChallengeStorage {
  Future<Challenge?> read();

  Future<void> save(Challenge challenge);

  Future<void> clear();
}
