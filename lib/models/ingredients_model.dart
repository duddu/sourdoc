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

  TextEditingController totalWeightController = TextEditingController();
  TextEditingController hydrationController = TextEditingController();
  TextEditingController saltController = TextEditingController();

  double _parseValue(TextEditingController controller) {
    if (controller.value.text.isEmpty) {
      return 0;
    }
    return double.parse(controller.value.text);
  }

  void updateIngredientsValues() {
    final double totalWeight = _parseValue(totalWeightController);
    final double hydration = _parseValue(hydrationController);
    final double saltLevel = _parseValue(saltController);

    _flour = getFlourValue(totalWeight, hydration, saltLevel, _inoculation);
    _water = getNonFlourIngredientValue(_flour, hydration);
    _levain = getNonFlourIngredientValue(_flour, _inoculation);
    _salt = getNonFlourIngredientValue(_flour, saltLevel);

    notifyListeners();
  }

  late double _inoculation;

  void updateInoculation(double inoculation) {
    _inoculation = inoculation;
    updateIngredientsValues();
  }
}
