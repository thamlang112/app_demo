import 'dart:convert';

import 'package:app_hello/Views/screens/authentication_screens/login_screen.dart';
import 'package:app_hello/Views/screens/main_screen.dart';
import 'package:app_hello/global_variables.dart';
import 'package:app_hello/Models/user.dart';
import 'package:app_hello/services/managa_http_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        password: password,
        token: '',
      );
      final response = await http.post(
        Uri.parse('$uri/api/signup'),
        body:
            user.toJson(), // Convert the user Object to Json for the request body
        headers: <String, String>{
          // Set the headers for the request
          'Content-Type': 'application/json; charset=utf-8',
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
          showSnackBar(context, "Account has been created for you");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  //sign in user function
  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email, //include email in the request body
          'password': password, //include password in the request body
        }),
        headers: <String, String>{
          // thi will set the headr
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      //Handle the response using the manageHttpResponse
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false, // Remove all previous routes
          );
          showSnackBar(context, "Logged in");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }
}
