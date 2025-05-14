import 'package:flutter/material.dart';
import 'package:food_delivery_app/app_state.dart';
import 'package:food_delivery_app/models/menu_item.dart';
import 'package:food_delivery_app/models/order.dart';
import 'package:food_delivery_app/models/order_item.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  int _quantity = 1;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as MenuItem;
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Order ${item.name}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (item.imageUrl.isNotEmpty)
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                item.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                item.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (_quantity > 1) {
                                setState(() => _quantity--);
                              }
                            },
                          ),
                          Container(
                            width: 40,
                            alignment: Alignment.center,
                            child: Text('$_quantity',
                                style: const TextStyle(fontSize: 20)),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => setState(() => _quantity++),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Special Instructions',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final user = FirebaseAuth.instance.currentUser;

                    if (user == null) {
                      throw Exception('User not signed in.');
                    }

                    final order = Order(
                      id: '',
                      userId: user.uid,
                      userName: user.email ?? 'Unknown',
                      items: [
                        OrderItem(
                          id: item.id,
                          name: item.name,
                          quantity: _quantity,
                        ),
                      ],
                      total: item.price * _quantity,
                      status: 'pending',
                      timestamp: DateTime.now(),
                      notes: _notesController.text,
                    );

                    await appState.placeOrder(order);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Order placed successfully!')),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to place order: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('PLACE ORDER'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/app_state.dart';
// import 'package:food_delivery_app/models/menu_item.dart';
// import 'package:food_delivery_app/models/order.dart';
// import 'package:food_delivery_app/models/order_item.dart';
// import 'package:provider/provider.dart';

// class OrderScreen extends StatefulWidget {
//   const OrderScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _notesController = TextEditingController();
//   int _quantity = 1;

//   @override
//   void dispose() {
//     _notesController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final item = ModalRoute.of(context)!.settings.arguments as MenuItem;
//     final appState = Provider.of<AppState>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text('Order ${item.name}')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               if (item.imageUrl.isNotEmpty)
//                 Container(
//                   height: 200,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     image: DecorationImage(
//                       image: NetworkImage(item.imageUrl),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               SizedBox(height: 16),
//               Text(
//                 item.name,
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//               SizedBox(height: 8),
//               Text(
//                 item.description,
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '\$${item.price.toStringAsFixed(2)}',
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                       color: Theme.of(context).primaryColor,
//                     ),
//               ),
//               SizedBox(height: 24),
//               Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Text('Quantity',
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.remove),
//                             onPressed: () {
//                               if (_quantity > 1) {
//                                 setState(() => _quantity--);
//                               }
//                             },
//                           ),
//                           Container(
//                             width: 40,
//                             alignment: Alignment.center,
//                             child: Text('$_quantity',
//                                 style: TextStyle(fontSize: 20)),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.add),
//                             onPressed: () => setState(() => _quantity++),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _notesController,
//                 decoration: InputDecoration(
//                   labelText: 'Special Instructions',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     final order = Order(
//                       id: '',
//                       userId: 'current_user_id',
//                       userName: 'Current User',
//                       items: [
//                         OrderItem(
//                           id: item.id,
//                           name: item.name,
//                           quantity: _quantity,
//                         ),
//                       ],
//                       total: item.price * _quantity,
//                       status: 'pending',
//                       timestamp: DateTime.now(),
//                       notes: _notesController.text,
//                     );

//                     await appState.placeOrder(order);

//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Order placed successfully!')),
//                     );
//                     Navigator.pop(context);
//                   } catch (e) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Failed to place order: $e')),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   child: Text('PLACE ORDER'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/app_state.dart';
// import 'package:food_delivery_app/models/menu_item.dart';
// import 'package:food_delivery_app/models/order.dart';
// import 'package:food_delivery_app/models/order_item.dart';
// import 'package:provider/provider.dart';

// class OrderScreen extends StatefulWidget {
//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _notesController = TextEditingController();
//   int _quantity = 1;

//   @override
//   void dispose() {
//     _notesController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final item = ModalRoute.of(context)!.settings.arguments as MenuItem;
//     final appState = Provider.of<AppState>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text('Order ${item.name}')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               if (item.imageUrl.isNotEmpty)
//                 Container(
//                   height: 200,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     image: DecorationImage(
//                       image: NetworkImage(item.imageUrl),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               SizedBox(height: 16),
//               Text(
//                 item.name,
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//               SizedBox(height: 8),
//               Text(
//                 item.description,
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '\$${item.price.toStringAsFixed(2)}',
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                       color: Theme.of(context).primaryColor,
//                     ),
//               ),
//               SizedBox(height: 24),
//               Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Text(
//                         'Quantity',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.remove),
//                             onPressed: () {
//                               if (_quantity > 1) {
//                                 setState(() => _quantity--);
//                               }
//                             },
//                           ),
//                           Container(
//                             width: 40,
//                             alignment: Alignment.center,
//                             child: Text(
//                               '$_quantity',
//                               style: TextStyle(fontSize: 20),
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.add),
//                             onPressed: () => setState(() => _quantity++),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _notesController,
//                 decoration: InputDecoration(
//                   labelText: 'Special Instructions',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     final order = Order(
//                       id: '',
//                       userId: 'current_user_id', // Replace with auth user ID
//                       userName: 'Current User', // Replace with auth user name
//                       items: [
//                         OrderItem(
//                           id: item.id,
//                           name: item.name,
//                           quantity: _quantity,
//                         )
//                       ],
//                       total: item.price * _quantity,
//                       status: 'pending',
//                       timestamp: DateTime.now(),
//                       notes: _notesController.text,
//                     );

//                     await appState.placeOrder(order);

//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Order placed successfully!'),
//                         behavior: SnackBarBehavior.floating,
//                       ),
//                     );

//                     Navigator.pop(context);
//                   } catch (e) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Failed to place order: $e'),
//                         behavior: SnackBarBehavior.floating,
//                       ),
//                     );
//                   }
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   child: Text('PLACE ORDER'),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
