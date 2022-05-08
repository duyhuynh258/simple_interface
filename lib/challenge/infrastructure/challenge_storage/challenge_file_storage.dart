import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:simple_interface/challenge/domain/challenge.dart';
import 'package:simple_interface/challenge/infrastructure/challenge_storage/challenge_storage.dart';

class ChallengeFileStorage implements ChallengeStorage {
  static const String _challengePath = 'a.txt';

  Future<String> get _documentsDirectoryPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _challengeFile async {
    final String documentsDirectoryPath = await _documentsDirectoryPath;
    return File('$documentsDirectoryPath/$_challengePath');
  }

  @override
  Future<void> clear() async {
    final file = await _challengeFile;
    await file.delete();
  }

  @override
  Future<Challenge?> read() async {
    final File file = await _challengeFile;
    final String contents = await file.readAsString();
    if (contents.isEmpty) {
      return null;
    }
    return Challenge(description: contents);
  }

  @override
  Future<void> save(Challenge challenge) async {
    final file = await _challengeFile;
    await file.writeAsString(challenge.description);
  }
}
