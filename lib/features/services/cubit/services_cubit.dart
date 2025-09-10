import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart'
    as _serviceRepository;
import 'package:mahu_home_services_app/features/services/cubit/services_state.dart';
import 'package:mahu_home_services_app/features/services/models/booking_model.dart';
import 'package:mahu_home_services_app/features/services/models/provider_performance.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';
import 'package:mahu_home_services_app/features/services/services/booking_services.dart';
import 'package:mahu_home_services_app/features/services/services/manage_provider_services.dart';
import 'package:mahu_home_services_app/features/services/services/profile_services.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceInitial());
  final ManageProviderServices _manageProviderServices =
      ManageProviderServices();
  final BookingServices _bookingServices = BookingServices();

  static ServiceCubit get(context) => BlocProvider.of(context);

  final List<ServiceModel> _services = [];
  List<ServiceModel> get services => _services;

  Future<void> fetchServices() async {
    emit(ServiceGetAllLoadingState());

    final services = await _manageProviderServices.getAllServices();
    services.fold(
      (failure) {
        emit(ServiceGetAllFailedState(failure));
      },
      (servicesList) {
        _services.clear();
        _services.addAll(servicesList);
        emit(ServiceGetAllSuccessState());
      },
    );
  }

  final List<BookingModel> _myBooking = [];
  List<BookingModel> get myBooking => _myBooking;

  Future<void> fetchMyBookings() async {
    emit(GetMyBookingsLoadingState());

    final booking = await _bookingServices.getMyBookings();
    booking.fold(
      (failure) {
        emit(GetMyBookingsFailedState(failure));
      },
      (bookingList) {
        _myBooking.clear();
        _myBooking.addAll(bookingList);
        emit(GetMyBookingSuccessState());
      },
    );
  }

  void createService(ServiceModel service) {
    print('Creating service: ${service.name}');
    emit(ServiceCreationLoadingState());

    _manageProviderServices.addService(service).then(
      (result) {
        result.fold(
          (failure) {
            print('Service creation failed: ${failure.message}');
            emit(ServiceCreationFailedState(failure));
          },
          (_) {
            print('Service created successfully');
            // _services.add(service);
            emit(ServiceCreationSuccessState());
            fetchServices();
          },
        );
      },
    ).catchError((error) {
      print('Error in createService: $error');
      emit(ServiceCreationFailedState(Failure(error.toString())));
    });
  }

  void updateService(ServiceModel service) {
    emit(ServiceUpdateLoadingState());

    _manageProviderServices.updateService(service).then(
      (result) {
        result.fold(
          (failure) {
            emit(ServiceUpdateFailedState(failure));
          },
          (_) {
            // _services.add(service);
            emit(ServiceUpdateSuccessState());
            fetchServices();
          },
        );
      },
    );
  }

  void updateProfile({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String avatar,
  }) async {
    emit(ProfileUpdateLoadingState());

    final result = await _profileServices.editProviderProfile(
      email: email,
      phone: phone,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
    );

    result.fold(
      (failure) {
        emit(ProfileUpdateFailedState(failure.message));
      },
      (updatedProfile) {
        _profile = updatedProfile;
        emit(ProfileUpdateSuccessState());
      },
    );
  }

  void changeBookingStatus(String bookingId, String status) async {
    emit(ProviderChangeBookingStatusLoadingState());
    _bookingServices.changeBookingStatus(bookingId, status).then(
      (result) {
        result.fold(
          (failure) {
            emit(ProviderChangeBookingStatusFailedState(failure));
          },
          (_) {
            emit(ProviderChangeBookingStatusSuccessState());
            fetchMyBookings();
            // fetchServices();
          },
        );
      },
    );
  }

  final ProfileServices _profileServices = ProfileServices();

  UserBaseProfileModel _profile = UserBaseProfileModel(
    firstName: '',
    id: '',
    lastName: '',
    avatar: '',
    name: '',
    businessName: '',
    businessRegistration: '',
    serviceProviderCategory: '',
  );
  ProviderPerformanceModel _performanceModel = ProviderPerformanceModel(
      totalBookings: 0,
      completed: 0,
      cancelled: 0,
      completionRate: 0.0,
      averageRating: 0.0,
      totalEarnings: 0.0);

  UserBaseProfileModel get profile => _profile;
  ProviderPerformanceModel get performanceModel => _performanceModel;

  void fetchDashboardData() async {
    emit(DashboardLoading());

    final profileResult = await _profileServices.getProfile();
    final performanceResult =
        await _manageProviderServices.getProviderPerformance();

    // Handle profile first
    profileResult.fold(
      (failure) {
        emit(DashboardError(failure));
        emit(ServiceErrorState(failure.message));
        return;
      },
      (profile) {
        _profile = profile;
      },
    );

    // Handle performance
    performanceResult.fold(
      (failure) {
        emit(DashboardError(failure));
        emit(ServiceErrorState(failure.message));
        return;
      },
      (performance) {
        _performanceModel = performance;
      },
    );

    emit(DashboardSuccess());
  }

  Future<void> updateServiceStatus(String serviceId, bool isActive) async {
    emit(ServiceStatusUpdateLoadingState());
    try {
      // Call your API to update service status
      await _manageProviderServices.toggleServiceStatus(serviceId, isActive);
      emit(ServiceStatusUpdateSuccessState());
    } catch (e) {
      emit(ServiceStatusUpdateFailedState(e.toString()));
    }
  }
}

// Add these to your ServiceCubit


// Add these states to your ServiceState

