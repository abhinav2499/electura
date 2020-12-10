import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:electura/constants/constants.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<int> attemptSignUp(
      String username, String email, String password) async {
    var res = await http.post('$SERVER_IP/api/register/',
        body: {"username": username, "email": email, "password": password});
    return res.statusCode;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'Hello',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                    child: Text(
                      'There',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'USERNAME',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          validator: (val) {
                            return val.isEmpty || val.length < 2
                                ? "Please provide a username"
                                : null;
                          },
                          controller: _usernameController,
                          style: TextStyle(color: Colors.white),
                          // decoration: textFieldInputDecoration('Username'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          validator: (val) {
                            return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                                    .hasMatch(val)
                                ? null
                                : "Please provide a valid email";
                          },
                          controller: _emailController,
                          style: TextStyle(color: Colors.white),
                          // decoration: textFieldInputDecoration('Email'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          validator: (val) {
                            return val.length < 6
                                ? "Please provide a strong password"
                                : null;
                          },
                          controller: _passwordController,
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          // decoration: textFieldInputDecoration('Password'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: 60.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.green,
                      shadowColor: Colors.greenAccent,
                      elevation: 5.0,
                      child: GestureDetector(
                        onTap: () async {
                          var username = _usernameController.text;
                          var email = _emailController.text;
                          var password = _passwordController.text;
                          var res =
                              await attemptSignUp(username, email, password);
                          if (res == 201)
                            Navigator.pop(context);
                          else if (res == 409)
                            displayDialog(context, "Username already exists",
                                "Please sign Up with another username.");
                          else
                            displayDialog(context, "Error!",
                                "An unknown error occurred.");
                        },
                        child: Center(
                          child: Text(
                            'SIGNUP',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
