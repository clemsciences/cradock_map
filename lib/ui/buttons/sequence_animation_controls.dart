import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:cradock_map/notifiers/app_state_notifier.dart";

class SequenceAnimationControls extends StatefulWidget {
  const SequenceAnimationControls({super.key});

  @override
  State<SequenceAnimationControls> createState() => _SequenceAnimationControlsState();
}

class _SequenceAnimationControlsState extends State<SequenceAnimationControls> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, notifier, child) {
        return Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: CircularProgressIndicator(
                        value: (notifier.isAnimating || notifier.isPaused) ? notifier.animationProgress : 0,
                        strokeWidth: 3,
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          (notifier.isAnimating || notifier.isPaused)
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    IconButton.filledTonal(
                      icon: Icon(notifier.isAnimating ? Icons.play_arrow : Icons.play_arrow_outlined),
                      tooltip: "Play",
                      onPressed: notifier.isAnimating
                          ? null
                          : () => notifier.startAnimation(startAt: notifier.animationProgress),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  icon: Icon(notifier.isPaused ? Icons.pause : Icons.pause_outlined),
                  tooltip: "Pause",
                  onPressed: !notifier.isAnimating ? null : () => notifier.pauseAnimation(),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  icon: const Icon(Icons.stop),
                  tooltip: "Stop",
                  onPressed: () => notifier.stopAnimation(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
