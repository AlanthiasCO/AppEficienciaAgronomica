import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DefaultLinearGauge extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final double interval;
  final Color gaugeColor;


  DefaultLinearGauge({
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 400,
    this.interval = 20,
    required this.gaugeColor,
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
          onChanged: onChanged,
          position: LinearElementPosition.outside,
          child: Icon(Icons.arrow_drop_down_circle_outlined, color: gaugeColor, size: 30),
        ),
      ],
    );
  }
}