import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userintegration/screen/Tab/tab1/userLogin.dart';
import 'package:userintegration/screen/Tab/tab2/addUser.dart';
import 'package:userintegration/screen/Tab/tab3/listUser.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int tabIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    sessionClear();
  }

  sessionClear() async {
    // SharedPreferences session = await SharedPreferences.getInstance();

    // if (session != null) {
    //   session.clear();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DefaultTabController(
          initialIndex: tabIndex,
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('User Integration'),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.verified_user)),
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.group))
                ],
              ),
            ),
            body: TabBarView(
              children: [UserLogin(), AddUser(), ListUser().GetList(context)],
            ),
          ),
        ),
      ),
    ));
  }
}
