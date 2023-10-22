import 'package:flutter_test/flutter_test.dart';
import 'package:sourdoc/methods/temperature_unit_helpers.dart';
import 'package:sourdoc/methods/get_fermentation_values.dart';

void main() {
  group('getInoculationValue', () {
    test('should return 0 if temperature is higher than 41', () {
      expect(getInoculationValue(42, TemperatureUnit.celsius), 0);
    });

    test('should return the correct calculation', () {
      expect(getInoculationValue(25, TemperatureUnit.celsius), 16);
    });

    test('should return the correct calculation for farenheit', () {
      expect(getInoculationValue(77, TemperatureUnit.farenheit), 16);
    });
  });

  group('getBulkRiseValue', () {
    test('should return 100 if temperature is lower than 21', () {
      expect(getBulkRiseValue(20, TemperatureUnit.celsius), 100);
    });

    test('should return 50 if temperature is 21', () {
      expect(getBulkRiseValue(21, TemperatureUnit.celsius), 50);
    });

    test('should return 50 if temperature is higher than 21 and lower than 25',
        () {
      expect(getBulkRiseValue(23, TemperatureUnit.celsius), 50);
    });

    test('should return 50 if temperature is 25', () {
      expect(getBulkRiseValue(25, TemperatureUnit.celsius), 50);
    });

    test('should return 25 if temperature is higher than 25', () {
      expect(getBulkRiseValue(26, TemperatureUnit.celsius), 25);
    });

    test('should return the correct calculation for farenheit', () {
      expect(getBulkRiseValue(73, TemperatureUnit.farenheit), 50);
    });
  });
}
