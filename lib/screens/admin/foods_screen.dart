import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/providers/restaurant_provider.dart';
import 'package:food_delivery_app/screens/admin/add_edit_food_screen.dart';
import 'package:food_delivery_app/models/food_model.dart';

class FoodsScreen extends StatefulWidget {
  const FoodsScreen({super.key});

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantProvider>(context, listen: false).fetchRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Food Items'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (restaurantProvider.restaurants.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please add a restaurant first')),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditFoodScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: restaurantProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : restaurantProvider.restaurants.isEmpty
              ? const Center(child: Text('No restaurants found. Add a restaurant first.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: restaurantProvider.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurantProvider.restaurants[index];
                    return ExpansionTile(
                      title: Text(restaurant.name),
                      children: [
                        FutureBuilder<List<Food>>(
                          future: restaurantProvider.getFoodsByRestaurant(restaurant.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('No food items found'),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, foodIndex) {
                                final food = snapshot.data![foodIndex];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(food.imageUrl),
                                  ),
                                  title: Text(food.name),
                                  subtitle: Text('\$${food.price.toStringAsFixed(2)}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddEditFoodScreen(
                                                food: food,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          _showDeleteDialog(context, food.id);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
    );
  }

  void _showDeleteDialog(BuildContext context, String foodId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Food Item'),
        content: const Text('Are you sure you want to delete this food item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await Provider.of<RestaurantProvider>(context, listen: false)
                    .deleteFood(foodId);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}