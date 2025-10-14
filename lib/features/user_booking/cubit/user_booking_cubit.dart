import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/services/models/new_booking_model.dart';
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

  final List<ServiceModel> _favoriteServices = [];
  List<ServiceModel> get favoriteServices => _favoriteServices;

  final Set<String> _favoritedServiceIds = {};
  Set<String> get favoritedServiceIds => _favoritedServiceIds;

  // Track loading per service for favorite toggle
  final Map<String, bool> _favoriteLoading = {};
  Map<String, bool> get favoriteLoading => _favoriteLoading;

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
          _availableServices
              .addAll(availableServicesList as Iterable<ServiceModel>);
          emit(FetchAvailableServicesSuccess());
        },
      );
    } else {
      // Get services for the specific provider with referenceId
      final availableServices =
          await _bookingServices.getServicesByProvider(referenceId);
      availableServices.fold(
        (failure) {
          emit(FetchAvailableServicesError(failure));
        },
        (availableServicesList) {
          _availableServices.clear();
          _availableServices
              .addAll(availableServicesList as Iterable<ServiceModel>);
          emit(FetchAvailableServicesSuccess());
        },
      );
    }
  }

  void createBooking(Map<String, dynamic> bookingData) {
    emit(CreateUserBookingLoading());

    _bookingServices.createBooking(bookingData).then((result) {
      result.fold(
        (failure) {
          emit(CreateUserBookingError(failure));
        },
        (_) {
          emit(CreateUserBookingSuccess());
          // Refresh bookings if needed
          // getUser();
        },
      );
    }).catchError((error) {
      emit(CreateUserBookingError(Failure(error.toString())));
    });
  }

  List<BookingNewModel> myBookings = [];

  get currentlyProcessingService => null;

  Future<void> getMyBookings() async {
    emit(UserGetMyBookingsLoadingState());

    final result = await _bookingServices.getUserPreviousBookings();

    result.fold(
      (failure) => emit(UserGetMyBookingsErrorState(failure)),
      (bookings) {
        myBookings = bookings;
        emit(UserGetMyBookingsSuccessState(bookings.cast<BookingNewModel>()));
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
        _availableServices
            .addAll(availableServicesList as Iterable<ServiceModel>);
        emit(FetchAvailableServicesSuccess());
      },
    );
  }

  Future<void> fetchServicesForProvider(String referenceId) async {
    emit(FetchAvailableServicesLoading());
    final availableServices =
        await _bookingServices.getServicesByProvider(referenceId);
    availableServices.fold(
      (failure) {
        emit(FetchAvailableServicesError(failure));
      },
      (availableServicesList) {
        _availableServices.clear();
        _availableServices
            .addAll(availableServicesList as Iterable<ServiceModel>);
        emit(FetchAvailableServicesSuccess());
      },
    );
  }

  // FAVORITES METHODS

  // Initialize favorites
  Future<void> initializeFavorites() async {
    emit(FavoritesLoading());

    final result = await _bookingServices.getUserFavorites();

    result.fold(
      (failure) {
        emit(FavoritesError(failure));
      },
      (favorites) {
        _favoriteServices.clear();
        _favoritedServiceIds.clear();

        _favoriteServices.addAll(favorites);
        _favoritedServiceIds
            .addAll(favorites.map((service) => service.id).toSet());

        emit(FavoritesLoaded(favorites));
      },
    );
  }

  // Add service to favorites
  Future<void> addToFavorites(String serviceId) async {
    _favoriteLoading[serviceId] = true;
    emit(FavoriteOperationLoading(serviceId)); // Pass serviceId to the state

    final result = await _bookingServices.addToFavorites(serviceId);

    result.fold(
      (failure) {
        _favoriteLoading[serviceId] = false;
        emit(FavoriteOperationError(failure, serviceId));
      },
      (_) {
        final service = _availableServices.firstWhere(
          (s) => s.id == serviceId,
          orElse: () => ServiceModel(
            id: '',
            name: '',
            totalReviews: 0,
            averageRating: 0,
            description: '',
            category: '',
            serviceType: '',
            subType: '',
            basePrice: 0.0,
            pricingModel: '',
            duration: 0,
            image: '',
            active: false,
            provider: '',
            isApproved: false,
            createdAt: DateTime.fromMillisecondsSinceEpoch(0),
            availableDays: const [],
            availableSlots: const [],
            options: [],
            businessName: '',
            firstName: '',
            lastName: '',
            avatar: '',
            v: 0,
            reviews: [],
          ),
        );

        if (service.id.isNotEmpty) {
          _favoriteServices.add(service);
          _favoritedServiceIds.add(serviceId);
        }
        _favoriteLoading[serviceId] = false;
        emit(FavoriteAddedSuccess(serviceId));
      },
    );
  }

  // Remove service from favorites
  Future<void> removeFromFavorites(String serviceId) async {
    _favoriteLoading[serviceId] = true;
    emit(FavoriteOperationLoading(serviceId)); // Pass serviceId to the state

    final result = await _bookingServices.removeFromFavorites(serviceId);

    result.fold(
      (failure) {
        _favoriteLoading[serviceId] = false;
        emit(FavoriteOperationError(failure, serviceId));
      },
      (_) {
        _favoriteServices.removeWhere((service) => service.id == serviceId);
        _favoritedServiceIds.remove(serviceId);
        _favoriteLoading[serviceId] = false;
        emit(FavoriteRemovedSuccess(serviceId));
      },
    );
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String serviceId) async {
    if (_favoritedServiceIds.contains(serviceId)) {
      await removeFromFavorites(serviceId);
    } else {
      await addToFavorites(serviceId);
    }
  }

  // Check if service is favorited
  bool isServiceFavorited(String serviceId) {
    return _favoritedServiceIds.contains(serviceId);
  }

  // Check favorite status from API (for verification)
  Future<void> checkFavoriteStatus(String serviceId) async {
    final result = await _bookingServices.checkIsFavorited(serviceId);

    result.fold(
      (failure) {
        if (kDebugMode) {
          print('Error checking favorite status: $failure');
        }
      },
      (isFavorited) {
        if (isFavorited && !_favoritedServiceIds.contains(serviceId)) {
          _favoritedServiceIds.add(serviceId);
          emit(FavoriteStatusUpdated(serviceId, isFavorited));
        } else if (!isFavorited && _favoritedServiceIds.contains(serviceId)) {
          _favoritedServiceIds.remove(serviceId);
          emit(FavoriteStatusUpdated(serviceId, isFavorited));
        }
      },
    );
  }

  // Clear favorites (useful on logout)
  void clearFavorites() {
    _favoriteServices.clear();
    _favoritedServiceIds.clear();
    _favoriteLoading.clear();
    emit(FavoritesCleared());
  }

  // Refresh favorites
  Future<void> refreshFavorites() async {
    await initializeFavorites();
  }

  // Check if a specific service is loading
  bool isServiceLoading(String serviceId) {
    return _favoriteLoading[serviceId] ?? false;
  }
}
