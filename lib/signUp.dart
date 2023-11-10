import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:miniproject/main.dart';
import 'package:miniproject/otpVerification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formfield = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SecureMe',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30, top: 120, right: 20),
          width: double.infinity,
          child: Form(
            key: _formfield,
            child: Column(
              children: [
                Image.asset('assets/images/bottom.png',
                    width: 300, height: 100),
                Padding(padding: EdgeInsets.only(bottom: 40)),
                Text(
                  'Sign Up ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 50)),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Enter Mobile Number',
                      prefixIcon: CountryCodePicker(
                        initialSelection: 'IN',
                        showCountryOnly: true,
                        flagWidth: 30,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a phone number";
                      } else if (_phoneController.text.length < 6) {
                        return "Enter 10 digit Phone number";
                      }
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 40)),
                SizedBox(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formfield.currentState!.validate()) {
                          onContinuePressed();
                        }
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    )),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    thickness: 3,
                  )),
                  Text(
                    "       Or       ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w200,
                      fontSize: 18,
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    thickness: 3,
                  )),
                ]),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/google.png',
                      height: 25,
                      width: 25,
                    ),
                    label: Text(
                      '  Continue with Google',
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                        side: BorderSide(width: 1, color: Colors.grey)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onContinuePressed() async {
    final _phone = _phoneController.text.trim();
    if (_phone.isEmpty) {
      return;
    } else {
      Navigator.pushNamed(context, 'OtpVerification', arguments: _phone);
    }
  }
}
