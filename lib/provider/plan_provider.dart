import 'package:flutter/material.dart';
import '../models/data_layer.dart';

/// InheritedNotifier: menyimpan ValueNotifier<Plan> di atas widget tree dan
/// otomatis membangun ulang widget turunan yang bergantung padanya
/// setiap kali nilai notifier berubah.
class PlanProvider extends InheritedNotifier<ValueNotifier<Plan>> {
  const PlanProvider({
    super.key,
    required Widget child,
    required ValueNotifier<Plan> notifier,
  }) : super(child: child, notifier: notifier);

  /// Mengambil notifier terdekat dari widget tree.
  static ValueNotifier<Plan> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PlanProvider>()!
        .notifier!;
  }
}