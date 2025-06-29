sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}

final class ServiceTypeSettedState extends ServiceState {}

final class ServiceSubTypeSettedState extends ServiceState {}

class PricingModelSettedState extends ServiceState {}

class ServiceDetailsUpdatedState extends ServiceState {}

class CoverageAreaUpdatedState extends ServiceState {}

class AvailabilityUpdatedState extends ServiceState {}

class ServiceBasePriceUpdated extends ServiceState {}

class ServicePriceInstructionsUpdated extends ServiceState {}

class ServiceDurationUpdated extends ServiceState {}
