
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class iafLinearGauge extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final double interval;
  final Color gaugeColor;
  final ValueChanged<String> onChangedTextField;

  iafLinearGauge({
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 400,
    this.interval = 20,
    required this.gaugeColor,
    required this.onChangedTextField,
});



  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      minimum: min,
      maximum: max,
      interval: interval,
      markerPointers: [
        LinearWidgetPointer(
          value: value,
          dragBehavior: LinearMarkerDragBehavior.constrained,
          onChanged: (value) {
            onChanged(value);
            onChangedTextField(value.toStringAsFixed(1)); // novo callback
          },
          position: LinearElementPosition.outside,
          child: Icon(Icons.arrow_drop_down_circle_outlined, color: gaugeColor, size: 30),
        ),
      ],
    );
  }
}