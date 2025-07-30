sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}

final class ServiceGetAllSuccessState extends ServiceState {}

final class ServiceGetAllFailedState extends ServiceState {}

final class ServiceGetAllLoadingState extends ServiceState {}

final class ServiceCreationSuccessState extends ServiceState {}

final class ServiceCreationlFailedState extends ServiceState {}

final class ServiceGCreationLoadingState extends ServiceState {}

class DashboardLoading extends ServiceState {}

class DashboardSuccess extends ServiceState {}

class DashboardError extends ServiceState {}


final class GetMyBookingsuccessState extends ServiceState {}

final class GetMyBookingsFailedState extends ServiceState {}

final class GetMyBookingsLoadingState extends ServiceState {}
