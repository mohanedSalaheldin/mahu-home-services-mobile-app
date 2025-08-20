import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserRole { client, provider, unknown }

class UserRoleCubit extends Cubit<UserRole> {
  UserRoleCubit() : super(UserRole.unknown) {
    // Initialize without automatically loading from prefs
  }
  
  static UserRoleCubit get(context) => BlocProvider.of(context);

  Future<void> setUserRole(UserRole role) async {
    await saveToPrefs(role);
    emit(role);
  }

  Future<void> loadSavedRole() async {
    final prefs = await SharedPreferences.getInstance();
    final roleStr = prefs.getString('user_role');
    if (roleStr != null) {
      emit(UserRole.values.firstWhere((e) => e.name == roleStr));
    }
  }

  Future<void> saveToPrefs(UserRole role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', role.name);
  }

  void clearSelection() {
    emit(UserRole.unknown);
  }
}