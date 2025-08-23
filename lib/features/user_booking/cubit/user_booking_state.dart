part of 'user_booking_cubit.dart';

@immutable
sealed class UserBookingState {}

final class UserBookingInitial extends UserBookingState {}

final class FetchAvailableServicesSuccess extends UserBookingState {}

final class FetchAvailableServicesError extends UserBookingState {
  final Failure failure;
  FetchAvailableServicesError(this.failure);
}

final class FetchAvailableServicesLoading extends UserBookingState {}

final class CreateUserBookingSuccess extends UserBookingState {}

final class CreateUserBookingError extends UserBookingState {
  final Failure failure;
  CreateUserBookingError(this.failure);
}

final class CreateUserBookingLoading extends UserBookingState {}


class UserGetMyBookingsLoadingState extends UserBookingState {}

class UserGetMyBookingsSuccessState extends UserBookingState {
  final List<UserBookingModel> bookings;
  UserGetMyBookingsSuccessState(this.bookings);
}

class UserGetMyBookingsErrorState extends UserBookingState {
  final Failure failure;
  UserGetMyBookingsErrorState(this.failure);
}


// Add these to your existing UserBookingState classes

// Favorites Loading
class FavoritesLoading extends UserBookingState {}

// Favorites Loaded
class FavoritesLoaded extends UserBookingState {
  final List<ServiceModel> favorites;
  
  FavoritesLoaded(this.favorites);
}

// Favorite Operation Loading
class FavoriteOperationLoading extends UserBookingState {
  final String serviceId;
  
  FavoriteOperationLoading(this.serviceId);
}
// Favorite Added Success
class FavoriteAddedSuccess extends UserBookingState {
  final String serviceId;
  
  FavoriteAddedSuccess(this.serviceId);
}

// Favorite Removed Success
class FavoriteRemovedSuccess extends UserBookingState {
  final String serviceId;
  
  FavoriteRemovedSuccess(this.serviceId);
}

// Favorites Error
class FavoritesError extends UserBookingState {
  final Failure failure;
  
  FavoritesError(this.failure);
}

// Favorite Operation Error
class FavoriteOperationError extends UserBookingState {
  final Failure failure;
  final String serviceId;
  
  FavoriteOperationError(this.failure, this.serviceId);
}

// Favorites Cleared
class FavoritesCleared extends UserBookingState {}

class FavoriteStatusUpdated extends UserBookingState {
  final String serviceId;
  final bool isFavorited;
  
  FavoriteStatusUpdated(this.serviceId, this.isFavorited);
}
