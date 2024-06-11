import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class VocationScreen extends StatelessWidget {
  const VocationScreen({super.key, required this.vocation});

  final Vocation vocation;

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
            title: StyledTitle(vocation.name),
            background: SizedBox(
              width: double.infinity,
              child: Opacity(
                opacity: 0.65,
                child: Image.asset('assets/img/vocations/${vocation.image}',
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
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const StyledHeading('Class'),
                            StyledText(vocation.title)
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const StyledHeading('Description'),
                            StyledText(vocation.description)
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),

                // weapon, ability and slogan
                const SizedBox(
                  width: 20,
                ),
                Center(
                  child: Icon(Icons.code, color: AppColors.primaryColor),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: AppColors.secondaryColor.withOpacity(.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StyledHeading('Title'),
                        StyledText(vocation.title),
                        const SizedBox(
                          height: 10,
                        ),
                        const StyledHeading('Weapon of choice'),
                        StyledText(vocation.weapon),
                        const SizedBox(
                          height: 10,
                        ),
                        const StyledHeading('Unique Ability'),
                        StyledText(vocation.ability),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 20,
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
