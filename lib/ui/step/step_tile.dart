import "package:cradock_map/models/path_step.dart";
import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class StepTile extends StatelessWidget {
  final PathStep step;
  final int selectedStepId;

  const StepTile({required this.step, required this.selectedStepId});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, notifier, _) => ListTile(
        selected: selectedStepId == step.id,
        title: Text(step.name),
        onTap: () {
          notifier.selectStepId(step.id);
        },
      ),
    );
  }
}
