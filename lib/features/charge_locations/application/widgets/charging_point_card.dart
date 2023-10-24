import 'package:flutter/material.dart';

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
