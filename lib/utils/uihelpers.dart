import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truthinx/screens/Widgets/slider.dart';

class UIHelpers {
  static miniSpace({bool horizontal = false}) {
    return SizedBox(
      height: horizontal ? 0 : 8,
      width: horizontal ? 8 : 0,
    );
  }

  static smallSpace({bool horizontal = false}) {
    return SizedBox(
      height: horizontal ? 0 : 10,
      width: horizontal ? 10 : 0,
    );
  }

  static mediumSpace({bool horizontal = false}) {
    return SizedBox(
      height: horizontal ? 0 : 20,
      width: horizontal ? 20 : 0,
    );
  }

  static largeSpace({bool horizontal = false}) {
    return SizedBox(
      height: horizontal ? 0 : 40,
      width: horizontal ? 40 : 0,
    );
  }

  static customSpace(double count, {bool horizontal = false}) {
    return SizedBox(
      height: horizontal ? 0 : count,
      width: horizontal ? count : 0,
    );
  }

  static Widget slider(double value, Function(double newValue) onChanged,
      {double? max, double? min, int? division}) {
    return SliderWidget(
      value: value,
      onChnaged: onChanged,
      max: max!,
      min: min!,
      division: division,
    );
  }

  static Widget dropDown(
      List<String> items, Function(String val) onChanged, String value,
      {String? hint}) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.grey.shade400)),
      child: DropdownSearch<String>(
        showSearchBox: true,
        dropdownSearchDecoration: InputDecoration(
          // hintText: null,
          // labelText: "Whar is Your Indusry?",
          contentPadding: EdgeInsets.only(
            left: 10,
          ),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        searchBoxDecoration: InputDecoration(
          hintText: hint,
        ),
        mode: Mode.DIALOG,
        items: items,
        itemAsString: (item) => item,
        hint: hint,
        onChanged: onChanged,
      ),
    );
  }

  static Widget button(
    String title,
    VoidCallback onPressed, {
    Color color = const Color(0xFFF08740),
  }) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: Get.width,
        height: 50,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: Text(title,
                  style: TextStyle(
                      fontFamily: GoogleFonts.varelaRound().fontFamily)),
            )),
      ),
    );
  }
}
