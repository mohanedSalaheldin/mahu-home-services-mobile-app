part of 'user_booking_cubit.dart';

@immutable
sealed class UserBookingState {}

final class UserBookingInitial extends UserBookingState {}

final class FetchAvailableServicesSuccess extends UserBookingState {}

final class FetchAvailableServicesError extends UserBookingState {}

final class FetchAvailableServicesLoading extends UserBookingState {}

final class CreateUserBookingSuccess extends UserBookingState {}

final class CreateUserBookingError extends UserBookingState {}

final class CreateUserBookingLoading extends UserBookingState {}
