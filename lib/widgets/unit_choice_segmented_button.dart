import 'package:flutter/material.dart';

class UnitSingleChoiceDescriptor<T> {
  UnitSingleChoiceDescriptor(
      {required this.value, required this.label, required this.tooltip});

  final T value;
  final String label;
  final String tooltip;
}

class UnitChoice<T> extends StatefulWidget {
  const UnitChoice({
    super.key,
    required this.a11yLabel,
    required this.unitList,
    required this.getInitialUnitValue,
    required this.onSelectionChanged,
  });

  final String a11yLabel;
  final List<UnitSingleChoiceDescriptor<T>> unitList;
  final Future<T> Function() getInitialUnitValue;
  final void Function(T) onSelectionChanged;

  @override
  State<UnitChoice<T>> createState() => _UnitChoiceState<T>();
}

class _UnitChoiceState<T> extends State<UnitChoice<T>> {
  T? _unit;

  Future<void> _loadInitialValue() async {
    final T initial = await widget.getInitialUnitValue();
    setState(() {
      _unit = initial;
    });
    widget.onSelectionChanged(initial);
  }

  @override
  void initState() {
    super.initState();
    _loadInitialValue();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
        focusable: true,
        inMutuallyExclusiveGroup: true,
        label: widget.a11yLabel,
        value: _unit?.toString(),
        child: SegmentedButton(
          multiSelectionEnabled: false,
          showSelectedIcon: true,
          segments: widget.unitList
              .map((unit) => ButtonSegment(
                  value: unit.value,
                  label: Text(unit.label,
                      style: Theme.of(context).textTheme.bodyLarge),
                  tooltip: unit.tooltip))
              .toList(),
          selected: {_unit},
          onSelectionChanged: (newSelection) {
            setState(() {
              _unit = newSelection.first;
            });
            widget.onSelectionChanged(newSelection.first as T);
          },
        ));
  }
}
