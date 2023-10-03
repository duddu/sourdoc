import 'package:flutter/material.dart';
import 'package:sourdoc/constants/defaults.dart' as defaults;
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/style.dart' as style;
import 'package:sourdoc/methods/convert_temperature_unit.dart';
import 'package:sourdoc/methods/get_fermentation_values.dart';
import 'package:sourdoc/methods/get_ingredients_values.dart';
import 'package:sourdoc/methods/persist_default_values.dart';
import 'package:sourdoc/widgets/full_width_container_with_label_and_value.dart';
import 'package:sourdoc/widgets/full_width_header_with_padding.dart';
import 'package:sourdoc/widgets/full_width_text_field_with_affixes.dart';
import 'package:sourdoc/widgets/unit_choice_segmented_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _inoculation = 0;
  double _bulkRise = 0;
  double _flour = 0;
  double _water = 0;
  double _levain = 0;
  double _salt = 0;
  TemperatureUnit _temperatureUnit = defaults.temperatureUnit;

  final totalWeightController = TextEditingController();
  final hydrationController = TextEditingController();
  final saltController = TextEditingController();
  final temperatureController = TextEditingController();

  double _parseValue(TextEditingController controller) {
    if (controller.value.text.isEmpty) {
      return 0;
    }
    return double.parse(controller.value.text);
  }

  void _updateFermentationValues() {
    final temperature = _parseValue(temperatureController);

    _inoculation = getInoculationValue(temperature, _temperatureUnit);
    _bulkRise = getBulkRiseValue(temperature, _temperatureUnit);
  }

  void _updateFermentationState() {
    setState(() {
      _updateFermentationValues();
      _updateIngredientsValues();
    });
  }

  void _updateIngredientsValues() {
    final totalWeight = _parseValue(totalWeightController);
    final hydration = _parseValue(hydrationController);
    final saltLevel = _parseValue(saltController);

    _flour = getFlourValue(totalWeight, hydration, saltLevel, _inoculation);
    _water = getNonFlourIngredientValue(_flour, hydration);
    _levain = getNonFlourIngredientValue(_flour, _inoculation);
    _salt = getNonFlourIngredientValue(_flour, saltLevel);
  }

  void _updateIngredientsState() {
    setState(() {
      _updateIngredientsValues();
    });
  }

  void _updateTemperatureUnit(selection) {
    setState(() {
      _temperatureUnit = temperatureUnitMap.entries
          .firstWhere((element) => element.value == selection)
          .key;
      temperatureController.text = convertTemperatureUnit(
              _parseValue(temperatureController), _temperatureUnit)
          .toStringAsFixed(0);
      _storeTemperatureUnit();
    });
  }

  void _storeTemperatureUnit() => storeDefaultValue(
      temperatureUnitKey, temperatureUnitMap[_temperatureUnit]!);

  void _storeTemperatureValue() =>
      storeDefaultValue(temperatureKey, temperatureController.text);

  void _storeTotalWeightValue() =>
      storeDefaultValue(totalWeightKey, totalWeightController.text);

  void _storeHydrationValue() =>
      storeDefaultValue(hydrationKey, hydrationController.text);

  void _storeSaltLevelValue() =>
      storeDefaultValue(saltLevelKey, saltController.text);

  Future<void> _loadStoredValuesOrDefaults() async {
    final String defaultTemperatureUnitValue = await getDefaultValue(
        temperatureUnitKey, defaults.temperatureUnitValue);
    _temperatureUnit = temperatureUnitMap.entries
        .firstWhere((element) => element.value == defaultTemperatureUnitValue)
        .key;
    temperatureController.text = await getDefaultValue(
        temperatureKey, defaults.temperatureMap[_temperatureUnit]!);
    totalWeightController.text =
        await getDefaultValue(totalWeightKey, defaults.totalWeight);
    hydrationController.text =
        await getDefaultValue(hydrationKey, defaults.hydration);
    saltController.text =
        await getDefaultValue(saltLevelKey, defaults.saltLevel);

    _updateFermentationValues();
    _updateIngredientsValues();
  }

  @override
  initState() {
    super.initState();

    _loadStoredValuesOrDefaults();

    temperatureController.addListener(_updateFermentationState);
    temperatureController.addListener(_storeTemperatureValue);
    totalWeightController.addListener(_updateIngredientsState);
    totalWeightController.addListener(_storeTotalWeightValue);
    hydrationController.addListener(_updateIngredientsState);
    hydrationController.addListener(_storeHydrationValue);
    saltController.addListener(_updateIngredientsState);
    saltController.addListener(_storeSaltLevelValue);
  }

  @override
  void dispose() {
    totalWeightController.dispose();
    hydrationController.dispose();
    saltController.dispose();
    temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(widget.title, style: const TextStyle(color: Colors.white)),
          const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                Icons.calculate_rounded,
                color: Colors.white,
              ))
        ]),
      ),
      body: Center(
          child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: style.bodyContainerMaxWidth),
              child: ListView(
                primary: true,
                padding: const EdgeInsets.only(bottom: 25),
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .inversePrimary
                              .withAlpha(170)),
                      child: const Padding(
                          padding: EdgeInsets.fromLTRB(style.viewLateralPadding,
                              10, style.viewLateralPadding, 11),
                          child: Text(
                            locale.formIntro,
                            textAlign: TextAlign.start,
                          ))),
                  Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(20),
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Colors.grey.shade300))),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              style.viewLateralPadding,
                              12,
                              style.viewLateralPadding,
                              12),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('${locale.labelTemperatureUnit}:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade800)),
                                    UnitChoice(
                                        unitList:
                                            temperatureUnitMap.values.toList(),
                                        initialUnitValue: temperatureUnitMap[
                                            _temperatureUnit]!,
                                        onSelectionChanged:
                                            _updateTemperatureUnit),
                                  ]),
                            ),
                            Row(
                              children: <FullWidthTextFieldWithAffixes>[
                                FullWidthTextFieldWithAffixes(
                                  controller: temperatureController,
                                  prefixText: locale.inputPrefixTemperature,
                                  suffixText:
                                      temperatureUnitMap[_temperatureUnit]!,
                                ),
                              ],
                            ),
                            Row(
                              children: <FullWidthTextFieldWithAffixes>[
                                FullWidthTextFieldWithAffixes(
                                  controller: totalWeightController,
                                  prefixText: locale.inputPrefixWeight,
                                  suffixText: locale.unitGrams,
                                ),
                              ],
                            ),
                            Row(
                              children: <FullWidthTextFieldWithAffixes>[
                                FullWidthTextFieldWithAffixes(
                                  controller: hydrationController,
                                  prefixText: locale.inputPrefixHydration,
                                  suffixText: locale.unitPercent,
                                ),
                              ],
                            ),
                            Row(
                              children: <FullWidthTextFieldWithAffixes>[
                                FullWidthTextFieldWithAffixes(
                                  controller: saltController,
                                  prefixText: locale.inputPrefixSalt,
                                  suffixText: locale.unitPercent,
                                ),
                              ],
                            )
                          ]))),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(
                          style.viewLateralPadding,
                          0,
                          style.viewLateralPadding,
                          0),
                      child: Column(children: [
                        const Row(
                          children: <FullWidthHeaderWithPadding>[
                            FullWidthHeaderWithPadding(
                              text: locale.headerIngredients,
                            )
                          ],
                        ),
                        FullWidthContainerWithLabelAndValue(
                            label: locale.labelFlour,
                            value:
                                '${_flour.toStringAsFixed(1)}${locale.unitGrams}'),
                        FullWidthContainerWithLabelAndValue(
                            label: locale.labelWater,
                            value:
                                '${_water.toStringAsFixed(1)}${locale.unitGrams}'),
                        FullWidthContainerWithLabelAndValue(
                            label: locale.labelLevain,
                            value:
                                '${_levain.toStringAsFixed(1)}${locale.unitGrams}'),
                        FullWidthContainerWithLabelAndValue(
                            label: locale.labelSalt,
                            value:
                                '${_salt.toStringAsFixed(1)}${locale.unitGrams}'),
                        const Row(
                          children: <FullWidthHeaderWithPadding>[
                            FullWidthHeaderWithPadding(
                              text: locale.headerFermentation,
                            )
                          ],
                        ),
                        FullWidthContainerWithLabelAndValue(
                            label: locale.labelInoculation,
                            value:
                                '${_inoculation.toStringAsFixed(0)}${locale.unitPercent}',
                            additionalInfoText:
                                locale.additionalInfoInoculation),
                        FullWidthContainerWithLabelAndValue(
                            label: locale.labelBulkRise,
                            value:
                                '${_bulkRise.toStringAsFixed(0)}${locale.unitPercent}',
                            additionalInfoText: locale.additionalInfoBulkRise),
                      ]))
                ],
              ))),
    );
  }
}
