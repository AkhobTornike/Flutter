import 'package:flutter/material.dart';
import 'package:flutter_app/data/constants.dart';
import 'package:flutter_app/views/pages/course_page.dart';
import 'package:flutter_app/widgets/container_widget.dart';
import 'package:flutter_app/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      KValue.basicLayout,
      KValue.keyConcepts,
      KValue.cleanUi,
      KValue.fixBugs,
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            HeroWidget(title: 'Flutter Map', nextPage: CoursePage()),
            SizedBox(height: 10.0),
            ...List.generate(list.length, (index) {
              return ContainerWidget(
                title: list.elementAt(index),
                description: "The description of this",
              );
            }),
          ],
        ),
      ),
    );
  }
}
