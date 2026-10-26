/// Model satu tugas. Immutable: nilai tidak diubah, tapi diganti objek baru.
class Task {
  final String description;
  final bool complete;

  const Task({
    this.complete = false,
    this.description = '',
  });
}