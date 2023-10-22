import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sourdoc/constants/form.dart' as form;
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/routes.dart';
import 'package:sourdoc/constants/style.dart' as style;
import 'package:sourdoc/methods/temperature_unit_helpers.dart';
import 'package:sourdoc/methods/persist_initial_values.dart';
import 'package:sourdoc/models/calculator_model.dart';
import 'package:sourdoc/models/temperature_unit_model.dart';
import 'package:sourdoc/widgets/app_bar_with_actions.dart';
import 'package:sourdoc/widgets/centered_container.dart';
import 'package:sourdoc/widgets/variable_with_label.dart';
import 'package:sourdoc/widgets/header.dart';
import 'package:sourdoc/widgets/text_field_with_affixes.dart';
import 'package:sourdoc/widgets/unit_choice_segmented_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithTitle(
          context,
          AppBarTitleWithAction(
              title: Semantics(
                  label: locale.a11yAppBarHomeTitleLabel,
                  child: const Text(locale.title,
                      style: TextStyle(color: Colors.white))),
              logo: true,
              action: Semantics(
                  button: true,
                  label: locale.a11yAppBarHomeActionButtonLabel,
                  hint: locale.a11yAppBarHomeActionButtonHint,
                  tooltip: locale.appBarHomeActionButtonTooltip,
                  child: IconButton(
                      icon: const Icon(
                        Icons.question_mark_rounded,
                        semanticLabel:
                            locale.a11yAppBarHomeActionButtonIconLabel,
                        color: Colors.white,
                      ),
                      color: Colors.white,
                      tooltip: locale.appBarHomeActionButtonTooltip,
                      onPressed: () {
                        Navigator.pushNamed(context, helpPagePath);
                      })))),
      body: ChangeNotifierProvider(
          create: (context) => CalculatorModel(),
          child: const HomePageListView()),
    );
  }
}

class HomePageListView extends StatelessWidget {
  const HomePageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      padding: const EdgeInsets.only(bottom: 35),
      children: [
        CenteredContainer(
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .inversePrimary
                    .withAlpha(170)),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              style.isMobileScreenWidth(context)
                  ? locale.formIntro
                  : locale.formIntroLarge,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium,
            )),
        Card(
            margin: EdgeInsets.zero,
            semanticContainer: false,
            shape: const RoundedRectangleBorder(),
            child: CenteredContainer(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ChangeNotifierProvider(
                    create: (context) => TemperatureUnitModel(),
                    child: const CalculatorForm()))),
        const CenteredContainer(child: IngredientsValues()),
        const CenteredContainer(child: FermentationValues()),
      ],
    );
  }
}

class CalculatorForm extends StatefulWidget {
  const CalculatorForm({super.key});

  @override
  State<CalculatorForm> createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {
  final temperatureController = TextEditingController();
  final totalWeightController = TextEditingController();
  final hydrationController = TextEditingController();
  final saltController = TextEditingController();

  final unitChoiceList = temperatureUnitSet
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
    Provider.of<CalculatorModel>(context, listen: false)
        .updateFermentationValues(
            _parseValue(temperatureController), temperatureUnit);
  }

  void _updateIngredientsValues() {
    Provider.of<CalculatorModel>(context, listen: false)
        .updateIngredientsValues(_parseValue(totalWeightController),
            _parseValue(hydrationController), _parseValue(saltController));
  }

  void _onTemperatureUnitSelectionChanged(TemperatureUnit selection) {
    Provider.of<TemperatureUnitModel>(context, listen: false)
        .updateTemperatureUnit(selection);
    storeInitialValue(temperatureUnitKey, getTemperatureUnitSymbol(selection));
    if (temperatureController.text.isNotEmpty) {
      temperatureController.text = convertTemperatureToUnit(
              _parseValue(temperatureController), selection)
          .toStringAsFixed(1)
          .replaceFirst('.0', '');
      storeInitialValue(temperatureKey, temperatureController.text);
    }
  }

