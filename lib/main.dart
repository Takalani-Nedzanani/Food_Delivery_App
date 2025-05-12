import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';

// import 'app_state.dart';
// import 'screens/auth/forgot_password_screen.dart';
// import 'screens/auth/login_screen.dart';
// import 'screens/auth/register_screen.dart';
// import 'screens/home_screen.dart';
// import 'screens/menu_screen.dart';
// import 'screens/order_screen.dart';
// import 'screens/order_status_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyB5yDlF-4sGO4c1B9i4mz2FSHUbuDed8mo",
//       appId: "1:227599926991:android:5f3b0c4a2d8e4b7c",
//       messagingSenderId: "227599926991",
//       projectId: "cut-smartbanking-app",
//       databaseURL: "https://cut-smartbanking-app-default-rtdb.firebaseio.com",
//     ),
//   );
//   runApp(const FoodOrderApp());
// }

// class FoodOrderApp extends StatelessWidget {
//   const FoodOrderApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<AppState>(
//       create: (_) => AppState(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Food Order App',
//         theme: ThemeData(
//           primarySwatch: Colors.orange,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         initialRoute: '/login',
//         routes: {
//           '/login': (context) => const LoginScreen(),
//           '/forgot-password': (context) => const ForgotPasswordScreen(),
//           '/register': (context) => const RegisterScreen(),
//           '/home': (context) => const MainScreen(),
//           '/menu': (context) => MenuScreen(), // <- StatefulWidget
//           '/order': (context) => OrderScreen(),
//           '/status': (context) => OrderStatusScreen(),
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:food_delivery_app/screens/auth/forgot_password_screen.dart';
// import 'package:food_delivery_app/screens/auth/login_screen.dart';
// import 'package:food_delivery_app/screens/auth/register_screen.dart';
// import 'package:provider/provider.dart';
// import 'app_state.dart';
// import 'screens/home_screen.dart';
// import 'screens/menu_screen.dart';
// import 'screens/order_screen.dart';
// import 'screens/order_status_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyB5yDlF-4sGO4c1B9i4mz2FSHUbuDed8mo",
//       appId: "1:227599926991:android:5f3b0c4a2d8e4b7c",
//       messagingSenderId: "227599926991",
//       projectId: "cut-smartbanking-app",
//       databaseURL: "https://cut-smartbanking-app-default-rtdb.firebaseio.com",
//     ),
//   );
//   runApp(FoodOrderApp());
// }

// class FoodOrderApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AppState(),
//       child: MaterialApp(
//         title: 'Food Order App',
//         theme: ThemeData(
//           primarySwatch: Colors.orange,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: LoginScreen(),
//         routes: {
//           '/home': (context) => MainScreen(),
//           '/login': (context) => LoginScreen(),
//           '/forgot-password': (context) => ForgotPasswordScreen(),
//           '/register': (context) => RegisterScreen(),
//           '/menu': (context) => MenuScreen(),
//           '/order': (context) => OrderScreen(),
//           '/status': (context) => OrderStatusScreen(),
//         },
//       ),
//     );
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:food_delivery_app/app_state.dart';
// import 'package:food_delivery_app/screens/auth/forgot_password_screen.dart';
// import 'package:food_delivery_app/screens/auth/login_screen.dart';
// import 'package:food_delivery_app/screens/auth/register_screen.dart';
// import 'package:food_delivery_app/screens/home_screen.dart';
// import 'package:food_delivery_app/services/auth_services.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => AppState(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Food Delivery',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const AuthWrapper(),
//       routes: {
//         '/login': (context) => const LoginScreen(),
//         '/register': (context) => const RegisterScreen(),
//         '/forgot-password': (context) => const ForgotPasswordScreen(),
//         '/main': (context) => const MainScreen(),
//       },
//     );
//   }
// }

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthService>(context);

//     return StreamBuilder<User?>(
//       stream: auth.user,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final user = snapshot.data;
//           return user == null ? const LoginScreen() : const MainScreen();
//         }
//         return const Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }
// }
