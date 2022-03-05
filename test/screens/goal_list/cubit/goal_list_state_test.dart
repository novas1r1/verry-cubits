import 'package:flutter_test/flutter_test.dart';
import 'package:verry_cubits/data/models/goal.dart';
import 'package:verry_cubits/screens/goal_list/cubit/goal_list_cubit.dart';

void main() {
  test('initial state is correct', () {
    const initialState = GoalListState();
    expect(initialState.status, GoalListStatus.initial);
  });

  test('copyWith works', () {
    const initialState = GoalListState();
    final tException = Exception('Test');
    const tGoalList = [
      Goal(title: 'Goal 1', description: "Goal 1 description"),
      Goal(title: 'Goal 2', description: "Goal 2 description"),
    ];

    final state = initialState.copyWith(
      status: GoalListStatus.success,
      goals: tGoalList,
      exception: tException,
    );

    expect(
      state,
      GoalListState(
        status: GoalListStatus.success,
        goals: tGoalList,
        exception: tException,
      ),
    );
  });
}
