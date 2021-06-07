import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:com.quizeee.quizeee/models/assignedModel.dart';
import 'package:com.quizeee.quizeee/models/dashboardBanner.dart';
import 'package:com.quizeee.quizeee/models/pracQuizModel.dart';
import 'package:com.quizeee.quizeee/models/publicModel.dart';
import 'package:com.quizeee.quizeee/models/userRank.dart';
import 'package:com.quizeee.quizeee/models/usernotifications.dart';
import 'package:com.quizeee.quizeee/provider/apiUrl.dart';
import 'package:com.quizeee.quizeee/provider/constFun.dart';
import 'package:com.quizeee.quizeee/provider/initialPro.dart';

import 'package:http/http.dart' as http;
import 'package:com.quizeee.quizeee/widgets/toast.dart';

class MainPro with ChangeNotifier {
  Auth _auth;

  //Global Loader for MainPro
  bool isLoading = false;

  Future<void> changeLoadingState(bool val) {
    isLoading = val;
    notifyListeners();
  }

  Future<void> upate(Auth auth) async {
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

  List<UserRank> _userRank = [];
  List<UserRank> get userRank {
    return [..._userRank];
  }

  List<PracticeQuizModel> _pracQuiz = [];
  List<PracticeQuizModel> get pracQuiz {
    return [..._pracQuiz];
  }

  List<UserNotificationModel> _userNotifications = [];
  List<UserNotificationModel> get userNofications {
    return [..._userNotifications];
  }

  clearDashBoard() {
    _assignedQuiz.clear();
    _publicQuiz.clear();
    _userRank.clear();
    _dashboardBanner.clear();
    changeServeStatus = false;
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
        // // // print(response);
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
      changeServeStatus = false;
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

  // score send count of correct answer

  Future<Map<String, dynamic>> submitQuizResult() async {
    try {
      // ""questionId"":101, ""userOption"":2},{""questionId"":102, ""userOption"":2}
      final userId = await ConstFun.getKeyValue("userId", _auth.storage);

      var reviewSolutions = [];
      answerSelections.forEach((element) {
        if (element['questionId'] != "") {
          reviewSolutions.add({
            "questionId": element['quesId'],
            "userOption": element['answer']
          });
        }
      });

      var body = {
        "userId": _auth.userModel[0].userId,
        "quizId": selectedData.quizId.toString(),
        "score": score,
        "responseTime": responseTime,
        "reviewSolutions": reviewSolutions
      };
      final result = await http.post(
        ApiUrls.baseUrl + ApiUrls.submitResult,
        body: json.encode(body),
        headers: ApiUrls.headers,
      );
      final response = json.decode(result.body) as Map<String, dynamic>;
      if (response['status']) {
        // calling get rank api here
        final responseData = await getUserRank();
        return responseData;
      }

      return response;
    } catch (e) {
      // print(e.toString());
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
    }
  }

  Future<Map<String, dynamic>> getUserRank() async {
    try {
      final userId = await ConstFun.getKeyValue("userId", _auth.storage);
      var body = {
        "userId": _auth.userModel[0].userId,
        "quizId": selectedData.quizId.toString(),
        "prizePool": selectedData.prizePool,
        "endDate": selectedData.endDate == "" || selectedData.endDate == "null"
            ? null
            : DateTime.fromMillisecondsSinceEpoch(
                    int.parse(selectedData.endDate))
                .toIso8601String(),
        "endTime": selectedData.endTime == "" || selectedData.endTime == "null"
            ? null
            : selectedData.endTime,
      };
      final result = await http.post(
        ApiUrls.baseUrl + ApiUrls.getUserRank,
        body: json.encode(body),
        headers: ApiUrls.headers,
      );
      final response = json.decode(result.body) as Map<String, dynamic>;
      _userRank.clear();
      if (response['status']) {
        _userRank.add(UserRank.fromJson(response['rankData']));
      }
      return response;
    } catch (e) {
      // print(e.toString());
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
    }
  }

  bool changeServeStatus = false;
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
      if (response['status']) {
        changeServeStatus = response['status'];
        notifyListeners();
      }
      return response;
    } catch (e) {
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
    }
  }

  Future<Map<String, dynamic>> getPracticeQuiz(
      int quizQuestions, String quizCategory) async {
    try {
      var body = {"noOfQuestions": quizQuestions, "quizCategory": quizCategory};
      final result = await http.post(
        ApiUrls.baseUrl + ApiUrls.pracQuiz,
        body: json.encode(body),
        headers: ApiUrls.headers,
      );
      final response = json.decode(result.body) as Map<String, dynamic>;
      if (response['status']) {
        _pracQuiz.clear();
        response['practiceQuestions'].forEach((element) {
          _pracQuiz.add(PracticeQuizModel.fromJson(element));
        });
      }
      // print(pracQuiz);
      return response;
    } catch (e) {
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
    }
  }

