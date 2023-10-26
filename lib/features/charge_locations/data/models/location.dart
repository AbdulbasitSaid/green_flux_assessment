import 'package:equatable/equatable.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/evses.dart';
import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

@JsonSerializable(createToJson: false)
class Location extends Equatable {
  final String? address, city, country;
  final double? latitude, longitude;
  final List<Evses> evses;
  const Location({
    required this.address,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.evses = const [],
  });
  static bool get getStatus => false;

  List<Evses> get availableEvses =>
      evses.where((element) => element.status == "AVAILABLE").toList();

  bool get availability {
    if (evses.isEmpty || availableEvses.isEmpty) {
      return false;
    }
    return availableEvses.length / evses.length <= 0.5 ? false : true;
  }

  @override
  List<Object?> get props => [
        address,
        city,
        country,
        latitude,
        longitude,
        evses,
      ];

  @override
  String toString() {
    return "Location({address:$address, city:$city, country:$country,"
        " latitude:$latitude, longitude:$longitude, evses:$evses})";
  }

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
