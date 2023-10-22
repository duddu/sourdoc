import 'package:flutter_test/flutter_test.dart';
import 'package:sourdoc/models/ingredients_model.dart';

void main() {
  group('IngredientsModel', () {
    test('should have ingredients values', () {
      final model = IngredientsModel();
      expect(model.flour, 0);
      expect(model.water, 0);
      expect(model.levain, 0);
      expect(model.salt, 0);
    });

    test('should update ingredients values', () {
      final model = IngredientsModel();
      var i = 0;
      model.addListener(() {
        expect(model.flour, greaterThan(0));
        expect(model.water, greaterThan(0));
        expect(model.levain, greaterThan(0));
        expect(model.salt, greaterThan(0));
        i++;
      });
      model.updateIngredientsValues(
          totalWeight: 100, hydration: 10, saltLevel: 1, inoculation: 20);
      expect(i, 1);
    });
  });
}
