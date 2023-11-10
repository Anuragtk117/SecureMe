import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miniproject/db/contacts/contacts_db.dart';
import 'package:miniproject/db/users/users_db.dart';
import 'package:miniproject/homePage.dart';
import 'package:miniproject/model/users/user_model.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formfield = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isDataMatched = true;
  bool _passtoggle = true;

 

  @override
  void initState() {
    ContactsDB().getContacts().then((value) {
      print('contacts get !!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n');
      print(value.toString());
    });
    UserDB().getUsers().then((value) {
      print('users get..............................');
      print(value.toString());
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 30, top: 120, right: 20),
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
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 40)),
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
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _passtoggle,
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      hoverColor: Colors.blue,
                      prefixIcon: Icon(Icons.key_outlined),
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 50)),
                    Visibility(
                      visible: !_isDataMatched,
                      child: Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 10)),
                    Visibility(
                      visible: !_isDataMatched,
                      child: Text(
                        'Invalid Username or Password',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                SizedBox(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formfield.currentState!.validate()) {
                          loginButtonClicked();
                        }
                      },
                      child: Text(
                        'LogIn',
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    )),
                Padding(padding: EdgeInsets.only(bottom: 30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account ?",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'SignUp');
                        },
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginButtonClicked() async {
    final _username = _usernameController.text.trim();
    final _password = _passwordController.text.trim();
    final _usersDB = await Hive.openBox<Usersmodel>(USERS_DB_NAME);
    final a = _usersDB.values.toList();
    bool flag = false;
    if (_username.isEmpty || _password.isEmpty) {
      return;
    } else {
      for (int i = 0; i < a.length; i++) {
        if (a[i].username == _username && a[i].password == _password) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx1) => homePage()),
              (route) => false);
          _usernameController.clear();
          _passwordController.clear();
          flag = false;
          break;
        } else {
          flag = true;
        }
      }
    }
    if (flag) {
      setState(() {
        _isDataMatched = false;
      });
    }
  }
}
