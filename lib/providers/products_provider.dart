import 'package:flutter_riverpod/flutter_riverpod.dart';

/// AsyncNotifier: state-nya bertipe AsyncValue<List<String>> yang otomatis
/// mewakili tiga kondisi: loading, error, dan data (success).
class ProductsNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    // Simulasi pemanggilan jaringan selama 2 detik.
    await Future.delayed(const Duration(seconds: 2));
    return ['Keyboard', 'Mouse', 'Monitor'];
  }

  /// Memuat ulang data. State dipindah ke loading dulu, lalu hasilnya
  /// dibungkus AsyncValue.guard supaya exception otomatis menjadi AsyncError.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<List<String>> _fetch() async {
    await Future.delayed(const Duration(seconds: 1));
    return ['Keyboard', 'Mouse', 'Monitor', 'Headset'];
  }
}

final productsProvider =
    AsyncNotifierProvider<ProductsNotifier, List<String>>(
        ProductsNotifier.new);