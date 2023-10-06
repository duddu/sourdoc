import 'package:sourdoc/methods/convert_temperature_unit.dart';

// Default initial values
const TemperatureUnit defaultTemperatureUnit = TemperatureUnit.celsius;
final String defaultTemperatureUnitValue =
    temperatureUnitMap[defaultTemperatureUnit]!.unit;
const Map<TemperatureUnit, String> defaultTemperatureMap = {
  TemperatureUnit.celsius: '22',
  TemperatureUnit.farenheit: '72'
};
const String defaultTotalWeight = '700';
const String defaultHydration = '70';
const String defaultSaltLevel = '2';

// Maximum values
const Map<TemperatureUnit, double> maxValueTemperatureMap = {
  TemperatureUnit.celsius: 40,
  TemperatureUnit.farenheit: 104
};
const double maxValueTotalWeight = 100000;
const double maxValueHydration = 99;
const double maxValueSaltLevel = 10;
