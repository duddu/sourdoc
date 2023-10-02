import 'package:sourdoc/methods/convert_temperature_unit.dart';

double _convertFromFarenheit(double temperature, TemperatureUnit unit) {
  double convertedTemperature = temperature;
  if (unit == TemperatureUnit.farenheit) {
    convertedTemperature =
        convertTemperatureUnit(convertedTemperature, TemperatureUnit.celsius);
  }
  return convertedTemperature;
}

double getInoculationValue(double temperature, TemperatureUnit unit) {
  double convertedTemperature = _convertFromFarenheit(temperature, unit);
  if (convertedTemperature > 41) {
    return 0;
  }
  return 41 - convertedTemperature;
}

double getBulkRiseValue(double temperature, TemperatureUnit unit) {
  double convertedTemperature = _convertFromFarenheit(temperature, unit);
  if (convertedTemperature > 25) {
    return 25;
  }
  if (convertedTemperature <= 20) {
    return 100;
  }
  return 50;
}
