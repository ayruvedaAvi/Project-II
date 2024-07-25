
import '../../utils/shared_preferences/shared_preference.dart';

String? getRole() {
  String? role;
  () async {
    role = await UserSharedPreference.getStringDataFromStorage("role");
  };
  return role;
}
