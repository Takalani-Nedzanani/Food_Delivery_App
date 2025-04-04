import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/providers/cart_provider.dart';
import 'package:food_delivery_app/widgets/app_button.dart';
import 'package:food_delivery_app/utils/styles.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/screens/cart/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartProvider.cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty',
                      style: Styles.headlineText2,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.cartItems[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(item.food.imageUrl),
                          ),
                          title: Text(item.food.name),
                          subtitle: Text(
                            '\$${item.food.price.toStringAsFixed(2)} x ${item.quantity}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (item.quantity > 1) {
                                    cartProvider.updateQuantity(
                                      item.food.id,
                                      item.quantity - 1,
                                    );
                                  } else {
                                    cartProvider.removeFromCart(item.food.id);
                                  }
                                },
                              ),
                              Text(item.quantity.toString()),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  cartProvider.updateQuantity(
                                    item.food.id,
                                    item.quantity + 1,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (cartProvider.cartItems.isNotEmpty)
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildSummaryRow('Subtotal', '\$${cartProvider.subtotal.toStringAsFixed(2)}'),
                    _buildSummaryRow('Delivery Fee', '\$${cartProvider.deliveryFee.toStringAsFixed(2)}'),
                    const Divider(),
                    _buildSummaryRow(
                      'Total',
                      '\$${cartProvider.total.toStringAsFixed(2)}',
                      isBold: true,
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      text: 'Proceed to Checkout',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckoutScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
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
}