import 'package:flutter/material.dart';
import 'package:sourdoc/methods/temperature_unit_helpers.dart';
import 'package:sourdoc/methods/get_fermentation_values.dart';

class FermentationModel extends ChangeNotifier {
  double _inoculation = 0;
  double _bulkRise = 0;

  double get inoculation => _inoculation;
  double get bulkRise => _bulkRise;

  TextEditingController temperatureController = TextEditingController();

  double _parseValue(TextEditingController controller) {
    if (controller.value.text.isEmpty) {
      return 0;
    }
    return double.parse(controller.value.text);
  }

  void updateFermentationValues() {
    final double temperature = _parseValue(temperatureController);

    _inoculation = getInoculationValue(temperature, _temperatureUnit);
    _bulkRise = getBulkRiseValue(temperature, _temperatureUnit);

    notifyListeners();
  }

  late TemperatureUnit _temperatureUnit;

  void updateTemperatureUnit(TemperatureUnit temperatureUnit) {
    _temperatureUnit = temperatureUnit;
    updateFermentationValues();
  }
}
