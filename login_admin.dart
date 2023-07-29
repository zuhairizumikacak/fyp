import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rabu/interface_design/common/custom_input_field.dart';
import 'package:rabu/interface_design/common/page_header.dart';
import 'package:rabu/mpi/admin_dashboard.dart';
import 'package:rabu/mpi/register_admin.dart';
import 'package:email_validator/email_validator.dart';
import 'package:rabu/interface_design/common/page_heading.dart';
import 'package:rabu/interface_design/common/custom_form_button.dart';
import 'package:get/get.dart';
import 'package:rabu/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:rabu/users/model/admin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rabu/admin/adminPreferences/admin_preference.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  var admin_emailController = TextEditingController();
  var admin_passwordController = TextEditingController();
  var isObsecure = true.obs;
  bool isLoading = false;

  loginAdminNow() async
  {
    try
    {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "admin_email": admin_emailController.text.trim(),
          "admin_password": admin_passwordController.text.trim(),
        },
      );

      if(res.statusCode == 200)
      {
        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin['success'] == true)
        {
          Fluttertoast.showToast(msg: "Login Successfully.");

          Admin adminInfo = Admin.fromJson(resBodyOfLogin["adminData"]);

          await RememberAdminPrefs.storeAdminInfo(adminInfo);

          Future.delayed(Duration(milliseconds: 2000),()
          {
            Get.to(AdminDashboard());
          });
        }
        else
        {
          Fluttertoast.showToast(msg: "Please write correct email or password. \nPlease do try again.");
        }
      }
    }
    catch(errorMsg)
    {
      print("Error :: " + errorMsg.toString());
    }

  }

  @override
  void dispose() {
    admin_emailController.dispose();
    admin_passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: Column(
          children: [
            const PageHeader(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        const PageHeading(title: 'Log-in',),
                        CustomInputField(
                            controller: admin_emailController,
                            labelText: 'Email',
                            hintText: 'Your email id',
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'Email is required!';
                              }
                              if (!EmailValidator.validate(textValue)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            }
                        ),
                        const SizedBox(height: 16,),
                        CustomInputField(
                          controller: admin_passwordController,
                          labelText: 'Password',
                          hintText: 'Your password',
                          obscureText: true,
                          suffixIcon: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Password is required!';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20,),
                        CustomFormButton(
                          innerText: 'Login',
                          onPressed: isLoading ? null : handleLoginUser,
                        ),
                        const SizedBox(height: 18,),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account ? ', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()))
                                },
                                child: const Text('Sign-up', style: TextStyle(fontSize: 15, color: Color(0xff748288), fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleLoginUser() {
    // login user
    if (_loginFormKey.currentState!.validate()) {
      loginAdminNow();
    }
  }
}
