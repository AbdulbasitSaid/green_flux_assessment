import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChargeLocationListCard extends StatelessWidget {
  const ChargeLocationListCard({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

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
            const Text(
              "Almere",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Text("NLD",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on),
                Flexible(
                    child: Text(" 48E louis Amstrongweg, Netherlands 1311RK")),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Text(
                  "Total Charge points: 6",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Status",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.radio_button_checked,
                      color: colorScheme.primary,
                    )
                  ],
                ),
                FilledButton(
                  onPressed: () {
                    context.go('/locations/1');
                  },
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
