import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      'New York',
      'Los Angeles',
      'Chicago',
      'Houston',
      'Phoenix',
      'Philadelphia',
      'San Antonio',
      'San Diego',
      'Dallas',
      'San Jose',
      'Austin',
      'Jacksonville',
      'San Francisco',
      'Indianapolis',
      'Columbus',
      'Fort Worth',
      'Charlotte',
      'Seattle',
      'Denver',
      'Washington'
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
