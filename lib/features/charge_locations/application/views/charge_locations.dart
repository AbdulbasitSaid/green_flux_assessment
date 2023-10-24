import 'package:flutter/material.dart';
import 'package:green_flux_assessment/shared/theme/theme.dart';

class ChargeLocations extends StatefulWidget {
  const ChargeLocations({super.key});

  @override
  State<ChargeLocations> createState() => _ChargeLocationsState();
}

class _ChargeLocationsState extends State<ChargeLocations> {
  LocationListViewType locationListViewType = LocationListViewType.lightMode;

  @override
  Widget build(BuildContext context) {
    late final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                  onPressed: () {},
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
