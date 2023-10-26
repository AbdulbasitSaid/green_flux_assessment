import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:green_flux_assessment/features/charge_locations/data/locations_api.dart';
import 'package:green_flux_assessment/features/charge_locations/domain/locations_repository.dart';

import '../../data/models/location.dart';

part 'charge_location_state.dart';
part 'charge_location_cubit.freezed.dart';

class ChargeLocationCubit extends Cubit<ChargeLocationState> {
  final LocationsRepository locationsRepository;
  ChargeLocationCubit(this.locationsRepository)
      : super(const ChargeLocationState.initial());

  Future<void> searchLocation({required String query}) async {
    if (query.length < 3) {
      return;
    }
    emit(const ChargeLocationState.loading());

    try {
      final result = await locationsRepository.getChargeLocations(query: query);
      emit(ChargeLocationState.loaded(locations: result));
    } on HttpBadRequest {
      emit(const ChargeLocationState.failed(
          errorMessage: 'Bad '
              'Request'));
    } on HttpServerError {
      emit(const ChargeLocationState.failed(
          errorMessage: 'Error '
              'from the Server'));
    } on Exception {
      emit(const ChargeLocationState.failed(
          errorMessage: 'An '
              'unexpected error occurred'));
    }
  }
}
