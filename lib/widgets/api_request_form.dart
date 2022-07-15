import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shifter_webapp/helpers/colors.dart';
import 'package:shifter_webapp/widgets/form_input_label.dart';
import 'package:shifter_webapp/api/api.dart';

// class MyData extends DataTableSource {
//   // Generate some made-up data
//   final List<Map<String, dynamic>> _data = List.generate(
//       200,
//       (index) => {
//             "id": index,
//             "title": "Item $index",
//             "price": Random().nextInt(10000)
//           });

//   @override
//   bool get isRowCountApproximate => false;
//   @override
//   int get rowCount => _data.length;
//   @override
//   int get selectedRowCount => 0;
//   @override
//   DataRow getRow(int index) {
//     return DataRow(cells: [
//       DataCell(Text(_data[index]['id'].toString())),
//       DataCell(Text(_data[index]["title"])),
//       DataCell(Text(_data[index]["price"].toString())),
//     ]);
//   }
// }

class RequestForm extends StatefulWidget {
  const RequestForm({Key? key}) : super(key: key);

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  String _courseName = "";
  String _courseYear = "";
  String _weekDate = "";

  bool _jsonOnly = false;
  bool _shiftFilter = true;

  Widget testingVariable = const FormLabelElement(
      text: "No course has been selected.", fontSize: 14, color: Colors.red);

  ManagerAPI caller = ManagerAPI("http://127.0.0.1:8000");

  static const List<String> courses = ['Bangalore', 'Chennai', 'New York'];

  List rows = [
    {"subject": "Example", "shift": "Example"},
    {"subject": "Example", "shift": "Example"},
    {"subject": "Example", "shift": "Example"},
    {"subject": "Example", "shift": "Example"},
    {"subject": "Example", "shift": "Example"},
    {"subject": "Example", "shift": "Example"}
  ];

  List columns = [
    {"title": "Subject", "index": 1, "key": "subject"},
    {"title": "Shift", "index": 2, "key": "shift"}
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();

  static List<String> getSuggestions(String query) {
    return List.of(courses).where((course) {
      return course.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Widget _buildCourseName() {
    return TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: _typeAheadController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
              hintText: 'Start typing to check every course available...',
              fillColor: Colors.white70),
        ),
        suggestionsCallback: (pattern) {
          return getSuggestions(pattern);
        },
        itemBuilder: (context, String? suggestion) {
          return ListTile(
            title: Text(suggestion!),
          );
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (String? suggestion) {
          _typeAheadController.text = suggestion!;
          setState(() {
            testingVariable = FutureBuilder(
                future: caller.testCall(),
                builder: (context, snapshot) {
                  return const FormLabelElement(
                      text: "Hello", fontSize: 24, color: Colors.purple);
                });
          });
        },
        validator: (String? value) {
          if (value!.isEmpty || !courses.contains(value)) {
            return 'Please select a course.';
          }
          return null;
        },
        onSaved: (value) {
          _courseName = value!;
        });
  }

  Widget _buildCourseYear() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
                hintText: 'Select year...',
                fillColor: Colors.white70),
            validator: (value) {
              if (value!.isEmpty) {
                return "Course year is required.";
              }

              int numberValue;
              try {
                numberValue = int.parse(value);
              } catch (e) {
                return 'Please insert a valid number.';
              }

              if (numberValue < 1 || numberValue >= 5) {
                return 'Value must be between 1 and 4.';
              }

              return null;
            },
            onSaved: (String? value) {
              _courseYear = value!;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeekDate() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: GoogleFonts.poppins(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
          hintText: 'Insert week date (dd-mm-YYYY)',
          fillColor: Colors.white70),
      validator: (value) {
        if (value!.isEmpty) {
          return "Week date is required.";
        }
        return null;
      },
      onSaved: (String? value) {
        _weekDate = value!;
      },
    );
  }

  Widget _buildCheckBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: _shiftFilter,
          onChanged: (bool? value) {
            setState(() {
              if (_jsonOnly == true && value! == true) {
                _shiftFilter = value;
              } else if (_jsonOnly == false && value! == true) {
                _shiftFilter = value;
              } else if (_jsonOnly == true && value! == false) {
                _shiftFilter = value;
              } else {
                _jsonOnly = true;
                _shiftFilter = value!;
              }
            });
          },
          checkColor: Colors.white70,
          fillColor: MaterialStateProperty.all<Color>(blue),
        ),
        Text("Filter Shifts",
            style: GoogleFonts.poppins(
                fontSize: 20, color: brown, fontWeight: FontWeight.w400)),
        const SizedBox(width: 12),
        Checkbox(
          value: _jsonOnly,
          onChanged: (bool? value) {
            setState(() {
              if (_shiftFilter == true && value! == true) {
                _jsonOnly = value;
              } else if (_shiftFilter == false && value! == true) {
                _jsonOnly = value;
              } else if (_shiftFilter == true && value! == false) {
                _jsonOnly = value;
              } else {
                _shiftFilter = true;
                _jsonOnly = value!;
              }
            });
          },
          checkColor: Colors.white70,
          fillColor: MaterialStateProperty.all<Color>(blue),
        ),
        Text("Json Only",
            style: GoogleFonts.poppins(
                fontSize: 20, color: brown, fontWeight: FontWeight.w400)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // final DataTableSource _data = MyData();

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 20, horizontal: screenSize.width / 4),
        child: Column(
          children: [
            FormLabelElement(
                text: "Select your course :", fontSize: 20, color: brown),
            _buildCourseName(),
            const SizedBox(height: 14),
            FormLabelElement(
                text: "Select a year :", fontSize: 20, color: brown),
            _buildCourseYear(),
            const SizedBox(height: 14),
            FormLabelElement(
                text: "Select week date :", fontSize: 20, color: brown),
            _buildWeekDate(),
            const SizedBox(height: 14),
            _buildCheckBoxes(),
            const SizedBox(height: 14),
            FormLabelElement(
                text: "Select your shifts :", fontSize: 20, color: brown),
            // PaginatedDataTable(
            //   source: _data,
            //   columns: const [
            //     DataColumn(label: Text('ID')),
            //     DataColumn(label: Text('Name')),
            //     DataColumn(label: Text('Price'))
            //   ],
            //   columnSpacing: 100,
            //   horizontalMargin: 10,
            //   rowsPerPage: 3,
            //   showCheckboxColumn: false,
            // ),
            testingVariable,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: 150, height: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate() ||
                          (_jsonOnly == false && _shiftFilter == false)) {
                        return;
                      }
                      _formKey.currentState!.save();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(74, 90, 232, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: blue),
                        ))),
                    child: Text("Download",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w300)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
