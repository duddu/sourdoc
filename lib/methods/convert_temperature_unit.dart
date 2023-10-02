import 'package:sourdoc/constants/locale.dart' as locale;

enum TemperatureUnit { celsius, farenheit }

const Map<TemperatureUnit, String> temperatureUnitMap = {
  TemperatureUnit.celsius: locale.unitDegreesCelsius,
  TemperatureUnit.farenheit: locale.unitDegreesFarenheit
};

final Map<TemperatureUnit, double Function(double)>
    _temperatureToUnitConversionMap = {
  TemperatureUnit.celsius: (double temperature) => 5 / 9 * (temperature - 32),
  TemperatureUnit.farenheit: (double temperature) => 9 / 5 * temperature + 32,
};

double convertTemperatureUnit(double temperature, TemperatureUnit toUnit) =>
    _temperatureToUnitConversionMap[toUnit]!(temperature);
