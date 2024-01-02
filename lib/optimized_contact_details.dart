import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'contact_details_list.dart';
import 'contact_details_model.dart';
import 'database_helper.dart';
import 'main.dart';

class OptimizedContactDetailsFormScreen extends StatefulWidget {
  const OptimizedContactDetailsFormScreen({super.key});

  @override
  State<OptimizedContactDetailsFormScreen> createState() => _OptimizedContactDetailsFormScreenState();
}

class _OptimizedContactDetailsFormScreenState extends State<OptimizedContactDetailsFormScreen> {
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

  // Edit mode
  bool firstTimeFlag = false;
  int _selectedId = 0;
  // Optimized
  String buttonText = 'Save';

  _deleteFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  print('--------------> Cancel Button Clicked');
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print('--------------> Delete Button Clicked');
                  _delete();
                },
                child: const Text('Delete'),
              )
            ],
            title: const Text('Are you sure you want to delete this?'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    // Edit - Receive Data
    if (firstTimeFlag == false) {
      print('---------->once execute');

      firstTimeFlag = true;

      //final bankDetails = ModalRoute.of(context)!.settings.arguments as BankDetailsModel;
      final contactDetails = ModalRoute.of(context)!.settings.arguments;

      if(contactDetails == null) {
        print('----------->FAB: Insert/Save:');
      } else {
        print('----------->ListView: Received Data: Edit/Delete');

        contactDetails as ContactDetailsModel;

        print('----------->Received Data');

        buttonText = 'Update';

        print(contactDetails.name);
        print(contactDetails.mobileNo);
        print(contactDetails.emailId);
        print(contactDetails.dob);
        print(contactDetails.time);

        _selectedId = contactDetails.id!;

        _contactNameController.text = contactDetails.name;
        _cotactMobNoController.text = contactDetails.mobileNo;
        _contactEmailIdController.text = contactDetails.emailId;
        _contactDOBController.text = contactDetails.dob;
        _contactTimeController.text = contactDetails.time;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details Form'),
        actions: _selectedId == 0 ? null :[
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text("Delete")),
            ],
            elevation: 2,
            onSelected: (value) {
              if (value == 1) {
                print('Delete option clicked');
                _deleteFormDialog(context);
              }
            },
          ),
        ],
      ),
      body: Column(

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
              prefixIcon: InkWell(onTap: ()
              {
                print('calender clicked');
                _datePicker();
              },
                child: Icon(Icons.calendar_today,color:
                Colors.lightBlue,),
              ),
            ),
          ),
          TextField(
            controller: _contactNameController,
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
                    print('--------------> Update Button Clicked');
                    if (_selectedId == 0) {
                      print('---------------> Save');
                      _save();
                    } else {
                      print('---------------> Update');
                      _update();
                    }
                  },
                  child: Text('Update'),
          )
        ],
      ),
    );
  }

  void _save() async{
    print('--------------> _save');
    print('--------------> Bank Name: ${_contactNameController.text}');
    print('--------------> Branch: ${_cotactMobNoController.text}');
    print('--------------> Account Type: ${_contactEmailIdController.text}');
    print('--------------> Account No: ${_contactDOBController.text}');
    print('--------------> IFSC Code: ${_contactTimeController.text}');

    Map<String, dynamic> row = {
      DatabaseHelper.colContactName: _contactNameController.text,
      DatabaseHelper.colMobNo: _cotactMobNoController.text,
      DatabaseHelper.colEmailId: _contactEmailIdController.text,
      DatabaseHelper.colDOB: _contactDOBController.text,
      DatabaseHelper.colTime: _contactTimeController.text,
    };


    final result = await dbHelper.insertContactDetails(row);
    debugPrint('--------> Inserted Row Id: $result');

    if(result != 0) {
      _showSuccessSnackBar(context, 'Successfully Saved');
      backToListScreen();
    }else{
      _showSuccessSnackBar(context, 'Failed to save.');
    }
  }

  void _update() async{
    print('--------------> _save');
    print('--------------> Bank Name: ${_contactNameController.text}');
    print('--------------> Branch: ${_cotactMobNoController.text}');
    print('--------------> Account Type: ${_contactEmailIdController.text}');
    print('--------------> Account No: ${_contactDOBController.text}');
    print('--------------> IFSC Code: ${_contactTimeController.text}');

    Map<String, dynamic> row = {
      DatabaseHelper.colContactName: _contactNameController.text,
      DatabaseHelper.colMobNo: _cotactMobNoController.text,
      DatabaseHelper.colEmailId: _contactEmailIdController.text,
      DatabaseHelper.colDOB: _contactDOBController.text,
      DatabaseHelper.colTime: _contactTimeController.text,
    };

    final result = await dbHelper.updateContactDetails(row);
    debugPrint('--------> Updated Row Id: $result');

    if(result != 0) {
      _showSuccessSnackBar(context, 'Successfully Updated');
      backToListScreen();
    }else{
      _showSuccessSnackBar(context, 'Failed to update.');
    }
  }

  void _delete() async{
    print('--------------> _delete');

    final result = await dbHelper.deleteContactDetails(_selectedId);

    debugPrint('-----------------> Deleted Row Id: $result');

    if(result != 0) {
      _showSuccessSnackBar(context, 'Successfully Deleted.');
      backToListScreen();
    }else{
      _showSuccessSnackBar(context, 'Failed to delete.');
    }
  }

  backToListScreen(){
    setState(() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ContactDetailsListScreen()));
    });
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(message)));
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
}
