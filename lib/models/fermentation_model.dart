import 'package:flutter/material.dart';
import 'package:sourdoc/methods/temperature_unit_helpers.dart';
import 'package:sourdoc/methods/get_fermentation_values.dart';

class FermentationModel extends ChangeNotifier {
  double _inoculation = 0;
  double _bulkRise = 0;

  double get inoculation => _inoculation;
  double get bulkRise => _bulkRise;

  void updateFermentationValues(
      {required double temperature, required TemperatureUnit temperatureUnit}) {
    _inoculation = getInoculationValue(temperature, temperatureUnit);
    _bulkRise = getBulkRiseValue(temperature, temperatureUnit);

    notifyListeners();
  }
}
