import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];

  void _fetchSuggestions(String input) {
    // Hard-coded list of suggestions for testing
    List<String> hardcodedSuggestions = [
      'London',
      'Manchester',
      'Birmingham',
      'Glasgow',
      'Liverpool',
      'Leeds',
      'Bristol',
      'Sheffield',
      'Edinburgh',
      'Cardiff',
      'Belfast',
      'Newcastle upon Tyne',
      'Brighton',
      'Leicester',
      'Nottingham',
      'Coventry',
      'Reading',
      'Bournemouth',
      'Southampton',
      'Aberdeen'
    ];

    setState(() {
      _suggestions = hardcodedSuggestions
          .where((place) => place.toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  void _selectSuggestion(String suggestion) {
    setState(() {
      _searchController.text = suggestion;
      _suggestions.clear(); // Clear suggestions after selecting one
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            _fetchSuggestions(value);
          },
          decoration: InputDecoration(
            hintText: 'Search for a location...',
          ),
        ),
      ),
      body: _suggestions.isNotEmpty
          ? ListView.builder(
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_suggestions[index]),
            onTap: () {
              _selectSuggestion(_suggestions[index]); // Update search bar text on tap
            },
          );
        },
      )
          : Container(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SearchPage(),
  ));
}