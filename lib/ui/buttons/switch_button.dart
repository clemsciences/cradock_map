


import 'package:cradock_map/notifiers/app_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowOverlayButton extends StatelessWidget {
  const ShowOverlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, state, child) {
      return Switch(value: state.isShowing, onChanged: (isChecked) {
        state.switchState();
      });
    });
  }

}