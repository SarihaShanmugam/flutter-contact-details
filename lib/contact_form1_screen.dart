import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import 'contact_details_list.dart';
import 'database_helper.dart';
import 'main.dart';

class ContactDetailsFormScreen1 extends StatefulWidget {
  const ContactDetailsFormScreen1({super.key});

  @override
  State<ContactDetailsFormScreen1> createState() => _ContactDetailsFormScreen1State();
}

class _ContactDetailsFormScreen1State extends State<ContactDetailsFormScreen1> {
  var _contactNameController = TextEditingController();
  var _cotactMobNoController = TextEditingController();
  var _contactEmailIdController = TextEditingController();
  var _contactDOBController = TextEditingController();
  var _contactTimeController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  _selectTodoDate(BuildContext context)async{
    print('Select Date Method');

    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );

    if(_pickedDate != null){
      setState(() {
        _dateTime = _pickedDate;
        _contactDOBController.text = DateFormat("dd-MM-yyyy").format(_dateTime);
        print('Picked Date : $_dateTime');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Contact Details', style: TextStyle(fontSize: 30,
            color: Colors.white),
            textAlign: TextAlign.center),
        backgroundColor: Colors.green,
        actions: [
          PopupMenuButton(itemBuilder: (context)=> [
            PopupMenuItem(
              value: 1,
              child: Text('Share',
                style: TextStyle(fontSize: 16),
              ),),
          ],
            onSelected: (value) {
              if(value == 1) {
                _share();
              }
            },
          ),
        ],

      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          TextField(
            controller: _contactNameController,
            decoration: InputDecoration(
              labelText: 'Contact Name',
              prefixIcon: InkWell(
                child: Icon(Icons.person,color: Colors.black,),
              ),
            ),
          ),
          TextField(
            controller: _cotactMobNoController,
            decoration: InputDecoration(
              labelText: 'Mobile No',
              prefixIcon: InkWell(
                child: Icon(Icons.phone,color: Colors.blue,),
              ),
            ),
          ),
          TextField(
            controller: _contactEmailIdController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: InkWell(
                child: Icon(Icons.email,color: Colors.red,),
              ),
            ),
          ),
          TextField(
            controller: _contactDOBController,
            decoration: InputDecoration(
              labelText: 'Date Of Birth',
              prefixIcon: InkWell(onTap: ()
                {
                  print('calender clicked');
                  _dateTime;
                },
                child: Icon(Icons.calendar_today,color:
                Colors.lightBlue,),
              ),
            ),
          ),
          TextField(
            controller: _contactTimeController,
            decoration: InputDecoration(
              labelText: 'Time',
              prefixIcon: InkWell(
                onTap: ()
                {
                  print('timer clicked');
                  _selectTime(context);
                },
                child: Icon(Icons.timer,color: Colors.orangeAccent,),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              print('--------------> Save Button Clicked');
              _save();
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }


  void _save() async {
    print('--------------> _save');
    print('--------------> contact Name: ${_contactNameController.text}');
    print('--------------> moblie no: ${_cotactMobNoController.text}');
    print('--------------> email: ${_contactEmailIdController.text}');
    print('--------------> dob: ${_contactDOBController.text}');
    print('-------------->date: ${_contactTimeController.text}');

    Map<String, dynamic> row = {
      DatabaseHelper.colContactName: _contactNameController.text,
      DatabaseHelper.colMobNo: _cotactMobNoController.text,
      DatabaseHelper.colEmailId: _contactEmailIdController.text,
      DatabaseHelper.colDOB: _contactDOBController.text,
      DatabaseHelper.colTime: _contactTimeController.text,
    };

    final result = await dbHelper.insertContactDetails(row);
    debugPrint('--------> Inserted Row Id: $result');

    _showSuccessSnackBar(context, 'Successfully Saved');

    setState(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ContactDetailsListScreen()));
    });
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        new SnackBar(content: new Text(message)));
  }
void _datePicker() async {
    var pickedDate = await showDatePicker(context: context,
        firstDate: DateTime(1990), lastDate: DateTime(2025));
    if (pickedDate !=null)
      {
        setState(() {
          _dateTime=pickedDate;
          _contactDOBController.text = DateFormat("dd-MM-yyyy").format(_dateTime);

        });
      }
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
  _share() {
    Share.share(_contactDOBController.text);
    Share.share(_contactNameController.text);
  }
}