import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/auth_screens/login_screen.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        // First sliver
        SliverAppBar(
          pinned: true,
          expandedHeight: 165.0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            // clear default title padding so centering works
            titlePadding: const EdgeInsets.only(),
            title: const StyledTitle('Settings'),
            background: SizedBox(
              width: double.infinity,
              child: Opacity(
                opacity: 0.65,
                child: Image.asset('assets/img/skills/gamify.jpg',
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),

        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StyledButton(
                    onPressed: () {
                      _signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const LoginScreen()));
                    },
                    child: const StyledHeading('Log Out')),
                const SizedBox(
                  width: 20,
                )
              ],
            );
          },
          childCount: 1,
        )),
      ]),
    );
  }
}
