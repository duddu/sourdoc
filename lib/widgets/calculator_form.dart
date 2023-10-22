import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sourdoc/constants/form.dart' as form;
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/methods/persist_initial_values.dart';
import 'package:sourdoc/methods/temperature_unit_helpers.dart';
import 'package:sourdoc/models/fermentation_model.dart';
import 'package:sourdoc/models/ingredients_model.dart';
import 'package:sourdoc/models/temperature_unit_model.dart';
import 'package:sourdoc/widgets/text_field_with_affixes.dart';
import 'package:sourdoc/widgets/unit_choice_segmented_button.dart';

class CalculatorForm extends StatefulWidget {
  const CalculatorForm({super.key});

  @override
  State<CalculatorForm> createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {
  final _temperatureController = TextEditingController();
  final _totalWeightController = TextEditingController();
  final _hydrationController = TextEditingController();
  final _saltController = TextEditingController();

  final _unitChoiceList = temperatureUnitSet
      .map((element) => UnitSingleChoiceDescriptor(
          value: element.name,
          label: element.symbol,
          tooltip: element.description))
      .toList();

  double _parseValue(TextEditingController controller) {
    if (controller.value.text.isEmpty) {
      return 0;
    }
    return double.parse(controller.value.text);
  }

  void _updateFermentationValues(TemperatureUnit temperatureUnit) {
    Provider.of<FermentationModel>(context, listen: false)
        .updateFermentationValues(
            temperature: _parseValue(_temperatureController),
            temperatureUnit: temperatureUnit);
  }

  void _updateIngredientsValues() {
    Provider.of<IngredientsModel>(context, listen: false)
        .updateIngredientsValues(
            totalWeight: _parseValue(_totalWeightController),
            hydration: _parseValue(_hydrationController),
            saltLevel: _parseValue(_saltController),
            inoculation: Provider.of<FermentationModel>(context, listen: false)
                .inoculation);
  }

  void _onTemperatureUnitSelectionChanged(TemperatureUnit selection) {
    Provider.of<TemperatureUnitModel>(context, listen: false)
        .updateTemperatureUnit(selection);
    storeInitialValue(temperatureUnitKey, getTemperatureUnitSymbol(selection));
    if (_temperatureController.text.isNotEmpty) {
      _temperatureController.text = convertTemperatureToUnit(
              _parseValue(_temperatureController), selection)
          .toStringAsFixed(1)
          .replaceFirst('.0', '');
      storeInitialValue(temperatureKey, _temperatureController.text);
    }
  }

  void _onTemperatureChanged(TemperatureUnit temperatureUnit) {
    _updateFermentationValues(temperatureUnit);
    _updateIngredientsValues();
    storeInitialValue(temperatureKey, _temperatureController.text);
  }

  void _onTotalWeightChanged() {
    _updateIngredientsValues();
    storeInitialValue(totalWeightKey, _totalWeightController.text);
  }

  void _onHydrationChanged() {
    _updateIngredientsValues();
    storeInitialValue(hydrationKey, _hydrationController.text);
  }

  void _onSaltChanged() {
    _updateIngredientsValues();
    storeInitialValue(saltLevelKey, _saltController.text);
  }

  Future<TemperatureUnit> _getInitialTemperatureSymbol() async {
    final String initialValueUnit = await getInitialOrDefaultValue(
        temperatureUnitKey, form.defaultTemperatureUnitSymbol);
    return getTemperatureUnitName(initialValueUnit);
  }

  Future<void> _loadInitialValues() async {
    final TemperatureUnit initialTemperatureUnit =
        await _getInitialTemperatureSymbol();
    _temperatureController.text = await getInitialOrDefaultValue(
        temperatureKey, form.getDefaultTemperature(initialTemperatureUnit));
    _totalWeightController.text =
        await getInitialOrDefaultValue(totalWeightKey, form.defaultTotalWeight);
    _hydrationController.text =
        await getInitialOrDefaultValue(hydrationKey, form.defaultHydration);
    _saltController.text =
        await getInitialOrDefaultValue(saltLevelKey, form.defaultSaltLevel);
    _updateFermentationValues(initialTemperatureUnit);
    _updateIngredientsValues();
  }

  @override
  void initState() {
    super.initState();
    _loadInitialValues();
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    _totalWeightController.dispose();
    _hydrationController.dispose();
    _saltController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Row>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('${locale.labelTemperatureUnit}:',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .merge(TextStyle(color: Colors.grey.shade800))),
          UnitChoice<TemperatureUnit>(
              a11yLabel: locale.a11yTemperatureUnitChoiceLabel,
              unitList: _unitChoiceList,
              getInitialUnitValue: _getInitialTemperatureSymbol,
              onSelectionChanged: _onTemperatureUnitSelectionChanged),
        ],
      ),
      Row(
        children: <Consumer<TemperatureUnitModel>>[
          Consumer<TemperatureUnitModel>(builder: (context, model, child) {
            return TextFieldWithAffixes(
              paddingTop: 10,
              controller: _temperatureController,
              prefixText: locale.inputPrefixTemperature,
              suffixText: model.temperatureUnitSymbol,
              tooltip: locale.inputTooltipTemperature,
              maxValue: form.getMaxValueTemperature(model.temperatureUnit),
              onChangedCallback: () {
                _onTemperatureChanged(model.temperatureUnit);
              },
            );
          }),
        ],
      ),
      Row(
        children: <TextFieldWithAffixes>[
          TextFieldWithAffixes(
            controller: _totalWeightController,
            prefixText: locale.inputPrefixWeight,
            suffixText: locale.unitGrams,
            tooltip: locale.inputTooltipWeight,
            maxValue: form.maxValueTotalWeight,
            onChangedCallback: _onTotalWeightChanged,
          ),
        ],
      ),
      Row(
        children: <TextFieldWithAffixes>[
          TextFieldWithAffixes(
              controller: _hydrationController,
              prefixText: locale.inputPrefixHydration,
              suffixText: locale.unitPercent,
              tooltip: locale.inputTooltipHydration,
              maxValue: form.maxValueHydration,
              onChangedCallback: _onHydrationChanged),
        ],
      ),
      Row(
        children: <TextFieldWithAffixes>[
          TextFieldWithAffixes(
            controller: _saltController,
            prefixText: locale.inputPrefixSalt,
            suffixText: locale.unitPercent,
            tooltip: locale.inputTooltipSalt,
            maxValue: form.maxValueSaltLevel,
            onChangedCallback: _onSaltChanged,
          ),
        ],
      )
    ]);
  }
}
