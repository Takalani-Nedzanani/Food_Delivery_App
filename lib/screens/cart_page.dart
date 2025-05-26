// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/screens/menu_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:food_delivery_app/app_state.dart';

// // class CartScreen extends StatelessWidget {
// //   const CartScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final appState = context.watch<AppState>();
// //     final cartItems = appState.cart;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Your Cart'),
// //         backgroundColor: Colors.orange,
// //       ),
// //       body: cartItems.isEmpty
// //           ? const Center(child: Text('Your cart is empty'))
// //           : ListView.builder(
// //               itemCount: cartItems.length,
// //               itemBuilder: (context, index) {
// //                 final item = cartItems[index];
// //                 return ListTile(
// //                   title: Text(item.name),
// //                   subtitle: Text('Quantity: ${item.quantity}'),
// //                   trailing: IconButton(
// //                     icon: const Icon(Icons.delete, color: Colors.red),
// //                     onPressed: () {
// //                       appState.removeFromCart(item.id);
// //                     },
// //                   ),
// //                 );
// //               },
// //             ),
// //       bottomNavigationBar: cartItems.isNotEmpty
// //           ? Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   // You could convert the cart to a full order here
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.orange,
// //                   foregroundColor: Colors.white,
// //                 ),
// //                 child: const Text('Proceed to Checkout'),
// //               ),
// //             )
// //           : null,
// //     );
// //   }
// // }

// // class CartScreen extends StatelessWidget {
// //   const CartScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final appState = context.watch<AppState>();
// //     final cartItems = appState.cart;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Your Cart'),
// //         backgroundColor: Colors.orange,
// //       ),
// //       body: cartItems.isEmpty
// //           ? const Center(child: Text('Your cart is empty'))
// //           : ListView.builder(
// //               itemCount: cartItems.length,
// //               itemBuilder: (context, index) {
// //                 final item = cartItems[index];
// //                 return Card(
// //                   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //                   child: ListTile(
// //                     leading: item.imageUrl.isNotEmpty
// //                         ? ClipRRect(
// //                             borderRadius: BorderRadius.circular(8),
// //                             child: Image.network(
// //                               item.imageUrl,
// //                               width: 60,
// //                               height: 60,
// //                               fit: BoxFit.cover,
// //                             ),
// //                           )
// //                         : const Icon(Icons.fastfood, size: 40, color: Colors.grey),
// //                     title: Text(item.name),
// //                     subtitle: Text('Quantity: ${item.quantity}'),
// //                     trailing: IconButton(
// //                       icon: const Icon(Icons.delete, color: Colors.red),
// //                       onPressed: () {
// //                         appState.removeFromCart(item.id);
// //                       },
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //       bottomNavigationBar: cartItems.isNotEmpty
// //           ? Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   // Proceed to checkout logic
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.orange,
// //                   foregroundColor: Colors.white,
// //                 ),
// //                 child: const Padding(
// //                   padding: EdgeInsets.symmetric(vertical: 12),
// //                   child: Text('Proceed to Checkout'),
// //                 ),
// //               ),
// //             )
// //           : null,
// //     );
// //   }
// // }

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final appState = context.watch<AppState>();
//     // final cartItems = appState.cart;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Your Cart',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.orange,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const MenuScreen()),
//             );
//           },
//         ),
//       ),
//       body: cartItems.isEmpty
//           ? const Center(child: Text('Your cart is empty'))
//           : ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = cartItems[index];
//                 return Card(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   child: ListTile(
//                     leading: item.imageUrl.isNotEmpty
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               item.imageUrl,
//                               width: 60,
//                               height: 60,
//                               fit: BoxFit.cover,
//                             ),
//                           )
//                         : const Icon(Icons.fastfood,
//                             size: 40, color: Colors.grey),
//                     title: Text(item.name),
//                     subtitle: Text('Quantity: ${item.quantity}'),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () {
//                         appState.removeFromCart(item.id);
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//       bottomNavigationBar: cartItems.isNotEmpty
//           ? Padding(
//               padding: const EdgeInsets.all(16),
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Proceed to checkout logic
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   foregroundColor: Colors.white,
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                   child: Text('Proceed to Checkout'),
//                 ),
//               ),
//             )
//           : null,
//     );
//   }
// }
