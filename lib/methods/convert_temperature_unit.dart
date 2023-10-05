import 'package:sourdoc/constants/locale.dart' as locale;

enum TemperatureUnit { celsius, farenheit }

class TemperatureUnitDescriptor {
  TemperatureUnitDescriptor({required this.unit, required this.description});

  final String unit;
  final String description;
}

final Map<TemperatureUnit, TemperatureUnitDescriptor> temperatureUnitMap = {
  TemperatureUnit.celsius: TemperatureUnitDescriptor(
      unit: locale.unitDegreesCelsius, description: locale.degreesCelsius),
  TemperatureUnit.farenheit: TemperatureUnitDescriptor(
      unit: locale.unitDegreesFarenheit, description: locale.degreesFarenheit)
};

final Map<TemperatureUnit, double Function(double)>
    _temperatureToUnitConversionMap = {
  TemperatureUnit.celsius: (double temperature) => 5 / 9 * (temperature - 32),
  TemperatureUnit.farenheit: (double temperature) => 9 / 5 * temperature + 32,
};

double convertTemperatureUnit(double temperature, TemperatureUnit toUnit) =>
    _temperatureToUnitConversionMap[toUnit]!(temperature);
