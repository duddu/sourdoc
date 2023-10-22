import 'package:flutter_test/flutter_test.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/methods/temperature_unit_helpers.dart';

void main() {
  group('temperatureUnitSet', () {
    test('should have the correct lenght', () {
      expect(temperatureUnitSet.length, 2);
    });

    test('should have the correct ordered keys', () {
      expect(
          temperatureUnitSet
              .singleWhere((unit) => unit.name == TemperatureUnit.celsius),
          isInstanceOf<TemperatureUnitDescriptor>());
      expect(
          temperatureUnitSet
              .singleWhere((unit) => unit.name == TemperatureUnit.farenheit),
          isInstanceOf<TemperatureUnitDescriptor>());
    });
  });

  group('getTemperatureUnitSymbol', () {
    test('should get the unit\'s symbol from its name', () {
      expect(getTemperatureUnitSymbol(TemperatureUnit.celsius),
          locale.unitDegreesCelsius);
      expect(getTemperatureUnitSymbol(TemperatureUnit.farenheit),
          locale.unitDegreesFarenheit);
    });
  });

  group('getTemperatureUnitSymbol', () {
    test('should get the unit\'s name from its symbol', () {
      expect(getTemperatureUnitName(locale.unitDegreesCelsius),
          TemperatureUnit.celsius);
      expect(getTemperatureUnitName(locale.unitDegreesFarenheit),
          TemperatureUnit.farenheit);
    });
  });

  group('convertTemperatureUnit', () {
    test('should convert farenheit to celsius', () {
      expect(convertTemperatureToUnit(20, TemperatureUnit.farenheit), 68);
    });

    test('should convert celsius to farenheit', () {
      expect(convertTemperatureToUnit(68, TemperatureUnit.celsius), 20);
    });
  });
}
