import 'package:green_flux_assessment/features/charge_locations/data/locations_api.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/charge_location.dart';

class LocationsRepository {
  final LocationsApi locationsApi;

  LocationsRepository({required this.locationsApi});

  Future<List<Location>> getChargeLocations({required String query}) {
    return locationsApi.searchChargeLocation(query);
  }
}
