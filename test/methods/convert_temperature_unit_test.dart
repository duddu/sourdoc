import 'package:flutter_test/flutter_test.dart';
import 'package:sourdoc/methods/convert_temperature_unit.dart';

void main() {
  group('temperatureUnitMap', () {
    test('should have the correct lenght', () {
      expect(temperatureUnitMap.length, 2);
    });

    test('should have the correct ordered keys', () {
      expect(temperatureUnitMap.keys.elementAt(0), TemperatureUnit.celsius);
      expect(temperatureUnitMap.keys.elementAt(1), TemperatureUnit.farenheit);
    });
  });

  group('convertTemperatureUnit', () {
    test('should convert farenheit to celsius', () {
      expect(convertTemperatureUnit(20, TemperatureUnit.farenheit), 68);
    });

    test('should convert celsius to farenheit', () {
      expect(convertTemperatureUnit(68, TemperatureUnit.celsius), 20);
    });
  });
}
