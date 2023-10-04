import 'package:shared_preferences/shared_preferences.dart';

const temperatureUnitKey = 'temperatureUnit';
const temperatureKey = 'temperature';
const totalWeightKey = 'totalWeight';
const hydrationKey = 'hydration';
const saltLevelKey = 'saltLevel';

Future<String> getInitialOrDefaultValue(String key, String defaultValue) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? defaultValue;
}

Future<bool> storeInitialValue(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  return await prefs.setString(key, value);
}
