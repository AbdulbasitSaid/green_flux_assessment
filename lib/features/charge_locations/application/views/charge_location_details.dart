import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_flux_assessment/features/charge_locations/application/widgets/charging_point_card.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/location.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ChargeLocationDetails extends StatefulWidget {
  const ChargeLocationDetails({super.key, required this.location});
  final Location location;

  @override
  State<ChargeLocationDetails> createState() => _ChargeLocationDetailsState();
}

class _ChargeLocationDetailsState extends State<ChargeLocationDetails> {
  late final Completer<GoogleMapController> _mapController;

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
    final location = widget.location;

    CameraPosition chargeLocation = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(location.latitude ?? 00, location.longitude ?? 00),
        tilt: 59.440717697143555,
        zoom: 15);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Charge points at: ${location.address} ',
                  style: const TextStyle(
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) => ChargingPointCard(
                        colorScheme: colorScheme,
                        evses: location.evses[index],
                      )),
                  itemCount: location.evses.length,
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
                      initialCameraPosition: chargeLocation,
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
                                  location.latitude ?? 00,
                                  location.longitude ?? 00,
                                  "${location.address}");
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
                        Row(
                          children: [
                            const Icon(Icons.pin_drop),
                            Text("Address: ${location.address}"),
                          ],
                        ),
                        TextButton.icon(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: location.address ?? ''));
                            },
                            icon: const Icon(Icons.copy),
                            label: const Text('Copy')),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_city_outlined),
                        Text("City: ${location.city}"),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.flag),
                        Text("Country Code: ${location.country}"),
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
