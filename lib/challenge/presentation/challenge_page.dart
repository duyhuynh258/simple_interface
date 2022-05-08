import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interface/challenge/application/challenge_cubit.dart';
import 'package:simple_interface/challenge/domain/challenge_failure.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({Key? key}) : super(key: key);

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ChallengeCubit, ChallengeState>(
          listener: (BuildContext context, ChallengeState state) {
            if (state is ChallengeInitial) {
              //Clean the text box
              _textEditingController.text = '';
            }

            if (state is ChallengeLoaded &&
                state.isFresh &&
                _textEditingController.text !=
                    state.freshChallenge?.description) {
              //Load the challenge.
              _textEditingController.text =
                  state.freshChallenge?.description ?? '';
            }

            if (state.failure is ChallengeNotFound) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ChallengeNotFound')));
            }
            if (state.failure is StorageFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('StorageFailure')));
            }
            if (state.failure is ChallengeInvalidToWrite) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ChallengeInvalidToWrite')));
            }
          },
          builder: (BuildContext context, ChallengeState state) {
            return Wrap(
              direction: Axis.vertical,
              spacing: 20,
              children: [
                const Text('Flutter challenge'),
                TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                      hintText: 'Challenge description...'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  onChanged: (String? text) {
                    if (text == null) {
                      return;
                    }
                    context
                        .read<ChallengeCubit>()
                        .onChallengeDescriptionUpdate(text);
                  },
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<ChallengeCubit>().onRead();
                      },
                      child: const Text('Read'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: state.isWritable
                          ? () {
                              context.read<ChallengeCubit>().onWrite();
                            }
                          : null,
                      child: const Text('Write'),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
