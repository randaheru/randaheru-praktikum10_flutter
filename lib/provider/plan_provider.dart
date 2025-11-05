import 'package:flutter/material.dart';
import '../models/data_layer.dart';

class PlanProvider extends InheritedNotifier<ValueNotifier<List<Plan>>> {
  const PlanProvider({
    super.key,
    required Widget child,
    required ValueNotifier<List<Plan>> notifier,
  }) : super(child: child, notifier: notifier);

  // Method untuk mengakses List<Plan> dari context
  static ValueNotifier<List<Plan>> of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    assert(provider != null, 'Tidak ada PlanProvider di context');
    return provider!.notifier!;
  }
}
