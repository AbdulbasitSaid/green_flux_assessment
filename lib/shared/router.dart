import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_flux_assessment/features/charge_locations/application/views/charge_location_details.dart';
import 'package:green_flux_assessment/features/charge_locations/application/views/charge_locations.dart';

class NavigationDestination {
  const NavigationDestination({
    required this.route,
    required this.label,
    required this.icon,
    this.child,
  });

  final String route;
  final String label;
  final Icon icon;
  final Widget? child;
}

final appRouter = GoRouter(
  initialLocation: '/locations',
  routes: [
    // charge-locations
    GoRoute(
      name: 'locations',
      path: '/locations',
      builder: (context, state) => const ChargeLocations(),
      routes: [
        GoRoute(
          name: 'location',
          path: ':aid',
          builder: (context, state) => ChargeLocationDetails(
            locationId: state.pathParameters['aid']!,
          ),
        ),
      ],
    ),
  ],
);
