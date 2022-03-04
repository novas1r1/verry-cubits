import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verry_cubits/data/models/goal.dart';
import 'package:verry_cubits/data/repositories/goal_repository.dart';
import 'package:verry_cubits/screens/goal_list/cubit/goal_list_cubit.dart';

class MockGoalRepository extends Mock implements GoalRepository {}

void main() {
  late MockGoalRepository mockGoalRepository;
  late GoalListCubit goalListCubit;

  setUp(() {
    mockGoalRepository = MockGoalRepository();
    goalListCubit = GoalListCubit(goalRepository: mockGoalRepository);
  });

  group('fetchGoals()', () {
    const List<Goal> tGoals = [
      Goal(title: 'Goal 1', description: 'Description 1'),
      Goal(title: 'Goal 2', description: 'Description 2'),
      Goal(title: 'Goal 3', description: 'Description 3'),
    ];

    final Exception tException = Exception('Failed to fetch goals.');

    blocTest<GoalListCubit, GoalListState>(
      'emits [GoalListStatus.loading, GoalListStatus.success] when '
      'fetchGoals() is called successfully.',
      setUp: () => when(() => mockGoalRepository.fetchGoals())
          .thenAnswer((_) async => tGoals),
      build: () => goalListCubit,
      act: (cubit) => cubit.fetchGoals(),
      expect: () => <GoalListState>[
        const GoalListState(status: GoalListStatus.loading),
        const GoalListState(
          status: GoalListStatus.success,
          goals: tGoals,
        ),
      ],
      verify: (_) async {
        verify(() => mockGoalRepository.fetchGoals()).called(1);
      },
    );

    blocTest<GoalListCubit, GoalListState>(
      'emits [GoalListStatus.loading, GoalListStatus.failure] when '
      'fetchGoals() failed.',
      setUp: () =>
          when(() => mockGoalRepository.fetchGoals()).thenThrow(tException),
      build: () => goalListCubit,
      act: (cubit) => cubit.fetchGoals(),
      expect: () => <GoalListState>[
        const GoalListState(status: GoalListStatus.loading),
        GoalListState(status: GoalListStatus.failure, exception: tException),
      ],
      verify: (_) async {
        verify(() => mockGoalRepository.fetchGoals()).called(1);
      },
    );
  });
}
