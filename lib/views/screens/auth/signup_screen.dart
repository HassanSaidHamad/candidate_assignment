import 'package:candindate_assignment/views/screens/auth/login_screen.dart';
import 'package:candindate_assignment/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    bool isEmailValid(String email) {
      // Regular expression for email validation
      final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      return regex.hasMatch(email);
    }

    bool isPasswordStrong(String password) {
      // Define criteria for a strong password
      const minLength = 8;
      final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
      final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
      final hasDigits = RegExp(r'\d').hasMatch(password);
      final hasSpecialCharacters =
          RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

      // Check if the password meets all criteria
      return password.length >= minLength &&
          hasUppercase &&
          hasLowercase &&
          hasDigits &&
          hasSpecialCharacters;
    }

    // ignore: no_leading_underscores_for_local_identifiers
    void _registerUser() async {
      // Validate email format
      if (!isEmailValid(_emailController.text)) {
        // Show error message for invalid email format
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email format.'),
          ),
        );
        return;
      }

      // Validate password strength
      if (!isPasswordStrong(_passwordController.text)) {
        // Show error message for weak password
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Password must be at least 8 characters long and contain uppercase letters, lowercase letters, numbers, and special characters.'),
          ),
        );
        return;
      }

      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', _emailController.text);
        await prefs.setString('email', _emailController.text);
        await prefs.setString('password', _passwordController.text);

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful.'),
          ),
        );

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } catch (error) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Registration failed.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        print('Error: $error');
      }
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          's i g n  u p'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 50,
                ),
              ),

              const SizedBox(height: 25),
              Text(
                'create your account'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // EMAIL
              const SizedBox(height: 25),
              Container(
                width: width,
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: TextInputField(
                  controller: _emailController,
                  labelText: 'Enter your email',
                  icon: Icons.email,
                ),
              ),

              // ADDRESS
              const SizedBox(height: 25),
              Container(
                width: width,
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: TextInputField(
                  controller: _addressController,
                  labelText: 'Enter your address',
                  icon: Icons.home,
                ),
              ),

              // PASSWORD
              const SizedBox(height: 25),
              Container(
                width: width,
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: TextInputField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: '********',
                  icon: Icons.password,
                  isObscure: true,
                ),
              ),

              // SIGN UP BUTTON
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () => _registerUser(),
                child: Container(
                  alignment: Alignment.center,
                  width: width,
                  height: 45,
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // FORGOT PWD
              Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(top: 10, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Already a member ?'),
                    const SizedBox(width: 7),
                    InkWell(
                      onTap: () {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
