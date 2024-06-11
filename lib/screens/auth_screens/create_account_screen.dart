import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/auth_screens/login_screen.dart';
import 'package:flutter_rpg/screens/home_screen/home.dart';
import 'package:flutter_rpg/shared/styled_textfield.dart';
import 'package:flutter_rpg/models/user.dart' as appuser;

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  createAccount(name, password) async {
    try {
      // create firebase user
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: name,
            password: password,
          )
          .then((value) => {
                // create user doc in firebase
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(value.user?.uid)
                    .set({'name': value.user?.email}),
                // create on device singleton
                appuser.User().setName(value.user?.email),
                appuser.User().setUid(value.user?.uid),
                // if sucessful route to home
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => const Home()))
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
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
                      'Create account',
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
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(Icons.password),
                    label: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        createAccount(
                            nameController.text, passwordController.text);
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Have and Account?'),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const LoginScreen()));
                      },
                    )
                  ],
                ),
              ],
            )));
  }
}
