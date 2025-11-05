import 'package:flutter/material.dart';
import './views/plan_screen.dart';
import './views/plan_creator_screen.dart';
import './models/data_layer.dart';
import './provider/plan_provider.dart';


void main() => runApp(const MasterPlanApp());

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlanProvider(
      notifier: ValueNotifier<List<Plan>>([]), // List kosong awal
      child: MaterialApp(
        title: 'State management app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PlanCreatorScreen(),
      ),
    );
  }
}

// Alias untuk kompatibilitas test
class MyApp extends MasterPlanApp {
  const MyApp({super.key});
}
