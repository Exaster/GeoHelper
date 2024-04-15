import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_geodata_app/screens/homepage.dart';
import 'package:flutter_geodata_app/screens/register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.2, 0.8],
              ),
            ),
          ),
          // Semi-transparent icons
          Positioned.fill(
            child: CustomPaint(
              painter: IconsMosaicPainter(),
            ),
          ),
          // Login content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Colors.blue),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.blue),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement login logic here
                        String username = usernameController.text;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                title: 'GeoHelper', userNickname: username),
                          ),
                        );
                      },
                      child: const Text('Enter'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to RegisterScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Create Account',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for creating semi-transparent icons mosaic
class IconsMosaicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const iconSize = 40.0;
    final iconColors = [Colors.blue, Colors.red, Colors.green];
    const iconOpacity = 0.2;

    final rng = Random();

    for (double x = 0; x < size.width; x += iconSize) {
      for (double y = 0; y < size.height; y += iconSize) {
        //final icon = Icons.location_on; // Change the icon as needed
        final paint = Paint()
          ..color = iconColors[rng.nextInt(iconColors.length)]
              .withOpacity(iconOpacity);
        canvas.drawCircle(
            Offset(x + iconSize / 2, y + iconSize / 2), iconSize / 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
