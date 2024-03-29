import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truthinx/screens/new_proposals/proposal_controller.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'checkbox_widget.dart';

class ProposalsDetails extends StatefulWidget {
  const ProposalsDetails({Key key}) : super(key: key);

  @override
  State<ProposalsDetails> createState() => _ProposalsDetailsState();
}

class _ProposalsDetailsState extends State<ProposalsDetails> {
  ProposalsController controller = Get.find<ProposalsController>();

  List<String> jobTypeList = [];
  List<String> estimatedDurationList = [
    "2 Hours",
    "4 Hours",
    "6 Hours",
    "8 Hours",
    "1 day"
  ];
  String selectedJobType = '';
  String estimatedDuration = '';
  GroupController checkBoxController = GroupController();

//firebase
//
  bool passwordVisibility = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController middlenameController = TextEditingController();

  String isProvidingWardrobe = '';

  bool hasWardrobe;
  String startTime;
  String date;

  int _radioValue1 = -1;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.88),
      body: ListView(children: [
        Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [Container()],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Start Booking Process',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * .3),
                  IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .03),
          _jobTypeDropdown(),
          _estimatedDurationDropdown(),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: _show,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(143, 148, 251, 1),
                        Color.fromRGBO(143, 148, 251, .6),
                      ])),
                  child: Center(
                    child: Text(
                      (startTime != null) ? startTime : "CHOOSE START TIME",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          backgroundColor: Colors.white,
                          actions: <Widget>[
                            Container(
                              height: 30,
                              child: MaterialButton(
                                color: Colors.green,
                                child: Text(
                                  'Set',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          content: Container(
                              height: 300,
                              width: 300,
                              child: SfDateRangePicker(
                                backgroundColor: Colors.black,
                                onSelectionChanged: _onSelectionChanged,
                                selectionMode:
                                    DateRangePickerSelectionMode.multiple,
                                initialSelectedRange: PickerDateRange(
                                  DateTime.now()
                                      .subtract(const Duration(days: 4)),
                                  DateTime.now().add(const Duration(days: 3)),
                                ),
                                confirmText: "SET",
                                onSubmit: (value) {
                                  print(value.toString());
                                },
                              )));
                    });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(143, 148, 251, 1),
                        Color.fromRGBO(143, 148, 251, .6),
                      ])),
                  child: Center(
                      child: Text((_selectedDate.isNotEmpty)
                          ? _selectedDate
                          : "SELECT DATE")),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 70.0,
                      offset: Offset(0, 10))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Row(children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "City",
                                fillColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.grey[400])),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter City Name';
                              }

                              return null;
                            },
                            controller: _firstName,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "State",
                                fillColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.grey[400])),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter State';
                              }
                              return null;
                            },
                            controller: _lastName,
                          ),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(height: 14),
                  Text(
                    'or',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 14),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Zip Code",
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.grey[400])),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Zip Code';
                          }
                          return null;
                        },
                        controller: _firstName,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .015),
                  CustomCheckBox(
                    title: "Are you providing a Wardrobe ?",
                    onChanged: (value) {
                      isProvidingWardrobe = value;

                      setState(() {});
                    },
                    values: ["Yes", "No"],
                  ),
                  Text(
                    'If no, please give an idea of the type of wardrope.” ( Not guarantee model will have it - model will try to pick the closest outfit she has to your request)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 14),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Wardrobe Specifications",
                            fillColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.grey[400])),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Wardrobe Specifications';
                          }
                          return null;
                        },
                        controller: _firstName,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomCheckBox(
                    title: "Should Model arrive Make-up ready ?",
                    onChanged: (value) {},
                    values: ["Yes", "No"],
                  )
                ],
              ),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Warning',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Flexible(
                    child: Text(
                      'If you exceed duration other fee’s may apply. e.g. Being 5 minutes over from selected time and duration you will be charged for the full hour.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 5),
                Flexible(
                  child: Text(
                    "Also, if you release the model earlier then the selected duration you will be charge for the full duration.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Note',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Flexible(
                  child: Text(
                    "Sending this request does not guarantee booking, This is just a job offer. - Model has the option to accept or decline the work. ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 50)
              ]),
        )
      ]),
    );
  }

  // We don't need to pass a context to the _show() function
  // You can safety use context as below
  Future<void> _show() async {
    final TimeOfDay result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        startTime = result.format(context);
      });
    }
  }

  Widget _jobTypeDropdown() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 5,
              left: 25,
              right: 20,
            ),
            child: Text(
              "Job Type",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.grey[400])),
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
                hintText: "Search Course",
              ),
              mode: Mode.DIALOG,
              // showSelectedItem: true,
              items: jobTypeList,
              // label: "Indusry",
              itemAsString: (item) => item,
              hint: "Choose Job Type",
              // popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: (value) {
                selectedJobType = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  // estimatedDurationList

  Widget _estimatedDurationDropdown() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 5,
              left: 25,
              right: 20,
            ),
            child: Text(
              "Job Type",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.grey[400])),
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
                hintText: "Estimated Duration",
              ),
              mode: Mode.DIALOG,
              items: estimatedDurationList,
              itemAsString: (item) => item,
              hint: "Select Estimated Time Duration",
              onChanged: (value) {
                estimatedDuration = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
