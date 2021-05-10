import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quizeee_ui/models/assignedModel.dart';
import 'package:quizeee_ui/models/publicModel.dart';
import 'package:quizeee_ui/provider/apiUrl.dart';
import 'package:quizeee_ui/provider/constFun.dart';
import 'package:quizeee_ui/provider/initialPro.dart';

import 'package:http/http.dart' as http;

class MainPro with ChangeNotifier {
  Auth _auth;

  void upate(Auth auth) async {
    this._auth = auth;
  }

  // Model References
  List<AssignedQuiz> _assignedQuiz = [];
  List<AssignedQuiz> get assignedQuiz {
    return [..._assignedQuiz];
  }

  List<PublicQuizes> _publicQuiz = [];
  List<PublicQuizes> get publicQuiz {
    return [..._publicQuiz];
  }

  Future<Map<String, dynamic>> getDashBoardData() async {
    try {
      final userId = await ConstFun.getKeyValue("userId", _auth.storage);
      var body = {
        "userId": _auth.userModel[0].userId,
        "age": _auth.userModel[0].userAge
      };
      final result = await http.post(ApiUrls.baseUrl + ApiUrls.dashboardData,
          headers: ApiUrls.headers, body: json.encode(body));
      final response = json.decode(result.body) as Map<String, dynamic>;
      if (ConstFun.checkStatus(result)) {
        print(response);
        if (response['status']) {
          _assignedQuiz.clear();
          _publicQuiz.clear();
          response['publicQuizes'].forEach((element) {
            _publicQuiz.add(PublicQuizes.fromJson(element));
          });
          response["assignedQuizes"].forEach((element) {
            _assignedQuiz.add(AssignedQuiz.fromJson(element));
          });
          print(_assignedQuiz);
          print(_publicQuiz);
          return ConstFun.reponseData(true, response['message']);
        } else {
          return ConstFun.reponseData(false, response['message']);
        }
      } else {
        return ConstFun.reponseData(false, response['message']);
      }
    } catch (e) {
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
    }
  }

  DateFormat format = DateFormat("dd-MM-yy hh:mm");
  String stateEndDate(dynamic date) {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime.parse(date.startDate);
    DateTime endTime = DateTime.parse(date.endDate);
    if (startDate.isAfter(now)) {
      return format.format(startDate);
    } else {
      return format.format(endTime);
    }
  }
}
