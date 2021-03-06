import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:quizeee_ui/models/userModel.dart';
import 'package:quizeee_ui/provider/apiUrl.dart';
import 'package:quizeee_ui/provider/constFun.dart';
import '../models/userModel.dart';
import 'apiUrl.dart';
import 'package:dio/dio.dart';

class Auth with ChangeNotifier {
  // Loader states
  bool isLoading = false;

  // Model References
  List<UserModel> _userModel = [];
  List<UserModel> get userModel {
    return [..._userModel];
  }

  //Local Storage
  final LocalStorage storage = new LocalStorage(ApiUrls.localStorageKey);

  Future<Map<String, dynamic>> sendVerificationOtp(
      Map<String, dynamic> body, bool isLogin) async {
    try {
      String actionurl = isLogin
          ? ApiUrls.sendVerificationOtp
          : ApiUrls.sendVerificationRegistration;
      final result = await http.post(ApiUrls.baseUrl + actionurl,
          headers: ApiUrls.headers, body: json.encode(body));
      final response = json.decode(result.body);
      if (ConstFun.checkStatus(result)) {
        print(response);
        if (actionurl == ApiUrls.sendVerificationRegistration) {
          return ConstFun.reponseData(true, response['message']);
        }
        return response as Map<String, dynamic>;
      } else {
        return ConstFun.reponseData(false, response['message']);
      }
    } catch (e) {
      return ConstFun.reponseData(
          true, "Something went wrong please try again!!");
    }
  }

  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> body) async {
    try {
      final result = await http.post(ApiUrls.baseUrl + ApiUrls.loginUser,
          headers: ApiUrls.headers, body: json.encode(body));
      final response = json.decode(result.body) as Map<String, dynamic>;
      if (ConstFun.checkStatus(result)) {
        print(response);
        if (response['status']) {
          _userModel.clear();
          _userModel.add(UserModel.fromJson(response['user']));
          await ConstFun.saveUserId(_userModel[0].userId, storage);
        } else {
          return ConstFun.reponseData(true, response['message']);
        }
        return ConstFun.reponseData(true, response['message']);
      } else {
        return ConstFun.reponseData(true, response['message']);
      }
    } catch (e) {
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
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
          await ConstFun.saveUserId(_userModel[0].userId, storage);
          return ConstFun.reponseData(true, result.data['message']);
        } else {
          return ConstFun.reponseData(false, result.data['message']);
        }
      } else {
        return ConstFun.reponseData(false, result.data['message']);
      }
    } on DioError catch (e) {
      return ConstFun.reponseData(false, e.response.data['message']);
    } catch (e) {
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
    }
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    try {
      final userId = await ConstFun.getKeyValue("userId", storage);
      final result = await http.get(
        ApiUrls.baseUrl + ApiUrls.getUserDetails + userId.toString(),
        headers: ApiUrls.headers,
      );
      final response = json.decode(result.body) as Map<String, dynamic>;
      if (ConstFun.checkStatus(result)) {
        print(response);
        if (response['status']) {
          _userModel.clear();
          _userModel.add(UserModel.fromJson(response['user']));
          await storage.ready;
          await ConstFun.saveUserId(_userModel[0].userId, storage);
          return ConstFun.reponseData(response['status'], response['message']);
        } else {
          return ConstFun.reponseData(true, response['message']);
        }
      } else {
        return ConstFun.reponseData(false, response['message']);
      }
    } catch (e) {
      return ConstFun.reponseData(
          false, "Something went wrong please try again!!");
    }
  }

  Future<dynamic> checkKeyExist(String key) async {
    await storage.ready;
    return await storage.getItem(key);
  }

  void removePreferences() async {
    await storage.ready;

    await storage.clear();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
