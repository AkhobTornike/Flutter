import 'package:FreeRide/widgets/footer_widget.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final bool showFooter;
  final int? selectedPageIndex; // NEW

  const MainLayout({
    super.key,
    required this.child,
    this.appBar,
    this.showFooter = true,
    this.selectedPageIndex, // optional but needed for footer
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Expanded(child: child),
          if (showFooter && selectedPageIndex != null)
            FooterWidget(selectedPageIndex: selectedPageIndex!),
        ],
      ),
    );
  }
}