  Future<Map<String, dynamic>> getUsersNotifications() async {
    try {
      final result = await http.get(
        ApiUrls.baseUrl +
            ApiUrls.getUserNotifications +
            _auth.userModel[0].userId.toString(),
        headers: ApiUrls.headers,
      );
      final response = json.decode(result.body) as Map<String, dynamic>;
      if (response['status']) {
        _userNotifications.clear();

        response['notifications'].forEach((element) {
          _userNotifications.add(UserNotificationModel.fromJson(element));
        });
      }
      print(_userNotifications);
      return response;
    } catch (e) {
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
    }
  }

  Future<Map<String, dynamic>> deleteNotications(String noticationId) async {
    try {
      changeLoadingState(true);
      final result = await http.post(
          ApiUrls.baseUrl + ApiUrls.deleteNotifications,
          headers: ApiUrls.headers,
          body: json.encode({"notificationId": noticationId}));
      final response = json.decode(result.body) as Map<String, dynamic>;
      if (response['status']) {
        await getUsersNotifications();
      }
      print(_userNotifications);
      return response;
    } catch (e) {
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
    } finally {
      changeLoadingState(false);
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> getUsersQuiz(
      int quizQuestions, String quizCategory) async {
    try {
      var body = {"noOfQuestions": quizQuestions, "quizCategory": quizCategory};
      final result = await http.get(
        ApiUrls.baseUrl + ApiUrls.getUserQuiz,
        headers: ApiUrls.headers,
      );
      final response = json.decode(result.body) as Map<String, dynamic>;
      if (response['status']) {
        // response['practiceQuestions'].forEach((element) {
        //   _pracQuiz.add(PracticeQuizModel.fromJson(element));
        // });
      }
      // print(pracQuiz);
      return response;
    } catch (e) {
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
    }
  }

  /// ------------------------------
  /// LOGICS
  /// ------------------------------
  DateFormat format = DateFormat("dd-MMMM , hh:mm a");
  DateFormat formatTime = DateFormat("h:mm a");
  String stateEndDate(dynamic date) {
    try {
      DateTime now = DateTime.now();
      DateTime startDate =
          DateTime.fromMillisecondsSinceEpoch(int.parse(date.startDate));
      if (date.endDate.isNotEmpty && date.endDate != "null") {
        DateTime endTime =
            DateTime.fromMillisecondsSinceEpoch(int.parse(date.endDate));
        if (startDate.isAfter(now)) {
          return format.format(startDate);
        } else {
          return format.format(endTime);
        }
      } else {
        return format.format(startDate);
      }
    } catch (e) {
      // print(e.toString());
    }
  }

  String isStartOrEnd(dynamic date) {
    try {
      DateTime now = DateTime.now();
      DateTime startDate =
          DateTime.fromMillisecondsSinceEpoch(int.parse(date.startDate));
      if (date.endDate.isNotEmpty && date.endDate != "null") {
        DateTime endTime =
            DateTime.fromMillisecondsSinceEpoch(int.parse(date.endDate));
        if (startDate.isAfter(now)) {
          return "QUIZ STARTS AT";
        } else {
          return "QUIZ ENDS AT";
        }
      } else {
        return "QUIZ STARTS AT";
      }
    } catch (e) {
      // print(e.toString());
    }
  }

  String formatDate(String date) {
    DateTime startDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    return format.format(startDate);
  }

  String selectedQuizId;
  int quizIndex;
  dynamic selectedData;
  Future<void> saveDataForQuestions(dynamic data) async {
    selectedData = data;
  }

  dynamic selectedPracQuizData;
  Future<void> saveDataForPracQuestions(dynamic data) async {
    selectedPracQuizData = data;
  }

  Future<void> saveCurrentQuizId({String quizId, int quizIndex}) async {
    selectedQuizId = quizId;
    quizIndex = quizIndex;
  }

  ///QUESTION ANSWER LOGICS
  int pracQuizQuestionSec = 0;
  int _seconds = 20;
  int _perQuestionAnswerSeconds = 0;
  bool enableButton = false;
  int _selectedOption;
  bool showSolutions = true;

  int get selectedOption {
    return _selectedOption;
  }

  List<Map<String, dynamic>> answerSelections = [];
  int get seconds {
    if (_seconds == null) {
      _seconds = selectedData.timePerQues;
      return selectedData.timePerQues;
    }
    return _seconds;
  }

  void addPracQuizQuestion(int sec) {
    pracQuizQuestionSec = sec;
  }

  Future<void> decrementSeconds() async {
    _seconds -= 1;
    // print(_seconds);
    notifyListeners();
  }

  Future<void> resetSeconds() async {
    _seconds = selectedData.timePerQues;
    _perQuestionAnswerSeconds = 0;
    notifyListeners();
  }

  Future<void> resetSelectedOption() async {
    _selectedOption = null;
    notifyListeners();
  }

  Future<void> setSelectedOption(int index) async {
    _selectedOption = index;
    notifyListeners();
  }

  int _currentQuestionIndex = 0;
  int get currentQuestionIndex {
    return _currentQuestionIndex;
  }

  Future<void> showAnswer(bool val) async {
    showSolutions = true;
    notifyListeners();
  }

  Future<bool> incrementQuestions() async {
    bool quesitonFinsh;
    _currentQuestionIndex += 1;
    if (_currentQuestionIndex >= selectedData.questions.length) {
      quesitonFinsh = true;
      _currentQuestionIndex = selectedData.questions.length - 1;
      notifyListeners();
      return quesitonFinsh;
    } else {
      // print(answerSelections);

      _selectedOption = null;
      quesitonFinsh = false;
      notifyListeners();
      return quesitonFinsh;
    }
  }

  Future<void> enableButtonAns(bool enable) async {
    enableButton = enable;
    _time_remain_provider = selectedData.timePerQues;
    _perQuestionAnswerSeconds = 0;
    notifyListeners();
  }

  int score = 0;
  int responseTime = 0;
  Future<void> calculateTotalScore() async {
    // print(answerSelections);
    answerSelections.forEach((element) {
      if (element['rightAnswer']) {
        score += 1;
        responseTime = element['second'] + responseTime;
      }
    });

    // print("SCORE : $score");
    // print("RESPONSE TIME : $responseTime");
  }

  Future<void> intializeAnswersList() async {
    answerSelections.clear();
    _perQuestionAnswerSeconds = 0;
    score = 0;
    _time_remain_provider = selectedData.timePerQues;

    for (int i = 0; i < selectedData.questions.length; i++) {
      answerSelections.add({
        "quesId": "",
        "answer": "",
        "second": 0,
        "answerIndex": "",
        "rightAnswer": false
      });
    }
  }

  Future<void> makeSelections(int index) async {
    answerSelections[_currentQuestionIndex]['quesId'] =
        selectedData.questions[_currentQuestionIndex].questionId;
    answerSelections[_currentQuestionIndex]['answer'] =
        selectedData.questions[_currentQuestionIndex].options[index];
    answerSelections[_currentQuestionIndex]['second'] =
        _perQuestionAnswerSeconds;
    answerSelections[_currentQuestionIndex]['answerIndex'] = index;
    answerSelections[_currentQuestionIndex]['rightAnswer'] =
        selectedData.questions[_currentQuestionIndex].rightOption == index;

    notifyListeners();
  }

  int _time_remain_provider = 11;
  void intiazlizeTimer() {}
  int gettime_remain_provider() => _time_remain_provider;
  updateRemainingTime() {
    _perQuestionAnswerSeconds += 1;
    _time_remain_provider--;
    notifyListeners();
  }

  bool showCountDownTimer = false;
  bool quizStarted = false;
  switchToCountDown(bool val) {
    showCountDownTimer = val;
    notifyListeners();
  }

  switchQuizStarted(bool val) {
    quizStarted = val;
    notifyListeners();
  }

  Future<void> clearQuizData() async {
    enableButton = false;
    _seconds = null;
    _perQuestionAnswerSeconds = 0;
    _selectedOption = null;
    showSolutions = true;
    // answerSelections.clear();
    _currentQuestionIndex = 0;
    pracQuizQuestionSec = 0;
    pracSeconds = 0;
    currentPracQuestion = 0;
    selectedOptionPrac = null;
    notifyListeners();
  }

  //TODO: PROACTICE QUIZ LOGICS
  int currentPracQuestion = 0;
  int pracSeconds = 0;
  int selectedOptionPrac = null;
  Future<void> resetSelectedOptionPrac() async {
    selectedOptionPrac = null;
    notifyListeners();
  }

  Future<void> setSelectedOptionPrac(int index) async {
    selectedOptionPrac = index;
    notifyListeners();
  }

  updateRemainingTimePractice(bool reset) {
    if (reset) {
      pracSeconds = 0;
      selectedOptionPrac = null;
      currentPracQuestion++;
    } else {
      pracSeconds++;
    }
    notifyListeners();
  }

  Future<void> intializeAnswersListPractice() async {
    answerSelections.clear();
    pracSeconds = 0;
    score = 0;

    for (int i = 0; i < selectedPracQuizData.length; i++) {
      answerSelections.add({
        "quesId": "",
        "answer": "",
        "second": 0,
        "answerIndex": "",
        "rightAnswer": false
      });
    }
  }

  Future<void> makeSelectionsPrac(int index) async {
    answerSelections[currentPracQuestion]['quesId'] =
        selectedPracQuizData[currentPracQuestion].practiceQuesId;
    answerSelections[currentPracQuestion]['answer'] =
        selectedPracQuizData[currentPracQuestion].options[index];
    answerSelections[currentPracQuestion]['second'] = pracSeconds;
    answerSelections[currentPracQuestion]['answerIndex'] = index;
    answerSelections[currentPracQuestion]['rightAnswer'] =
        selectedPracQuizData[currentPracQuestion].rightOption == index;
    notifyListeners();

    // print(answerSelections);
  }
}
