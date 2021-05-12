import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quizeee_ui/models/assignedModel.dart';
import 'package:quizeee_ui/models/dashboardBanner.dart';
import 'package:quizeee_ui/models/publicModel.dart';
import 'package:quizeee_ui/provider/apiUrl.dart';
import 'package:quizeee_ui/provider/constFun.dart';
import 'package:quizeee_ui/provider/initialPro.dart';

import 'package:http/http.dart' as http;
import 'package:quizeee_ui/widgets/toast.dart';

class MainPro with ChangeNotifier {
  Auth _auth;

  //Global Loader for MainPro
  bool isLoading = false;

  void changeLoadingState(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void upate(Auth auth) async {
    this._auth = auth;
  }

  // Model References
  List<AssignedQuiz> _assignedQuiz = [];
  List<AssignedQuiz> get assignedQuiz {
    return [..._assignedQuiz];
  }

  List<DashboardBanner> _dashboardBanner = [];
  List<DashboardBanner> get dashboardBanner {
    return [..._dashboardBanner];
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
        // print(response);
        if (response['status']) {
          _assignedQuiz.clear();
          _publicQuiz.clear();
          response['publicQuizes'].forEach((element) {
            _publicQuiz.add(PublicQuizes.fromJson(element));
          });
          response["assignedQuizes"].forEach((element) {
            _assignedQuiz.add(AssignedQuiz.fromJson(element));
          });
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

  Future<Map<String, dynamic>> getDashBoardBanner() async {
    try {
      final userId = await ConstFun.getKeyValue("userId", _auth.storage);
      var body = {
        "userId": _auth.userModel[0].userId,
        "age": _auth.userModel[0].userAge
      };
      final result = await http.get(
        ApiUrls.baseUrl + ApiUrls.dashboardBanner,
        headers: ApiUrls.headers,
      );
      final response = json.decode(result.body) as Map<String, dynamic>;
      if (ConstFun.checkStatus(result)) {
        if (response['status']) {
          _dashboardBanner.clear();
          _dashboardBanner.add(DashboardBanner.fromJson(response['banner']));
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

  Future<Map<String, dynamic>> checkQuizBookingStatus(String quizId) async {
    try {
      final userId = await ConstFun.getKeyValue("userId", _auth.storage);
      var body = {"userId": _auth.userModel[0].userId, "quizId": quizId};
      final result = await http.post(
        ApiUrls.baseUrl + ApiUrls.checkBookinStatus,
        body: json.encode(body),
        headers: ApiUrls.headers,
      );
      final response = json.decode(result.body) as Map<String, dynamic>;
      return response;
    } catch (e) {
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
    }
  }

  Future<Map<String, dynamic>> bookAQuiz(String quizId) async {
    try {
      final userId = await ConstFun.getKeyValue("userId", _auth.storage);
      var body = {"userId": _auth.userModel[0].userId, "quizId": quizId};
      final result = await http.post(
        ApiUrls.baseUrl + ApiUrls.bookQuiz,
        body: json.encode(body),
        headers: ApiUrls.headers,
      );
      final response = json.decode(result.body) as Map<String, dynamic>;
      return response;
    } catch (e) {
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
    }
  }

  DateFormat format = DateFormat("dd-MMMM , hh:mm");
  String stateEndDate(dynamic date) {
    try {
      DateTime now = DateTime.now();
      DateTime startDate = DateTime.parse(date.startDate);
      if (date.endDate.isNotEmpty) {
        DateTime endTime = DateTime.parse(date.endDate);
        if (startDate.isAfter(now)) {
          return format.format(startDate);
        } else {
          return format.format(endTime);
        }
      } else {
        return format.format(startDate);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String formatDate(String date) {
    DateTime startDate = DateTime.parse(date);
    return format.format(startDate);
  }

  String selectedQuizId;
  int quizIndex;
  dynamic selectedData;
  void saveDataForQuestions(dynamic data) {
    selectedData = data;
  }

  void saveCurrentQuizId({String quizId, int quizIndex}) async {
    selectedQuizId = quizId;
    quizIndex = quizIndex;
  }

  ///QUESTION ANSWER LOGICS
  int _seconds;
  bool enableButton = false;
  List<Map<String, dynamic>> answerSelections = [];
  int get seconds {
    if (_seconds == null) {
      return selectedData.timePerQues;
    }
    return _seconds;
  }

  int _currentQuestionIndex = 0;
  int get currentQuestionIndex {
    return _currentQuestionIndex;
  }

  bool incrementQuestions() {
    bool quesitonFinsh;
    _currentQuestionIndex += 1;
    if (_currentQuestionIndex >= selectedData.questions.length) {
      quesitonFinsh = true;
      _currentQuestionIndex = selectedData.questions.length - 1;
      notifyListeners();
      return quesitonFinsh;
    } else {
      quesitonFinsh = false;
      notifyListeners();
      return quesitonFinsh;
    }
  }

  void enableButtonAns() {
    enableButton = true;
    notifyListeners();
  }

  void makeSelections(int index) {
    final data = answerSelections.where((element) =>
        element['quesId'] ==
        selectedData.questions[_currentQuestionIndex].questionId);
    if (data.isEmpty) {
      answerSelections.add({
        "quesId": selectedData.questions[_currentQuestionIndex].questionId,
        "answer": selectedData.questions[_currentQuestionIndex].options[index]
      });
    } else {
      print(data);
    }
  }
}
