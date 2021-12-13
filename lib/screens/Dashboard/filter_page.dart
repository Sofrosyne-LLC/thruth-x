import 'package:flutter/material.dart';
import 'package:truthinx/utils/constants.dart';
import 'package:truthinx/utils/uihelpers.dart';
import 'package:truthinx/utils/utils.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double sliderValue = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelpers.mediumSpace(),
            Row(
              children: [
                Checkbox(value: true, onChanged: (_) {}),
                Text(
                  "Search by City",
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
            filterTile(
                title: "Rate",
                widget: UIHelpers.slider(
                    sliderValue,
                    (newValue) => setState(() {
                          sliderValue = newValue;
                        }),
                    max: 500,
                    min: 25,
                    division: 25)),
            filterTile(
                title: "Gender",
                padding: 10,
                widget: Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (_) {}),
                        Text(
                          "Male",
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (_) {}),
                        Text(
                          "Female",
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ],
                )),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Height",
                widget: UIHelpers.dropDown(
                    Constants.heights, (val) => null, Constants.heights[0])),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Weight",
                widget: UIHelpers.dropDown(
                    Constants.weight, (val) => null, Constants.weight[0])),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Hair Color",
                widget: UIHelpers.dropDown(
                    Constants.hair, (val) => null, Constants.hair[0])),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Eye Color",
                widget: UIHelpers.dropDown(
                    Constants.eyeColor, (val) => null, Constants.eyeColor[0])),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Dress",
                widget: UIHelpers.slider(
                    sliderValue,
                    (newValue) => setState(() {
                          sliderValue = newValue;
                        }),
                    max: 32,
                    min: 1,
                    division: 1)),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Bust",
                widget: UIHelpers.slider(
                    sliderValue,
                    (newValue) => setState(() {
                          sliderValue = newValue;
                        }),
                    max: 60,
                    min: 20,
                    division: 1)),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Waist",
                widget: UIHelpers.slider(
                    sliderValue,
                    (newValue) => setState(() {
                          sliderValue = newValue;
                        }),
                    max: 50,
                    min: 20,
                    division: 1)),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Hips",
                widget: UIHelpers.slider(
                    sliderValue,
                    (newValue) => setState(() {
                          sliderValue = newValue;
                        }),
                    max: 60,
                    min: 22,
                    division: 1)),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Neck",
                widget: UIHelpers.slider(
                  14,
                  (newValue) => setState(() {
                    sliderValue = newValue;
                  }),
                  max: 22,
                  min: 13,
                )),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Jacket",
                widget: UIHelpers.slider(
                    20,
                    (newValue) => setState(() {
                          sliderValue = newValue;
                        }),
                    max: 50,
                    min: 1,
                    division: 1)),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "InSeam",
                widget: UIHelpers.slider(
                    20,
                    (newValue) => setState(() {
                          sliderValue = newValue;
                        }),
                    max: 60,
                    min: 20,
                    division: 1)),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Shoe",
                widget: UIHelpers.slider(
                    20,
                    (newValue) => setState(() {
                          sliderValue = newValue;
                        }),
                    max: 20,
                    min: 5,
                    division: 5)),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Category",
                widget: UIHelpers.dropDown(
                    categories, (val) => null, categories[0])),
            UIHelpers.mediumSpace(),
            filterTile(
                title: "Nudity",
                padding: 10,
                widget: Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (_) {}),
                        Text(
                          "None",
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (_) {}),
                        Text(
                          "Partial",
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ],
                )),
            UIHelpers.largeSpace(),
            UIHelpers.button(
              "Apply Filter",
              () {},
            ),
            UIHelpers.button("Clear Filter", () {},
                color: Color(0xFFF08740).withOpacity(0.2))
          ],
        ),
      ),
    );
  }

  Widget filterTile({String? title, Widget? widget, double padding = 0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "$title",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: padding), child: widget)
      ],
    );
  }
}
