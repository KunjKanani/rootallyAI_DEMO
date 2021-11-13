import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rootally_ai/constants/app_colors.dart';
import 'package:rootally_ai/services/auth_services.dart';
import 'package:rootally_ai/utils/helper.dart';
import 'package:rootally_ai/view/home_screen/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInUI extends StatefulWidget {
  const SignInUI({Key? key}) : super(key: key);

  @override
  State<SignInUI> createState() => _SignInUIState();
}

class _SignInUIState extends State<SignInUI> {
  TextEditingController? email = TextEditingController(),
      pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true, _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              left: MediaQuery.of(context).size.width / 2 - 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.wifi_calling_3_outlined,
                    color: AppColors.primaryColor,
                    size: 16,
                  ),
                  emptyHorizontalBox(width: 10),
                  const Text(
                    "Contant us",
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FlutterLogo(
                    size: 50,
                  ),
                  emptyVerticalBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      emptyHorizontalBox(width: 10),
                      const Icon(Icons.login, size: 25),
                    ],
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                      side: const BorderSide(
                          color: AppColors.secondaryColor, width: 2),
                    ),
                    elevation: 0,
                    child: ListTile(
                      title: TextFormField(
                        controller: email,
                        validator: (val) {
                          if (val == null || val == "") {
                            return "Email is required";
                          } else if (!EmailValidator.validate(val)) {
                            return "Invalid Email";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Email Address",
                          border: InputBorder.none,
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                      side: const BorderSide(
                          color: AppColors.secondaryColor, width: 2),
                    ),
                    elevation: 0,
                    child: ListTile(
                      title: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Password",
                          border: InputBorder.none,
                          alignLabelWithHint: true,
                        ),
                        controller: pass,
                        obscureText: _passwordVisible,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Password is required";
                          } else if (value.length <= 7) {
                            return "Minimum 8 char required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        child: _passwordVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                  emptyVerticalBox(height: 10),
                  const Text(
                    "Forget Password?",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  emptyVerticalBox(height: 60),
                  MaterialButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      if (_formKey.currentState!.validate()) {
                        String res = await AuthService.signUpUsingFirebase(
                            email: email!.text, password: pass!.text);
                        if (res == "success") {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setBool("isLoggedIn", true);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(res),
                            ),
                          );
                        }
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.secondaryColor),
                          )
                        : const Text(
                            "Sign In / Sign Up",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: AppColors.secondaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
