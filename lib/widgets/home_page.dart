import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/routes.dart';
import 'package:sourdoc/constants/style.dart' as style;
import 'package:sourdoc/models/fermentation_model.dart';
import 'package:sourdoc/models/ingredients_model.dart';
import 'package:sourdoc/models/temperature_unit_model.dart';
import 'package:sourdoc/widgets/app_bar_with_actions.dart';
import 'package:sourdoc/widgets/calculator_form.dart';
import 'package:sourdoc/widgets/centered_container.dart';
import 'package:sourdoc/widgets/variable_with_label.dart';
import 'package:sourdoc/widgets/header.dart';
import 'package:sourdoc/widgets/version_info.dart';

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
      body: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => FermentationModel()),
        ChangeNotifierProvider(create: (context) => IngredientsModel())
      ], child: const HomePageListView()),
    );
  }
}

class HomePageListView extends StatelessWidget {
  const HomePageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: ListView(
            primary: true,
            padding: const EdgeInsets.only(bottom: 25),
            children: [
              CenteredContainer(
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withAlpha(170)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    locale.formIntro,
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
          )),
          if (MediaQuery.of(context).size.height >
              (style.isMobileScreenWidth(context) ? 880 : 770))
            getVersionInfoContainer(context)
        ]);
  }
}

class IngredientsValues extends StatelessWidget {
  const IngredientsValues({super.key});

  VariableWithLabelValue _getVariableWithLabelValue(double value) {
    return VariableWithLabelValue(
        value: value, fractionDigits: 1, unit: locale.unitGrams);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Row>[
      const Row(children: <Header>[
        Header(
          text: locale.headerIngredients,
          paddingTop: 25,
        )
      ]),
      Row(children: <VariableWithLabel>[
        VariableWithLabel(
            noMarginLeft: true,
            label: locale.variableLabelFlour,
            value: Consumer<IngredientsModel>(builder: (context, model, child) {
              return _getVariableWithLabelValue(model.flour);
            })),
        VariableWithLabel(
            label: locale.variableLabelWater,
            value: Consumer<IngredientsModel>(builder: (context, model, child) {
              return _getVariableWithLabelValue(model.water);
            })),
        VariableWithLabel(
            label: locale.variableLabelLevain,
            value: Consumer<IngredientsModel>(builder: (context, model, child) {
              return _getVariableWithLabelValue(model.levain);
            })),
        VariableWithLabel(
            label: locale.variableLabelSalt,
            value: Consumer<IngredientsModel>(builder: (context, model, child) {
              return _getVariableWithLabelValue(model.salt);
            })),
      ]),
    ]);
  }
}

class FermentationValues extends StatelessWidget {
  const FermentationValues({super.key});

  VariableWithLabelValue _getVariableWithLabelValue(double value) {
    return VariableWithLabelValue(
        value: value, fractionDigits: 0, unit: locale.unitPercent);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Row>[
      const Row(children: <Header>[Header(text: locale.headerFermentation)]),
      Row(children: <VariableWithLabel>[
        VariableWithLabel(
          noMarginLeft: true,
          label: locale.variableLabelInoculation,
          additionalInfoText: locale.additionalInfoInoculation,
          value: Consumer<FermentationModel>(builder: (context, model, child) {
            return _getVariableWithLabelValue(model.inoculation);
          }),
        ),
        VariableWithLabel(
            label: locale.variableLabelDoughRise,
            additionalInfoText: locale.additionalInfoDoughRise,
            value:
                Consumer<FermentationModel>(builder: (context, model, child) {
              return _getVariableWithLabelValue(model.bulkRise);
            }))
      ]),
    ]);
  }
}
