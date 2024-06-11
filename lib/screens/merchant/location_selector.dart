import 'package:com.mybill.app/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationSelector extends StatefulWidget {
  final LatLng center;

  const LocationSelector({super.key, required this.center});

  @override
  _LocationSelectorState createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  bool counterRotate = false;
  late MapController _mapController;
  final LatLng _userLocation =
      const LatLng(51.509364, -0.128928); // Initial center
  Marker? _selectedMarker;
  late LatLng _selectedLocation;
  late final customMarkers = <Marker>[];

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        // Use the recommended flutter_map_cancellable_tile_provider package to
        // support the cancellation of loading tiles.
        tileProvider: CancellableNetworkTileProvider(),
      );

  Marker buildPin(LatLng point) => Marker(
        point: point,
        width: 60,
        height: 60,
        child: GestureDetector(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tapped existing marker'),
              duration: Duration(seconds: 1),
              showCloseIcon: true,
            ),
          ),
          child: const Icon(Icons.location_pin, size: 60, color: Colors.black),
        ),
      );

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
    }

    if (!status.isGranted) {
      // Handle the case where the user did not grant permission
      // You might want to show a dialog or a snackbar to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permission is required to use this feature.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _requestLocationPermission().then((_) => _getCurrentLocation());
  }

  @override
  void dispose() {
    // //before going to other screen show statusbar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    // final Position position = await Geolocator.getCurrentPosition();
    // setState(() {
    //   _userLocation = LatLng(position.latitude, position.longitude);
    // });
  }

  // void _onMarkerTapped(Marker marker) {
  //   setState(() {
  //     // Update the selected marker
  //     _selectedMarker = marker;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        FlutterMap(
            options: MapOptions(
              initialCenter: widget.center,
              initialZoom: 10,
              onTap: (_, p) => setState(() {
                setState(() {
                  _selectedLocation = p;
                });
                customMarkers.clear();
                customMarkers.add(buildPin(p));
              }),
              interactionOptions: const InteractionOptions(
                flags: ~InteractiveFlag.doubleTapZoom,
              ),
            ),
            children: [
              openStreetMapTileLayer,
              MarkerLayer(
                rotate: counterRotate,
                markers: const [],
              ),
              MarkerLayer(
                markers: customMarkers,
                rotate: counterRotate,
              ),
            ]),
        SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: FloatingActionButton(
                  backgroundColor: customMarkers.isNotEmpty
                      ? MyTheme.accent_color
                      : MyTheme.dark_grey,
                  onPressed: customMarkers.isNotEmpty
                      ? () {
                          Navigator.pop(context, _selectedLocation);
                        }
                      : null,
                  child: const Text('Select Position')),
            )),
      ],
    );
  }
}

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Container(

//   //   );
//   // }
