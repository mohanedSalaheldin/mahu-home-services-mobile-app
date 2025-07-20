import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserRole { client, serviceProvider }

class UserRoleCubit extends Cubit<UserRole?> {
  UserRoleCubit() : super(null);

  void setUserRole(UserRole role) {
    emit(role);
    saveToPrefs(role);
  }

  Future<void> loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    final roleStr = prefs.getString('user_role');
    if (roleStr != null) {
      emit(UserRole.values.firstWhere((e) => e.name == roleStr));
    }
  }

  void saveToPrefs(UserRole role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', role.name);
  }
}
