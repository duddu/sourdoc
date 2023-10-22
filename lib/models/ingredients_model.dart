import 'package:flutter/material.dart';
import 'package:sourdoc/methods/get_ingredients_values.dart';

class IngredientsModel extends ChangeNotifier {
  double _flour = 0;
  double _water = 0;
  double _levain = 0;
  double _salt = 0;

  double get flour => _flour;
  double get water => _water;
  double get levain => _levain;
  double get salt => _salt;

  void updateIngredientsValues(
      {required double totalWeight,
      required double hydration,
      required double saltLevel,
      required double inoculation}) {
    _flour = getFlourValue(totalWeight, hydration, saltLevel, inoculation);
    _water = getNonFlourIngredientValue(_flour, hydration);
    _levain = getNonFlourIngredientValue(_flour, inoculation);
    _salt = getNonFlourIngredientValue(_flour, saltLevel);

    notifyListeners();
  }
}
