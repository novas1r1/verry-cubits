import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verry_cubits/data/repositories/goal_repository.dart';
import 'package:verry_cubits/screens/goal_list/goal_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => GoalRepository(),
      child: MaterialApp(
        title: 'Verry Cubits',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const GoalListScreen(),
      ),
    );
  }
}
