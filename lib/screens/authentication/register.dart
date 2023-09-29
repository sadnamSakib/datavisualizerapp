import 'package:flutter/material.dart';

import '../../services/auth.dart';
class Register extends StatefulWidget {

  final Function toggleView;
  const Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        title: const Text('Register to Pet Project',
        style: TextStyle(color: Colors.white)),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.person,
            color: Colors.white),
            label: const Text('Login',
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
                    validator: (val) => val!.length < 8 ? 'Enter a password 8+ chars long' : null,
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
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() => error = 'please supply a valid email');
                        print('error registering');
                      } else {
                        print('registered');
                        print(result);
                      }
                    };
                  }),
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
