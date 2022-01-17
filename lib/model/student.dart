class Student {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  double? lat;
  double? long;
  String? error;

  Student(this.id, this.firstName, this.lastName, this.email, this.gender,
      this.lat, this.long);

  Student.fromJson(Map<String, dynamic> jsonObj)
      : id = jsonObj["id"],
        firstName = jsonObj["first_name"],
        lastName = jsonObj["last_name"],
        email = jsonObj["email"],
        gender = jsonObj["gender"],
        lat = jsonObj["lat"],
        long = jsonObj["long"];

  Student.withError(this.error);
}
