import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
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
    // Get referenceId from cache
    final referenceId = CacheHelper.getString('referenceId');
    if (referenceId == null || referenceId.isEmpty) {
      // Get all services for all providers
      final availableServices = await _bookingServices.getAllServices();
      availableServices.fold(
        (failure) {
          emit(FetchAvailableServicesError(failure));
        },
        (availableServicesList) {
          _availableServices.clear();
          _availableServices.addAll(availableServicesList as Iterable<ServiceModel>);
          emit(FetchAvailableServicesSuccess());
        },
      );
    } else {
      // Get services for the specific provider with referenceId
      final availableServices = await _bookingServices.getServicesByProvider(referenceId);
      availableServices.fold(
        (failure) {
          emit(FetchAvailableServicesError(failure));
        },
        (availableServicesList) {
          _availableServices.clear();
          _availableServices.addAll(availableServicesList as Iterable<ServiceModel>);
          emit(FetchAvailableServicesSuccess());
        },
      );
    }
  }

  Future<void> createBooking(UserBookingModel bookingMode) async {
    emit(CreateUserBookingLoading());

    final availableServices = await _bookingServices.createBooking(bookingMode);
    availableServices.fold(
      (failure) {
        emit(CreateUserBookingError(failure));
      },
      (_) {
        emit(CreateUserBookingSuccess());
      },
    );
  }

  List<UserBookingModel> myBookings = [];

  Future<void> getMyBookings() async {
    emit(UserGetMyBookingsLoadingState());

    final result = await _bookingServices.getUserPreviousBookings();

    result.fold(
      (failure) => emit(UserGetMyBookingsErrorState(failure)),
      (bookings) {
        myBookings = bookings.cast<UserBookingModel>();
        emit(UserGetMyBookingsSuccessState(bookings.cast<UserBookingModel>()));
      },
    );
  }

  Future<void> fetchAllServicesForAllProviders() async {
    emit(FetchAvailableServicesLoading());
    final availableServices = await _bookingServices.getAllServices();
    availableServices.fold(
      (failure) {
        emit(FetchAvailableServicesError(failure));
      },
      (availableServicesList) {
        _availableServices.clear();
        _availableServices.addAll(availableServicesList as Iterable<ServiceModel>);
        emit(FetchAvailableServicesSuccess());
      },
    );
  }

  Future<void> fetchServicesForProvider(String referenceId) async {
    emit(FetchAvailableServicesLoading());
    final availableServices = await _bookingServices.getServicesByProvider(referenceId);
    availableServices.fold(
      (failure) {
        emit(FetchAvailableServicesError(failure));
      },
      (availableServicesList) {
        _availableServices.clear();
        _availableServices.addAll(availableServicesList as Iterable<ServiceModel>);
        emit(FetchAvailableServicesSuccess());
      },
    );
  }
}
