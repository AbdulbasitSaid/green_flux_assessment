import 'package:flutter/material.dart';
import 'package:green_flux_assessment/features/charge_locations/application/widgets/charge_location_card.dart';
import 'package:green_flux_assessment/shared/theme/theme.dart';

class ChargeLocations extends StatefulWidget {
  const ChargeLocations({super.key});

  @override
  State<ChargeLocations> createState() => _ChargeLocationsState();
}

class _ChargeLocationsState extends State<ChargeLocations> {
  late LocationListViewType locationListViewType;

  @override
  Widget build(BuildContext context) {
    late final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    locationListViewType =
        isDark ? LocationListViewType.darkMode : LocationListViewType.lightMode;
    return Scaffold(
      backgroundColor: colorScheme.background.withAlpha(200),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              const SearchBar(
                leading: Icon(Icons.search),
                trailing: [Icon(Icons.close)],
                hintText: "search charge locations",
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: [
                    ChargeLocationListCard(colorScheme: colorScheme),
                    const SizedBox(height: 8),
                    ChargeLocationListCard(colorScheme: colorScheme),
                    const SizedBox(height: 8),
                    ChargeLocationListCard(colorScheme: colorScheme),
                    const SizedBox(height: 8),
                    ChargeLocationListCard(colorScheme: colorScheme),
                    const SizedBox(height: 8),
                    ChargeLocationListCard(colorScheme: colorScheme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: colorScheme.outline,
        child: Row(children: [
          SegmentedButton<LocationListViewType>(
            segments: const [
              ButtonSegment<LocationListViewType>(
                value: LocationListViewType.lightMode,
                label: Text('Light Mode'),
                icon: Icon(Icons.light_mode),
              ),
              ButtonSegment<LocationListViewType>(
                value: LocationListViewType.darkMode,
                label: Text('Dark Mode'),
                icon: Icon(Icons.dark_mode),
              ),
            ],
            selected: <LocationListViewType>{locationListViewType},
            onSelectionChanged: (Set<LocationListViewType> newSelection) {
              final themeProvider = ThemeProvider.of(context);
              final themeSettings = themeProvider.settings.value;

              setState(() {
                locationListViewType = newSelection.first;
                final newThemeSettings = ThemeSettings(
                  sourceColor: themeSettings.sourceColor,
                  themeMode: isDark ? ThemeMode.light : ThemeMode.dark,
                );
                ThemeSettingChange(settings: newThemeSettings)
                    .dispatch(context);
              });
            },
          ),
        ]),
      ),
    );
  }
}

enum LocationListViewType {
  lightMode,
  darkMode,
}
