import 'package:flutter/material.dart';

class TimePickerRef extends StatefulWidget {
  const TimePickerRef({Key? key}) : super(key: key);

  @override
  State<TimePickerRef> createState() => _TimePickerRefState();
}

class _TimePickerRefState extends State<TimePickerRef> {
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Picker Reference'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                print('Choose Time');
                _selectTime(context);
              },
              child: Text('Choose Time'),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(
                "${selectedTime.format(context)}",
                style: TextStyle(fontSize: 30),
              ),
            )
          ],
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    print('Select Time Method');

    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {

        selectedTime = timeOfDay;
        print('Selected Time: $selectedTime');
      });
    }
  }
}
