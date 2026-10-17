import 'package:cradock_map/ui/map/markers/marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  testWidgets('SatMarker shows name popup only when showNamePopup is true', (WidgetTester tester) async {
    final markerPosition = LatLng(47.39, 0.688);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 400,
            height: 400,
            child: _TestMap(),
          ),
        ),
      ),
    );

    // The _TestMap builds two markers: one with popup and one without.
    expect(find.byKey(const ValueKey('sat_marker_popup_With popup')), findsOneWidget);
    expect(find.byKey(const ValueKey('sat_marker_popup_Without popup')), findsNothing);
  });
}

class _TestMap extends StatelessWidget {
  const _TestMap();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(initialCenter: LatLng(47.39, 0.688), initialZoom: 13),
      children: [
        MarkerLayer(markers: [
          SatMarker(
            position: const LatLng(47.39024, 0.68886),
            onTap: () {},
            withCarrosse: false,
            label: 'With popup',
            height: 60,
            width: 60,
            showNamePopup: true,
          ),
          SatMarker(
            position: const LatLng(47.391, 0.689),
            onTap: () {},
            withCarrosse: false,
            label: 'Without popup',
            height: 60,
            width: 60,
            showNamePopup: false,
          ),
        ])
      ],
    );
  }
}
