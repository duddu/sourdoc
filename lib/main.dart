import 'package:flutter/material.dart';
import 'package:sourdoc/methods/get_fermentation_values.dart';
import 'package:sourdoc/methods/get_ingredients_values.dart';
import 'package:sourdoc/widgets/full_width_container_with_label_and_value.dart';
import 'package:sourdoc/widgets/full_width_header_with_padding.dart';
import 'package:sourdoc/widgets/full_width_text_field_with_affixes.dart';

void main() {
  runApp(const Sourdoc());
}

class Sourdoc extends StatelessWidget {
  const Sourdoc({super.key});

  final String _title = 'Sourdoc';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: HomePage(title: _title),
    );
  }
}

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

  final totalWeightController = TextEditingController();
  final hydrationController = TextEditingController();
  final saltController = TextEditingController();
  final temperatureController = TextEditingController();

  double _parseValue(TextEditingController controller) =>
      double.parse(controller.value.text);

  void _updateFermentationValues() {
    final temperature = _parseValue(temperatureController);

    _inoculation = getInoculationValue(temperature);
    _bulkRise = getBulkRiseValue(temperature);
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

  @override
  void initState() {
    super.initState();

    totalWeightController.text = '700';
    hydrationController.text = '70';
    saltController.text = '2';
    temperatureController.text = '22';

    _updateFermentationValues();
    _updateIngredientsValues();

    totalWeightController.addListener(_updateIngredientsState);
    hydrationController.addListener(_updateIngredientsState);
    saltController.addListener(_updateIngredientsState);
    temperatureController.addListener(_updateFermentationState);
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
          child: ListView(
        padding: const EdgeInsets.only(bottom: 30),
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(20),
                  border: Border(
                      bottom:
                          BorderSide(width: 1, color: Colors.grey.shade300))),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 14),
                  child: Column(children: [
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 10),
                        child: Text(
                          'Edit the following four parameters, the ingredients and fermentation values will update accordingly.',
                          textAlign: TextAlign.start,
                        )),
                    Row(
                      children: <FullWidthTextFieldWithAffixes>[
                        FullWidthTextFieldWithAffixes(
                          controller: totalWeightController,
                          prefixText: 'Target bread weight',
                          suffixText: 'g',
                        ),
                      ],
                    ),
                    Row(
                      children: <FullWidthTextFieldWithAffixes>[
                        FullWidthTextFieldWithAffixes(
                          controller: hydrationController,
                          prefixText: 'Hydration level',
                          suffixText: '%',
                        ),
                      ],
                    ),
                    Row(
                      children: <FullWidthTextFieldWithAffixes>[
                        FullWidthTextFieldWithAffixes(
                          controller: saltController,
                          prefixText: 'Salt level',
                          suffixText: '%',
                        ),
                      ],
                    ),
                    Row(
                      children: <FullWidthTextFieldWithAffixes>[
                        FullWidthTextFieldWithAffixes(
                          controller: temperatureController,
                          prefixText: 'Ambient temperature',
                          suffixText: 'ºC',
                        ),
                      ],
                    )
                  ]))),
          Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Column(children: [
                const Row(
                  children: <FullWidthHeaderWithPadding>[
                    FullWidthHeaderWithPadding(
                      text: 'Ingredients',
                    )
                  ],
                ),
                FullWidthContainerWithLabelAndValue(
                    label: 'Flour', value: '${_flour.toStringAsFixed(1)}g'),
                FullWidthContainerWithLabelAndValue(
                    label: 'Water', value: '${_water.toStringAsFixed(1)}g'),
                FullWidthContainerWithLabelAndValue(
                    label: 'Levain', value: '${_levain.toStringAsFixed(1)}g'),
                FullWidthContainerWithLabelAndValue(
                    label: 'Salt', value: '${_salt.toStringAsFixed(1)}g'),
                const Row(
                  children: <FullWidthHeaderWithPadding>[
                    FullWidthHeaderWithPadding(
                      text: 'Fermentation',
                    )
                  ],
                ),
                FullWidthContainerWithLabelAndValue(
                    label: 'Inoculation',
                    value: '$_inoculation%',
                    additionalInfoText:
                        'Inoculation measures the ratio between the levain and the total flour weight. The higher the value the stronger the fermentation. This value is directly affected by ambient temperature: a colder fermentation environment will require more levain to achieve the best results.'),
                FullWidthContainerWithLabelAndValue(
                    label: 'Bulk rise',
                    value: '$_bulkRise%',
                    additionalInfoText:
                        'This value indicates how much should the dough have risen, from the moment of mixing the levain, to consider the bulk fermentation phase completed. It is directly affected by the ambient temperature, as in a warmer environment the dough will need to rise less to be considered ready for the shaping phase.'),
              ]))
        ],
      )),
    );
  }
}
