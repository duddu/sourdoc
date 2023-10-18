import 'package:flutter/material.dart';

class UnitSingleChoiceDescriptor {
  UnitSingleChoiceDescriptor({required this.value, required this.tooltip});

  final String value;
  final String tooltip;
}

class UnitChoice<T extends Enum> extends StatefulWidget {
  const UnitChoice({
    super.key,
    required this.a11yLabel,
    required this.unitList,
    required this.initialUnitValue,
    required this.onSelectionChanged,
  });

  final String a11yLabel;
  final List<UnitSingleChoiceDescriptor> unitList;
  final String initialUnitValue;
  final Function(String) onSelectionChanged;

  @override
  State<UnitChoice> createState() => _UnitChoiceState<T>();
}

class _UnitChoiceState<T extends Enum> extends State<UnitChoice> {
  String? unit;

  @override
  void initState() {
    unit = widget.initialUnitValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
        focusable: true,
        inMutuallyExclusiveGroup: true,
        label: widget.a11yLabel,
        value: unit,
        child: SegmentedButton(
          multiSelectionEnabled: false,
          showSelectedIcon: true,
          segments: <ButtonSegment<String>>[
            ButtonSegment(
                value: widget.unitList.first.value,
                label: Text(widget.unitList.first.value,
                    style: Theme.of(context).textTheme.bodyLarge),
                tooltip: widget.unitList.first.tooltip),
            ButtonSegment(
                value: widget.unitList.last.value,
                label: Text(widget.unitList.last.value,
                    style: Theme.of(context).textTheme.bodyLarge),
                tooltip: widget.unitList.last.tooltip),
          ],
          selected: {unit},
          onSelectionChanged: (Set newSelection) {
            setState(() {
              unit = newSelection.first;
              widget.onSelectionChanged(unit!);
            });
          },
        ));
  }
}
