import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/classes/activity_class.dart';
import 'package:http/http.dart' as http;

// Import your Activity model here
// (Paste the Activity class from earlier above or in a separate file)

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  Future<Activity>? _activityFuture;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    _fetchRandomActivity();
  }

  void _fetchRandomActivity() {
    setState(() {
      _activityFuture = fetchActivity();
    });
  }

  Future<Activity> fetchActivity() async {
    final response = await http.get(
      Uri.parse('https://bored-api.appbrewery.com/random'),
    );
    if (response.statusCode == 200) {
      return Activity.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load activity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Activity"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFirst = !isFirst;
              });
            },
            icon: Icon(Icons.switch_access_shortcut),
          ),
        ],
      ),
      body: FutureBuilder<Activity>(
        future: _activityFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final activity = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedCrossFade(
                firstChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activity: ${activity.activity}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    Text('Type: ${activity.type}'),
                    Text('Participants: ${activity.participants}'),
                    Text('Price: ${activity.type}'),
                    Text('Availability: ${activity.type}'),
                    Text('Accessibility: ${activity.type}'),
                    Text('Duration: ${activity.type}'),
                    Text(
                      'Kid-Friendly: ${activity.kidFriendly ? 'Yes' : 'No'}',
                    ),
                    SizedBox(height: 16),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _fetchRandomActivity,
                      child: Text('Fetch Another Activity'),
                    ),
                  ],
                ),
                secondChild: Center(child: Image.asset('assets/images/bg.jpg')),
                crossFadeState: isFirst
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 1000),
              ),
            );
          }
          return Center(child: Text('No activity found'));
        },
      ),
    );
  }
}
