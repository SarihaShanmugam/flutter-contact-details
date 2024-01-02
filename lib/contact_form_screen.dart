/*import 'package:flutter/material.dart';

import 'contact_details_list.dart';
import 'database_helper.dart';
import 'main.dart';

class ContactDetailsFormScreen extends StatefulWidget {
  const ContactDetailsFormScreen({super.key});

  @override
  State<ContactDetailsFormScreen> createState() => _ContactDetailsFormScreenState();
}

class _ContactDetailsFormScreenState extends State<ContactDetailsFormScreen> {
  var _contactNameController = TextEditingController();
  var _cotactMobNoController = TextEditingController();
  var _contactEmailIdController = TextEditingController();
  var _contactDOBController = TextEditingController();
  var _contactTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Contact Details', style: TextStyle(fontSize: 30,
            color: Colors.white),textAlign: TextAlign.center),
        backgroundColor: Colors.green,
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
            controller: _contactNameController,
            decoration: InputDecoration(
              labelText: 'Date Of Birth',
              prefixIcon: InkWell(
                child: Icon(Icons.calendar_today,color: Colors.lightBlue,),
              ),
            ),
          ),
          TextField(
            controller: _contactNameController,
            decoration: InputDecoration(
              labelText: 'Time',
              prefixIcon: InkWell(
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
}*/