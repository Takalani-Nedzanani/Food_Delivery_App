import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_delivery_app/screens/cart_page.dart';
import 'package:food_delivery_app/services/notification_service.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'services/auth_services.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/order_screen.dart';
import 'screens/order_status_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB5yDlF-4sGO4c1B9i4mz2FSHUbuDed8mo",
      appId: "1:227599926991:android:5f3b0c4a2d8e4b7c",
      messagingSenderId: "227599926991",
      projectId: "cut-smartbanking-app",
      databaseURL: "https://cut-smartbanking-app-default-rtdb.firebaseio.com",
    ),
  );

  runApp(const FoodOrderApp());
}

class FoodOrderApp extends StatelessWidget {
  const FoodOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        Provider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Order App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/home': (context) => const MainScreen(),       
          '/menu': (context) => MenuScreen(),
          '/order': (context) => OrderScreen(),
          '/status': (context) => OrderStatusScreen(),
          // '/cart': (context) => const CartScreen(),
        },
      ),
    );
  }
}
