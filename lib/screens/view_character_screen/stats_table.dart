import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class StatsTable extends StatefulWidget {
  const StatsTable(this.character, {super.key});

  final Character character;

  @override
  State<StatsTable> createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {
  double turns = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // available points
          Container(
            color: AppColors.secondaryColor,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.star,
                    color: widget.character.points > 0
                        ? Colors.yellow
                        : Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const StyledText('Stats points available: '),
                const Expanded(
                  child: SizedBox(
                    width: 20,
                  ),
                ),
                StyledHeading(widget.character.points.toString())
              ],
            ),
          ),

          // stats table
          Table(
            children: widget.character.statsAsFormattedList.map((stat) {
              return TableRow(
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor.withOpacity(.5)),
                  children: [
                    // stat title
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: StyledHeading(stat['title']!),
                        )),
                    // stat value
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: StyledHeading(stat['value']!),
                        )),
                    // icon to increase stat
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.character.increaseStats(stat['title']!);
                                turns += .5;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_upward,
                              color: AppColors.textColor,
                            ))),
                    // icon to decrease stat
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.character.decreaseStats(stat['title']!);
                                turns -= .5;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_downward,
                              color: AppColors.textColor,
                            )))
                  ]);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
