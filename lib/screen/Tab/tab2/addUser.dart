import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userintegration/element/Alert/alert.dart';

import 'package:userintegration/models/userModel.dart';
import 'package:userintegration/screen/homescreen/homescreen.dart';
import 'package:userintegration/services/database/CRUD/saveUser.dart';
import 'package:userintegration/services/database/CRUD/update.dart';

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late String birthDateInString;

  bool isDateSelected = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rpassword = TextEditingController();

  bool nameV = false;
  bool emailV = false;
  bool dobV = false;
  bool passwordV = false;
  bool rpasswordV = false;

  bool hidePass = false;
  bool hidePassr = false;

  int id = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatas();
  }

  getDatas() async {
    SharedPreferences session = await SharedPreferences.getInstance();

    if (session != null) {
      if (session.getString("ename") != null) {
        setState(() {
          id = int.parse(session.getString("eid")!);
          name.text = session.getString("ename")!;
          email.text = session.getString("eemail")!;
          dob.text = session.getString("edob")!;
          password.text = session.getString("epass")!;
          rpassword.text = session.getString("epass")!;
        });

        session.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: MediaQuery.of(context).size.height * 0.60,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 110, 188, 233),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: TextField(
                controller: name,
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
                  labelText: 'Enter your Name',
                  errorText: nameV ? 'Name Can\'t Be Empty' : null,
                ),
              ),
            ),
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
                  errorText: emailV ? 'gmail Can\'t Be Empty' : null,
                ),
              ),
            ),
            Container(
              child: TextField(
                controller: dob,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      child: new Icon(Icons.calendar_today),
                      onTap: () async {
                        final datePick = await showDatePicker(
                            context: context,
                            initialDate: new DateTime.now(),
                            firstDate: new DateTime(1900),
                            lastDate: new DateTime(2100));
                        if (datePick != null) {
                          setState(() {
                            //birthDate = datePick;
                            isDateSelected = true;

                            // put it here
                            birthDateInString =
                                "${datePick.month}/${datePick.day}/${datePick.year}"; // 08/14/2019

                            dob.text = birthDateInString;
                          });
                        }
                      }),
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
                  labelText: 'Date of barth',
                  errorText: dobV ? 'DOB Can\'t Be Empty' : null,
                ),
              ),
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
            Container(
              child: TextField(
                obscureText: !hidePassr,
                controller: rpassword,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        if (hidePassr) {
                          hidePassr = false;
                        } else {
                          hidePassr = true;
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
                  labelText: 'Confirm Password',
                  errorText: rpasswordV ? 'password Can\'t Be Empty' : null,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            id == 0
                ? Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith<
                            EdgeInsetsGeometry>(
                          (Set<MaterialState> states) {
                            return EdgeInsets.only(right: 20, left: 20);
                          },
                        ),
                      ),
                      onPressed: () {
                        if (isValid(context)) {
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return Center(
                                  child: const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              });

                          User user = User(
                              name: name.text,
                              dob: dob.text,
                              email: email.text,
                              password: password.text);

                          Userop().insertUser(user).then((value) {
                            Navigator.of(context).pop();
                            showAlertDialog(
                                context, "User Added", "New Entry Saved");
                          });
                        }
                      },
                      child: Text("Register"),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith<
                            EdgeInsetsGeometry>(
                          (Set<MaterialState> states) {
                            return EdgeInsets.only(right: 20, left: 20);
                          },
                        ),
                      ),
                      onPressed: () {
                        if (isValid(context)) {
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return Center(
                                  child: const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              });

                          User user = User(
                              id: id,
                              name: name.text,
                              dob: dob.text,
                              email: email.text,
                              password: password.text);

                          UpdateUser().update(id, user).then((value) {
                            print("Record Updated");

                            Navigator.of(context).pop();

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }));
                          });
                        }
                      },
                      child: Text("Update"),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  bool isValid(BuildContext context) {
    if (name.text.isEmpty) {
      setState(() {
        nameV = true;
      });
      return false;
    }

    if (email.text.isEmpty) {
      setState(() {
        emailV = true;
      });
      return false;
    }

    if (dob.text.isEmpty) {
      setState(() {
        dobV = true;
      });
      return false;
    }

    if (password.text.isEmpty) {
      setState(() {
        passwordV = true;
      });
      return false;
    }

    if (rpassword.text.isEmpty) {
      setState(() {
        rpasswordV = true;
      });
      return false;
    }

    if (password.text != rpassword.text) {
      showAlertDialog(context, "Wrong Data", "Both Password different");
      return false;
    }

    return true;
  }
}
