import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizeee_ui/models/userModel.dart';
import 'package:quizeee_ui/provider/apiUrl.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  // Loader states
  bool isLoading = false;

  // Model References
  List<UserModel> _userModel = [];
  List<UserModel> get userModel {
    return [..._userModel];
  }

  Future<Map<String, dynamic>> sendVerificationOtp(
      Map<String, dynamic> body, bool isLogin) async {
    try {
      String actionurl = isLogin
          ? ApiUrls.sendVerificationOtp
          : ApiUrls.sendVerificationRegistration;
      final result = await http.post(ApiUrls.baseUrl + actionurl,
          headers: ApiUrls.headers, body: json.encode(body));
      final response = json.decode(result.body);
      if (checkStatus(result)) {
        print(response);
        if (actionurl == ApiUrls.sendVerificationRegistration) {
          return reponseData(true, response['message']);
        }
        return response as Map<String, dynamic>;
      } else {
        return reponseData(false, response['message']);
      }
    } catch (e) {
      return reponseData(true, "Something went wrong please try again!!");
    }
  }

  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> body) async {
    try {
      final result = await http.post(ApiUrls.baseUrl + ApiUrls.loginUser,
          headers: ApiUrls.headers, body: json.encode(body));
      final response = json.decode(result.body) as Map<String, dynamic>;
      if (checkStatus(result)) {
        print(response);
        if (response['status']) {
          _userModel.clear();
          _userModel.add(UserModel.fromJson(response['user']));
          await saveUserId(_userModel[0].userId);
        } else {
          return reponseData(true, response['message']);
        }
        return reponseData(true, response['message']);
      } else {
        return reponseData(true, response['message']);
      }
    } catch (e) {
      return reponseData(false, "Something went wrong please try again!!");
    }
  }

  Future<Map<String, dynamic>> signupUser(FormData body) async {
    try {
      final result =
          await Dio().post(ApiUrls.baseUrl + ApiUrls.signUpUser, data: body);
      // final response = json.decode(result.data) as Map<String, dynamic>;
      // print(result.data);
      if (result.statusCode == 200) {
        if (result.data['status']) {
          _userModel.clear();
          _userModel.add(UserModel.fromJson(result.data['user']));
          await saveUserId(_userModel[0].userId);
          return reponseData(true, result.data['message']);
        } else {
          return reponseData(false, result.data['message']);
        }
      } else {
        return reponseData(false, result.data['message']);
      }
    } on DioError catch (e) {
      return reponseData(false, e.response.data['message']);
    } catch (e) {
      return reponseData(false, "Something went wrong please try again!!");
    }
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    try {
      final userId = await getKeyValue("userId");
      final result = await http.get(
        ApiUrls.baseUrl + ApiUrls.getUserDetails + userId.toString(),
        headers: ApiUrls.headers,
      );
      final response = json.decode(result.body) as Map<String, dynamic>;
      if (checkStatus(result)) {
        print(response);
        if (response['status']) {
          _userModel.clear();
          _userModel.add(UserModel.fromJson(response['user']));
          await saveUserId(_userModel[0].userId);
        } else {
          return reponseData(true, response['message']);
        }
        return reponseData(true, response['message']);
      } else {
        return reponseData(true, response['message']);
      }
    } catch (e) {
      return reponseData(false, "Something went wrong please try again!!");
    }
  }

  void saveUserId(int userId) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setInt("userId", userId);
  }

  Future<dynamic> getKeyValue(String key) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getInt(key);
  }

  void removePreferences() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.clear();
  }

  Future<bool> checkKeyExist(String key) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.containsKey(key);
  }

  Map<String, dynamic> reponseData(bool status, String msg) {
    return {"msg": msg, "status": status};
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool checkStatus(http.Response result) {
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
