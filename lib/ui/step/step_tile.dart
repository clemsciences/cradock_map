import "package:cradock_map/models/path_step.dart";
import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class StepTile extends StatelessWidget {
  final PathStep step;
  final int selectedStepId;

  const StepTile({super.key, required this.step, required this.selectedStepId});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, notifier, _) {
        final isSelected = selectedStepId == step.id;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: Material(
            color: isSelected ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(28),
            child: ListTile(
              selected: isSelected,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              title: Text(
                step.name,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Theme.of(context).colorScheme.onPrimaryContainer : null,
                ),
              ),
              onTap: () {
                notifier.selectStepId(step.id);
              },
            ),
          ),
        );
      },
    );
  }
}
