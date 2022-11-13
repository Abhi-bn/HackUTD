import 'package:flutter/material.dart';

class FormApp extends StatelessWidget {
  const FormApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Create Emergency',
      theme: ThemeData(brightness: Brightness.dark),
      home: const EmergencyPage(title: 'Create emergency'),
    );
  }
}

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(100, 100, 100, 100),
          child: EmergencyForm()),
    );
  }
}

class EmergencyForm extends StatefulWidget {
  @override
  _EmergencyFormState createState() => _EmergencyFormState();
}

class _EmergencyFormState extends State<EmergencyForm> {
  final _formKey = GlobalKey<FormState>();

  String _location = '';
  String _description = '';
  int _selectedEmergency = 0;
  bool _sameAsAddress = true;

  List<DropdownMenuItem<int>> emergencyList = [];

  void loadEmergencyTypeList() {
    emergencyList = [];
    emergencyList.add(const DropdownMenuItem(
      child: Text('Animal spotting'),
      value: 0,
    ));
    emergencyList.add(const DropdownMenuItem(
      child: Text('Health emergency'),
      value: 1,
    ));
    emergencyList.add(const DropdownMenuItem(
      child: Text('Theft/Burglary'),
      value: 2,
    ));
    emergencyList.add(const DropdownMenuItem(
      child: Text('Others'),
      value: 3,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadEmergencyTypeList();
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          labelText: 'Enter Description', hintText: 'Description'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _description = value.toString();
        });
      },
    ));

    formWidget.add(DropdownButton(
      items: emergencyList,
      value: _selectedEmergency,
      hint: const Text('Select Emergency type'),
      onChanged: (value) {
        setState(() {
          _selectedEmergency = int.parse(value.toString());
        });
      },
      isExpanded: true,
    ));

    formWidget.add(TextFormField(
      enabled: _sameAsAddress ? false : true,
      decoration: const InputDecoration(
          hintText: 'Location', labelText: 'Enter Location'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter location';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _location = value.toString();
        });
      },
    ));

    formWidget.add(CheckboxListTile(
      value: _sameAsAddress,
      onChanged: (value) {
        setState(() {
          _sameAsAddress = !_sameAsAddress;
        });
      },
      title: const Text(
        'Same as address',
      ),
      controlAffinity: ListTileControlAffinity.leading,
    ));

    void onPressedSubmit() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();

        print("Location " + _location);
        print("Description " + _description);
        switch (_selectedEmergency) {
          case 0:
            print("Animal spotting alert");
            break;
          case 1:
            print("Health Emergency");
            break;
          case 3:
            print("Theft/Burglary");
            break;
          case 4:
            print("Others");
            break;
        }

        print("Location same as address " + _sameAsAddress.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Form Submitted')));
      }
    }

    formWidget.add(ElevatedButton(
        child: const Text('Create'),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.pinkAccent, // Background Color
        ),
        onPressed: onPressedSubmit));

    return formWidget;
  }
}
