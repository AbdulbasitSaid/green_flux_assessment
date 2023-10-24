import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ChargeLocationDetails extends StatefulWidget {
  const ChargeLocationDetails({super.key, required this.locationId});
  final String locationId;

  @override
  State<ChargeLocationDetails> createState() => _ChargeLocationDetailsState();
}

class _ChargeLocationDetailsState extends State<ChargeLocationDetails> {
  late final Completer<GoogleMapController> _mapController;

  static const CameraPosition _chargeLocation = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(19.06593, -98.13851),
      tilt: 59.440717697143555,
      zoom: 15);

  @override
  void initState() {
    _mapController = Completer<GoogleMapController>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Charge points at: Address710 486 ',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                  // textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 140,
                padding: const EdgeInsets.only(left: 16),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ChargingPointCard(colorScheme: colorScheme),
                    ChargingPointCard(colorScheme: colorScheme),
                    ChargingPointCard(colorScheme: colorScheme),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .3,
                clipBehavior: Clip.antiAlias,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      myLocationButtonEnabled: false,
                      initialCameraPosition: _chargeLocation,
                      zoomControlsEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        _mapController.complete(controller);
                      },
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              await MapsLauncher.launchCoordinates(
                                  37.4220041, -122.0862462, "Address here");
                            } catch (e) {
                              return;
                            }
                          },
                          icon: const Icon(Icons.map),
                          label: const Text("Open in Maps")),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Divider(
                color: colorScheme.primary,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Location detail",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.pin_drop),
                            Text("Address: Address710 486"),
                          ],
                        ),
                        TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.copy),
                            label: const Text('Copy')),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Row(
                      children: [
                        Icon(Icons.location_city_outlined),
                        Text("City: Amsterdam"),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Row(
                      children: [
                        Icon(Icons.flag),
                        Text("Country Code: NLD"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChargingPointCard extends StatelessWidget {
  const ChargingPointCard({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorScheme.secondaryContainer,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.ev_station_rounded),
            Text('Status: Available'),
            Text('Power type: DC'),
            Text('Connection type: IEC_62196_T1_COMBO'),
          ],
        ),
      ),
    );
  }
}
