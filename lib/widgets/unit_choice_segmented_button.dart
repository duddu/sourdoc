import 'package:flutter/material.dart';

class UnitChoice<T extends Enum> extends StatefulWidget {
  const UnitChoice({
    super.key,
    required this.unitList,
    required this.onSelectionChanged,
  });

  final List<String> unitList;
  final Function(String) onSelectionChanged;

  @override
  State<UnitChoice> createState() => _UnitChoiceState<T>();
}

class _UnitChoiceState<T extends Enum> extends State<UnitChoice> {
  late String unit;

  @override
  void initState() {
    unit = widget.unitList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      segments: <ButtonSegment>[
        ButtonSegment(
            value: widget.unitList[0], label: Text(widget.unitList[0])),
        ButtonSegment(
            value: widget.unitList[1], label: Text(widget.unitList[1])),
      ],
      selected: {unit},
      onSelectionChanged: (Set newSelection) {
        setState(() {
          unit = newSelection.first;
          widget.onSelectionChanged(unit);
        });
      },
    );
  }
}
