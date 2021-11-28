import 'package:flutter/material.dart';
import 'package:truthinx/utils/constants.dart';

class SliderWidget extends StatefulWidget {
  final double value;
  final Function(double value) onChnaged;
  final double min;
  final double max;
  final int division;

  const SliderWidget(
      {Key key,
      @required this.value,
      @required this.onChnaged,
      this.min = 0,
      this.division,
      this.max = 100})
      : super(key: key);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Constants.maincolor.withOpacity(0.7),
        inactiveTrackColor: Colors.grey[400].withOpacity(0.4),
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 2.0,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        thumbColor: Constants.maincolor,
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: Constants.maincolor,
        inactiveTickMarkColor: Constants.maincolor.withOpacity(0.1),
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Constants.maincolor,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
          value: widget.value,
          min: widget.min,
          max: widget.max,
          divisions: widget.division,
          label: widget.value.toStringAsFixed(0),
          onChanged: widget.onChnaged),
    );
  }
}
