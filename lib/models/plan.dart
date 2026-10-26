import './task.dart';

/// Model satu rencana yang berisi daftar tugas.
class Plan {
  final String name;
  final List<Task> tasks;

  const Plan({this.name = '', this.tasks = const []});

  /// Jumlah tugas yang sudah selesai.
  int get completedCount => tasks.where((task) => task.complete).length;

  /// Pesan progres, contoh: "1 out of 3 tasks".
  String get completenessMessage => '$completedCount out of ${tasks.length} tasks';
}