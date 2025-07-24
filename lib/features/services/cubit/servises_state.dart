sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}

final class ServiceGetAllSuccessState extends ServiceState {}

final class ServiceGetAllFailedState extends ServiceState {}

final class ServiceGetAllLoadingState extends ServiceState {}

final class ServiceCreationSuccessState extends ServiceState {}

final class ServiceCreationlFailedState extends ServiceState {}

final class ServiceGCreationLoadingState extends ServiceState {}
