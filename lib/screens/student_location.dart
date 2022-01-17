import 'package:code_aamy_test/model/student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StudentLocation extends StatefulWidget {
  final Student _student;

  const StudentLocation(this._student, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StudentLocationState();
  }
}

class StudentLocationState extends State<StudentLocation> {
  late GoogleMapController mapController;
  late LatLng position;
  late Student student;

  @override
  void initState() {
    super.initState();
    student = widget._student;
    position = LatLng(student.lat!, student.long!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${student.firstName} Location"),
      ),
      body: GoogleMap(
        onMapCreated: (mapController) {
          this.mapController = mapController;
        },
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 11.0,
        ),
        markers: <Marker>{
          Marker(
              markerId: MarkerId("${student.id!}"),
              position: position,
              infoWindow: InfoWindow(
                  title: "${student.firstName} ${student.lastName}",
                  snippet: "${student.email}"))
        },
      ),
    );
  }
}
