import 'package:flutter_test/flutter_test.dart';
import 'package:sourdoc/methods/convert_temperature_unit.dart';
import 'package:sourdoc/models/temperature_unit_model.dart';

void main() {
  group('TemperatureUnitModel', () {
    test('should have a default unit', () {
      final model = TemperatureUnitModel();
      expect(model.temperatureUnit, TemperatureUnit.celsius);
    });

    test('should have a default unit to string', () {
      final model = TemperatureUnitModel();
      expect(model.temperatureUnitToString,
          temperatureUnitMap[TemperatureUnit.celsius]!.unit);
    });

    test('should update unit', () {
      final model = TemperatureUnitModel();
      var i = 0;
      model.addListener(() {
        expect(model.temperatureUnit, TemperatureUnit.farenheit);
        expect(model.temperatureUnitToString,
            temperatureUnitMap[TemperatureUnit.farenheit]!.unit);
        i++;
      });
      model.updateTemperatureUnit(TemperatureUnit.farenheit);
      expect(i, 1);
    });

    test('update should skip if unit did not change', () {
      final model = TemperatureUnitModel();
      var i = 0;
      model.addListener(() {
        i++;
      });
      model.updateTemperatureUnit(TemperatureUnit.celsius);
      expect(i, 0);
    });
  });
}
