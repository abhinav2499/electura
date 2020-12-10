import 'package:electura/models/usermodel.dart';
import 'package:electura/helper/data.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:electura/constants/constants.dart';

class HomePage extends StatefulWidget {
  // HomePage(this.jwt);

  // final String jwt;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> userList = new List<UserModel>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  getUsers() async {
    UserClass userClass = UserClass();
    await userClass.getUsers();
    userList = userClass.users;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage')),
      body: _loading
          ? Center(child: Container(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return UserTile(
                            username: userList[index].username,
                            email: userList[index].email);
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            FilePickerResult result = await FilePicker.platform.pickFiles();
            if (result != null) {
              File file = File(result.files.single.path);
            }
          },
          child: Icon(Icons.add),
          tooltip: 'Add a file'),
    );
  }
}

class UserTile extends StatelessWidget {
  final String username, email;
  UserTile({@required this.username, @required this.email});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              username,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              email,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
