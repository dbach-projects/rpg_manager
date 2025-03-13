import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/home_screen/bottom_navigation_bar.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/shared/styled_textfield.dart';

class SearchFilterListScreen extends StatefulWidget {
  const SearchFilterListScreen(
      {super.key,
      required this.items,
      this.itemPropertyToSearchBy,
      this.itemPropertyToFilterBy,
      this.onTap,
      this.borderColor});

  final List<dynamic> items;
  final String? itemPropertyToSearchBy;
  final String? itemPropertyToFilterBy;
  final Function? onTap;
  final Function? borderColor;

  @override
  State<SearchFilterListScreen> createState() => _SearchFilterListScreenState();
}

class _SearchFilterListScreenState extends State<SearchFilterListScreen> {
  List<dynamic> _foundItems = [];
  final _searchController = TextEditingController();

  @override
  initState() {
    // at the beginning, all users are shown
    _foundItems = widget.items;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // This function is called whenever the text field changes
  void _runSearch(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.items;
    } else {
      results = widget.items
          .where((item) => item[widget.itemPropertyToSearchBy]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      _foundItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Choose Skills'),
        centerTitle: true,
      ),
      bottomNavigationBar: const NavigationBarBottom(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            StyledTextfield(
                onChanged: (value) => _runSearch(value),
                controller: _searchController,
                label: 'Search',
                textInputType: TextInputType.text,
                prefixIcon: const Icon(Icons.search)),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundItems.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              widget.onTap!();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: widget.borderColor!(), width: 2)),
                              margin: const EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _foundItems[index].image
                                      ? Image.asset(
                                          'assets/img/skills/${_foundItems[index].image}',
                                          width: 70,
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  StyledText(
                                    _foundItems[index].name,
                                    textOverflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  )
                                ],
                              ),
                            ),
                          ))
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
