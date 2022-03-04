part of 'goal_list_cubit.dart';

enum GoalListStatus { initial, loading, success, failure }

class GoalListState extends Equatable {
  final GoalListStatus status;
  final List<Goal> goals;
  final Exception? exception;

  const GoalListState({
    this.status = GoalListStatus.initial,
    this.goals = const [],
    this.exception,
  });

  GoalListState copyWith({
    GoalListStatus? status,
    List<Goal>? goals,
    Exception? exception,
  }) {
    return GoalListState(
      status: status ?? this.status,
      goals: goals ?? this.goals,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [status, goals, exception];
}
