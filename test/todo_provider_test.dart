import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pml/providers/todo_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() => container = ProviderContainer());
  tearDown(() => container.dispose());

  test('state awal berupa daftar kosong', () {
    expect(container.read(todoListProvider), isEmpty);
  });

  test('add menambah tugas baru yang belum selesai', () {
    container.read(todoListProvider.notifier).add('Belajar Riverpod');

    final todos = container.read(todoListProvider);
    expect(todos.length, 1);
    expect(todos.first.title, 'Belajar Riverpod');
    expect(todos.first.done, isFalse);
  });

  test('toggle membalik status selesai', () {
    final notifier = container.read(todoListProvider.notifier);
    notifier.add('A');

    notifier.toggle(0);
    expect(container.read(todoListProvider).first.done, isTrue);

    notifier.toggle(0);
    expect(container.read(todoListProvider).first.done, isFalse);
  });

  test('remove menghapus tugas pada index tertentu', () {
    final notifier = container.read(todoListProvider.notifier);
    notifier
      ..add('A')
      ..add('B');

    notifier.remove(0);

    final todos = container.read(todoListProvider);
    expect(todos.length, 1);
    expect(todos.first.title, 'B');
  });

  test('state immutable: setiap perubahan menghasilkan list baru', () {
    final notifier = container.read(todoListProvider.notifier);
    notifier.add('A');
    final before = container.read(todoListProvider);

    notifier.add('B');
    final after = container.read(todoListProvider);

    expect(identical(before, after), isFalse);
    expect(before.length, 1); // list lama tidak ikut berubah
    expect(after.length, 2);
  });
}