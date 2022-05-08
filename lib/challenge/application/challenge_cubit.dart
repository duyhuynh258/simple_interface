import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_interface/challenge/domain/challenge.dart';

part 'challenge_state.dart';

class ChallengeCubit extends Cubit<ChallengeState> {
  ChallengeCubit() : super(ChallengeInitial());
}
