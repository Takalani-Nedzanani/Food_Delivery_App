// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/app_state.dart';
// import 'package:food_delivery_app/models/menu_item.dart';
// import 'package:food_delivery_app/models/order.dart';
// import 'package:food_delivery_app/models/order_item.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class OrderScreen extends StatefulWidget {
//   const OrderScreen({super.key});

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
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: Text('Order ${item.name}',
//             style: const TextStyle(color: Colors.white)),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
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
//               const SizedBox(height: 16),
//               Text(
//                 item.name,
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 item.description,
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'R${item.price.toStringAsFixed(2)}',
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                       color: Colors.orange,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               const SizedBox(height: 24),
//               Card(
//                 color: Colors.orange.withOpacity(0.1),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       const Text(
//                         'Quantity',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             icon:
//                                 const Icon(Icons.remove, color: Colors.orange),
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
//                                 style: const TextStyle(fontSize: 20)),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.add, color: Colors.orange),
//                             onPressed: () => setState(() => _quantity++),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _notesController,
//                 decoration: const InputDecoration(
//                   labelText: 'Special Instructions',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     final user = FirebaseAuth.instance.currentUser;
//                     if (user == null) throw Exception('User not signed in.');

//                     final order = Order(
//                       id: '',
//                       userId: user.uid,
//                       userName: user.email ?? '',
//                       items: [
//                         OrderItem(
//                           id: item.id,
//                           name: item.name,
//                           quantity: _quantity,
//                           imageUrl: item.imageUrl,
//                         ),
//                       ],
//                       total: item.price * _quantity,
//                       status: 'pending',
//                       timestamp: DateTime.now(),
//                       notes: _notesController.text,
//                     );

//                     await appState.placeOrder(order);

//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text('Order placed successfully!')),
//                     );
//                     Navigator.pop(context);
//                   } catch (e) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Failed to place order: $e')),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   child: Text('PLACE ORDER'),
//                 ),
//               ),
//               // const SizedBox(height: 16),
//               // ElevatedButton(
//               //   onPressed: () {
//               //     appState.addToCart(item, _quantity);
//               //     ScaffoldMessenger.of(context).showSnackBar(
//               //       const SnackBar(content: Text('Added to cart')),
//               //     );
//               //     Navigator.pop(context);
//               //   },
//               //   style: ElevatedButton.styleFrom(
//               //     backgroundColor: Colors.green,
//               //     foregroundColor: Colors.white,
//               //     shape: RoundedRectangleBorder(
//               //         borderRadius: BorderRadius.circular(8)),
//               //   ),
//               //   child: const Padding(
//               //     padding: EdgeInsets.symmetric(vertical: 16),
//               //     child: Text('ADD TO CART'),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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

  Future<void> _selectPaymentMethod(
      BuildContext context, MenuItem item, AppState appState) async {
    String? selectedPaymentMethod = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Payment Method'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'Cash'),
              child: const Text('Cash'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'Card'),
              child: const Text('Card'),
            ),
          ],
        );
      },
    );

    if (selectedPaymentMethod != null) {
      await _placeOrder(item, appState, selectedPaymentMethod);
    }
  }

  Future<void> _placeOrder(
      MenuItem item, AppState appState, String paymentMethod) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not signed in.');

      final order = Order(
        id: '',
        userId: user.uid,
        userName: user.email ?? '',
        items: [
          OrderItem(
            id: item.id,
            name: item.name,
            quantity: _quantity,
            imageUrl: item.imageUrl,
          ),
        ],
        total: item.price * _quantity,
        status: 'pending',
        timestamp: DateTime.now(),
        notes: _notesController.text,
        paymentMethod: paymentMethod,
      );

      await appState.placeOrder(order);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as MenuItem;
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Order ${item.name}',
            style: const TextStyle(color: Colors.white)),
      ),
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
                'R${item.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              Card(
                color: Colors.orange.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
                            icon:
                                const Icon(Icons.remove, color: Colors.orange),
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
                            icon: const Icon(Icons.add, color: Colors.orange),
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
                onPressed: () => _selectPaymentMethod(context, item, appState),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('PROCEED TO PAYMENT'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
