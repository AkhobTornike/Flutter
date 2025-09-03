import 'package:flutter/material.dart';
import 'package:flutter_app/views/pages/expanded_flexible_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitched = false;
  double sliderValue = 0.0;
  String? menuItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(widget.title))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text('SnackBar'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Text('Open Snackbar'),
              ),
              Divider(color: Colors.teal, thickness: 5.0, endIndent: 200.0),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Alert Title'),
                        content: Text('Alert Content'),
                        actions: [
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Open Dialog'),
              ),
              DropdownButton(
                value: menuItem,
                hint: Text('Select Element'),
                items: [
                  DropdownMenuItem(value: '1', child: Text('Element 1')),
                  DropdownMenuItem(value: '2', child: Text('Element 2')),
                  DropdownMenuItem(value: '3', child: Text('Element 3')),
                ],
                onChanged: (String? value) {
                  setState(() {
                    menuItem = value;
                  });
                },
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(border: OutlineInputBorder()),
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              Text(controller.text),
              Checkbox.adaptive(
                tristate: true,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
              CheckboxListTile.adaptive(
                tristate: true,
                title: Text('Click me'),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
              Switch.adaptive(
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              SwitchListTile.adaptive(
                title: Text('Switch me'),
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              Slider.adaptive(
                max: 10.0,
                value: sliderValue,
                divisions: 10,
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              ),
              InkWell(
                splashColor: Colors.teal,
                onTap: () {},
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.white12,
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ExpandedFlexiblePage();
                      },
                    ),
                  );
                },
                child: Text('Show Flexible and Expanded'),
              ),
              FilledButton(onPressed: () {}, child: Text('filled')),
              TextButton(onPressed: () {}, child: Text('text')),
              OutlinedButton(onPressed: () {}, child: Text('outlined')),
              CloseButton(),
              BackButton(),
            ],
          ),
        ),
      ),
    );
  }
}
