import 'package:flutter_test/flutter_test.dart';

import 'package:sourdoc/methods/get_ingredients_values.dart';

void main() {
  group('getflourValue', () {
    test('should return 0 if total weight is negative', () {
      expect(getFlourValue(-1, 70, 2, 20), 0);
    });

    test('should return 0 if hydration is negative', () {
      expect(getFlourValue(492, -1, 2, 20), 0);
    });

    test('should return 0 if salt level is negative', () {
      expect(getFlourValue(492, 70, -1, 20), 0);
    });

    test('should return 0 if inoculation is negative', () {
      expect(getFlourValue(492, 70, 2, -1), 0);
    });

    test('should return the correct calculation', () {
      expect(getFlourValue(492, 70, 2, 20), 256.25);
    });
  });

  group('getNonFlourIngredientValue', () {
    test('should return 0 if the dependent level is negative', () {
      expect(getNonFlourIngredientValue(300, -1), 0);
    });

    test('should return 0 if the dependent level is 0', () {
      expect(getNonFlourIngredientValue(300, 0), 0);
    });

    test('should return the correct calculation', () {
      expect(getNonFlourIngredientValue(300, 25), 75);
    });
  });
}
