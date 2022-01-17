import 'package:code_aamy_test/model/student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/mfg_labs_icons.dart';

class StudentComponent extends StatelessWidget {
  Student _student;

  StudentComponent(this._student);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(_student.gender?.toLowerCase() == "male"
          ? MfgLabs.user_male
          : MfgLabs.user_female),
      title: Text(
        "${_student.firstName} ${_student.lastName}",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("${_student.email}"),
    );
  }
}
