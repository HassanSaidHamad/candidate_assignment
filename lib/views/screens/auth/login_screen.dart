import 'package:candindate_assignment/views/screens/auth/signup_screen.dart';
import 'package:candindate_assignment/views/screens/home_screen.dart';
import 'package:candindate_assignment/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // VALIDATE EMAIL
  bool isEmailValid(String email) {
    // Regular expression for email validation
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  void _loginUser() async {
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

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String storedEmail = prefs.getString('email') ?? '';
    final String storedpassword = prefs.getString('password') ?? '';

    if (_emailController.text == storedEmail &&
        _passwordController.text == storedpassword) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful.'),
        ),
      );

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      // Show error message for invalid credentials
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Invalid email or password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'L o g i n'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.teal,
              radius: 50,
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

            // FORGOT PWD
            Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(top: 10, right: 18),
                child: const Text('Forgot Password ?')),

            // LOGIN BUTTON
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () => _loginUser(),
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
                      'Login',
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

            // SIGN UP BUTTON
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
              },
              child: Container(
                alignment: Alignment.center,
                width: width,
                height: 45,
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  // color: Colors.teal,
                  border: Border.all(color: Colors.teal),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.app_registration,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
