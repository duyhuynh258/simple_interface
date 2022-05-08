import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interface/challenge/application/challenge_cubit.dart';
import 'package:simple_interface/challenge/challenge.dart';
import 'package:simple_interface/challenge/infrastructure/challenge_repository.dart';
import 'package:simple_interface/challenge/infrastructure/challenge_storage/challenge_file_storage.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (BuildContext context) =>
              ChallengeCubit(ChallengeRepository(ChallengeFileStorage())),
          child: const ChallengePage()),
    );
  }
}
