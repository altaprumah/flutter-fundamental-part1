import './task.dart';

/// Model satu rencana yang berisi daftar tugas.
class Plan {
  final String name;
  final List<Task> tasks;

  const Plan({this.name = '', this.tasks = const []});
}