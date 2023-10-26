import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_flux_assessment/features/charge_locations/application/widgets/charge_location_list_card.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/evses.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/location.dart';

void main() {
  const testLocation = Location(
    city: 'Amsterdam',
    country: 'Netherlands',
    address: '123 Main St',
    evses: [],
    latitude: null,
    longitude: null,
  );

  testWidgets('ChargeLocationListCard shows correct data',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChargeLocationListCard(
            colorScheme: ThemeData.light().colorScheme,
            location: testLocation,
          ),
        ),
      ),
    );

    // Verify if the UI displays the correct data
    expect(find.text('Amsterdam'), findsOneWidget);
    expect(find.text('Netherlands'), findsOneWidget);
    expect(find.text('123 Main St'), findsOneWidget);
    expect(find.text('Total Charge points: 0'), findsOneWidget);
    expect(find.text('Status: Unavailable'), findsOneWidget);
    expect(find.byIcon(Icons.radio_button_checked), findsOneWidget);
    expect(find.text('View Details'), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);
  });

  testWidgets('Icon color should be primary when location is available',
      (WidgetTester tester) async {
    const Location availableLocation = Location(evses: [
      Evses(
          evseId: 'evseId',
          status: 'AVAILABLE',
          connectorType: 'connectorType',
          powerType: 'powerType')
    ], address: '', city: '', country: '', latitude: null, longitude: null);
    final ColorScheme colorScheme = ThemeData.light().colorScheme;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChargeLocationListCard(
            colorScheme: ThemeData.light().colorScheme,
            location: availableLocation,
          ),
        ),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.radio_button_checked));
    expect(icon.color, equals(colorScheme.primary));
  });
  testWidgets('Icon color should be error when location is not available',
      (WidgetTester tester) async {
    const Location availableLocation = Location(evses: [
      Evses(
          evseId: 'evseId',
          status: 'NOT AVAILABLE',
          connectorType: 'connectorType',
          powerType: 'powerType')
    ], address: '', city: '', country: '', latitude: null, longitude: null);
    final ColorScheme colorScheme = ThemeData.light().colorScheme;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChargeLocationListCard(
            colorScheme: ThemeData.light().colorScheme,
            location: availableLocation,
          ),
        ),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.radio_button_checked));
    expect(icon.color, equals(colorScheme.error));
  });
}
