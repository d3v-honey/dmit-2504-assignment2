// ignore_for_file: avoid_print, use_key_in_widget_constructors, file_names, todo, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:robbinlaw/widgets/mysnackbar.dart';

// Do not change the structure of this files code.
// Just add code at the TODO's.

final formKey = GlobalKey<FormState>();

// We must make the variable firstName nullable.
String? firstName;
final TextEditingController textEditingController = TextEditingController();

class MyFirstPage extends StatefulWidget {
  @override
  MyFirstPageState createState() => MyFirstPageState();
}

class MyFirstPageState extends State<MyFirstPage> {
  bool enabled = false;
  int timesClicked = 0;
  String msg1 = '';
  String msg2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A2 - User Input'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Enable Button'),
              Switch(
                value: enabled,
                onChanged: (bool onChangedValue) {
                  print('onChangedValue is $onChangedValue');
                  // enabled is now DIRTY after next statement.
                  enabled = onChangedValue;
                  setState(() {
                    if(timesClicked == 0) {
                      msg1 = 'Click Me';
                    }
                });
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: Build the two buttons here 
              // as children of the row.
              // For each button use a 
              // "Visibility Widget" and its child 
              // will be an "ElevatedButton"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    visible: enabled,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          timesClicked++;
                          msg1 = 'Clicked $timesClicked';
                          print('clicked $timesClicked');
                        });
                      },
                      child: Text(msg1),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: enabled,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          msg1 = 'Click Me';
                          timesClicked = 0;
                        });
                      },
                      child: Text('Reset'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //TODO: Build the text form field
                  // here as the first
                  // child of the column.
                  // Include as the second child
                  // of the column
                  // a submit button that will show a
                  // snackbar with the "firstName"
                  // if validation is satisfied.
                TextFormField(
                  controller: textEditingController,
                  onChanged: (value) {
                    print(value);
                  },
                  onFieldSubmitted: (text) {
                    print('Name = $text');
                    if (formKey.currentState!.validate()) {
                      print('the name input is now valid');
                    }
                  },
                  validator: (input) {
                    return input!.length < 2 ? 'min 1 chars please' : null;
                  },
                  onSaved: (input) {
                    print('onSaved first name = $input');
                    firstName = input;
                  },
                  maxLength: 10,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'first name',
                    helperText: 'min 1, max 10',
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          textEditingController.clear();
                            MySnackBar(text: 'Hey there! Your name is $firstName').show();
                          setState(() {});
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  )
                ],
              ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
