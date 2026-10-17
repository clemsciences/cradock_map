import "dart:async";

import "package:cradock_map/data/commune_boundary_data.dart";
import "package:cradock_map/data/path_data.dart";
import "package:cradock_map/data/post_house_data.dart";
import "package:cradock_map/data/step_data.dart";
import "package:cradock_map/models/commune_boundary.dart";
import "package:cradock_map/models/path_step.dart";
import "package:cradock_map/models/view_mode.dart";
import "package:flutter/material.dart";
import "package:latlong2/latlong.dart";

///
class AppStateNotifier extends ChangeNotifier {
  bool _isShowing = false;
  double opacity = 1.0;
  ViewMode viewMode = ViewMode.sequence;
  List<PathStep> steps = StepData.steps;
  int selectedStepId = -1;
  LatLng initialCenter = const LatLng(47.39024, 0.68886);
  GlobalKey mapKey = GlobalKey();

  // MapController mapController = MapController();
  // late AnimatedMapController animatedMapController;
  // Broadcast : la carte se réabonne à chaque fois qu'elle est reconstruite.
  final StreamController<List<PathStep>> _streamController =
      StreamController.broadcast();
  bool withCarrosse = false;
  bool showAllMarkers = false;
  bool showTrack = true;
  // Copie pour ne pas modifier les données d'origine avec les outils de tracé.
  List<LatLng> trackPoints = List.of(PathData.points);

  bool withPostHouses = false;
  List<LatLng> postHouses = PostHouseData.points;

  bool showCommuneBoundaries = false;
  // Loaded on first display only, to keep the start-up light.
  List<CommuneBoundary> communeBoundaries = [];
  Future<void>? _communeBoundariesLoading;

  bool isExpertMode = false;

  Timer? _animationTimer;
  bool _isAnimating = false;
  bool _isPaused = false;
  double _animationProgress = 0.0;
  bool get isAnimating => _isAnimating;
  bool get isPaused => _isPaused;
  double get animationProgress => _animationProgress;

  bool get isShowing => _isShowing;

  List<PathStep> get selectedSteps =>
      steps.where((item) => item.id == selectedStepId).toList();

  void startAnimation({double startAt = 0.0}) {
    if (_isAnimating) return;
    _isAnimating = true;
    _animationTimer?.cancel();

    // On commence avec la progression donnée
    _animationProgress = startAt;

    const int resolutionMs = 100; // Mise à jour toutes les 100ms
    const int totalDurationMs = 10000;

    _animationTimer =
        Timer.periodic(const Duration(milliseconds: resolutionMs), (timer) {
      _animationProgress += resolutionMs / totalDurationMs;

      if (_animationProgress >= 1.0) {
        _animationProgress = 0.0;
        _nextStep();
      }
      notifyListeners();
    });

    if (!_isPaused && selectedStepId == -1) {
      if (steps.isNotEmpty) {
        selectStepId(steps.first.id);
      }
    }

    _isPaused = false;
    notifyListeners();
  }

  void _nextStep() {
    if (steps.isEmpty) return;
    int currentIndex = steps.indexWhere((s) => s.id == selectedStepId);
    int nextIndex = (currentIndex + 1) % steps.length;
    selectStepId(steps[nextIndex].id);
  }

  void pauseAnimation() {
    _isAnimating = false;
    _isPaused = true;
    _animationTimer?.cancel();
    _animationTimer = null;
    notifyListeners();
  }

  void stopAnimation() {
    _isAnimating = false;
    _isPaused = false;
    _animationProgress = 0.0;
    _animationTimer?.cancel();
    _animationTimer = null;
    if (steps.isNotEmpty) {
      selectStepId(steps.first.id);
    }
    notifyListeners();
  }

  /// Updates the visibility of layer.
  void switchState() {
    _isShowing = !_isShowing;
    notifyListeners();
  }

  /// Updates the opacity of layer.
  void updateOpacity(double newOpacity) {
    opacity = newOpacity;
    notifyListeners();
  }

  /// Updates the view mode.
  void updateViewMode(ViewMode newViewMode) {
    if (newViewMode != viewMode) {
      viewMode = newViewMode;
      notifyListeners();
    }
  }

  void selectStepId(int newSelectedStateId) {
    selectedStepId = newSelectedStateId;
    // print("new selectedStepId: $selectedStepId");
    notifyListeners();
    _streamController.add(selectedSteps);
  }

  void switchMarker() {
    withCarrosse = !withCarrosse;
    notifyListeners();
  }

  void switchShowAllMarkers() {
    showAllMarkers = !showAllMarkers;
    notifyListeners();
  }

  void switchShowTrack() {
    showTrack = !showTrack;
    notifyListeners();
  }

  void switchPostHouses() {
    withPostHouses = !withPostHouses;
    notifyListeners();
  }

  Future<void> switchCommuneBoundaries() {
    showCommuneBoundaries = !showCommuneBoundaries;
    notifyListeners();
    return preloadCommuneBoundaries();
  }

  /// Starts loading the boundaries in the background (once), so that the
  /// switch shows them without delay.
  Future<void> preloadCommuneBoundaries() {
    return _communeBoundariesLoading ??= _loadCommuneBoundaries();
  }

  /// Shown but not loaded yet.
  bool get isLoadingCommuneBoundaries =>
      showCommuneBoundaries && communeBoundaries.isEmpty;

  Future<void> _loadCommuneBoundaries() async {
    try {
      communeBoundaries = await CommuneBoundaryData.load();
      notifyListeners();
    } catch (e) {
      debugPrint("Impossible de charger les limites des communes : $e");
      _communeBoundariesLoading = null; // retried at the next switch
    }
  }

  void switchExpertMode() {
    isExpertMode = !isExpertMode;
    if (!isExpertMode) {
      viewMode = ViewMode.sequence;
    }
    notifyListeners();
  }

  void removeLastTrackPoint() {
    if (trackPoints.isEmpty) return;
    trackPoints.removeLast();
    notifyListeners();
  }

  void addTrackPoint(LatLng point) {
    trackPoints.add(point);
    // print(trackPoints);
    notifyListeners();
  }

  void flushTrackPoints() {
    trackPoints.clear();
    selectedStepId = -1;
    notifyListeners();
  }

  // void setAnimatedMapController(AnimatedMapController amc) {
  //   animatedMapController = amc;
  // }
  Stream<List<PathStep>> get pathStepStream => _streamController.stream;

  @override
  void dispose() {
    _animationTimer?.cancel();
    _streamController.close();
    super.dispose();
  }
}
