import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_flux_assessment/features/charge_locations/application/widgets/charging_point_card.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/charge_location.dart';

void main() {
  const ColorScheme colorScheme = ColorScheme.light();
  const Evses evses = Evses(
    status: 'Available',
    powerType: 'AC',
    connectorType: 'Type 2',
    evseId: '',
  );

  testWidgets('ChargingPointCard shows correct information',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData.light().copyWith(colorScheme: colorScheme),
      home: const ChargingPointCard(colorScheme: colorScheme, evses: evses),
    ));

    // Verify if the card shows the correct icons and texts
    expect(find.byIcon(Icons.ev_station_rounded), findsOneWidget);
    expect(find.text('Status: Available'), findsOneWidget);
    expect(find.text('Power type: AC'), findsOneWidget);
    expect(find.text('Connection type: Type 2'), findsOneWidget);
  });
}
