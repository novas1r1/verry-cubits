import 'package:verry_cubits/data/models/goal.dart';

class GoalRepository {
  // Returns a mocked list of goals. This could only be the place where
  // you would fetch data from an API.
  Future<List<Goal>> fetchGoals() async {
    // simulate exception
    //throw Exception('Error while fetching goals');

    return [
      const Goal(title: 'Goal 1', description: 'Description 1'),
      const Goal(title: 'Goal 2', description: 'Description 2'),
      const Goal(title: 'Goal 3', description: 'Description 3'),
      const Goal(title: 'Goal 4', description: 'Description 4'),
      const Goal(title: 'Goal 5', description: 'Description 5'),
    ];
  }
}
