import 'package:flutter/foundation.dart';
import 'package:sourdoc/constants/form.dart' as form;
import 'package:sourdoc/methods/convert_temperature_unit.dart';

class TemperatureUnitModel extends ChangeNotifier {
  TemperatureUnit _temperatureUnit = form.defaultTemperatureUnit;

  TemperatureUnit get temperatureUnit => _temperatureUnit;
  String get temperatureUnitToString =>
      temperatureUnitMap[_temperatureUnit]!.unit;

  void updateTemperatureUnit(TemperatureUnit newTemperatureUnit) {
    if (newTemperatureUnit == _temperatureUnit) {
      return;
    }
    _temperatureUnit = newTemperatureUnit;

    notifyListeners();
  }
}
