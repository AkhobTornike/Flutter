import 'package:FreeRide/widgets/footer_widget.dart';
import 'package:flutter/material.dart';

// Assuming you have your FooterWidget defined in another file.
// import 'your_footer_widget_file.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'ჩემი ინფორმაცია', // My Information
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              _buildProfilePictureSection(),
              const SizedBox(height: 40),
              _buildInputField(
                'სახელი',
                'ლიკა ფაჩურიშვილი',
              ), // Name, Lika Pachurishvili
              _buildInputField(
                'ელ-ფოსტა',
                'likatyebuchava@gmail.com',
              ), // Email, likatyebuchava@gmail.com
              _buildInputField(
                'დაბადების თარიღი',
                '23/05/1995',
              ), // Date of Birth, 23/05/1995
              _buildPasswordField('პაროლი', '*********'), // Password, *********
              _buildPasswordField('ტელეფონი', '555121312444'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FooterWidget(
        selectedPageIndex: 4,
      ), // Phone Number, 555121312444
      // bottomNavigationBar: const FooterWidget(), // Uncomment this line and replace with your actual widget
    );
  }

  Widget _buildProfilePictureSection() {
    return Center(
      child: Stack(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              'https://example.com/your_profile_image.jpg',
            ), // Replace with user's profile image URL from Firebase Storage
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.black, size: 20),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            readOnly: true, // You might want to make these editable later.
            controller: TextEditingController(text: initialValue),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            readOnly: true,
            controller: TextEditingController(text: initialValue),
            obscureText: label == 'პაროლი', // Obscure text for password field
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
