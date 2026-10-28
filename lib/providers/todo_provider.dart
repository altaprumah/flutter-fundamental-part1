import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Model satu tugas. Immutable: ubah lewat copyWith, bukan mengganti field.
class Todo {
  Todo(this.title, {this.done = false});

  final String title;
  final bool done;

  Todo copyWith({String? title, bool? done}) =>
      Todo(title ?? this.title, done: done ?? this.done);
}

/// Notifier yang menyimpan dan mengubah daftar tugas.
class TodoListNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => const []; // state awal: daftar kosong

  // Setiap method membuat list BARU agar Riverpod mendeteksi perubahan.
  // Jangan pernah memakai state.add(...) atau mengubah isi list langsung.
  void add(String title) => state = [...state, Todo(title)];

  void toggle(int index) {
    final todos = [...state];
    todos[index] = todos[index].copyWith(done: !todos[index].done);
    state = todos;
  }

  void remove(int index) => state = [...state]..removeAt(index);
}

final todoListProvider =
    NotifierProvider<TodoListNotifier, List<Todo>>(TodoListNotifier.new);