  void _onTemperatureChanged(TemperatureUnit temperatureUnit) {
    _updateFermentationValues(temperatureUnit);
    _updateIngredientsValues();
    storeInitialValue(temperatureKey, temperatureController.text);
  }

  void _onTotalWeightChanged() {
    _updateIngredientsValues();
    storeInitialValue(totalWeightKey, totalWeightController.text);
  }

  void _onHydrationChanged() {
    _updateIngredientsValues();
    storeInitialValue(hydrationKey, hydrationController.text);
  }

  void _onSaltChanged() {
    _updateIngredientsValues();
    storeInitialValue(saltLevelKey, saltController.text);
  }

  Future<TemperatureUnit> _getInitialTemperatureSymbol() async {
    final String initialValueUnit = await getInitialOrDefaultValue(
        temperatureUnitKey, form.defaultTemperatureUnitSymbol);
    return getTemperatureUnitName(initialValueUnit);
  }

  Future<void> _loadInitialValues() async {
    final TemperatureUnit initialTemperatureUnit =
        await _getInitialTemperatureSymbol();
    temperatureController.text = await getInitialOrDefaultValue(
        temperatureKey, form.getDefaultTemperature(initialTemperatureUnit));
    totalWeightController.text =
        await getInitialOrDefaultValue(totalWeightKey, form.defaultTotalWeight);
    hydrationController.text =
        await getInitialOrDefaultValue(hydrationKey, form.defaultHydration);
    saltController.text =
        await getInitialOrDefaultValue(saltLevelKey, form.defaultSaltLevel);
    _updateFermentationValues(initialTemperatureUnit);
    _updateIngredientsValues();
  }

  @override
  initState() {
    super.initState();
    _loadInitialValues();
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
              unitList: unitChoiceList,
              getInitialUnitValue: _getInitialTemperatureSymbol,
              onSelectionChanged: _onTemperatureUnitSelectionChanged),
        ],
      ),
      Row(
        children: <Consumer<TemperatureUnitModel>>[
          Consumer<TemperatureUnitModel>(builder: (context, model, child) {
            return TextFieldWithAffixes(
              paddingTop: 10,
              controller: temperatureController,
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
            controller: totalWeightController,
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
              controller: hydrationController,
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
            controller: saltController,
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

class IngredientsValues extends StatelessWidget {
  const IngredientsValues({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorModel>(builder: (context, model, child) {
      return Column(children: <Row>[
        const Row(children: <Header>[
          Header(
            text: locale.headerIngredients,
            paddingTop: 25,
          )
        ]),
        Row(children: [
          VariableWithLabel(
            label: locale.variableLabelFlour,
            value: model.flour,
            fractionDigits: 1,
            unit: locale.unitGrams,
            noMarginLeft: true,
          ),
          VariableWithLabel(
              label: locale.variableLabelWater,
              value: model.water,
              fractionDigits: 1,
              unit: locale.unitGrams),
          VariableWithLabel(
              label: locale.variableLabelLevain,
              value: model.levain,
              fractionDigits: 1,
              unit: locale.unitGrams),
          VariableWithLabel(
              label: locale.variableLabelSalt,
              value: model.salt,
              fractionDigits: 1,
              unit: locale.unitGrams)
        ]),
      ]);
    });
  }
}

class FermentationValues extends StatelessWidget {
  const FermentationValues({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorModel>(builder: (context, model, child) {
      return Column(children: <Row>[
        const Row(children: <Header>[Header(text: locale.headerFermentation)]),
        Row(children: <VariableWithLabel>[
          VariableWithLabel(
            label: locale.variableLabelInoculation,
            value: model.inoculation,
            fractionDigits: 0,
            unit: locale.unitPercent,
            additionalInfoText: locale.additionalInfoInoculation,
            noMarginLeft: true,
          ),
          VariableWithLabel(
              label: locale.variableLabelDoughRise,
              value: model.bulkRise,
              fractionDigits: 0,
              unit: locale.unitPercent,
              additionalInfoText: locale.additionalInfoDoughRise)
        ]),
      ]);
    });
  }
}
