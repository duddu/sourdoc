import 'package:flutter_test/flutter_test.dart';
import 'package:sourdoc/methods/temperature_unit_helpers.dart';
import 'package:sourdoc/models/fermentation_model.dart';

void main() {
  group('FermentationModel', () {
    test('should have fermentation values', () {
      final model = FermentationModel();
      expect(model.inoculation, 0);
      expect(model.bulkRise, 0);
    });

    test('should update fermentation values', () {
      final model = FermentationModel();
      var i = 0;
      model.addListener(() {
        expect(model.inoculation, greaterThan(0));
        expect(model.bulkRise, greaterThan(0));
        i++;
      });
      model.updateFermentationValues(
          temperature: 20, temperatureUnit: TemperatureUnit.celsius);
      expect(i, 1);
    });
  });
}
