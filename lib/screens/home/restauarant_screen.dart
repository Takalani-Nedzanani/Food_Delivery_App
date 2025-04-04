import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/providers/restaurant_provider.dart';
import 'package:food_delivery_app/widgets/food_card.dart';
import 'package:food_delivery_app/utils/styles.dart';
import 'package:food_delivery_app/screens/home/food_details_screen.dart';

class RestaurantScreen extends StatefulWidget {
  final String restaurantId;

  const RestaurantScreen({super.key, required this.restaurantId});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);

    return FutureBuilder<Restaurant>(
      future: restaurantProvider.getRestaurantById(widget.restaurantId),
      builder: (context, restaurantSnapshot) {
        if (restaurantSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (restaurantSnapshot.hasError || !restaurantSnapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Restaurant not found')),
          );
        }

        final restaurant = restaurantSnapshot.data!;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(restaurant.name),
                  background: Image.network(
                    restaurant.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.description,
                        style: Styles.bodyText1,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.delivery_dining),
                          const SizedBox(width: 8),
                          Text(
                            '${restaurant.deliveryTime} min • \$${restaurant.deliveryFee.toStringAsFixed(2)} delivery fee',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.attach_money),
                          const SizedBox(width: 8),
                          Text(
                            'Min. order: \$${restaurant.minOrder.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Menu',
                        style: Styles.headlineText2,
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<Food>>(
                future: restaurantProvider.getFoodsByRestaurant(widget.restaurantId),
                builder: (context, foodSnapshot) {
                  if (foodSnapshot.connectionState == ConnectionState.waiting) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (foodSnapshot.hasError || !foodSnapshot.hasData || foodSnapshot.data!.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(child: Text('No food items found')),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final food = foodSnapshot.data![index];
                        return FoodCard(
                          food: food,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoodDetailsScreen(
                                  foodId: food.id,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      childCount: foodSnapshot.data!.length,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}