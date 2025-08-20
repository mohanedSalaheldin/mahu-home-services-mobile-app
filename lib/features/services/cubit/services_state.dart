import 'package:mahu_home_services_app/core/errors/failures.dart';

import '../views/screens/booking_details_screen.dart';

sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}

// ===== Service Get All =====
final class ServiceGetAllSuccessState extends ServiceState {}

final class ServiceGetAllFailedState extends ServiceState {
  final Failure failure;
  ServiceGetAllFailedState(this.failure);
}

final class ServiceGetAllLoadingState extends ServiceState {}

// ===== Service Creation =====
final class ServiceCreationSuccessState extends ServiceState {}

final class ServiceCreationFailedState extends ServiceState {
  final Failure failure;
  ServiceCreationFailedState(this.failure);
}

final class ServiceCreationLoadingState extends ServiceState {}

// ===== Service Deletion =====
final class ServiceDeletionSuccessState extends ServiceState {}

final class ServiceDeletionFailedState extends ServiceState {
  final Failure failure;
  ServiceDeletionFailedState(this.failure);
}

final class ServiceDeletionLoadingState extends ServiceState {}

// ===== Service Update =====
final class ServiceUpdateSuccessState extends ServiceState {}

final class ServiceUpdateFailedState extends ServiceState {
  final Failure failure;
  ServiceUpdateFailedState(this.failure);
}

final class ServiceUpdateLoadingState extends ServiceState {}

// ===== Dashboard =====
class DashboardLoading extends ServiceState {}

class DashboardSuccess extends ServiceState {}

class DashboardError extends ServiceState {
  final Failure failure;
  DashboardError(this.failure);
}

// ===== My Bookings =====
final class GetMyBookingSuccessState extends ServiceState {}

final class GetMyBookingsFailedState extends ServiceState {
  final Failure failure;
  GetMyBookingsFailedState(this.failure);
}



final class GetMyBookingsLoadingState extends ServiceState {}

class GetMyBookingsSuccessState extends ServiceState {
  final List<Booking> bookings;
  GetMyBookingsSuccessState(this.bookings);
}

// ===== Provider Accept Bookings =====
final class ProviderChangeBookingStatusSuccessState extends ServiceState {}

final class ProviderChangeBookingStatusFailedState extends ServiceState {
  final Failure failure;
  ProviderChangeBookingStatusFailedState(this.failure);
}

final class ProviderChangeBookingStatusLoadingState extends ServiceState {}


class ProfileUpdateLoadingState extends ServiceState {}

class ProfileUpdateSuccessState extends ServiceState {}

class ProfileUpdateFailedState extends ServiceState {
  final String error;
  ProfileUpdateFailedState(this.error);
}


class ServiceErrorState extends ServiceState {
  final String message;
  ServiceErrorState(this.message);
}
