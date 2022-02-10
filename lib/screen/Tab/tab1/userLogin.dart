import 'package:flutter/material.dart';
import 'package:userintegration/element/Alert/alert.dart';
import 'package:userintegration/services/database/CRUD/login.dart';

class UserLogin extends StatefulWidget {
  UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool emailV = false;
  bool passwordV = false;
  bool hidePass = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 400,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 110, 188, 233),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextField(
                controller: email,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 0, 94, 255)),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Enter your Gmail',
                  errorText: emailV ? 'Gmail Can\'t Be Empty' : null,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: TextField(
                obscureText: !hidePass,
                controller: password,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        if (hidePass) {
                          hidePass = false;
                        } else {
                          hidePass = true;
                        }
                      });
                    },
                    child: Icon(
                      Icons.visibility_off,
                      color: Colors.black,
                    ),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 0, 94, 255)),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Enter Password',
                  errorText: passwordV ? 'password Can\'t Be Empty' : null,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                    (Set<MaterialState> states) {
                      return EdgeInsets.all(20);
                    },
                  ),
                ),
                onPressed: () {
                  if (isValid(context)) {
                    Login().checkLogin(email.text, password.text).then((value) {
                      if (value != null) {
                        showAlertDialog(context, "Welcome", "Welcome User");
                      } else {
                        showAlertDialog(context, "Ops", "No User Found");
                      }
                    });
                  }
                },
                child: Text("Login"),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isValid(BuildContext context) {
    if (email.text.isEmpty) {
      setState(() {
        emailV = true;
      });
      return false;
    }

    if (password.text.isEmpty) {
      setState(() {
        passwordV = true;
      });
      return false;
    }

    return true;
  }
}
