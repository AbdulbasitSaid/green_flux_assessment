import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'evses.g.dart';

@JsonSerializable(
  createToJson: false,
)
class Evses extends Equatable {
  final String evseId, status, connectorType, powerType;

  const Evses(
      {required this.evseId,
      required this.status,
      required this.connectorType,
      required this.powerType});

  @override
  List<Object?> get props => [
        evseId,
        status,
        connectorType,
        powerType,
      ];
  @override
  String toString() {
    return "Evses({evseId:$evseId, status:$status, "
        "connectorType:$connectorType, powerType: $powerType })";
  }

  factory Evses.fromJson(Map<String, dynamic> json) => _$EvsesFromJson(json);
}
