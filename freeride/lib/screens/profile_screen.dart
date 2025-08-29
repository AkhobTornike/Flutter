import 'dart:convert';
import 'package:FreeRide/screens/home_screen.dart';
import 'package:FreeRide/screens/news_screen.dart';
import 'package:FreeRide/widgets/main_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FreeRide/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!mounted) return; // ✅ safeguard
      if (doc.exists) {
        setState(() {
          userData = doc.data();
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      await AuthService.instance.updateProfileImage(bytes);
      await _loadUserData(); // refresh after upload
      if (!mounted) return; // ✅ safeguard
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("პროფილის სურათი განახლდა")));
    }
  }

  void _changePasswordDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("შეცვალე პაროლი"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: "ახალი პაროლი"),
          obscureText: true,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                await AuthService.instance.changePassword(
                  controller.text.trim(),
                );
                if (!mounted) return;
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("პაროლი წარმატებით შეიცვალა")),
                );
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("შეცდომა: $e")));
              }
            },
            child: const Text("შენახვა"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return MainLayout(
      selectedPageIndex: 4,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const HomeScreen(isWeatherWidgetExpanded: false),
              ),
            );
          },
        ),
        title: const Text(
          'ჩემი ინფორმაცია',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const NewsScreen()),
              );
            },
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              _buildProfilePictureSection(userData?['profileImage']),
              const SizedBox(height: 40),
              _buildInputField('სახელი', userData?['fullName'] ?? ''),
              _buildInputField('ელ-ფოსტა', _auth.currentUser?.email ?? ''),
              _buildEditablePhoneField(userData?['phoneNumber'] ?? ''),
              _buildPasswordChangeField(),
              const SizedBox(height: 30),

              // logout button
              ElevatedButton(
                onPressed: () async {
                  try {
                    await AuthService.instance.signOut();
                    if (!mounted) return; // ✅ safeguard
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HomeScreen(isWeatherWidgetExpanded: false),
                      ),
                    );
                  } catch (e) {
                    if (!mounted) return; // ✅ safeguard
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('გამოსვლა ვერ მოხერხდა: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'გამოსვლა',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePictureSection(String? base64Image) {
    ImageProvider profileImage;
    if (base64Image != null && base64Image.isNotEmpty) {
      profileImage = MemoryImage(base64Decode(base64Image));
    } else {
      profileImage = const AssetImage('assets/images/profile_image.png');
    }

    return Center(
      child: Stack(
        children: [
          CircleAvatar(radius: 60, backgroundImage: profileImage),
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
                onPressed: _pickImage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, String value) {
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
            controller: TextEditingController(text: value),
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

  Widget _buildEditablePhoneField(String phone) {
    final controller = TextEditingController(text: phone);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ტელეფონი',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.save, color: Colors.blue),
                onPressed: () async {
                  try {
                    await AuthService.instance.updatePhoneNumber(
                      controller.text.trim(),
                    );
                    await _loadUserData();
                    if (!mounted) return; // ✅ safeguard
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("ტელეფონი განახლდა")),
                    );
                  } catch (e) {
                    if (!mounted) return; // ✅ safeguard
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("შეცდომა: $e")));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordChangeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'პაროლი',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            readOnly: true,
            obscureText: true,
            controller: TextEditingController(text: "********"),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: _changePasswordDialog,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
