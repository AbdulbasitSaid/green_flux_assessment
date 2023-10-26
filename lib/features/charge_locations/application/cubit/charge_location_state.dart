part of 'charge_location_cubit.dart';

@freezed
class ChargeLocationState with _$ChargeLocationState {
  const factory ChargeLocationState.initial() = _Initial;
  const factory ChargeLocationState.loading() = _Loading;
  const factory ChargeLocationState.failed({required String errorMessage}) =
      _Failed;
  const factory ChargeLocationState.loaded(
      {required List<Location> locations}) = _Loaded;
}
