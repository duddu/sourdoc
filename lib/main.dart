import 'package:flutter/material.dart';
import 'package:sourdoc/widgets/full_width_container_with_label_and_value.dart';
import 'package:sourdoc/widgets/full_width_header_with_padding.dart';
import 'package:sourdoc/widgets/full_width_text_field_with_affixes.dart';

void main() {
  runApp(const Sourdoc());
}

class Sourdoc extends StatelessWidget {
  const Sourdoc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sourdoc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Sourdoc'),
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

  void _updateFermentationValues() {
    final temperature = double.parse(temperatureController.text);

    _inoculation = 20 + 21 - temperature;
    if (temperature > 20) {
      if (temperature > 25) {
        _bulkRise = 25;
      } else {
        _bulkRise = 50;
      }
    } else {
      _bulkRise = 100;
    }
  }

  void _updateFermentationState() {
    setState(() {
      _updateFermentationValues();
      _updateIngredientsValues();
    });
  }

  void _updateIngredientsValues() {
    final hydrationPercent = double.parse(hydrationController.text) / 100;
    final saltPercent = double.parse(saltController.text) / 100;
    final inoculationPercent = _inoculation / 100;

    _flour = double.parse(totalWeightController.text) /
        (1 + hydrationPercent + saltPercent + inoculationPercent);
    _water = _flour * hydrationPercent;
    _levain = _flour * inoculationPercent;
    _salt = _flour * saltPercent;
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        children: [
          Row(
            children: <FullWidthTextFieldWithAffixes>[
              FullWidthTextFieldWithAffixes(
                controller: totalWeightController,
                prefixText: 'Total weight',
                suffixText: 'g',
              ),
            ],
          ),
          Row(
            children: <FullWidthTextFieldWithAffixes>[
              FullWidthTextFieldWithAffixes(
                controller: hydrationController,
                prefixText: 'Hydration',
                suffixText: '%',
              ),
            ],
          ),
          Row(
            children: <FullWidthTextFieldWithAffixes>[
              FullWidthTextFieldWithAffixes(
                controller: saltController,
                prefixText: 'Salt',
                suffixText: '%',
              ),
            ],
          ),
          Row(
            children: <FullWidthTextFieldWithAffixes>[
              FullWidthTextFieldWithAffixes(
                controller: temperatureController,
                prefixText: 'Temperature',
                suffixText: 'ºC',
              ),
            ],
          ),
          const Row(
            children: <FullWidthHeaderWithPadding>[
              FullWidthHeaderWithPadding(
                text: 'Ingredients',
                paddingTop: 40,
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
              label: 'Inoculation', value: '$_inoculation%'),
          FullWidthContainerWithLabelAndValue(
              label: 'Bulk rise', value: '$_bulkRise%'),
        ],
      )),
    );
  }
}
