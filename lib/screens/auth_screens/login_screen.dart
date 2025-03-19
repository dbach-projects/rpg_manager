import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/auth_screens/create_account_screen.dart';
import 'package:flutter_rpg/screens/home_screen/home.dart';
import 'package:flutter_rpg/shared/styled_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signInWithUsernamePassword(name, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: name, password: password)
          .then((value) => {
                // if sucessful route to home
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => const Home()))
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: StyledTextfield(
                    controller: nameController,
                    textInputType: TextInputType.text,
                    prefixIcon: const Icon(Icons.abc),
                    label: 'User Name',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: StyledTextfield(
                    obscureText: true,
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(Icons.password),
                    label: 'Password',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text(
                    'Forgot Password',
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        signInWithUsernamePassword(
                            nameController.text, passwordController.text);
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      const Text('Do not have an account?',
                          style: TextStyle(height: 3.3, fontSize: 15)),
                      TextButton(
                        child: const Text(
                          'Create Account',
                          style: TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      const CreateAccountScreen()));
                        },
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
