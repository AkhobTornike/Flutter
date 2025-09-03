import 'package:flutter/material.dart';
import 'package:flutter_app/data/constants.dart';
import 'package:flutter_app/data/notifiers.dart';
import 'package:flutter_app/views/pages/home_page.dart';
import 'package:flutter_app/views/pages/profile_page.dart';
import 'package:flutter_app/views/pages/settings_page.dart';
import 'package:flutter_app/widgets/navbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Widget> pages = [HomePage(), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Column(
          spacing: 15,
          children: [
            Image.asset('assets/images/icon_bg.png', height: 50),
            Text(
              'შეტყობინება',
              style: TextStyle(
                color: isDarkModeNotifier.value ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 10.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_sharp,
              color: isDarkModeNotifier.value ? Colors.white : Colors.black87,
              size: 40,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 10.0),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(title: 'Settings'),
                      ),
                    );
                  },
                  icon: Icon(Icons.settings, size: 40),
                ),
                IconButton(
                  onPressed: () async {
                    isDarkModeNotifier.value = !isDarkModeNotifier.value;
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool(
                      KConstants.themeModeKey,
                      isDarkModeNotifier.value,
                    );
                  },
                  icon: ValueListenableBuilder(
                    valueListenable: isDarkModeNotifier,
                    builder: (context, isDarkMode, child) {
                      return Icon(
                        isDarkMode
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                        color: Colors.cyan,
                        size: 40,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
        backgroundColor: isDarkModeNotifier.value
            ? Colors.black87
            : Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Container(
            color: isDarkModeNotifier.value ? Colors.white : Colors.black87,
            height: 1,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
