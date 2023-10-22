import 'package:flutter/foundation.dart';
import 'package:sourdoc/methods/temperature_unit_helpers.dart';
import 'package:sourdoc/methods/get_fermentation_values.dart';
import 'package:sourdoc/methods/get_ingredients_values.dart';

class CalculatorModel extends ChangeNotifier {
  double _inoculation = 0;
  double _bulkRise = 0;
  double _flour = 0;
  double _water = 0;
  double _levain = 0;
  double _salt = 0;

  double get inoculation => _inoculation;
  double get bulkRise => _bulkRise;
  double get flour => _flour;
  double get water => _water;
  double get levain => _levain;
  double get salt => _salt;

  void updateFermentationValues(
      double temperature, TemperatureUnit temperatureUnit) {
    _inoculation = getInoculationValue(temperature, temperatureUnit);
    _bulkRise = getBulkRiseValue(temperature, temperatureUnit);
    notifyListeners();
  }

  void updateIngredientsValues(
      double totalWeight, double hydration, double saltLevel) {
    _flour = getFlourValue(totalWeight, hydration, saltLevel, _inoculation);
    _water = getNonFlourIngredientValue(_flour, hydration);
    _levain = getNonFlourIngredientValue(_flour, _inoculation);
    _salt = getNonFlourIngredientValue(_flour, saltLevel);
    notifyListeners();
  }
}
