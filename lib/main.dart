import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/auth_screens/login_screen.dart';
import 'package:flutter_rpg/screens/home_screen/home.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/services/skill_store.dart';
import 'package:flutter_rpg/services/vocation_store.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rpg/models/user.dart' as appuser;

//Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //if there is a userId then user already logged in and we can skip this page
  bool loggedIn = FirebaseAuth.instance.currentUser?.uid != null;
  //if the user is still logged in we need to recreate the local User singleton
  if (loggedIn) {
    appuser.User().setName(FirebaseAuth.instance.currentUser?.email);
    appuser.User().setUid(FirebaseAuth.instance.currentUser?.uid);
  }

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CharacterStore()),
        ChangeNotifierProvider(create: (context) => VocationStore()),
        ChangeNotifierProvider(create: (context) => SkillStore()),
      ],
      child: MaterialApp(
          theme: primaryTheme,
          home: loggedIn ? const Home() : const LoginScreen())));
}
