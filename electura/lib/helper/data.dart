import 'package:electura/models/usermodel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:electura/constants/constants.dart';

class UserClass {
  List<UserModel> users = [];
  Future<void> getUsers() async {
    var response = await http.get('$SERVER_IP/api/users/');
    var jsonData = jsonDecode(response.body);

    jsonData.forEach((element) {
      if (element['email'] != "") {
        UserModel userModel =
            UserModel(username: element['username'], email: element['email']);
        users.add(userModel);
      }
    });
  }
}
