import 'package:equatable/equatable.dart';

class Goal extends Equatable {
  final String title;
  final String description;

  const Goal({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}
