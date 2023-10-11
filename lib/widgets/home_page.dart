import 'package:flutter/material.dart';
import 'package:sourdoc/constants/form.dart' as form;
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/methods/convert_temperature_unit.dart';
import 'package:sourdoc/methods/get_fermentation_values.dart';
import 'package:sourdoc/methods/get_ingredients_values.dart';
import 'package:sourdoc/methods/persist_initial_values.dart';
import 'package:sourdoc/widgets/app_bar_title.dart';
import 'package:sourdoc/widgets/centered_container.dart';
import 'package:sourdoc/widgets/help_page.dart';
import 'package:sourdoc/widgets/variable_with_label.dart';
import 'package:sourdoc/widgets/header.dart';
import 'package:sourdoc/widgets/text_field_with_affixes.dart';
import 'package:sourdoc/widgets/unit_choice_segmented_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
  TemperatureUnit _temperatureUnit = form.defaultTemperatureUnit;

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
          .firstWhere((element) => element.value.unit == selection)
          .key;
      temperatureController.text = convertTemperatureUnit(
              _parseValue(temperatureController), _temperatureUnit)
          .toStringAsFixed(1)
          .replaceFirst('.0', '');
      _storeTemperatureUnit();
    });
  }

  void _storeTemperatureUnit() => storeInitialValue(
      temperatureUnitKey, temperatureUnitMap[_temperatureUnit]!.unit);

  void _storeTemperatureValue() =>
      storeInitialValue(temperatureKey, temperatureController.text);

  void _storeTotalWeightValue() =>
      storeInitialValue(totalWeightKey, totalWeightController.text);

  void _storeHydrationValue() =>
      storeInitialValue(hydrationKey, hydrationController.text);

  void _storeSaltLevelValue() =>
      storeInitialValue(saltLevelKey, saltController.text);

  Future<void> _loadInitialValues() async {
    final String defaultTemperatureUnitValue = await getInitialOrDefaultValue(
        temperatureUnitKey, form.defaultTemperatureUnitValue);
    _temperatureUnit = temperatureUnitMap.entries
        .firstWhere(
            (element) => element.value.unit == defaultTemperatureUnitValue)
        .key;
    temperatureController.text = await getInitialOrDefaultValue(
        temperatureKey, form.defaultTemperatureMap[_temperatureUnit]!);
    totalWeightController.text =
        await getInitialOrDefaultValue(totalWeightKey, form.defaultTotalWeight);
    hydrationController.text =
        await getInitialOrDefaultValue(hydrationKey, form.defaultHydration);
    saltController.text =
        await getInitialOrDefaultValue(saltLevelKey, form.defaultSaltLevel);

    _updateFermentationValues();
    _updateIngredientsValues();
  }

  @override
  initState() {
    super.initState();

    _loadInitialValues();

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

  Route _createHelpRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HelpPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          titleSpacing: 0,
          title: AppBarTitle(
              title: Semantics(
                  label: locale.a11yAppBarHomeTitleLabel,
                  child: const Text(locale.title,
                      style: TextStyle(color: Colors.white))),
              icon: const Icon(
                Icons.calculate_rounded,
                color: Colors.white,
                semanticLabel: locale.a11yAppBarHomeTitleIconLabel,
              ),
              action: Semantics(
                  button: true,
                  label: locale.a11yAppBarHomeHelpButtonLabel,
                  hint: locale.a11yAppBarHomeHelpButtonHint,
                  tooltip: locale.appBarHomeHelpButtonTooltip,
                  child: IconButton(
                      icon: const Icon(
                        Icons.question_mark_rounded,
                        semanticLabel: locale.a11yAppBarHomeHelpButtonIconLabel,
                        color: Colors.white,
                      ),
                      color: Colors.white,
                      tooltip: locale.appBarHomeHelpButtonTooltip,
                      onPressed: () {
                        Navigator.of(context).push(_createHelpRoute());
                      })))),
      body: ListView(
        primary: true,
        padding: const EdgeInsets.only(bottom: 25),
        children: <CenteredContainer>[
          CenteredContainer(
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .inversePrimary
                      .withAlpha(170)),
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 11),
              child: Semantics(
                  label: locale.a11yFormIntroLabel,
                  child: const Text(
                    locale.formIntro,
                    textAlign: TextAlign.start,
                  ))),
          CenteredContainer(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(20),
                  border: Border(
                      bottom:
                          BorderSide(width: 1, color: Colors.grey.shade300))),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Row>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${locale.labelTemperatureUnit}:',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade800)),
                    UnitChoice(
                        a11yLabel: locale.a11yTemperatureUnitChoiceLabel,
                        unitList: temperatureUnitMap.values
                            .map((element) => UnitSingleChoiceDescriptor(
                                value: element.unit,
                                tooltip: element.description))
                            .toList(),
                        initialUnitValue:
                            temperatureUnitMap[_temperatureUnit]!.unit,
                        onSelectionChanged: _updateTemperatureUnit),
                  ],
                ),
                Row(
                  children: <TextFieldWithAffixes>[
                    TextFieldWithAffixes(
                      paddingTop: 10,
                      controller: temperatureController,
                      prefixText: locale.inputPrefixTemperature,
                      suffixText: temperatureUnitMap[_temperatureUnit]!.unit,
                      maxValue: form.maxValueTemperatureMap[_temperatureUnit]!,
                    ),
                  ],
                ),
                Row(
                  children: <TextFieldWithAffixes>[
                    TextFieldWithAffixes(
                      controller: totalWeightController,
                      prefixText: locale.inputPrefixWeight,
                      suffixText: locale.unitGrams,
                      maxValue: form.maxValueTotalWeight,
                    ),
                  ],
                ),
                Row(
                  children: <TextFieldWithAffixes>[
                    TextFieldWithAffixes(
                      controller: hydrationController,
                      prefixText: locale.inputPrefixHydration,
                      suffixText: locale.unitPercent,
                      maxValue: form.maxValueHydration,
                    ),
                  ],
                ),
                Row(
                  children: <TextFieldWithAffixes>[
                    TextFieldWithAffixes(
                      controller: saltController,
                      prefixText: locale.inputPrefixSalt,
                      suffixText: locale.unitPercent,
                      maxValue: form.maxValueSaltLevel,
                    ),
                  ],
                )
              ])),
          CenteredContainer(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(children: <Row>[
                const Row(children: <Header>[
                  Header(
                    text: locale.headerIngredients,
                  )
                ]),
                Row(children: <VariableWithLabel>[
                  VariableWithLabel(
                      label: locale.variableLabelFlour,
                      value: '${_flour.toStringAsFixed(1)}${locale.unitGrams}')
                ]),
                Row(children: <VariableWithLabel>[
                  VariableWithLabel(
                      label: locale.variableLabelWater,
                      value: '${_water.toStringAsFixed(1)}${locale.unitGrams}')
                ]),
                Row(children: <VariableWithLabel>[
                  VariableWithLabel(
                      label: locale.variableLabelLevain,
                      value: '${_levain.toStringAsFixed(1)}${locale.unitGrams}')
                ]),
                Row(children: <VariableWithLabel>[
                  VariableWithLabel(
                      label: locale.variableLabelSalt,
                      value: '${_salt.toStringAsFixed(1)}${locale.unitGrams}')
                ]),
                const Row(children: <Header>[
                  Header(
                    text: locale.headerFermentation,
                  )
                ]),
                Row(children: <VariableWithLabel>[
                  VariableWithLabel(
                      label: locale.variableLabelInoculation,
                      value:
                          '${_inoculation.toStringAsFixed(0)}${locale.unitPercent}',
                      additionalInfoText: locale.additionalInfoInoculation)
                ]),
                Row(children: <VariableWithLabel>[
                  VariableWithLabel(
                      label: locale.variableLabelDoughRise,
                      value:
                          '${_bulkRise.toStringAsFixed(0)}${locale.unitPercent}',
                      additionalInfoText: locale.additionalInfoDoughRise)
                ]),
              ]))
        ],
      ),
    );
  }
}
