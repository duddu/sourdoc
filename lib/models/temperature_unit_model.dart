import 'package:flutter/foundation.dart';
import 'package:sourdoc/constants/form.dart' as form;
import 'package:sourdoc/methods/temperature_unit_helpers.dart';

class TemperatureUnitModel extends ChangeNotifier {
  TemperatureUnit _temperatureUnit = form.defaultTemperatureUnit;

  TemperatureUnit get temperatureUnit => _temperatureUnit;
  String get temperatureUnitSymbol =>
      getTemperatureUnitSymbol(_temperatureUnit);

  void updateTemperatureUnit(TemperatureUnit newTemperatureUnit) {
    if (newTemperatureUnit == _temperatureUnit) {
      return;
    }
    _temperatureUnit = newTemperatureUnit;

    notifyListeners();
  }
}
