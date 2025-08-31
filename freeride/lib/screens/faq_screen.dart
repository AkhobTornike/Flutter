import 'package:FreeRide/screens/home_screen.dart';
import 'package:FreeRide/screens/news_screen.dart';
import 'package:FreeRide/widgets/icon_bg_icon.dart';
import 'package:FreeRide/widgets/main_layout.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int selectedTab = 0; // 0 -> About Us, 1 -> FAQ

  final List<Map<String, String>> faqItems = [
    {
      "question": "როგორ შევქმნა ანგარიში?",
      "answer":
          "ანგარიშის შესაქმნელად გადადით FreeRide აპლიკაციაში, შეიყვანეთ საჭირო მონაცემები და დაადასტურეთ რეგისტრაცია.",
    },
    {
      "question": "როგორ შევცვალო პაროლი?",
      "answer":
          "პაროლის შესაცვლელად შედით პარამეტრებში და აირჩიეთ პაროლის შეცვლა.",
    },
    {
      "question": "სხვა ვერსიის აპლიკაცია არსებობს?",
      "answer": "ამჟამად FreeRide ხელმისაწვდომია მხოლოდ მიმდინარე ვერსიაში.",
    },
    {
      "question": "რა ხდება თუ პაროლი დამავიწყდა?",
      "answer":
          "შეგიძლიათ გამოიყენოთ 'პაროლის აღდგენა' ფუნქცია შესვლის გვერდზე.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // The main layout of the screen
    return MainLayout(
      selectedPageIndex: 5,
      appBar: null,
      child: Column(
        children: [
          // Custom AppBar-like header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 8.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              children: [
                // Top line with the logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [IconBg()],
                ),
                const SizedBox(height: 10), // Space between the two lines
                // Bottom line with arrow, text, and notifications
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back arrow on the left
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomeScreen(isWeatherWidgetExpanded: false),
                        ),
                      ),
                    ),
                    // Dynamic text in the middle
                    Text(
                      selectedTab == 0 ? "ჩვენს შესახებ" : "დახმარება",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Notification icon with red dot on the right
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_none,
                            color: Colors.black,
                          ),
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewsScreen(),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // The rest of your screen's content
          // The container that holds the two buttons
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Left button: "ჩვენს შესახებ"
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = 0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: selectedTab == 0
                            ? const LinearGradient(
                                colors: [
                                  Color.fromRGBO(5, 208, 230, 0.5),
                                  Color.fromRGBO(0, 75, 173, 0.58),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                            : const LinearGradient(
                                colors: [
                                  Color.fromRGBO(146, 217, 224, 40),
                                  Color.fromRGBO(146, 217, 224, 40),
                                ], // Light gray background
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                        color: selectedTab == 0 ? Colors.grey[100] : null,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedTab == 0
                              ? Colors.grey[300]!
                              : Colors.transparent,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: selectedTab == 0
                                ? Color.fromRGBO(5, 208, 230, 100)
                                : Colors.blueGrey,
                            size: 30,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "ჩვენს შესახებ",
                            style: TextStyle(
                              color: selectedTab == 0
                                  ? Colors.grey[700]
                                  : Colors.grey[400],
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "დახმარება",
                            style: TextStyle(
                              color: selectedTab == 0
                                  ? Colors.black87
                                  : Colors.black12,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Right button: "FAQ"
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = 1),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: selectedTab == 1
                            ? const LinearGradient(
                                colors: [
                                  Color.fromRGBO(5, 208, 230, 0.5),
                                  Color.fromRGBO(0, 75, 173, 0.58),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                            : const LinearGradient(
                                colors: [
                                  Color.fromRGBO(146, 217, 224, 40),
                                  Color.fromRGBO(146, 217, 224, 40),
                                ], // Light gray background
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                        color: selectedTab == 1 ? null : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedTab == 1
                              ? Colors.transparent
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.help_outline,
                            color: selectedTab == 1
                                ? Color.fromRGBO(5, 208, 230, 100)
                                : Colors.blueGrey,
                            size: 30,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "FAQ",
                            style: TextStyle(
                              color: selectedTab == 1
                                  ? Colors.grey[700]
                                  : Colors.grey[400],
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "კითხვები",
                            style: TextStyle(
                              color: selectedTab == 1
                                  ? Colors.black87
                                  : Colors.black12,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(child: selectedTab == 0 ? _buildAboutUs() : _buildFaqList()),
        ],
      ),
    );
  }

  Widget _buildAboutUs() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          "FreeRide არის აპლიკაცია, რომელიც გეხმარებათ სწრაფად, მარტივად და კომფორტულად გადაადგილებაში. "
          "ჩვენი მიზანია მოგაწოდოთ უსაფრთხო და მოსახერხებელი მომსახურება.",
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ),
    );
  }

  Widget _buildFaqList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: faqItems.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            title: Text(
              faqItems[index]["question"]!,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            trailing: const Icon(Icons.add, color: Colors.black54),
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  faqItems[index]["answer"]!,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
