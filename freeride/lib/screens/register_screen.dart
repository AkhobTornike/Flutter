import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // A state variable to track the password visibility
  bool _isPasswordVisible = false;

  // Controllers for all text fields
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // State variables for validation rules
  bool _hasMinLength = false;
  bool _hasNumber = false;
  bool _hasUppercase = false;
  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _passwordsMatch = false;

  // State variables to track if fields have been touched
  bool _isPasswordTouched = false;
  bool _isRepeatPasswordTouched = false;
  bool _isNameTouched = false;
  bool _isEmailTouched = false;

  // Track focus nodes for each field
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _repeatPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Listen to changes in all text fields to trigger validation
    _passwordController.addListener(_validateAllFields);
    _repeatPasswordController.addListener(_validateAllFields);
    _nameController.addListener(_validateAllFields);
    _emailController.addListener(_validateAllFields);

    // Initial validation to ensure the button is disabled on load
    _validateAllFields();

    // Add focus listeners
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus && _nameController.text.isNotEmpty) {
        setState(() {
          _isNameTouched = true;
        });
      }
    });

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus && _emailController.text.isNotEmpty) {
        setState(() {
          _isEmailTouched = true;
        });
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus && _passwordController.text.isNotEmpty) {
        setState(() {
          _isPasswordTouched = true;
        });
      }
    });

    _repeatPasswordFocusNode.addListener(() {
      if (!_repeatPasswordFocusNode.hasFocus &&
          _repeatPasswordController.text.isNotEmpty) {
        setState(() {
          _isRepeatPasswordTouched = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repeatPasswordFocusNode.dispose();
    super.dispose();
  }

  // A single validation function for all form fields
  void _validateAllFields() {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final repeatPassword = _repeatPasswordController.text;

    // Check all validation rules
    final isNameValid = name.trim().isNotEmpty;
    final isEmailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    final hasMinLength = password.length >= 8;
    final hasNumber = password.contains(RegExp(r'\d'));
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));

    // Check if passwords match
    final passwordsMatch = password == repeatPassword && password.isNotEmpty;

    // Update the state with the new validation results
    setState(() {
      _isNameValid = isNameValid;
      _isEmailValid = isEmailValid;
      _hasMinLength = hasMinLength;
      _hasNumber = hasNumber;
      _hasUppercase = hasUppercase;
      _passwordsMatch = passwordsMatch;
    });
  }

  // A computed property to determine if the form is valid
  bool get _isFormValid {
    return _isNameValid &&
        _isEmailValid &&
        _hasMinLength &&
        _hasNumber &&
        _hasUppercase &&
        _passwordsMatch;
  }

  // Helper widget to display a single validation row
  Widget _buildValidationRow(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          size: 16,
          color: isValid ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isValid ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  // Helper function to determine border color for text fields
  Color _getBorderColor(
    bool isTouched,
    bool isValid, {
    bool isFocused = false,
  }) {
    if (!isTouched) {
      return isFocused ? Colors.blue : Colors.black45;
    }
    return isValid ? Colors.green : Colors.red;
  }

  // New Function to show a custom, beautiful success message
  void _showSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withValues(alpha: 0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              const SizedBox(height: 16),
              const Text(
                'დარეგისტრირდით წარმატებით!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'თქვენი ანგარიში შექმნილია და შეგიძლიათ შეხვიდეთ.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'შესვლა',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Application Logo
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png', // Your app logo
                      width: 150,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Icon(
                            Icons.directions_car,
                            size: 60,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      'რეგისტრაცია',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Name Field
                  const Text(
                    'სრული სახელი',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    onTap: () {
                      setState(() {
                        _isNameTouched = true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'ჩაწერეთ თქვენი სრული სახელი და გვარი',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _getBorderColor(_isNameTouched, _isNameValid),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _getBorderColor(
                            _isNameTouched,
                            _isNameValid,
                            isFocused: true,
                          ),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                  // Name Validation
                  if (_isNameTouched && !_isNameValid) ...[
                    const SizedBox(height: 8),
                    _buildValidationRow('არ არის შევსებული!', _isNameValid),
                  ],
                  const SizedBox(height: 20),

                  // Email Field
                  const Text(
                    'ელ.ფოსტა',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    onTap: () {
                      setState(() {
                        _isEmailTouched = true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'ჩაწერეთ თქვენი ელ.ფოსტა',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _getBorderColor(
                            _isEmailTouched,
                            _isEmailValid,
                          ),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _getBorderColor(
                            _isEmailTouched,
                            _isEmailValid,
                            isFocused: true,
                          ),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                  // Email Validation
                  if (_isEmailTouched && !_isEmailValid) ...[
                    const SizedBox(height: 15),
                    _buildValidationRow(
                      'არ არის შევსებული!',
                      _emailController.text.isNotEmpty,
                    ),
                    const SizedBox(height: 8),
                    _buildValidationRow('არ არის ვალიდური!', _isEmailValid),
                  ],

                  const SizedBox(height: 20),

                  // Password Field
                  const Text(
                    'პაროლი',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: !_isPasswordVisible,
                    onTap: () {
                      setState(() {
                        _isPasswordTouched = true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'ჩაწერეთ თქვენი პაროლი',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _getBorderColor(
                            _isPasswordTouched,
                            _hasMinLength && _hasNumber && _hasUppercase,
                          ),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _getBorderColor(
                            _isPasswordTouched,
                            _hasMinLength && _hasNumber && _hasUppercase,
                            isFocused: true,
                          ),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  // Password Requirements
                  if (_isPasswordTouched &&
                      (!_hasMinLength || !_hasNumber || !_hasUppercase)) ...[
                    const SizedBox(height: 15),
                    _buildValidationRow('მინიმუმ 8 სიმბოლო!', _hasMinLength),
                    const SizedBox(height: 8),
                    _buildValidationRow('მინიმუმ 1 ციფრი!', _hasNumber),
                    const SizedBox(height: 8),
                    _buildValidationRow('მინიმუმ 1 დიდი ასო!', _hasUppercase),
                  ],
                  const SizedBox(height: 30),

                  // Repeat Password Field
                  const Text(
                    'გამეორეთ პაროლი',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _repeatPasswordController,
                    focusNode: _repeatPasswordFocusNode,
                    obscureText: !_isPasswordVisible,
                    onTap: () {
                      setState(() {
                        _isRepeatPasswordTouched = true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'გაიმეორეთ თქვენი პაროლი',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _getBorderColor(
                            _isRepeatPasswordTouched,
                            _passwordsMatch,
                          ),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _getBorderColor(
                            _isRepeatPasswordTouched,
                            _passwordsMatch,
                            isFocused: true,
                          ),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  // Repeat Password Validation
                  if (_isRepeatPasswordTouched && !_passwordsMatch) ...[
                    const SizedBox(height: 15),
                    _buildValidationRow(
                      'პაროლები უნდა ემთხვეოდეს!',
                      _passwordsMatch,
                    ),
                  ],
                  const SizedBox(height: 30),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isFormValid
                          ? () {
                              // Add registration logic here
                              _showSuccessMessage(context);
                            }
                          : null, // Disable button if form is invalid
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFormValid
                            ? Colors.blue
                            : Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'რეგისტრაცია',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Divider with "or" text
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Colors.grey)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'ან',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      const Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Social Login Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google Icon
                      GestureDetector(
                        onTap: () {
                          // Google sign-up logic
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(
                            'assets/images/google_icon.png',
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.error,
                                size: 30,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),

                      // Facebook Icon
                      GestureDetector(
                        onTap: () {
                          // Facebook sign-up logic
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(
                            'assets/images/facebook_icon.png',
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.error,
                                size: 30,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),

                      // Apple Icon
                      GestureDetector(
                        onTap: () {
                          // Apple sign-up logic
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(
                            'assets/images/apple_icon.png',
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.error,
                                size: 30,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // This Positioned widget places the back button at the top-left corner
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 20, // Adjust the radius to control the circle size
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
