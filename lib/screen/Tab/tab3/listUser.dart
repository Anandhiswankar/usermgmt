import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userintegration/models/userModel.dart';
import 'package:userintegration/screen/homescreen/homescreen.dart';
import 'package:userintegration/services/database/CRUD/deluser.dart';
import 'package:userintegration/services/database/CRUD/getUser.dart';

class ListUser {
  Widget GetList(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width - 100,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 71, 168, 212),
          borderRadius: BorderRadius.circular(10)),
      child: FutureBuilder(
          future: getUsers().retrieveUsers(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  height: 200,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Name"),
                                          Text("email"),
                                          Text("DOB"),
                                          Text("password")
                                        ],
                                      ),
                                      Container(
                                        width: 120,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(data![index].name),
                                            Text(data[index].email.toString()),
                                            Text(data[index].dob),
                                            Text(data[index].password)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 200,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          SharedPreferences session =
                                              await SharedPreferences
                                                  .getInstance();

                                          session.setString(
                                              "ename", data[index].name);
                                          session.setString(
                                              "edob", data[index].dob);
                                          session.setString("eemail",
                                              data[index].email.toString());
                                          session.setString(
                                              "epass", data[index].password);
                                          session.setString(
                                              "eid", data[index].id.toString());

                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return HomeScreen();
                                          }));
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          DeleteUser().delete(data[index].id);
                                          print("Deleted");

                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return HomeScreen();
                                          }));
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      );
                    }),
              );
            } else {
              return Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
