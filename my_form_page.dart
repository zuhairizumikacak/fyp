import 'package:flutter/material.dart';
import 'diploma_programs_page.dart';
import 'package:rabu/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:rabu/users/model/school_details.dart';



class MyFormPage extends StatefulWidget {
  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  String? selectedSchoolType;
  String tahun = '';
  var formKey = GlobalKey<FormState>();
  var school_nameController = TextEditingController();
  var spm_yearController = TextEditingController();
  var ic_numberController = TextEditingController();
  var isObsecure = true.obs;


  final List<String> allCourses = [

    'Additional Mathematics',
    'Additional Science',
    'Applied Science',
    'Bahasa Arab Tinggi',
    'Bahasa Cina',
    'Bahasa Tamil',
    'Bahasa Iban',
    'Bahasa Kadazandusun',
    'Bahasa Semai',
    'Bahasa Arab Komunikasi',
    'Bahasa Arab Tinggi',
    'Bahasa Perancis',
    'Bahasa Punjabi',
    'Bible Knowledge',
    'Biology',
    'Chemistry',
    'English for Science and Technology',
    'Ekonomi Asas',
    'Geografi',
    'Information and Communication Technology',
    'Kesusasteraan Melayu',
    'Kesusasteraan Cina',
    'Kesusasteraan Tamil',
    'Lukisan Kejuruteraan',
    'Literature in English',
    'Pengajian Kejuruteraan Elektrik dan Elektronik',
    'Pengajian Kejuruteraan Awam',
    'Pengajian Kejuruteraan Mekanikal',
    'Pengetahuan Sains Sukan',
    'Pendidikan Muzik',
    'Pendidikan Seni Visual',
    'Perakaunan Perniagaan',
    'Pendidikan Syariah Islamiah',
    'Pendidikan Al-Quran dan As-Sunnah',
    'Prinsip Perakaunan',
    'Perdagangan',
    'Pengajian Keusahawanan',
    'Physics',
    'Rekacipta',
    'Science',
    'Teknologi Kejuruteraan',
    'Tasawwur Islam',



  ];

  // Selected values for each course
  String? selectedCourse1;
  String? selectedCourse2;
  String? selectedCourse3;
  String? selectedCourse4;
  String? selectedCourse5;
  String? selectedCourse6;

  List<String> spmGrades = List.filled(18, 'Select');
  List<String> spmCourses = List.filled(18, 'Select');

