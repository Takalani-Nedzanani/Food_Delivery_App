import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_delivery_app/widgets/food_card.dart';
import 'package:food_delivery_app/widgets/restaurant_card.dart';
import 'package:food_delivery_app/providers/restaurant_provider.dart';
import 'package:food_delivery_app/screens/home/restaurant_screen.dart';
import 'package:food_delivery_app/screens/home/food_details_screen.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/styles.dart';

import '../../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Provider.of<RestaurantProvider>(context, listen: false).fetchRestaurants();
    await Provider.of<RestaurantProvider>(context, listen: false).fetchPopularFoods();
    await Provider.of<RestaurantProvider>(context, listen: false).fetchRecommendedFoods();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        BottomNavBar();
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            title: Text(
              'Food Delivery',
              style: Styles.headlineText1,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Popular Restaurants',
                    style: Styles.headlineText2,
                  ),
                  const SizedBox(height: 16),
                  restaurantProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurantProvider.restaurants.length,
                            itemBuilder: (context, index) {
                              final restaurant =
                                  restaurantProvider.restaurants[index];
                              return RestaurantCard(
                                restaurant: restaurant,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RestaurantScreen(
                                        restaurantId: restaurant.id,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 24),
                  Text(
                    'Popular Foods',
                    style: Styles.headlineText2,
                  ),
                  const SizedBox(height: 16),
                  restaurantProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CarouselSlider.builder(
                          itemCount: restaurantProvider.popularFoods.length,
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                          ),
                          itemBuilder: (context, index, realIdx) {
                            final food = restaurantProvider.popularFoods[index];
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
                        ),
                  const SizedBox(height: 24),
                  Text(
                    'Recommended Foods',
                    style: Styles.headlineText2,
                  ),
                  const SizedBox(height: 16),
                  restaurantProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: restaurantProvider.recommendedFoods.length,
                          itemBuilder: (context, index) {
                            final food =
                                restaurantProvider.recommendedFoods[index];
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
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}