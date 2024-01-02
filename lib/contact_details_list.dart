import 'package:flutter/material.dart';

import 'contact_details_model.dart';
import 'database_helper.dart';

import 'main.dart';
import 'optimized_contact_details.dart';


class ContactDetailsListScreen extends StatefulWidget {
  const ContactDetailsListScreen({super.key});

  @override
  State<ContactDetailsListScreen> createState() => _ContactDetailsListScreenState();
}

class _ContactDetailsListScreenState extends State<ContactDetailsListScreen> {
  List<ContactDetailsModel> _contactDetailsList = <ContactDetailsModel>[];

  @override
  void initState() {
    super.initState();
    print('------------------> initState');
    _getContactDetailsRecords();
  }

  _getContactDetailsRecords() async {
    var _contactDetailRecords = await dbHelper.getAllContactDetails();

    _contactDetailRecords.forEach((contactDetailRow) {
      setState(() {

        print(contactDetailRow[DatabaseHelper.colContactName]);
        print(contactDetailRow[DatabaseHelper.colMobNo]);
        print(contactDetailRow[DatabaseHelper.colEmailId]);
        print(contactDetailRow[DatabaseHelper.colDOB]);
        print(contactDetailRow[DatabaseHelper.colTime]);

        var contactDetailsModel = ContactDetailsModel(
          contactDetailRow[DatabaseHelper.colContactName],
          contactDetailRow[DatabaseHelper.colMobNo],
          contactDetailRow[DatabaseHelper.colEmailId],
          contactDetailRow[DatabaseHelper.colDOB],
          contactDetailRow[DatabaseHelper.colTime],
        );

        _contactDetailsList.add(contactDetailsModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: _contactDetailsList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  print('---------->Edit or Delete invoked: Send Data');

                  print(_contactDetailsList[index].name);
                  print(_contactDetailsList[index].mobileNo);
                  print(_contactDetailsList[index].emailId);
                  print(_contactDetailsList[index].dob);
                  print(_contactDetailsList[index].time);


                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OptimizedContactDetailsFormScreen(),
                    settings: RouteSettings(
                      arguments: _contactDetailsList[index],
                    ),
                  ));

                },
                child: ListTile(
                  title: Text(_contactDetailsList[index].name +
                      '\n' +
                      _contactDetailsList[index].mobileNo +
                      '\n' +
                      _contactDetailsList[index].emailId +
                      '\n' +
                      _contactDetailsList[index].dob +
                      '\n' +
                      _contactDetailsList[index].time),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('--------------> Launch contact Details Form Screen');

          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => OptimizedContactDetailsFormScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
