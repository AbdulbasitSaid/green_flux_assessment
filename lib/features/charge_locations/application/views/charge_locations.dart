import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:green_flux_assessment/features/charge_locations/application/cubit/charge_location_cubit.dart';
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
  void initState() {
    _searchController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  late final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    late final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    locationListViewType =
        isDark ? LocationListViewType.darkMode : LocationListViewType.lightMode;
    final chargeLocationsState = context.watch<ChargeLocationCubit>().state;
    return Scaffold(
      backgroundColor: colorScheme.background.withAlpha(200),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              SearchBar(
                controller: _searchController,
                leading: const Icon(Icons.search),
                trailing: [
                  IconButton(
                      onPressed: () {
                        _searchController.clear();
                      },
                      icon: const Icon(Icons.close))
                ],
                hintText: "search charge locations",
                onChanged: (value) => context
                    .read<ChargeLocationCubit>()
                    .searchLocation(query: _searchController.text),
              ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(height: 8),
              Expanded(
                  child: chargeLocationsState.maybeWhen(
                      initial: () =>
                          const Text('Search city to get charge locations'),
                      loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                      loaded: (locations) => locations.isEmpty
                          ? const Center(
                              child: Text('No charge location found'),
                            )
                          : ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                return ChargeLocationListCard(
                                    location: locations[index],
                                    colorScheme: colorScheme);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 8,
                                );
                              },
                              itemCount: locations.length,
                            ),
                      failed: (errorMessage) => Center(
                            child: Text(errorMessage),
                          ),
                      orElse: () => const Center(
                            child: Text("Error while loading"),
                          ))),
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
