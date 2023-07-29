import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rabu/api_connection/api_connection.dart';
import 'package:rabu/users/model/admin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rabu/interface_design/common/page_header.dart';
import 'package:rabu/interface_design/common/page_heading.dart';
import 'package:rabu/mpi/login_admin.dart';
import 'package:rabu/interface_design/common/custom_form_button.dart';
import 'package:rabu/interface_design/common/custom_input_field.dart';



class RegisterScreen extends StatefulWidget
{


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var admin_emailController = TextEditingController();
  var admin_nameController = TextEditingController();
  var admin_numberController = TextEditingController();
  var admin_passwordController = TextEditingController();
  var isObsecure = true.obs;

  validateUserEmail() async
  {

    try
    {
      var res = await http.post(
          Uri.parse(API.validateEmail),
          body: {
            'admin_email': admin_emailController.text.trim(),
          }
      );

      if(res.statusCode==200)
      {
        var resBodyOfValidateEmail = jsonDecode(res.body);

        if(resBodyOfValidateEmail['emailFound']==true)
        {
          Fluttertoast.showToast(msg: "Email is already in use.");
        }
        else
        {
          registerAndSaveAdminRecord();
        }
      }
    }
    catch(e)
    {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  registerAndSaveAdminRecord() async
  {

    Admin adminModel = Admin(
      1,
      admin_emailController.text.trim(),
      admin_nameController.text.trim(),
      admin_numberController.text.trim(),
      admin_passwordController.text.trim(),
    );

    try
    {
      var res = await http.post(
        Uri.parse(API.register),
        body: adminModel.toJson(),
      );

      if(res.statusCode == 200)
      {
        var resBodyOfRegister = jsonDecode(res.body);

        if(resBodyOfRegister['success'] == true)
        {
          Fluttertoast.showToast(msg: "Register Successfully.");

          setState(() {
            admin_emailController.clear();
            admin_nameController.clear();
            admin_numberController.clear();
            admin_passwordController.clear();
          });
        }
        else
        {
          Fluttertoast.showToast(msg: "Error Occurred.");
        }
      }
    }
    catch(e)
    {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const PageHeader(),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                  ),
                  child: Column(
                    children: [
                      const PageHeading(title: 'Sign-up'),
                      const SizedBox(height: 16),
                       CustomInputField(
                         controller: admin_emailController,
                          labelText: 'Email',
                          hintText: 'Your email id',
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
                      CustomInputField(
                        controller: admin_nameController,
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
                      CustomInputField(
                        controller: admin_numberController,
                          labelText: 'Contact no.',
                          hintText: 'Your contact number',
                          isDense: true,
                          validator: (textValue) {
                            if(textValue == null || textValue.isEmpty) {
                              return 'Contact number is required!';
                            }
                            return null;
                          }
                      ),

                      const SizedBox(height: 16,),
                      CustomInputField(
                        controller: admin_passwordController,
                        labelText: 'Password',
                        hintText: 'Your password',
                        isDense: true,
                        obscureText: true,
                        validator: (textValue) {
                          if(textValue == null || textValue.isEmpty) {
                            return 'Password is required!';
                          }
                          return null;
                        },
                        suffixIcon: true,
                      ),

                      const SizedBox(height: 22,),
                      CustomFormButton(innerText: 'Signup',
                          onPressed: ()
                          {
                            if (formKey.currentState!.validate()) {
                              validateUserEmail();
                            }
                          },
                      ),

                      const SizedBox(height: 18,),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Already have an account ? ', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                            GestureDetector(
                              onTap: () => {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()))
                              },
                              child: const Text('Log-in', style: TextStyle(fontSize: 15, color: Color(0xff748288), fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

