import 'package:sourdoc/constants/locale.dart' as locale;

enum TemperatureUnit { celsius, farenheit }

const Map<TemperatureUnit, String> temperatureUnitMap = {
  TemperatureUnit.celsius: locale.unitDegreesCelsius,
  TemperatureUnit.farenheit: locale.unitDegreesFarenheit
};

final List<String> temperatureUnitList = [
  temperatureUnitMap[TemperatureUnit.celsius]!,
  temperatureUnitMap[TemperatureUnit.farenheit]!
];

double convertTemperatureUnit(double temperature, TemperatureUnit toUnit) {
  switch (toUnit) {
    case TemperatureUnit.farenheit:
      return 9 / 5 * temperature + 32;
    case TemperatureUnit.celsius:
      return 5 / 9 * (temperature - 32);
    default:
      return 0;
  }
}
