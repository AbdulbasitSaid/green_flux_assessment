import 'package:flutter/material.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/charge_location.dart';

class ChargingPointCard extends StatelessWidget {
  const ChargingPointCard(
      {super.key, required this.colorScheme, required this.evses});

  final ColorScheme colorScheme;
  final Evses evses;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorScheme.secondaryContainer,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.ev_station_rounded),
            Text('Status: ${evses.status}'),
            Text('Power type: ${evses.powerType}'),
            Text('Connection type: ${evses.connectorType}'),
          ],
        ),
      ),
    );
  }
}
