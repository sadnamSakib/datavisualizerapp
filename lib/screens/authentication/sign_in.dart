import 'package:flutter/material.dart';
import 'package:pet_project/screens/authentication/register.dart';
import 'package:pet_project/shared/loading.dart';

import '../../services/auth.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({required this.toggleView});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading=false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return  loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        title: const Text('Sign in to Pet Project',
        style: TextStyle(color: Colors.white)),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.person,
            color: Colors.white),
            label: const Text('Register',
            style: TextStyle(color: Colors.white)),
            onPressed: () {
              widget.toggleView();
            },
          ), ],
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body : Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => email = val);
                },
                decoration:  const InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val){
                  setState(() => password = val);
                },
                decoration:  const InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  if (_formkey.currentState!.validate()){
                    dynamic result = await _auth.signinWithEmailAndPassword(email, password);
                    if (result == null){
                      print('error signing in');
                      setState(() => {
                      error = 'Could not sign in with those credentials',
                      loading = false,

                    });
                    }
                    else{
                      print('signed in');
                      print(result);
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        )
        ),
      );

  }
}
