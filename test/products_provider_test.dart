import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pml/providers/products_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() => container = ProviderContainer());
  tearDown(() => container.dispose());

  test('awalnya loading, lalu success berisi 3 produk', () async {
    // Segera setelah dibaca, state masih loading.
    expect(container.read(productsProvider).isLoading, isTrue);

    final products = await container.read(productsProvider.future);
    expect(products, ['Keyboard', 'Mouse', 'Monitor']);
    expect(container.read(productsProvider).hasValue, isTrue);
  });

  test('refresh memuat ulang dan menghasilkan 4 produk', () async {
    await container.read(productsProvider.future);

    final refreshing = container.read(productsProvider.notifier).refresh();
    expect(container.read(productsProvider).isLoading, isTrue);
    await refreshing;

    final state = container.read(productsProvider);
    expect(state.hasValue, isTrue);
    expect(state.requireValue, ['Keyboard', 'Mouse', 'Monitor', 'Headset']);
  });
}