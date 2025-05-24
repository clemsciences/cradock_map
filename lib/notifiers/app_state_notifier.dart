import "dart:async";

import "package:cradock_map/data/path_data.dart";
import "package:cradock_map/data/post_house_data.dart";
import "package:cradock_map/data/step_data.dart";
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
  final StreamController<List<PathStep>> _streamController = StreamController();
  bool withCarrosse = false;
  bool showAllMarkers = false;
  List<LatLng> trackPoints = PathData.points;

  bool withPostHouses = false;
  List<LatLng> postHouses = PostHouseData.points;

  bool get isShowing => _isShowing;

  List<PathStep> get selectedSteps =>
      steps.where((item) => item.id == selectedStepId).toList();

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

  void switchPostHouses() {
    withPostHouses = !withPostHouses;
    notifyListeners();
  }

  void removeLastTrackPoint() {
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
    notifyListeners();
  }

  // void setAnimatedMapController(AnimatedMapController amc) {
  //   animatedMapController = amc;
  // }
  Stream<List<PathStep>> get pathStepStream =>
      _streamController.stream.asBroadcastStream();

  @override
  void dispose() {
    // _streamController.
    super.dispose();
  }
}
