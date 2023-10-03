import 'package:shared_preferences/shared_preferences.dart';

const temperatureUnitKey = 'temperatureUnit';
const temperatureKey = 'temperature';
const totalWeightKey = 'totalWeight';
const hydrationKey = 'hydration';
const saltLevelKey = 'saltLevel';

Future<String> getDefaultValue(String key, String defaultValue) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? defaultValue;
}

Future<void> storeDefaultValue(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}
