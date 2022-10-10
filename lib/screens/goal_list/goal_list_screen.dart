import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verry_cubits/data/repositories/goal_repository.dart';
import 'package:verry_cubits/screens/goal_list/cubit/goal_list_cubit.dart';

class GoalListScreen extends StatelessWidget {
  const GoalListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GoalListCubit(
          goalRepository: RepositoryProvider.of<GoalRepository>(context))
        ..fetchGoals(),
      child: const GoalListView(),
    );
  }
}

class GoalListView extends StatelessWidget {
  const GoalListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goal List')),
      body: BlocConsumer<GoalListCubit, GoalListState>(
        listener: (context, state) {
          if (state.status == GoalListStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Goals successfully refreshed')),
            );
          } else if (state.status == GoalListStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${state.exception}')),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<GoalListCubit, GoalListState>(
            builder: (context, state) {
              switch (state.status) {
                case GoalListStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case GoalListStatus.initial:
                case GoalListStatus.success:
                case GoalListStatus.failure:
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    itemCount: state.goals.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(state.goals[index].title),
                      subtitle: Text(state.goals[index].description),
                    ),
                  );
              }
            },
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.refresh),
            onPressed: () => context.read<GoalListCubit>().fetchGoals(),
          ),
        ],
      ),
    );
  }
}
