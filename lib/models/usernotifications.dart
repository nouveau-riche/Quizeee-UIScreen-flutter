class UserNotificationModel {
  String sId;
  String userId;
  String message;
  String notificationDate;

  UserNotificationModel(
      {this.sId, this.userId, this.message, this.notificationDate});

  UserNotificationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    userId = json['userId'].toString();
    message = json['message'].toString();
    notificationDate = json['notificationDate'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['message'] = this.message;
    data['notificationDate'] = this.notificationDate;
    return data;
  }
}
