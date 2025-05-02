// import 'dart:convert';
// import 'package:food_delivery_app/models/menu_item_model.dart';
// import 'package:food_delivery_app/models/order_model.dart';
// import 'package:food_delivery_app/models/restaurant_model.dart';
// import 'package:food_delivery_app/models/user_model.dart';
// import 'package:http/http.dart' as http;

// import '../utils/constants.dart';

// class ApiService {
//   final String baseUrl = Constants.apiUrl;
//   final String? token;

//   ApiService(this.token);

//   // Authentication
//   Future<String> login(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/api/auth/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({'email': email, 'password': password}),
//     );

//     if (response.statusCode == 200) {
//       return json.decode(response.body)['token'];
//     } else {
//       throw Exception('Failed to login');
//     }
//   }

//   Future<User> register(User user, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/api/auth/register'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({...user.toJson(), 'password': password}),
//     );

//     if (response.statusCode == 201) {
//       return User.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to register');
//     }
//   }

//   // Restaurants
//   Future<List<Restaurant>> getRestaurants() async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/api/restaurants'),
//       headers: {'Authorization': 'Bearer $token'},
//     );

//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((data) => Restaurant.fromJson(data)).toList();
//     } else {
//       throw Exception('Failed to load restaurants');
//     }
//   }

//   // Menu
//   Future<List<MenuItem>> getMenuItems(int restaurantId) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/api/restaurants/$restaurantId/menu'),
//       headers: {'Authorization': 'Bearer $token'},
//     );

//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((data) => MenuItem.fromJson(data)).toList();
//     } else {
//       throw Exception('Failed to load menu');
//     }
//   }

//   // Orders
//   Future<Order> placeOrder(Order order) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/api/orders'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: json.encode(order.toJson()),
//     );

//     if (response.statusCode == 201) {
//       return Order.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to place order');
//     }
//   }

//   Future<List<Order>> getUserOrders(int userId) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/api/users/$userId/orders'),
//       headers: {'Authorization': 'Bearer $token'},
//     );

//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((data) => Order.fromJson(data)).toList();
//     } else {
//       throw Exception('Failed to load orders');
//     }
//   }

//   // User
//   Future<User> getUserProfile() async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/api/users/me'),
//       headers: {'Authorization': 'Bearer $token'},
//     );

//     if (response.statusCode == 200) {
//       return User.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load user profile');
//     }
//   }

//   Future<User> updateUserProfile(User user) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/api/users/me'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: json.encode(user.toJson()),
//     );

//     if (response.statusCode == 200) {
//       return User.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to update profile');
//     }
//   }
// }