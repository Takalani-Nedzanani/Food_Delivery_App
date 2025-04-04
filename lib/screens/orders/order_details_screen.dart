import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/providers/order_provider.dart';
import 'package:food_delivery_app/models/order_model.dart';
import 'package:food_delivery_app/utils/styles.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final bool isAdmin;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Order>(
      future: Provider.of<OrderProvider>(context, listen: false).getOrderById(orderId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData) {
          return const Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('Order not found')),
          );
        }

        final order = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text('Order #${order.id.substring(0, 8)}'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status: ${order.status[0].toUpperCase()}${order.status.substring(1)}',
                          style: TextStyle(
                            color: _getStatusColor(order.status),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Order Date: ${DateFormat('MMM d, y - h:mm a').format(order.createdAt)}',
                        ),
                        const SizedBox(height: 8),
                        Text('Payment Method: ${order.paymentMethod}'),
                        const SizedBox(height: 8),
                        if (order.note.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Note:'),
                              Text(order.note),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Order Items',
                  style: Styles.headlineText2,
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: order.items.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = order.items[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text((index + 1).toString()),
                        ),
                        title: Text(item.name),
                        subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                        trailing: Text('x${item.quantity}'),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildSummaryRow('Subtotal', '\$${order.subtotal.toStringAsFixed(2)}'),
                        _buildSummaryRow('Delivery Fee', '\$${order.deliveryFee.toStringAsFixed(2)}'),
                        const Divider(),
                        _buildSummaryRow(
                          'Total',
                          '\$${order.total.toStringAsFixed(2)}',
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Delivery Information',
                  style: Styles.headlineText2,
                ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address: ${order.deliveryAddress}'),
                        const SizedBox(height: 8),
                        Text('Phone: ${order.phone}'),
                      ],
                    ),
                  ),
                ),
                if (isAdmin) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Admin Actions',
                    style: Styles.headlineText2,
                  ),
                  const SizedBox(height: 8),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 3,
                    children: [
                      if (order.status != 'preparing')
                        ElevatedButton(
                          onPressed: () => _updateOrderStatus(context, order.id, 'preparing'),
                          child: const Text('Mark as Preparing'),
                        ),
                      if (order.status != 'onTheWay')
                        ElevatedButton(
                          onPressed: () => _updateOrderStatus(context, order.id, 'onTheWay'),
                          child: const Text('Mark as On The Way'),
                        ),
                      if (order.status != 'delivered')
                        ElevatedButton(
                          onPressed: () => _updateOrderStatus(context, order.id, 'delivered'),
                          child: const Text('Mark as Delivered'),
                        ),
                      if (order.status != 'cancelled')
                        ElevatedButton(
                          onPressed: () => _updateOrderStatus(context, order.id, 'cancelled'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Cancel Order'),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isBold
                ? Styles.subtitleText1?.copyWith(fontWeight: FontWeight.bold)
                : Styles.subtitleText1,
          ),
          Text(
            value,
            style: isBold
                ? Styles.subtitleText1?.copyWith(fontWeight: FontWeight.bold)
                : Styles.subtitleText1,
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'preparing':
        return Colors.blue;
      case 'onTheWay':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  Future<void> _updateOrderStatus(BuildContext context, String orderId, String status) async {
    try {
      await Provider.of<OrderProvider>(context, listen: false)
          .updateOrderStatus(orderId, status);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order status updated to $status')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}