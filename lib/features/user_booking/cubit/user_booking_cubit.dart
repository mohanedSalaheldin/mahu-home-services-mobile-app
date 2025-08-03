import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/models/booking_model.dart';
import 'package:mahu_home_services_app/features/user_booking/services/user_booking_services.dart';
import 'package:meta/meta.dart';

part 'user_booking_state.dart';

class UserBookingCubit extends Cubit<UserBookingState> {
  UserBookingCubit() : super(UserBookingInitial());

  final UserBookingServices _bookingServices = UserBookingServices();

  static UserBookingCubit get(context) => BlocProvider.of(context);

  final List<ServiceModel> _availableServices = [];
  List<ServiceModel> get availableServices => _availableServices;

  Future<void> fetchavailableServices() async {
    emit(FetchAvailableServicesLoading());

    final availableServices = await _bookingServices.getAllServices();
    availableServices.fold(
      (failure) {
        emit(FetchAvailableServicesError());
      },
      (availableServicesList) {
        _availableServices.clear();
        _availableServices.addAll(availableServicesList);
        emit(FetchAvailableServicesSuccess());
      },
    );
  }

  Future<void> createBooking(UserBookingModel bookingMode) async {
    emit(CreateUserBookingLoading());

    final availableServices =
        await _bookingServices.createBBooking(bookingMode);
    availableServices.fold(
      (failure) {
        emit(CreateUserBookingError());
      },
      (_) {
        emit(CreateUserBookingSuccess());
      },
    );
  }
}
