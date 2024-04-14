import 'package:flutter/material.dart';
import 'package:park_notify/widgets/custom_search_view.dart';

class EnterDestinationMaimunaScreen extends StatelessWidget {
  EnterDestinationMaimunaScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();
  final List<String> suggestionsList = [
    'Hackney Wick',
    'Hackney Central',
    'Homerton',
    // Add more suggestions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 100),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return suggestionsList.where((suggestion) =>
                  suggestion.toLowerCase().contains(textEditingValue.text.toLowerCase()));
            },
            onSelected: (String selection) {
              searchController.text = selection;
            },
            fieldViewBuilder: (
                BuildContext context,
                TextEditingController fieldController,
                FocusNode fieldFocusNode,
                VoidCallback onFieldSubmitted,
                ) {
              searchController = fieldController;
              return TextFormField(
                controller: fieldController,
                focusNode: fieldFocusNode,
                decoration: InputDecoration(
                  hintText: "Search Address",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // Update the suggestions based on the user's input
                  // You may want to call an API here to fetch suggestions dynamically
                },
                onFieldSubmitted: (value) {
                  // Handle when the user submits the search
                },
              );
            },
            optionsViewBuilder: (
                BuildContext context,
                AutocompleteOnSelected<String> onSelected,
                Iterable<String> options,
                ) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 200),
                    width: MediaQuery.of(context).size.width - 30,
                    child: ListView(
                      children: options
                          .map(
                            (String option) => ListTile(
                          title: Text(option),
                          onTap: () {
                            onSelected(option);
                          },
                        ),
                      )
                          .toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
