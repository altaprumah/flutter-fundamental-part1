import '../models/data_layer.dart';
import '../provider/plan_provider.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;

  // Plan yang dipilih dari layar sebelumnya. Dipakai terutama untuk
  // mengidentifikasi plan (lewat name); data terbaru selalu dibaca dari provider.
  Plan get plan => widget.plan;

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(title: Text(plan.name)),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          Plan currentPlan = plans.firstWhere((p) => p.name == plan.name);
          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(child: Text(currentPlan.completenessMessage)),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        // Selalu baca data terbaru dari provider (bukan dari widget.plan).
        final plans = plansNotifier.value;
        final planIndex = plans.indexWhere((p) => p.name == plan.name);
        final currentPlan = plans[planIndex];
        plansNotifier.value = List<Plan>.from(plans)
          ..[planIndex] = Plan(
            name: currentPlan.name,
            tasks: List<Task>.from(currentPlan.tasks)..add(const Task()),
          );
      },
    );
  }

  Widget _buildList(Plan currentPlan) {
    return ListView.builder(
      controller: scrollController,
      keyboardDismissBehavior: Theme.of(context).platform == TargetPlatform.iOS
          ? ScrollViewKeyboardDismissBehavior.onDrag
          : ScrollViewKeyboardDismissBehavior.manual,
      itemCount: currentPlan.tasks.length,
      itemBuilder: (context, index) =>
          _buildTaskTile(currentPlan.tasks[index], index, context),
    );
  }

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);
    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          final plans = plansNotifier.value;
          final planIndex = plans.indexWhere((p) => p.name == plan.name);
          final currentPlan = plans[planIndex];
          plansNotifier.value = List<Plan>.from(plans)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: List<Task>.from(currentPlan.tasks)
                ..[index] = Task(
                  description: task.description,
                  complete: selected ?? false,
                ),
            );
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          final plans = plansNotifier.value;
          final planIndex = plans.indexWhere((p) => p.name == plan.name);
          final currentPlan = plans[planIndex];
          plansNotifier.value = List<Plan>.from(plans)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: List<Task>.from(currentPlan.tasks)
                ..[index] = Task(
                  description: text,
                  complete: task.complete,
                ),
            );
        },
      ),
    );
  }
}