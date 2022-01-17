import 'package:code_aamy_test/bloc/student_list_bloc.dart';
import 'package:code_aamy_test/bloc/user_auth_bloc.dart';
import 'package:code_aamy_test/components/student_comp.dart';
import 'package:code_aamy_test/constants.dart';
import 'package:code_aamy_test/model/student.dart';
import 'package:code_aamy_test/model/studentlist.dart';
import 'package:code_aamy_test/screens/student_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  StudentListBloc studentListBloc = StudentListBloc();
  UserAuthBloc userAuthBloc = UserAuthBloc();
  bool isLoggedIn = false;
  late Widget active;

  @override
  initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      active = listBuilder(context);
      isLoggedIn = true;
      studentListBloc.getStudentList();
    } else {
      active = signinMessageWidget(context);
    }

    userAuthBloc.subject.listen((value) {
      setState(() {
        if (value.error.isNotEmpty) {
          active = failedLogin(context);
          isLoggedIn = false;
        } else {
          studentListBloc.getStudentList();
          active = listBuilder(context);
          isLoggedIn = true;
        }
      });
      debugPrint("User Details0 ${value.credential?.user?.displayName}");

      debugPrint("User Details1 ${value.credential?.user?.email}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Students"), actions: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: getWidth(context, ratio: 0.05),
              vertical: getWidth(context, ratio: 0.02)),
          child: TextButton(
            child: Text(isLoggedIn ? "Sign Out" : "Sign In"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white60)),
            onPressed: () {
              if (isLoggedIn) {
                FirebaseAuth.instance.signOut();
                setState(() {
                  isLoggedIn = false;
                  active = signinMessageWidget(context);
                });
              } else {
                userAuthBloc.doUserAuth();
              }
            },
          ),
        )
      ]),
      body: active,
    );
  }

  Widget listBuilder(BuildContext context) {
    return StreamBuilder<StudentList>(
      stream: studentListBloc.subject.stream,
      builder:
          (BuildContext context, AsyncSnapshot<StudentList> asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          if (asyncSnapshot.data?.error == null &&
              asyncSnapshot.data!.studentList.isNotEmpty) {
            List<Student> studentList = asyncSnapshot.data!.studentList;
            return ListView.builder(
                itemCount: studentList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: StudentComponent(studentList[index]),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return StudentLocation(studentList[index]);
                      }));
                    },
                  );
                });
          } else {
            if (!asyncSnapshot.hasError) {
              return Center(
                  child: Text(
                "An error was encountered...",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getWidth(context, ratio: 0.03)),
              ));
            }
            return const Text("No students found");
          }
        } else {
          return Center(child: const Text("Loading..."));
        }
      },
    );
  }

  Widget failedLogin(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Center(
              child: Text("Sign in Failed, Please retry!",
                  style: TextStyle(fontSize: getWidth(context, ratio: 0.06)))),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: getWidth(context, ratio: 0.03)),
          ),
          GestureDetector(
            child: textClick(
                "Retry", Colors.white60, getWidth(context, ratio: 0.01)),
            onTap: () {
              userAuthBloc.doUserAuth();
            },
          )
        ],
      ),
    );
  }

  Widget signinMessageWidget(BuildContext context) {
    return Center(
        child: Text(
      "Please sign in",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ));

    //  fontSize: getWidth(context, ratio: 0.1)
  }
}
