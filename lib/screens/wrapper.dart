import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'authentication/sign_in.dart';
import 'authentication/authenticate.dart';
import 'package:provider/provider.dart';
import '../models/userModel.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final currentUser = Provider.of<user?>(context);
    if(currentUser == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}

