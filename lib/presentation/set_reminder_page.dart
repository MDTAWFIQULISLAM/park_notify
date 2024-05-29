import 'package:flutter/material.dart';
import 'dart:async';

class SetReminderPage extends StatefulWidget {
  @override
  _SetReminderPageState createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {
  late Timer _timer;
  late int _hours;
  late int _minutes;
  late int _seconds;
  bool _timerRunning = false;

  @override
  void initState() {
    super.initState();
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
  }

  void _startTimer() {
    int totalSeconds = _hours * 3600 + _minutes * 60 + _seconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (totalSeconds > 0) {
          totalSeconds--;
          _hours = totalSeconds ~/ 3600;
          _minutes = (totalSeconds % 3600) ~/ 60;
          _seconds = totalSeconds % 60;
        } else {
          _timer.cancel();
          _timerRunning = false;
        }
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
    _timerRunning = false;
  }

  void _resetTimer() {
    setState(() {
      _hours = 0;
      _minutes = 0;
      _seconds = 0;
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final List<int?>? selectedTime = await showDialog<List<int?>>(
      context: context,
      builder: (BuildContext context) {
        int hour = _hours;
        int minute = _minutes;
        int second = _seconds;
        return AlertDialog(
          title: Text('Select Parking Duration'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  children: [
                    Text('Hours:'),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          hour = int.tryParse(value) ?? hour;
                        },
                        decoration: InputDecoration(labelText: 'Hours'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Minutes:'),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          minute = int.tryParse(value) ?? minute;
                        },
                        decoration: InputDecoration(labelText: 'Minutes'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Seconds:'),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          second = int.tryParse(value) ?? second;
                        },
                        decoration: InputDecoration(labelText: 'Seconds'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Parked'),
              onPressed: () {
                Navigator.of(context).pop([hour, minute, second]);
              },
            ),
          ],
        );
      },
    );

    if (selectedTime != null) {
      setState(() {
        _hours = selectedTime[0] ?? 0;
        _minutes = selectedTime[1] ?? 0;
        _seconds = selectedTime[2] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Reminder"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Move Your Car in $_hours:${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            if (!_timerRunning)
              ElevatedButton(
                onPressed: () {
                  _selectTime(context).then((_) {
                    setState(() {
                      _timerRunning = true;
                    });
                    _startTimer();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22), // Padding around the button
                ),
                child: Text(
                  'Set Parking Reminder',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Text color
                  ),
                ), // Text size
              ),
            if (_timerRunning)
              ElevatedButton(
                onPressed: () {
                  _stopTimer();
                  _resetTimer(); // Reset the timer
                  setState(() {
                    _timerRunning = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22), // Padding around the button
                ),
                child: Text(
                  'Car Moved',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Text color
                  ),
                ), // Text size
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SetReminderPage(),
  ));
}
