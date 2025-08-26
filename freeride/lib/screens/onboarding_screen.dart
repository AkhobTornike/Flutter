import 'package:flutter/material.dart';
import 'package:FreeRide/models/onboarding_model.dart';
import 'package:FreeRide/widgets/onboarding_page.dart';
import 'package:FreeRide/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      image: 'assets/images/onboarding1.png',
      title: 'აღმოაჩინე შენი შემდეგი თავგადასავალი!',
      description:
          'ინტერაქტიული რუკები მოთხილამურეებისთვის, სნოუბორდინგის, MTB-ისა და ლაშქრობისთვის, სიმაღლის სირთულის შეფასებით და ადგილობრივი მოგზაურების რჩევებით.',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding2.png',
      title: 'რეალურ დროში ამინდი და უსაფრთხოება',
      description:
          'განახლებული ამინდის ინფორმაცია, ბილიკების სირთულეები და სწრაფი SOS შეტყობინებები, შენი უსაფრთხო თავგადასავლებისთვის ',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding3.png',
      title: 'შემოუერთდი ჩვენს ქომუნითის',
      description:
          'გააზიარე შენი მოგზაურობები, აღმოაჩინე ახალი ბილიკები და შეხვდი თავგადასავლების მოყვარულებს მსოფლიოდან',
    ),
  ];

  // Function to navigate to the login screen
  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _onboardingItems.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return OnboardingPage(item: _onboardingItems[index]);
        },
      ),
      bottomSheet: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: _currentPage == _onboardingItems.length - 1
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Onboarding indicator dots in the center for the final page
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _onboardingItems.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Single "Done" button for the final page
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _navigateToLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'დასრულება',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Onboarding indicator dots in the center for non-final pages
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _onboardingItems.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Skip and Next buttons for non-final pages
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _navigateToLogin,
                          child: const Text('გამოტოვება'),
                        ),
                        SizedBox(
                          width: 130,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'შემდეგი',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
