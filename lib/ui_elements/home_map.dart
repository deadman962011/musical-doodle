import 'package:csh_app/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeMap extends StatefulWidget {
  final List items;
  const HomeMap({required this.items, Key? key}) : super(key: key);

  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  bool counterRotate = false;
  List<Marker> _markers = [];
  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    setPins();
  }

  setPins() {
    if (widget.items.isNotEmpty) {
      for (var item in widget.items) {
        setState(() {
          _markers.add(buildPin(item['coordinates'], item['amount']));
        });
      }
    }
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        // Use the recommended flutter_map_cancellable_tile_provider package to
        // support the cancellation of loading tiles.
        tileProvider: CancellableNetworkTileProvider(),
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

  Marker buildPin(LatLng point, amount) => Marker(
      alignment: Alignment.topCenter,
      point: point,
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Icon(Icons.location_pin, size: 60, color: MyTheme.accent_color),
          Image.asset(
            'assets/location_pin.png',
            width: 64,
            height: 64,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(4),
            width: 26,
            height: 26,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60), color: Colors.white),
            child: Text(
              '${amount.toString()}%',
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
          ),
        ],
      ));

  @override
  void dispose() {
    // //before going to other screen show statusbar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 16),
        height: 200,
        child: FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(24.7136, 46.6753),
              initialZoom: 9,
              zoom: 9,
              interactionOptions: InteractionOptions(
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
                markers: _markers,
                rotate: counterRotate,
              ),
            ]));
  }
}
