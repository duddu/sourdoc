import 'package:sourdoc/constants/locale.dart' as locale;

enum TemperatureUnit { celsius, farenheit }

class TemperatureUnitDescriptor {
  TemperatureUnitDescriptor(
      {required this.name, required this.symbol, required this.description});

  final TemperatureUnit name;
  final String symbol;
  final String description;
}

final Set<TemperatureUnitDescriptor> temperatureUnitSet = {
  TemperatureUnitDescriptor(
      name: TemperatureUnit.celsius,
      symbol: locale.unitDegreesCelsius,
      description: locale.degreesCelsius),
  TemperatureUnitDescriptor(
      name: TemperatureUnit.farenheit,
      symbol: locale.unitDegreesFarenheit,
      description: locale.degreesFarenheit)
};

String getTemperatureUnitSymbol(TemperatureUnit temperatureUnit) {
  return temperatureUnitSet
      .singleWhere((unit) => unit.name == temperatureUnit)
      .symbol;
}

TemperatureUnit getTemperatureUnitName(String symbol) {
  return temperatureUnitSet.singleWhere((unit) => unit.symbol == symbol).name;
}

double convertTemperatureToUnit(double temperature, TemperatureUnit toUnit) {
  if (toUnit == TemperatureUnit.celsius) {
    return 5 / 9 * (temperature - 32);
  }
  if (toUnit == TemperatureUnit.farenheit) {
    return 9 / 5 * temperature + 32;
  }
  throw ArgumentError.value('toUnit');
}
