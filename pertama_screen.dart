import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rabu/api_connection/api_connection.dart';
import 'package:rabu/users/model/user_details.dart';
import 'my_form_page.dart';
import 'package:http/http.dart' as http;
import 'package:rabu/interface_design/common/custom_input_field_user.dart';
import 'package:email_validator/email_validator.dart';

class PertamaScreen extends StatefulWidget {
  @override
  State<PertamaScreen> createState() => _PertamaScreenState();
}

class _PertamaScreenState extends State<PertamaScreen> {
  // Use const for widgets that are not going to change
  var formKey = GlobalKey<FormState>();
  var ic_numberController = TextEditingController();
  var candidate_nameController = TextEditingController();
  var phone_numberController = TextEditingController();
  var candidate_emailController = TextEditingController();
  var candidate_addressController = TextEditingController();
  var isObsecure = true.obs;

  registerAndSaveUserRecord() async {
    User userModel = User(
      ic_numberController.text.trim(),
      candidate_nameController.text.trim(),
      phone_numberController.text.trim(),
      candidate_emailController.text.trim(),
      candidate_addressController.text.trim(),
    );

    try {
      var res = await http.post(
        Uri.parse(API.candidateDetails),
        body: userModel.toJson(),
      );

      if (res.statusCode == 200) {
        var resBodyOfcandidateDetails = jsonDecode(res.body);
        if (resBodyOfcandidateDetails['success']) {
          // Handle success case
        } else {

        }
      }
    } catch (e) {
      print(e.toString());

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox.shrink(),
            Text(
              'DSS FOR STUDENT INTAKE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: Text(
                'Welcome To Homepage',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white, // add this line
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Please Enter Your Personal Details',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16,),
                          CustomInputFieldUser(
                              controller: ic_numberController,
                              labelText: 'IC number',
                              hintText: 'Your IC number',
                              isDense: true,
                              validator: (textValue) {
                                if(textValue == null || textValue.isEmpty) {
                                  return 'IC number field is required!';
                                }
                                return null;
                              }
                          ),

                      const SizedBox(height: 16,),
                      CustomInputFieldUser(
                          controller: candidate_nameController,
                          labelText: 'Name',
                          hintText: 'Your name',
                          isDense: true,
                          validator: (textValue) {
                            if(textValue == null || textValue.isEmpty) {
                              return 'Name field is required!';
                            }
                            return null;
                          }
                      ),

                      const SizedBox(height: 16,),
                      CustomInputFieldUser(
                          controller: phone_numberController,
                          labelText: 'Contact no.',
                          hintText: 'Your contact number',
                          isDense: true,
                          validator: (textValue) {
                            if(textValue == null || textValue.isEmpty) {
                              return 'Contact number field is required!';
                            }
                            return null;
                          }
                      ),


                      const SizedBox(height: 16),
                      CustomInputFieldUser(
                        controller: candidate_emailController,
                        labelText: 'Email',
                        hintText: 'Your email',
                        isDense: true,
                        validator: (textValue) {
                          if(textValue == null || textValue.isEmpty) {
                            return 'Email is required!';
                          }
                          if(!EmailValidator.validate(textValue)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },

                      ),


                      const SizedBox(height: 16,),
                      CustomInputFieldUser(
                          controller: candidate_addressController,
                          labelText: 'Address.',
                          hintText: 'Your address',
                          isDense: true,
                          validator: (textValue) {
                            if(textValue == null || textValue.isEmpty) {
                              return 'Contact address field is required!';
                            }
                            return null;
                          }
                      ),

                    ],
                  ),
                ),
              ),
            ),


            SizedBox(height: 20),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    registerAndSaveUserRecord();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyFormPage()),

                    );
                  }
                },
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PertamaScreen(),
  ));
}
