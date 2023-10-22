import 'package:sourdoc/methods/temperature_unit_helpers.dart';

// Default initial values
const TemperatureUnit defaultTemperatureUnit = TemperatureUnit.celsius;
final String defaultTemperatureUnitSymbol =
    getTemperatureUnitSymbol(defaultTemperatureUnit);
const String defaultTotalWeight = '700';
const String defaultHydration = '70';
const String defaultSaltLevel = '2';
String getDefaultTemperature(TemperatureUnit temperatureUnit) {
  if (temperatureUnit == TemperatureUnit.celsius) {
    return '22';
  }
  if (temperatureUnit == TemperatureUnit.farenheit) {
    return '72';
  }
  throw ArgumentError.value('temperatureUnit');
}

// Maximum values
const double maxValueTotalWeight = 9999;
const double maxValueHydration = 99;
const double maxValueSaltLevel = 10;
double getMaxValueTemperature(TemperatureUnit temperatureUnit) {
  if (temperatureUnit == TemperatureUnit.celsius) {
    return 40;
  }
  if (temperatureUnit == TemperatureUnit.farenheit) {
    return 104;
  }
  throw ArgumentError.value('temperatureUnit');
}
