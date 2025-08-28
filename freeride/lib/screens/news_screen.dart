import 'package:FreeRide/screens/home_screen.dart';
import 'package:FreeRide/widgets/icon_bg_icon.dart';
import 'package:FreeRide/widgets/main_layout.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int? expandedIndex; // keeps track of which news is expanded

  final List<Map<String, String>> newsList = [
    {
      "title": "FreeRide გამოგზავნა შეტყობინება",
      "preview": "შეტყობინება ტრასის შესახებ.",
      "details":
          "გაფრთხილება: გურიაში, ბახმაროს მახლობლად ძლიერი ქარიშხალია მოსალოდნელი. გთხოვთ იყოთ ფრთხილად, გადაადგილდეთ მხოლოდ უსაფრთხო ადგილებში და მოერიდოთ მთიან უბნებში გადაადგილებას.",
    },
    {
      "title": "FreeRide ახალი ამბავი",
      "preview": "ახალი ფუნქციები დაემატა აპლიკაციას.",
      "details":
          "მომხმარებლებს შეუძლიათ იხილონ ახალი რუკის ფუნქციები, დამატებითი SOS შესაძლებლობები და გაუმჯობესებული ნავიგაცია.",
    },
    {
      "title": "FreeRide გაფრთხილება",
      "preview": "ტრასა დროებით დახურულია.",
      "details":
          "ამინდის პირობების გამო ტრასა დროებით დახურულია. გთხოვთ დაელოდოთ ოფიციალურ განცხადებას გახსნის შესახებ.",
    },
  ];

  void _toggleExpanded(int index) {
    setState(() {
      if (expandedIndex == index) {
        expandedIndex = null; // collapse if tapped again
      } else {
        expandedIndex = index; // expand only one at a time
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedPageIndex: 3,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            ); // Go back to the previous screen
          },
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const IconBg(), // Your FreeRide icon
            const SizedBox(
              height: 4,
            ), // A small space between the icon and text
            Text(
              "შეტყობინება", // The "Notification" text
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
            },
          ),
        ],
        toolbarHeight: 100, // Increased toolbar height to fit content
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final news = newsList[index];
          final isExpanded = expandedIndex == index;

          return GestureDetector(
            onTap: () => _toggleExpanded(index),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Preview
                    Row(
                      children: [
                        const IconBg(),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "${news["title"]} ${news["preview"]}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isExpanded) ...[
                      const SizedBox(height: 12),
                      Text(
                        news["details"]!,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
