import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class MultiNotifier extends StatelessWidget {
  final Widget? child;

  const MultiNotifier({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppStateNotifier(), child: child);
  }
}
