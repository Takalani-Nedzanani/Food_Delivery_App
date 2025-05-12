import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/auth/login_screen.dart';
import 'package:food_delivery_app/services/auth_services.dart';
import 'package:provider/provider.dart';

import 'menu_screen.dart';
import 'order_status_screen.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Delivery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final auth = Provider.of<AuthService>(context, listen: false);
              await auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  MenuScreen()),
              ),
              child: const Text('View Menu'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  OrderStatusScreen()),
              ),
              child: const Text('My Orders'),
            ),
          ],
        ),
      ),
    );
  }
}