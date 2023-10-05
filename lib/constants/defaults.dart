import 'package:sourdoc/methods/convert_temperature_unit.dart';

const TemperatureUnit temperatureUnit = TemperatureUnit.celsius;
final String temperatureUnitValue = temperatureUnitMap[temperatureUnit]!.unit;

const Map<TemperatureUnit, String> temperatureMap = {
  TemperatureUnit.celsius: '22',
  TemperatureUnit.farenheit: '72'
};

const String totalWeight = '700';
const String hydration = '70';
const String saltLevel = '2';
