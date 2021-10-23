import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final String title;
  ValueChanged<String> onChanged;
  List<String> values;
  String intialSelection;
   List<CheckBoxObject> list;
  CustomCheckBox(
      {this.title, this.onChanged, this.values, this.intialSelection, this.list});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  List<CheckBoxObject> list = [];
  bool _currentValue=false;

  void initializeList() {
    widget.values.forEach((element) {
      if (widget.intialSelection != null && widget.intialSelection == element) {
        list.add(CheckBoxObject(item: element, isSelected: true));
      } else {
        list.add(CheckBoxObject(item: element));
      }
    });
  }

  void _handleOnTap(String item) {
    list.forEach((element) {
      element.isSelected = false;
    });

    list.forEach((element) {
      if (element.item == item) {
        element.isSelected = !_currentValue;
      }
    });

    setState(() {});
  }

  @override
  initState() {
    super.initState();
    initializeList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      (widget.title != null)
          ? Align(alignment: Alignment.topLeft, child: Text(widget.title))
          : SizedBox.shrink(),
      SizedBox(height: 5),
      Column(
        children: singleItemWidget(),
      )
    ]));
  }

  singleItemWidget() {
    return list
        .map((e) => Row(children: [
              Text(e.item),
              Checkbox(
                value: e.isSelected,
                onChanged: (value) {
                  _currentValue= e.isSelected;
                  _handleOnTap(e.item);
                },
              ),
            ]))
        .toList();
  }
}

class CheckBoxObject {
  String item;
  bool isSelected;
  CheckBoxObject({this.item, this.isSelected = false});
}
