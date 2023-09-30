import 'package:flutter_test/flutter_test.dart';

import 'package:sourdoc/methods/get_fermentation_values.dart';

void main() {
  group('getInoculationValue', () {
    test('should return 0 if temperature is higher than 41', () {
      expect(getInoculationValue(42), 0);
    });

    test('should return the correct calculation', () {
      expect(getInoculationValue(25), 16);
    });
  });

  group('getBulkRiseValue', () {
    test('should return 100 if temperature is lower than 21', () {
      expect(getBulkRiseValue(20), 100);
    });

    test('should return 50 if temperature is 21', () {
      expect(getBulkRiseValue(21), 50);
    });

    test('should return 50 if temperature is higher than 21 and lower than 25',
        () {
      expect(getBulkRiseValue(23), 50);
    });

    test('should return 50 if temperature is 25', () {
      expect(getBulkRiseValue(25), 50);
    });

    test('should return 25 if temperature is higher than 25', () {
      expect(getBulkRiseValue(26), 25);
    });
  });
}
