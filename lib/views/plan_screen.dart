import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import '../provider/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan; // Plan yang ingin ditampilkan
  const PlanScreen({super.key, required this.plan});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;
  late Plan _plan;

  // Getter untuk akses plan
  Plan get plan => _plan;

  @override
  void initState() {
    super.initState();
    _plan = widget.plan; // inisialisasi plan lokal
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(_plan.name)),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          // Ambil plan yang sesuai
          Plan currentPlan =
              plans.firstWhere((p) => p.name == _plan.name, orElse: () => _plan);

          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    currentPlan.completenessMessage,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  Widget _buildList(Plan currentPlan) {
    return ListView.builder(
      controller: scrollController,
      itemCount: currentPlan.tasks.length,
      itemBuilder: (context, index) =>
          _buildTaskTile(currentPlan.tasks[index], index, context),
    );
  }

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          Plan currentPlan = _plan;
          int planIndex =
              planNotifier.value.indexWhere((p) => p.name == currentPlan.name);

          List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
            ..[index] = Task(description: task.description, complete: selected ?? false);

          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(name: currentPlan.name, tasks: updatedTasks);

          setState(() {
            _plan = Plan(name: currentPlan.name, tasks: updatedTasks);
          });
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        decoration: const InputDecoration(border: InputBorder.none),
        onChanged: (text) {
          Plan currentPlan = _plan;
          int planIndex =
              planNotifier.value.indexWhere((p) => p.name == currentPlan.name);

          List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
            ..[index] = Task(description: text, complete: task.complete);

          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(name: currentPlan.name, tasks: updatedTasks);

          setState(() {
            _plan = Plan(name: currentPlan.name, tasks: updatedTasks);
          });
        },
      ),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

    return FloatingActionButton(
      backgroundColor: Colors.purple,
      child: const Icon(Icons.add, color: Colors.white),
      onPressed: () {
        int planIndex =
            planNotifier.value.indexWhere((p) => p.name == _plan.name);

        List<Task> updatedTasks = List<Task>.from(_plan.tasks)..add(const Task());

        planNotifier.value = List<Plan>.from(planNotifier.value)
          ..[planIndex] = Plan(name: _plan.name, tasks: updatedTasks);

        setState(() {
          _plan = Plan(name: _plan.name, tasks: updatedTasks);
        });

        // Scroll ke bawah
        Future.delayed(const Duration(milliseconds: 100), () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        });
      },
    );
  }
}
