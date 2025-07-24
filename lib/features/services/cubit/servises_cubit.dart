import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_state.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/services/services/manage_provider_services.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceInitial());
  final ManageProviderServices _manageProviderServices =
      ManageProviderServices();

  static ServiceCubit get(context) => BlocProvider.of(context);
  final List<ServiceModel> _services = [];
  List<ServiceModel> get services => _services;
  Future<void> fetchServices() async {
    emit(ServiceGetAllLoadingState());

    final services = await _manageProviderServices.getAllServices();
    services.fold(
      (failure) {
        emit(ServiceGetAllFailedState());
      },
      (servicesList) {
        _services.clear();
        _services.addAll(servicesList);
        emit(ServiceGetAllSuccessState());
      },
    );
  }

  void createService(ServiceModel service) {
    emit(ServiceCreationSuccessState());

    _manageProviderServices.addService(service).then(
      (result) {
        result.fold(
          (failure) {
            emit(ServiceCreationlFailedState());
          },
          (_) {
            _services.add(service);
            emit(ServiceCreationSuccessState());

          },
        );
      },
    );
  }
}