  registerAndSaveUserRecord() async {
    School schoolModel = School(
      1,
      spm_yearController.text.trim(),
      selectedSchoolType!,
      school_nameController.text.trim(),
      ic_numberController.text.trim(),

    );

    try {
      var res = await http.post(
        Uri.parse(API.schoolDetails),
        body: schoolModel.toJson(),
      );

      if (res.statusCode == 200) {
        var resBodyOfSchoolDetails = jsonDecode(res.body);
        if (resBodyOfSchoolDetails['success']) {
          // Handle success case
        } else {
          // Handle failure case
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }







  List<DropdownMenuItem<String>> getDropdownMenuItems() {
    return <String>[
      'Select',
      'A+',
      'A',
      'A-',
      'B+',
      'B',
      'C+',
      'C',
      'D',
      'E',
      'G',

    ].map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }




  List<DataRow> createFixedRows() {
    return [
      DataRow(cells: [
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: Text('1'),
        )),
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: FormField<String>(
            builder: (FormFieldState<String> field) {
              return DropdownButtonFormField<String>(
                value: spmCourses[0],
                items: ['Select', 'Bahasa Malaysia']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    spmCourses[0] = value ?? 'Select';
                  });
                  field.didChange(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == 'Select') {
                    return 'Please select a subject';
                  }
                  return null;
                },
              );
            },
          ),
        )),
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: FormField<String>(
            builder: (FormFieldState<String> field) {
              return DropdownButtonFormField<String>(
                value: spmGrades[0],
                items: ['Select','A+','A','A-','B+','B','C+','C','D','E','G']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    spmGrades[0] = value ?? 'Select';
                  });
                  field.didChange(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == 'Select') {
                    return 'Please select a grade';
                  }
                  return null;
                },
              );
            },
          ),
        )),
      ]),

      DataRow(cells: [
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: Text('2'),
        )),
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: FormField<String>(
            builder: (FormFieldState<String> field) {
              return DropdownButtonFormField<String>(
                value: spmCourses[1],
                items: ['Select', 'Bahasa Inggeris']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    spmCourses[1] = value ?? 'Select';
                  });
                  field.didChange(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == 'Select') {
                    return 'Please select a subject';
                  }
                  return null;
                },
              );
            },
          ),
        )),
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: FormField<String>(
            builder: (FormFieldState<String> field) {
              return DropdownButtonFormField<String>(
                value: spmGrades[1],
                items: ['Select','A+','A','A-','B+','B','C+','C','D','E','G']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    spmGrades[1] = value ?? 'Select';
                  });
                  field.didChange(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == 'Select') {
                    return 'Please select a grade';
                  }
                  return null;
                },
              );
            },
          ),
        )),
      ]),





      DataRow(cells: [
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: Text('3'),
        )),
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: FormField<String>(
            builder: (FormFieldState<String> field) {
              return DropdownButtonFormField<String>(
                value: spmCourses[2],
                items: ['Select', 'Pendidikan Islam','Pendidikan Moral']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    spmCourses[2] = value ?? 'Select';
                  });
                  field.didChange(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == 'Select') {
                    return 'Please select a subject';
                  }
                  return null;
                },
              );
            },
          ),
        )),
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: FormField<String>(
            builder: (FormFieldState<String> field) {
              return DropdownButtonFormField<String>(
                value: spmGrades[2],
                items: ['Select','A+','A','A-','B+','B','C+','C','D','E','G']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    spmGrades[2] = value ?? 'Select';
                  });
                  field.didChange(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == 'Select') {
                    return 'Please select a grade';
                  }
                  return null;
                },
              );
            },
          ),
        )),
      ]),



      DataRow(cells: [
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: Text('4'),
        )),
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: FormField<String>(
            builder: (FormFieldState<String> field) {
              return DropdownButtonFormField<String>(
                value: spmCourses[3],
                items: ['Select', 'Sejarah']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    spmCourses[3] = value ?? 'Select';
                  });
                  field.didChange(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == 'Select') {
                    return 'Please select a subject';
                  }
                  return null;
                },
              );
            },
          ),
        )),
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: FormField<String>(
            builder: (FormFieldState<String> field) {
              return DropdownButtonFormField<String>(
                value: spmGrades[3],
                items: ['Select','A+','A','A-','B+','B','C+','C','D','E','G']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    spmGrades[3] = value ?? 'Select';
                  });
                  field.didChange(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == 'Select') {
                    return 'Please select a grade';
                  }
                  return null;
                },
              );
            },
          ),
        )),
      ]),



      DataRow(cells: [
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: Text('5'),
        )),
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: FormField<String>(
            builder: (FormFieldState<String> field) {
              return DropdownButtonFormField<String>(
                value: spmCourses[4],
                items: ['Select', 'Mathematics']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    spmCourses[4] = value ?? 'Select';
                  });
                  field.didChange(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == 'Select') {
                    return 'Please select a subject';
                  }
                  return null;
                },
              );
            },
          ),
        )),
        DataCell(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0), // Adjust the horizontal padding as needed
          child: FormField<String>(
            builder: (FormFieldState<String> field) {
              return DropdownButtonFormField<String>(
                value: spmGrades[4],
                items: ['Select','A+','A','A-','B+','B','C+','C','D','E','G']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    spmGrades[4] = value ?? 'Select';
                  });
                  field.didChange(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value == 'Select') {
                    return 'Please select a grade';
                  }
                  return null;
                },
              );
            },
          ),
        )),
      ]),



      // Add other rows as needed with adjusted padding
    ];
  }

  List<DataRow> createSelectedCourseRows() {
    List<DataRow> rows = [];

    for (int i = 5; i < 18; i++) {
      List<String> subjectDropdownItems = ['Select', ...allCourses];
      rows.add(DataRow(cells: [
        DataCell(Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: Text((i + 1).toString()),
          ),
        )),
        DataCell(Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: FormField<String>(
              builder: (FormFieldState<String> field) => DropdownButtonFormField<String>(
                  value: spmCourses[i],
                  items: subjectDropdownItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                          value,
                      style: TextStyle(
                        fontSize : 14,
                        color: Colors.black,
                      ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      spmCourses[i] = value ?? 'Select';
                    });
                    field.didChange(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  style: TextStyle(fontSize: 14),
                  itemHeight: kMinInteractiveDimension,
                  selectedItemBuilder: (BuildContext context) {
                    return subjectDropdownItems.map((String value) {
                      return Text(
                        value,
                        style: TextStyle(fontSize: 14),
                      );
                    }).toList();
                  },

                ),
            ),
          ),
        )),
        DataCell(Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: FormField<String>(
              builder: (FormFieldState<String> field) {
                return DropdownButtonFormField<String>(
                  value: spmGrades[i],
                  items: ['Select', 'A+', 'A', 'A-', 'B+', 'B', 'C+', 'C', 'D', 'E', 'G'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text( value,
                        style: TextStyle(
                          fontSize : 14,
                          color: Colors.white,
                        ),),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      spmGrades[i] = value ?? 'Select';
                    });
                    field.didChange(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                  ),

                  isExpanded: true,
                  style: TextStyle(fontSize: 14),
                  itemHeight: kMinInteractiveDimension,
                  selectedItemBuilder: (BuildContext context) {
                    return ['Select', 'A+', 'A', 'A-', 'B+', 'B', 'C+', 'C', 'D', 'E', 'G'].map((String value) {
                      return Text(
                        value,
                        style: TextStyle(fontSize: 14),
                      );
                    }).toList();
                  }
                );
              },
            ),
          ),
        )),
      ]));
    }
    return rows;
  }



  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isCreditedSubject(String grade) {
    return grade.compareTo('C') >= 0;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('My Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tahun SPM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    controller: spm_yearController,
                    onChanged: (value) {
                      setState(() {
                        tahun = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a year';
                      }
                      if (int.tryParse(value) == null ||
                          int.parse(value) < 2000 ||
                          int.parse(value) > 2030) {
                        return 'Please enter a valid year';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Year',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "School Type",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      value: selectedSchoolType,
                      items: <String>['SMK', 'SMKA', 'Select'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedSchoolType = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "School Name",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    FormField<String>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a school name';
                        }
                        return null;
                      },
                      builder: (FormFieldState<String> field) {
                        return TextFormField(
                          controller: school_nameController,
                          onChanged: field.didChange,
                          decoration: InputDecoration(
                            hintText: 'Enter School Name',
                            border: OutlineInputBorder(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.0, width: 5.0),
                DataTable(
                  columns: [
                    DataColumn(label: Text('No.', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Grade', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],

                  rows: [
                    ...createFixedRows(),
                    ...createSelectedCourseRows(),
                  ],
                ),


                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      registerAndSaveUserRecord();
                      bool allRequirementsMet = true;
                      bool mathematicsAndSainsCredit = true;
                      bool bahasaInggerisPass = false;
                      int creditCount = 0;
                      for (int i = 0; i < 6; i++) {
                        final course = spmCourses[i];
                        final grade = spmGrades[i];
                        if ((course[0] == 'Bahasa Malaysia' || course[1] == 'Sejarah') && grade.compareTo('G') < 0) {
                          allRequirementsMet = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Bahasa Malaysia dan Sejarah adalah subjek wajib lulus.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          break;
                        }

                        if ((course == 'Mathematics' || course == 'SAINS') && !isCreditedSubject(grade)) {
                          mathematicsAndSainsCredit = false;
                                 }
                        // Check for Bahasa Inggeris
                        if (course == 'Bahasa Inggerisa' && isCreditedSubject(grade)) {
                          bahasaInggerisPass = true;
                        }
                         if (isCreditedSubject(grade)) {
                           creditCount++;
                             }
                               }
                      if (allRequirementsMet) {
                        if (mathematicsAndSainsCredit && bahasaInggerisPass && creditCount >= 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiplomaProgramsPage(
                                programs: [
                                  'Diploma in Technology Management in Entrepreneurship',
                                  'Diploma in Technology Management in Accounting',
                                  'Diploma in Computer Networking',
                                  'Diploma in Information Technology',
                                  'Diploma in Graphic Design & Creative Media',
                                  'Diploma in Manufacturing Engineering (Tool and Die Design)',
                                  'Diploma in Manufacturing Engineering (Tool and Die Making)',
                                  'Diploma in Industrial Automation Engineering Technology (Electrical)',
                                  'Diploma in Industrial Automation Engineering Technology (Electronic and Instrumentation)',
                                  'Diploma in Engineering Technology (Non-Destructive Testing)',
                                  'Diploma in Industrial Automation Engineering Technology (Mechatronics)',
                                  'Diploma in Polymer Engineering Technology',
                                  'Diploma in Chemical Engineering Technology',
                                ],
                              ),
                            ),
                          );
                        } else if (creditCount == 3 && isCreditedSubject(spmGrades[spmCourses.indexOf('Mathematics')])) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiplomaProgramsPage(
                                programs: [
                                  'Diploma in Computer Networking',
                                  'Diploma in Information Technology',
                                ],
                              ),
                            ),
                          );
                        } else if (creditCount >= 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiplomaProgramsPage(
                                programs: [
                                  'Diploma in Graphic Design & Creative Media',
                                  'Diploma in Technology Management in Entrepreneurship',
                                  'Diploma in Technology Management in Accounting',
                                ],
                              ),
                            ),
                          );
                        } else {
                          // Do nothing
                        }
                      }
                    }
                  },
                  child: Text('Check Eligibility'),
                ),
              ],
            ),
          ),
        ),
      ),
    );





  }
}




void main() {
  runApp(MyFormPage());
}
