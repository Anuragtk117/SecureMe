import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:miniproject/main.dart';
import 'package:miniproject/profileSetup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class otpVerification extends StatefulWidget {
  const otpVerification({super.key});

  @override
  State<otpVerification> createState() => _otpVerificationState();
}

class _otpVerificationState extends State<otpVerification> {
  @override
  Widget build(BuildContext context) {
    final phone = ModalRoute.of(context)!.settings.arguments.toString();

    print('$phone..................................');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SecureMe',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 30, top: 50, right: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              Text(
                'A four digit OTP is sent to your registered mobile number',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              Text(
                phone,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              Text(
                'Enter OTP',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                        width: 2,
                        color: Colors.pink,
                      ))),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                        width: 2,
                        color: Colors.pink,
                      ))),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                        width: 2,
                        color: Colors.pink,
                      ))),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                        width: 2,
                        color: Colors.pink,
                      ))),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0)),
              TweenAnimationBuilder(
                tween: Tween(begin: 30.0, end: 0),
                duration: Duration(seconds: 30),
                builder: (context, value, child) {
                  double val = value.toDouble();
                  int time = val.toInt();
                  //print(time);
                  if (time == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                          ),
                          child: Row(
                            //mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Resend ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.pink,
                                ),
                              ),
                              Icon(
                                Icons.autorenew,
                                size: 20.0,
                                color: Colors.pink,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$time',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.pink),
                        ),
                      ],
                    ),
                  );
                },
                onEnd: () {},
              ),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              Center(
                child: SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'ProfileSetup',
                            arguments: phone);
                      },
                      child: Text(
                        'Verify',
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
