import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_state.dart';
import 'package:mahu_home_services_app/features/services/models/service_type.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceInitial());

  static ServiceCubit get(context) => BlocProvider.of(context);

  ServiceType? _serviceType;

  set serviceType(ServiceType serviceType) {
    _serviceType = serviceType;
    emit(ServiceTypeSettedState());
  }

  ServiceType get serviceType {
    return _serviceType ?? ServiceType.oneTime;
  }

  ServiceSubType? _serviceSubType;

  set serviceSubType(ServiceSubType serviceSubType) {
    _serviceSubType = serviceSubType;
    emit(ServiceTypeSettedState());
  }

  ServiceSubType get serviceSubType {
    return _serviceSubType ?? ServiceSubType.standard;
  }

  PricingModel? _pricingModel;

  set pricingModel(PricingModel model) {
    _pricingModel = model;
    emit(PricingModelSettedState()); // نفس طريقتك
  }

  PricingModel get pricingModel {
    return _pricingModel ?? PricingModel.fixed;
  }

  // base price
  double? _basePrice;
  double? get basePrice => _basePrice;
  set basePrice(double? value) {
    _basePrice = value;
    emit(ServiceBasePriceUpdated());
  }

// price instructions
  String? _priceInstructions;
  String? get priceInstructions => _priceInstructions;
  set priceInstructions(String? value) {
    _priceInstructions = value;
    emit(ServicePriceInstructionsUpdated());
  }

// duration
  int? _duration;
  int? get duration => _duration;
  set duration(int? value) {
    _duration = value;
    emit(ServiceDurationUpdated());
  }

// category (usually fixed)
  String _category = "cleaning";
  String get category => _category;

  String? _serviceName;
  String? _description;

  set serviceName(String name) {
    _serviceName = name;
    emit(ServiceDetailsUpdatedState());
  }

  String get serviceName => _serviceName ?? '';

  set description(String desc) {
    _description = desc;
    emit(ServiceDetailsUpdatedState());
  }

  String get description => _description ?? '';

  String? _imageUrl;

  set imageUrl(String url) {
    _imageUrl = url;
    emit(ServiceDetailsUpdatedState());
  }

  set category(String value) {
    _category = value;
    emit(ServiceDetailsUpdatedState());
  }

  String get imageUrl => _imageUrl ?? '';

  final List<String> _selectedAreas = [];

  List<String> get selectedAreas => _selectedAreas;

  void addArea(String area) {
    if (!_selectedAreas.contains(area)) {
      _selectedAreas.add(area);
      emit(CoverageAreaUpdatedState());
    }
  }

  void removeArea(String area) {
    _selectedAreas.remove(area);
    emit(CoverageAreaUpdatedState());
  }

  final List<DailyAvailability> _availability = [
    DailyAvailability(day: 'Saturday'),
    DailyAvailability(day: 'Sunday'),
    DailyAvailability(day: 'Monday'),
    DailyAvailability(day: 'Tuesday'),
    DailyAvailability(day: 'Wednesday'),
    DailyAvailability(day: 'Thursday'),
    DailyAvailability(day: 'Friday'),
  ];

  List<DailyAvailability> get availability => _availability;

  void setStartTime(String day, TimeOfDay? time) {
    _availability.firstWhere((a) => a.day == day).startTime = time;
    emit(AvailabilityUpdatedState());
  }

  void setEndTime(String day, TimeOfDay? time) {
    _availability.firstWhere((a) => a.day == day).endTime = time;
    emit(AvailabilityUpdatedState());
  }
}

class DailyAvailability {
  final String day;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  DailyAvailability({
    required this.day,
    this.startTime,
    this.endTime,
  });
}
