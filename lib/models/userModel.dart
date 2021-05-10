class UserModel {
  String sId;
  int userId;
  String username;
  String location;
  String email;
  String phone;
  String userAge;
  String referralCode;
  String generatedReferralCode;
  String profilePic;
  String dateOfBirth;
  String deviceId;
  String creationTimeStamp;

  UserModel(
      {this.sId,
      this.userId,
      this.username,
      this.location,
      this.userAge,
      this.email,
      this.phone,
      this.referralCode,
      this.generatedReferralCode,
      this.profilePic,
      this.dateOfBirth,
      this.deviceId,
      this.creationTimeStamp});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    username = json['username'];
    location = json['location'];
    email = json['email'].toString();
    phone = json['phone'].toString();
    referralCode = json['referralCode'];
    generatedReferralCode = json['generatedReferralCode'];
    profilePic = json['profilePic'];
    dateOfBirth = json['dateOfBirth'];
    deviceId = json['deviceId'];
    creationTimeStamp = json['creationTimeStamp'];
    userAge = calculateAge(DateTime.parse(dateOfBirth));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['location'] = this.location;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['referralCode'] = this.referralCode;
    data['generatedReferralCode'] = this.generatedReferralCode;
    data['profilePic'] = this.profilePic;
    data['dateOfBirth'] = this.dateOfBirth;
    data['deviceId'] = this.deviceId;
    data['creationTimeStamp'] = this.creationTimeStamp;
    return data;
  }

  String calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }
}
