import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class OrderStatusScreen extends StatefulWidget {
  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final userId = 'user1'; // Replace with actual user ID

    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: StreamBuilder<List<Order>>(
        stream: appState.getUserOrders(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found'));
          }
          
          final orders = snapshot.data!;
          
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order #${order.id.substring(0, 8)}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Status: ${order.status.toUpperCase()}'),
                      SizedBox(height: 8),
                      Text('Total: \$${order.total.toStringAsFixed(2)}'),
                      SizedBox(height: 8),
                      Text('Items:'),
                      ...order.items.map((item) => 
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('${item.quantity}x ${item.name}'),
                        ),
                      ),
                      if (order.notes?.isNotEmpty ?? false)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text('Notes: ${order.notes}'),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}