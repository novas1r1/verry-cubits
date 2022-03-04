import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verry_cubits/data/models/goal.dart';
import 'package:verry_cubits/data/repositories/goal_repository.dart';

part 'goal_list_state.dart';

class GoalListCubit extends Cubit<GoalListState> {
  final GoalRepository goalRepository;

  GoalListCubit({required this.goalRepository}) : super(const GoalListState());

  Future<void> fetchGoals() async {
    emit(state.copyWith(status: GoalListStatus.loading));

    try {
      final goalList = await goalRepository.fetchGoals();
      emit(
        state.copyWith(
          status: GoalListStatus.success,
          goals: goalList,
        ),
      );
    } on Exception catch (exception) {
      emit(
        state.copyWith(
          status: GoalListStatus.failure,
          exception: exception,
        ),
      );
    }
  }
}
