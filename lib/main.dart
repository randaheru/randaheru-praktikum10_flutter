import 'package:flutter/material.dart';
import './views/plan_screen.dart';
import './models/data_layer.dart';
import './provider/plan_provider.dart';

void main() => runApp(const MasterPlanApp());

// Widget utama (tetap)
class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: PlanProvider(
        notifier: ValueNotifier<Plan>(const Plan()),
        child: const PlanScreen(),
      ),
    );
  }
}

// Alias untuk kompatibilitas dengan test yang menunggu MyApp
class MyApp extends MasterPlanApp {
  const MyApp({super.key});
}
