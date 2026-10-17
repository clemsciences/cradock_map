import "dart:math";

import "package:cradock_map/models/view_mode.dart";
import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:cradock_map/ui/buttons/map_options_panel.dart";
import "package:cradock_map/ui/buttons/sequence_animation_controls.dart";
import "package:cradock_map/ui/buttons/view_mode_switch.dart";
import "package:cradock_map/ui/map/map.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/step/step_tile.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

/// Full-screen map page. The map is never placed inside a scrolling view, so
/// dragging (touch) or the mouse wheel act on the map without fighting the
/// page scroll.
class MapView extends StatelessWidget {
  const MapView({super.key});

  static const double wideBreakpoint = 800;
  static const double maxBaladeMapWidth = 1000;
  static const double stepListWidth = 280;
  static const double minHeightForStepTitle = 300;
  static const double minHeightForInlineOptions = 500;
  static const double maxInlineOptionsHeight = 200;

  /// Side-by-side layout on wide screens, and on landscape phones/tablets.
  static bool isWideLayout(BoxConstraints constraints) =>
      constraints.maxWidth > wideBreakpoint ||
      (constraints.maxWidth > 600 &&
          constraints.maxWidth > constraints.maxHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, notifier, _) {
      // No app bar: like the other pages, the NavBar tells where we are.
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const NavBar(),
              const Center(child: ViewModeRadioButton()),
              Expanded(
                child: LayoutBuilder(builder: (context, constraints) {
                  final isWide = isWideLayout(constraints);
                  // Inline options would leave too little room to the map on
                  // short screens (landscape phones).
                  final inlineOptions = isWide &&
                      constraints.maxHeight > minHeightForInlineOptions;
                  return switch (notifier.viewMode) {
                    ViewMode.balade =>
                      _buildBalade(context, constraints, inlineOptions),
                    ViewMode.sequence =>
                      _buildSequence(context, isWide, inlineOptions),
                  };
                }),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildMap(AppStateNotifier notifier) {
    return TouraineMap(
      mapKey: notifier.mapKey,
      initialCenter: notifier.initialCenter,
    );
  }

  /// Options are shown inline on large screens, behind a button otherwise.
  Widget _buildOptions(BuildContext context, bool inline) {
    if (inline) {
      // Bounded height + scroll: in expert mode the options can be taller than
      // the space left under the map. Not a Flexible, which would reserve half
      // of the height even when the options need less.
      return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: maxInlineOptionsHeight),
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: MapOptionsPanel(),
        ),
      );
    }
    return TextButton.icon(
      icon: const Icon(Icons.tune),
      label: const Text("Options de la carte"),
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (context) => const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: MapOptionsPanel(),
          ),
        ),
      ),
    );
  }

  Widget _buildBalade(
      BuildContext context, BoxConstraints constraints, bool inlineOptions) {
    final notifier = context.read<AppStateNotifier>();
    return Column(
      children: [
        Expanded(
          child: Center(
            child: SizedBox(
              width: min(maxBaladeMapWidth, constraints.maxWidth),
              child: _buildMap(notifier),
            ),
          ),
        ),
        _buildOptions(context, inlineOptions),
      ],
    );
  }

  Widget _buildSequence(BuildContext context, bool isWide, bool inlineOptions) {
    final notifier = context.read<AppStateNotifier>();
    final stepList = Material(
      elevation: 1,
      color: Theme.of(context).colorScheme.surface,
      borderRadius: isWide
          ? const BorderRadius.horizontal(left: Radius.circular(16))
          : const BorderRadius.vertical(top: Radius.circular(16)),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: [
            // The title is dropped when height is scarce (landscape phones):
            // the list and the playback controls matter more.
            if (constraints.maxHeight > minHeightForStepTitle)
              Padding(
                padding: EdgeInsets.all(isWide ? 16.0 : 8.0),
                child: Text(
                  "Étapes",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                  itemCount: notifier.steps.length,
                  itemBuilder: (context, index) => StepTile(
                      selectedStepId: notifier.selectedStepId,
                      step: notifier.steps[index])),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SequenceAnimationControls(),
            ),
          ],
        ),
      ),
    );

    final mapAndOptions = Column(
      children: [
        Expanded(child: _buildMap(notifier)),
        _buildOptions(context, inlineOptions),
      ],
    );

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: mapAndOptions),
          const SizedBox(width: 8),
          // Fixed width: a fraction of the screen is too narrow for the
          // playback controls on small laptops and landscape tablets.
          SizedBox(width: stepListWidth, child: stepList),
        ],
      );
    }
    return Column(
      children: [
        Expanded(flex: 3, child: mapAndOptions),
        Expanded(flex: 2, child: stepList),
      ],
    );
  }
}
