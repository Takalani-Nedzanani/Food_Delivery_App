import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/providers/auth_provider.dart';
import 'package:food_delivery_app/screens/admin/categories_screen.dart';
import 'package:food_delivery_app/screens/admin/promo_codes_screen.dart';
import 'package:food_delivery_app/screens/admin/restaurants_screen.dart';
import 'package:food_delivery_app/screens/admin/foods_screen.dart';
import 'package:food_delivery_app/screens/admin/orders_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          _buildDashboardItem(
            context,
            icon: Icons.category,
            title: 'Categories',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoriesScreen()),
              );
            },
          ),
          _buildDashboardItem(
            context,
            icon: Icons.local_offer,
            title: 'Promo Codes',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PromoCodesScreen()),
              );
            },
          ),
          _buildDashboardItem(
            context,
            icon: Icons.restaurant,
            title: 'Restaurants',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminRestaurantsScreen()),
              );
            },
          ),
          _buildDashboardItem(
            context,
            icon: Icons.fastfood,
            title: 'Food Items',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FoodsScreen()),
              );
            },
          ),
          _buildDashboardItem(
            context,
            icon: Icons.list_alt,
            title: 'Orders',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminOrdersScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Theme.of(context).primaryColor),
            const SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}