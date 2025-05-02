import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class OrderScreen extends StatefulWidget {
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
    final MenuItem item = ModalRoute.of(context)!.settings.arguments as MenuItem;
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Order ${item.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(item.name, style: Theme.of(context).textTheme.titleLarge),
              Text(item.description),
              SizedBox(height: 20),
              Text('\$${item.price.toStringAsFixed(2)}', 
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() => _quantity--);
                      }
                    },
                  ),
                  Text('$_quantity', style: TextStyle(fontSize: 20)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => setState(() => _quantity++),
                  ),
                ],
              ),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'Special Instructions'),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final order = Order(
                      id: '',
                      userId: 'user1', // Replace with actual user ID
                      userName: 'Current User', // Replace with actual user name
                      items: [
                        OrderItem(
                          id: item.id,
                          name: item.name,
                          quantity: _quantity,
                        )
                      ],
                      total: item.price * _quantity,
                      status: 'pending',
                      timestamp: DateTime.now(),
                      notes: _notesController.text,
                    );

                    await appState.placeOrder(order);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Order placed successfully!')),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to place order: $e')),
                    );
                  }
                },
                child: Text('Place Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}