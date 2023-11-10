import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:miniproject/db/users/users_db.dart';
import 'package:miniproject/model/users/user_model.dart';

import 'homePage.dart';

class ProfileFirst extends StatefulWidget {
  const ProfileFirst({super.key});

  @override
  State<ProfileFirst> createState() => _ProfileFirstState();
}

class _ProfileFirstState extends State<ProfileFirst> {
  final _formfield = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _passwordController2 = TextEditingController();
  bool _passtoggle = true;
  bool _flag = true;

  @override
  Widget build(BuildContext context) {
    final phone = ModalRoute.of(context)!.settings.arguments.toString();
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
          margin: EdgeInsets.only(left: 30, top: 100, right: 20),
          child: Form(
            key: _formfield,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/bottom.png',
                    width: 300, height: 100),
                Padding(padding: EdgeInsets.only(bottom: 40)),
                Text(
                  'Complete Your Profile',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 50)),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Enter Username',
                      hoverColor: Colors.blue,
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username Can not be Null ";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _passtoggle,
                    decoration: InputDecoration(
                      labelText: 'Enter your Password',
                      hoverColor: Colors.blue,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _passtoggle = !_passtoggle;
                          });
                        },
                        child: Icon(_passtoggle
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password Can not be Null ";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _passwordController2,
                    obscureText: _passtoggle,
                    decoration: InputDecoration(
                      labelText: 'Verify your Password',
                      hoverColor: Colors.blue,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _passtoggle = !_passtoggle;
                          });
                        },
                        child: Icon(_passtoggle
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password Can not be Null ";
                      }
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 50)),
                      Visibility(
                        visible: !_flag,
                        child: Icon(
                          Icons.warning,
                          color: Colors.red,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Visibility(
                        visible: !_flag,
                        child: Text(
                          'Password does not match',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 30)),
                SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formfield.currentState!.validate()) {
                          print("successs");

                          submitButtonClicked(phone);
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitButtonClicked(String phone) async {
    final _username = _usernameController.text.trim();
    final _password1 = _passwordController.text.trim();
    final _password2 = _passwordController2.text.trim();

    if (_password1 == _password2) {
      final _addUser =
          Usersmodel(username: _username, password: _password1, phone: phone);
      UserDB().insertUser(_addUser);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx1) => homePage()), (route) => false);
    } else {
      setState(() {
        _flag = false;
      });
    }
  }
}
