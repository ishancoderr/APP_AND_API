import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:login_project/blocs/aut_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:login_project/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:login_project/models/phonebook.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Phonebook> _phonebooks = <Phonebook>[];

  Future<List<Phonebook>> fetchNotes() async {
    var url = Uri.parse('http://10.0.2.2:8000/apis/v1/?format=json');
    final response = await http.get(url);
    // ignore: deprecated_member_use
    var notes = <Phonebook>[];
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var notesJson in notesJson) {
        notes.add(Phonebook.fromJson(notesJson));
      }
    }
    return notes;
  }

  late StreamSubscription<User?> loginStateSubcription;

  get navigator => null;
  @override
  void initState() {
    var authBloc = Provider.of<AuthBlock>(context, listen: false);
    loginStateSubcription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubcription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fetchNotes().then((value) {
      setState(() {
        _phonebooks.addAll(value);
      });
    });

    final authBloc = Provider.of<AuthBlock>(context);

    var streamBuilder = StreamBuilder<User?>(
        stream: authBloc.currentUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          print(snapshot.data!.photoURL);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Log In Sucessfull', style: TextStyle(fontSize: 10.0)),
              SizedBox(
                height: 20.0,
              ),
              SignInButton(Buttons.Google,
                  text: 'Sign out of  Google',
                  onPressed: () => authBloc.logout()),
              SizedBox(
                height: 20.0,
              ),
              ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                      child: Column(children: <Widget>[
                    Text(_phonebooks[index].names,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(_phonebooks[index].telNo,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                        ))
                  ]));
                },
                itemCount: _phonebooks.length,
              )
            ],
          );
        });
    return Scaffold(
      body: Center(
        child: streamBuilder,
      ),
    );
  }
}
