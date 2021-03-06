import 'package:exercise_3/model/slot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddSlot extends StatefulWidget {
  const AddSlot({Key? key, required this.addSlot}) : super(key: key);
  final addSlot;
  @override
  _AddSlotState createState() => _AddSlotState();
}

class _AddSlotState extends State<AddSlot> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _roomIdController = TextEditingController();
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextFormField(
                  controller: _roomIdController,
                  decoration: InputDecoration(labelText: 'Room ID'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a room ID';
                    }
                    return null;
                  },
                ),
              ),
              TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )
                    ),
                ),
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime:
                            DateTime.now().subtract(Duration(days: 365 * 3)),
                        maxTime: DateTime.now().add(Duration(days: 365 * 13)),
                        onChanged: (date) {
                      setState(() {
                        _date = date;
                      });
                    }, onConfirm: (date) {
                      setState(() {
                        _date = date;
                      });
                    }, currentTime: DateTime.now());
                  },
                  child: Text(
                    'Select Date',
                    style: TextStyle(color: Colors.indigo),
                  )),
              SizedBox(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: ElevatedButton(
                      onPressed: () => {
                            if (_formKey.currentState!.validate())
                              {
                                widget.addSlot(Slot(
                                    description: _descriptionController.text,
                                    location: _locationController.text,
                                    roomId: _roomIdController.text,
                                    startTime: _date)),
                                Navigator.pop(context),
                                Navigator.pop(context)
                              }
                          },
                      child: Text("Add Exam")),
                ),
              )
              // Add TextFormFields and ElevatedButton here.
            ],
          ),
        )));
  }
}
