import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:simple_interface/do_challenge/domain/challenge.dart';
import 'package:simple_interface/do_challenge/infrastructure/challenge_storage/challenge_storage.dart';

class ChallengeFileStorage implements ChallengeStorage {
  static const String _challengePath = 'a.txt';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_challengePath');
  }

  @override
  Future<void> clear() async {
    final file = await _localFile;
    await file.delete();
  }

  @override
  Future<Challenge?> read() async {
    try {
      final file = await _localFile;
      final String contents = await file.readAsString();
      return Challenge(description: contents);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> save(Challenge challenge) async {
    final file = await _localFile;
    await file.writeAsString(challenge.description);
  }
}
