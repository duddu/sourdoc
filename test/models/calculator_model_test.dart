import 'package:flutter_test/flutter_test.dart';
import 'package:sourdoc/methods/convert_temperature_unit.dart';
import 'package:sourdoc/models/calculator_model.dart';

void main() {
  group('CalculatorModel', () {
    test('should have default unit', () {
      final model = CalculatorModel();
      expect(model.inoculation, 0);
      expect(model.bulkRise, 0);
      expect(model.flour, 0);
      expect(model.water, 0);
      expect(model.levain, 0);
      expect(model.salt, 0);
    });

    test('should update fermentation values', () {
      final model = CalculatorModel();
      var i = 0;
      model.addListener(() {
        expect(model.inoculation, greaterThan(0));
        expect(model.bulkRise, greaterThan(0));
        expect(model.flour, 0);
        expect(model.water, 0);
        expect(model.levain, 0);
        expect(model.salt, 0);
        i++;
      });
      model.updateFermentationValues(1, TemperatureUnit.celsius);
      expect(i, 1);
    });

    test('should update ingredients values', () {
      final model = CalculatorModel();
      model.updateFermentationValues(1, TemperatureUnit.celsius);
      var i = 0;
      model.addListener(() {
        expect(model.flour, greaterThan(0));
        expect(model.water, greaterThan(0));
        expect(model.levain, greaterThan(0));
        expect(model.salt, greaterThan(0));
        i++;
      });
      model.updateIngredientsValues(1, 1, 1);
      expect(i, 1);
    });
  });
}
