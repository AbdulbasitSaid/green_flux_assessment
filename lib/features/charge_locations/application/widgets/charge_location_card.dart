import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/location.dart';

class ChargeLocationListCard extends StatelessWidget {
  const ChargeLocationListCard({
    super.key,
    required this.colorScheme,
    required this.location,
  });

  final ColorScheme colorScheme;
  final Location location;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${location.city}",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text("${location.country}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on),
                Flexible(child: Text("${location.address}")),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Total Charge points: ${location.evses.length}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                        "Status: ${location.availability ? "Available" : "Unavailable"}",
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.radio_button_checked,
                      color: location.availability
                          ? colorScheme.primary
                          : colorScheme.error,
                    )
                  ],
                ),
                FilledButton(
                  onPressed: location.availability
                      ? () {
                          context.go('/locations/${location.address}',
                              extra: location);
                        }
                      : null,
                  child: const Text('View Details'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
