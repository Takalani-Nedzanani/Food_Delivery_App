// // // import 'package:flutter/material.dart';
// // // import 'package:food_delivery_app/screens/auth/login_screen.dart';
// // // import 'package:food_delivery_app/services/auth_services.dart';
// // // import 'package:provider/provider.dart';

// // // import 'menu_screen.dart';
// // // import 'order_status_screen.dart';

// // // class MainScreen extends StatefulWidget {
// // //   const MainScreen({super.key});

// // //   @override
// // //   State<MainScreen> createState() => _MainScreenState();
// // // }

// // // class _MainScreenState extends State<MainScreen> {
// // //   int _selectedIndex = 0;

// // //   final List<Widget> _screens = [
// // //     const HomeContent(),
// // //     MenuScreen(),
// // //     OrderStatusScreen(),
// // //   ];

// // //   void _onItemTapped(int index) {
// // //     setState(() {
// // //       _selectedIndex = index;
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: _screens[_selectedIndex],
// // //       bottomNavigationBar: BottomNavigationBar(
// // //         currentIndex: _selectedIndex,
// // //         onTap: _onItemTapped,
// // //         type: BottomNavigationBarType.fixed,
// // //         backgroundColor: Colors.orange,
// // //         selectedItemColor: Colors.white, // Selected icon & label color
// // //         unselectedItemColor: Colors.black, // Unselected icon & label color
// // //         selectedLabelStyle: const TextStyle(color: Colors.white),
// // //         unselectedLabelStyle: const TextStyle(color: Colors.black),
// // //         items: [
// // //           const BottomNavigationBarItem(
// // //             icon: Icon(Icons.home),
// // //             label: 'Home',
// // //           ),
// // //           const BottomNavigationBarItem(
// // //             icon: Icon(Icons.restaurant_menu),
// // //             label: 'Menu',
// // //           ),
// // //           const BottomNavigationBarItem(
// // //             icon: Icon(Icons.receipt_long),
// // //             label: 'My Orders',
// // //           ),
// // //           // BottomNavigationBarItem(
// // //           //   icon: GestureDetector(
// // //           //     onTap: () async {
// // //           //       Navigator.pushReplacement(
// // //           //         context,
// // //           //         MaterialPageRoute(builder: (context) => const CartScreen()),
// // //           //       );
// // //           //     },
// // //           //     child: const Icon(Icons.shopping_cart),
// // //           //   ),
// // //           //   label: 'Cart',
// // //           // ),
// // //           BottomNavigationBarItem(
// // //             icon: GestureDetector(
// // //               onTap: () async {
// // //                 final auth = Provider.of<AuthService>(context, listen: false);
// // //                 await auth.signOut();
// // //                 Navigator.pushReplacement(
// // //                   context,
// // //                   MaterialPageRoute(builder: (context) => const LoginScreen()),
// // //                 );
// // //               },
// // //               child: const Icon(Icons.logout),
// // //             ),
// // //             label: 'Logout',
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class HomeContent extends StatelessWidget {
// // //   const HomeContent({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.orange,
// // //         title: const Text(
// // //           'James’ Foodbar',
// // //           style: TextStyle(color: Colors.white),
// // //         ),
// // //         iconTheme: const IconThemeData(color: Colors.white),
// // //       ),
// // //       body: Container(
// // //         color: Colors.orange.shade50,
// // //         padding: const EdgeInsets.all(24),
// // //         child: Center(
// // //           child: Column(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: [
// // //               const Icon(Icons.fastfood, size: 80, color: Colors.orange),
// // //               const SizedBox(height: 20),
// // //               const Text(
// // //                 'Welcome to James’ Foodbar!',
// // //                 textAlign: TextAlign.center,
// // //                 style: TextStyle(
// // //                   fontSize: 24,
// // //                   fontWeight: FontWeight.bold,
// // //                   color: Colors.orange,
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 16),
// // //               const Text(
// // //                 'Order your favorite meals from local restaurants and get them delivered fast to your doorstep. Browse our menu and check your order status anytime!',
// // //                 textAlign: TextAlign.center,
// // //                 style: TextStyle(fontSize: 16, color: Colors.black87),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:food_delivery_app/screens/auth/login_screen.dart';
// // import 'package:food_delivery_app/services/auth_services.dart';
// // import 'package:provider/provider.dart';
// // import 'package:food_delivery_app/app_state.dart';
// // import 'package:food_delivery_app/models/menu_item.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';

// // import 'menu_screen.dart';
// // import 'order_status_screen.dart';

// // class MainScreen extends StatefulWidget {
// //   const MainScreen({super.key});

// //   @override
// //   State<MainScreen> createState() => _MainScreenState();
// // }

// // class _MainScreenState extends State<MainScreen> {
// //   int _selectedIndex = 0;

// //   final List<Widget> _screens = [
// //     const HomeContent(),
// //     const MenuScreen(),
// //     const OrderStatusScreen(),
// //   ];

// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: _screens[_selectedIndex],
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _selectedIndex,
// //         onTap: _onItemTapped,
// //         type: BottomNavigationBarType.fixed,
// //         backgroundColor: Colors.orange,
// //         selectedItemColor: Colors.white,
// //         unselectedItemColor: Colors.black,
// //         selectedLabelStyle: const TextStyle(color: Colors.white),
// //         unselectedLabelStyle: const TextStyle(color: Colors.black),
// //         items: [
// //           const BottomNavigationBarItem(
// //             icon: Icon(Icons.home),
// //             label: 'Home',
// //           ),
// //           const BottomNavigationBarItem(
// //             icon: Icon(Icons.restaurant_menu),
// //             label: 'Menu',
// //           ),
// //           const BottomNavigationBarItem(
// //             icon: Icon(Icons.receipt_long),
// //             label: 'My Orders',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: GestureDetector(
// //               onTap: () async {
// //                 final auth = Provider.of<AuthService>(context, listen: false);
// //                 await auth.signOut();
// //                 Navigator.pushReplacement(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => const LoginScreen()),
// //                 );
// //               },
// //               child: const Icon(Icons.logout),
// //             ),
// //             label: 'Logout',
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class HomeContent extends StatefulWidget {
// //   const HomeContent({super.key});

// //   @override
// //   State<HomeContent> createState() => _HomeContentState();
// // }

// // class _HomeContentState extends State<HomeContent> {
// //   bool _isLoading = true;
// //   String? _errorMessage;
// //   String _searchQuery = '';
// //   String _selectedCategory = 'All';
// //   final List<String> _categories = [
// //     'All',
// //     'Appetizers',
// //     'Main Courses',
// //     'Desserts',
// //     'Drinks',
// //     'Specials'
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeScreen();
// //   }

// //   Future<void> _initializeScreen() async {
// //     try {
// //       setState(() {
// //         _isLoading = true;
// //         _errorMessage = null;
// //       });

// //       final appState = Provider.of<AppState>(context, listen: false);
// //       final user = FirebaseAuth.instance.currentUser;
// //       if (user != null) {
// //         appState.setUserId(user.uid);
// //       }
// //       await appState.loadMenuItems();
// //     } catch (e) {
// //       setState(() {
// //         _errorMessage = 'Error loading menu: ${e.toString()}';
// //       });
// //     } finally {
// //       if (mounted) {
// //         setState(() {
// //           _isLoading = false;
// //         });
// //       }
// //     }
// //   }

// //   Future<String> _getImageUrl(String imagePath) async {
// //     if (imagePath.isEmpty) return '';
// //     final cleanedPath =
// //         imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
// //     if (cleanedPath.startsWith('http')) return cleanedPath;

// //     try {
// //       final ref = FirebaseStorage.instance.ref().child(cleanedPath);
// //       final url = await ref.getDownloadURL();
// //       return url;
// //     } catch (e) {
// //       debugPrint('❌ Image fetch error for $cleanedPath: $e');
// //       return '';
// //     }
// //   }

// //   void _toggleLike(AppState appState, MenuItem item) async {
// //     final isLiked = appState.isLiked(item.id);
// //     if (isLiked) {
// //       await appState.unlikeItem(item);
// //     } else {
// //       await appState.likeItem(item);
// //     }
// //   }

// //   List<MenuItem> _filterMenuItems(List<MenuItem> items) {
// //     List<MenuItem> filtered = items;

// //     // Filter by category
// //     if (_selectedCategory != 'All') {
// //       filtered =
// //           filtered.where((item) => item.category == _selectedCategory).toList();
// //     }

// //     // Filter by search query
// //     if (_searchQuery.isNotEmpty) {
// //       filtered = filtered
// //           .where((item) =>
// //               item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
// //               item.description
// //                   .toLowerCase()
// //                   .contains(_searchQuery.toLowerCase()))
// //           .toList();
// //     }

// //     return filtered;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final appState = Provider.of<AppState>(context);
// //     final filteredItems = _filterMenuItems(appState.menuItems);

// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.orange,
// //         title: const Text(
// //           'James\' Foodbar',
// //           style: TextStyle(color: Colors.white),
// //         ),
// //         iconTheme: const IconThemeData(color: Colors.white),
// //       ),
// //       body: Container(
// //         color: Colors.orange.shade50,
// //         child: Column(
// //           children: [
// //             Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Column(
// //                 children: [
// //                   // Welcome message
// //                   const Column(
// //                     children: [
// //                       Icon(Icons.fastfood, size: 80, color: Colors.orange),
// //                       SizedBox(height: 10),
// //                       Text(
// //                         'Welcome to James\' Foodbar!',
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(
// //                           fontSize: 24,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.orange,
// //                         ),
// //                       ),
// //                       SizedBox(height: 8),
// //                       Text(
// //                         'Order your favorite meals from local restaurants and get them delivered fast to your doorstep.',
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(fontSize: 16, color: Colors.black87),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 16),
// //                   // Search bar
// //                   TextField(
// //                     decoration: InputDecoration(
// //                       hintText: 'Search for food...',
// //                       prefixIcon: const Icon(Icons.search),
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(30),
// //                       ),
// //                       filled: true,
// //                       fillColor: Colors.white,
// //                     ),
// //                     onChanged: (value) {
// //                       setState(() {
// //                         _searchQuery = value;
// //                       });
// //                     },
// //                   ),
// //                   const SizedBox(height: 8),
// //                   // Category filter
// //                   SizedBox(
// //                     height: 50,
// //                     child: ListView.builder(
// //                       scrollDirection: Axis.horizontal,
// //                       itemCount: _categories.length,
// //                       itemBuilder: (context, index) {
// //                         final category = _categories[index];
// //                         return Padding(
// //                           padding: const EdgeInsets.symmetric(horizontal: 4.0),
// //                           child: ChoiceChip(
// //                             label: Text(category),
// //                             selected: _selectedCategory == category,
// //                             selectedColor: Colors.orange,
// //                             onSelected: (selected) {
// //                               setState(() {
// //                                 _selectedCategory = selected ? category : 'All';
// //                               });
// //                             },
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             Expanded(
// //               child: _isLoading
// //                   ? const Center(child: CircularProgressIndicator())
// //                   : _errorMessage != null
// //                       ? Center(
// //                           child: Column(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               Text(_errorMessage!),
// //                               const SizedBox(height: 20),
// //                               ElevatedButton(
// //                                 onPressed: _initializeScreen,
// //                                 child: const Text('Retry'),
// //                               ),
// //                             ],
// //                           ),
// //                         )
// //                       : filteredItems.isEmpty
// //                           ? const Center(child: Text('No menu items found'))
// //                           : GridView.builder(
// //                               padding: const EdgeInsets.all(8),
// //                               gridDelegate:
// //                                   const SliverGridDelegateWithFixedCrossAxisCount(
// //                                 crossAxisCount: 2,
// //                                 childAspectRatio: 0.8,
// //                                 crossAxisSpacing: 8,
// //                                 mainAxisSpacing: 8,
// //                               ),
// //                               itemCount: filteredItems.length,
// //                               itemBuilder: (context, index) {
// //                                 final item = filteredItems[index];
// //                                 final isLiked = appState.isLiked(item.id);

// //                                 return FutureBuilder<String>(
// //                                   future: _getImageUrl(item.imageUrl),
// //                                   builder: (context, snapshot) {
// //                                     final imageUrl = snapshot.data ?? '';
// //                                     return _buildMenuItemCard(
// //                                         appState, item, imageUrl, isLiked);
// //                                   },
// //                                 );
// //                               },
// //                             ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildMenuItemCard(
// //       AppState appState, MenuItem item, String imageUrl, bool isLiked) {
// //     return Card(
// //       shape: RoundedRectangleBorder(
// //         side: BorderSide(color: Colors.orange.shade200, width: 2),
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       elevation: 4,
// //       child: InkWell(
// //         onTap: () => Navigator.pushNamed(context, '/order', arguments: item),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             Expanded(
// //               child: ClipRRect(
// //                 borderRadius:
// //                     const BorderRadius.vertical(top: Radius.circular(12)),
// //                 child: _buildImageWidget(imageUrl),
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(8),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     item.name,
// //                     style: const TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 16,
// //                       color: Colors.black,
// //                     ),
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     'R${item.price.toStringAsFixed(2)}',
// //                     style: const TextStyle(
// //                       color: Colors.orange,
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 14,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         '${item.likes} likes',
// //                         style:
// //                             const TextStyle(fontSize: 12, color: Colors.grey),
// //                       ),
// //                       IconButton(
// //                         icon: Icon(
// //                           isLiked ? Icons.favorite : Icons.favorite_border,
// //                           color: Colors.red,
// //                         ),
// //                         onPressed: () => _toggleLike(appState, item),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildImageWidget(String imageUrl) {
// //     if (imageUrl.isEmpty) {
// //       return Container(
// //         color: Colors.grey[200],
// //         child: const Center(
// //           child: Icon(Icons.fastfood, size: 50, color: Colors.orange),
// //         ),
// //       );
// //     }

// //     return CachedNetworkImage(
// //       imageUrl: imageUrl,
// //       fit: BoxFit.cover,
// //       placeholder: (context, url) => Container(
// //         color: Colors.grey[200],
// //         child: const Center(
// //           child: Icon(Icons.fastfood, size: 50, color: Colors.orange),
// //         ),
// //       ),
// //       errorWidget: (context, url, error) {
// //         return Container(
// //           color: Colors.grey[200],
// //           child: const Center(
// //             child: Icon(Icons.broken_image, size: 50, color: Colors.orange),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/screens/auth/login_screen.dart';
// import 'package:food_delivery_app/services/auth_services.dart';
// import 'package:provider/provider.dart';
// import 'package:food_delivery_app/app_state.dart';
// import 'package:food_delivery_app/models/menu_item.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// import 'menu_screen.dart';
// import 'order_status_screen.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _screens = [
//     const HomeContent(),
//     const MenuScreen(),
//     const OrderStatusScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.orange,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.black,
//         selectedLabelStyle: const TextStyle(color: Colors.white),
//         unselectedLabelStyle: const TextStyle(color: Colors.black),
//         items: [
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.restaurant_menu),
//             label: 'Menu',
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.receipt_long),
//             label: 'My Orders',
//           ),
//           BottomNavigationBarItem(
//             icon: GestureDetector(
//               onTap: () async {
//                 final auth = Provider.of<AuthService>(context, listen: false);
//                 await auth.signOut();
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginScreen()),
//                 );
//               },
//               child: const Icon(Icons.logout),
//             ),
//             label: 'Logout',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HomeContent extends StatefulWidget {
//   const HomeContent({super.key});

//   @override
//   State<HomeContent> createState() => _HomeContentState();
// }

// class _HomeContentState extends State<HomeContent> {
//   bool _isLoading = true;
//   String? _errorMessage;
//   String _searchQuery = '';
//   String _selectedCategory = 'All';
//   final List<String> _categories = [
//     'All',
//     'Appetizers',
//     'Main Courses',
//     'Desserts',
//     'Drinks',
//     'Specials'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _initializeScreen();
//   }

//   Future<void> _initializeScreen() async {
//     try {
//       setState(() {
//         _isLoading = true;
//         _errorMessage = null;
//       });

//       final appState = Provider.of<AppState>(context, listen: false);
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         appState.setUserId(user.uid);
//       }
//       await appState.loadMenuItems();
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error loading menu: ${e.toString()}';
//       });
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   Future<String> _getImageUrl(String imagePath) async {
//     if (imagePath.isEmpty) return '';
//     final cleanedPath =
//         imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
//     if (cleanedPath.startsWith('http')) return cleanedPath;

//     try {
//       final ref = FirebaseStorage.instance.ref().child(cleanedPath);
//       final url = await ref.getDownloadURL();
//       return url;
//     } catch (e) {
//       debugPrint('Image fetch error for $cleanedPath: $e');
//       return '';
//     }
//   }

//   void _toggleLike(AppState appState, MenuItem item) async {
//     final isLiked = appState.isLiked(item.id);
//     if (isLiked) {
//       await appState.unlikeItem(item);
//     } else {
//       await appState.likeItem(item);
//     }
//   }

//   List<MenuItem> _filterMenuItems(List<MenuItem> items) {
//     List<MenuItem> filtered = items;

//     // Filter by category first (exact match)
//     if (_selectedCategory != 'All') {
//       filtered =
//           filtered.where((item) => item.category == _selectedCategory).toList();
//     }

//     // Then filter by search query (name or description)
//     if (_searchQuery.isNotEmpty) {
//       filtered = filtered.where((item) {
//         final nameMatch =
//             item.name.toLowerCase().contains(_searchQuery.toLowerCase());
//         final descMatch =
//             item.description.toLowerCase().contains(_searchQuery.toLowerCase());
//         return nameMatch || descMatch;
//       }).toList();
//     }

//     return filtered;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<AppState>(context);
//     final filteredItems = _filterMenuItems(appState.menuItems);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: const Text(
//           'James\' Foodbar',
//           style: TextStyle(color: Colors.white),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Container(
//         color: Colors.orange.shade50,
//         child: Column(
//           children: [
//             // Welcome and search section
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     blurRadius: 5,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//                 image: DecorationImage(
//                   image: const AssetImage(
//                       'assets/images/background2.jpg'), // Add your image to assets
//                   fit: BoxFit.cover,
//                   colorFilter: ColorFilter.mode(
//                     const Color.fromARGB(255, 255, 255, 255).withOpacity(
//                         0.99), // Adjust opacity to make text readable
//                     BlendMode.dstATop,
//                   ),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   const Column(
//                     children: [
//                       Icon(Icons.fastfood,
//                           size: 60, color: Color.fromARGB(255, 255, 255, 255)),
//                       SizedBox(height: 8),
//                       Text(
//                         'Welcome to James\' Foodbar!',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w900,
//                           color: Color.fromARGB(255, 255, 255, 255),
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Order delicious meals and collect!',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w900,
//                           color: Color.fromARGB(221, 255, 255, 255),
//                           shadows: [
//                             Shadow(
//                               blurRadius: 10,
//                               color: Colors.white,
//                               offset: Offset(0, 0),
//                             )
//                           ],
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // Search bar
//                   TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search for food...',
//                       prefixIcon:
//                           const Icon(Icons.search, color: Colors.orange),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white
//                           .withOpacity(0.8), // Semi-transparent white
//                       contentPadding: const EdgeInsets.symmetric(vertical: 8),
//                     ),
//                     onChanged: (value) => setState(() => _searchQuery = value),
//                   ),
//                 ],
//               ),
//             ),
//             // Category filter chips
//             Container(
//               height: 60,
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _categories.length,
//                 itemBuilder: (context, index) {
//                   final category = _categories[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4),
//                     child: FilterChip(
//                       label: Text(category),
//                       selected: _selectedCategory == category,
//                       selectedColor: Colors.orange,
//                       checkmarkColor: Colors.white,
//                       labelStyle: TextStyle(
//                         color: _selectedCategory == category
//                             ? Colors.white
//                             : Colors.black,
//                       ),
//                       onSelected: (selected) => setState(() {
//                         _selectedCategory = selected ? category : 'All';
//                       }),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             // Menu items grid
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : _errorMessage != null
//                       ? Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(_errorMessage!),
//                               const SizedBox(height: 20),
//                               ElevatedButton(
//                                 onPressed: _initializeScreen,
//                                 child: const Text('Retry'),
//                               ),
//                             ],
//                           ),
//                         )
//                       : filteredItems.isEmpty
//                           ? const Center(
//                               child: Text(
//                                 'No items found',
//                                 style:
//                                     TextStyle(fontSize: 16, color: Colors.grey),
//                               ),
//                             )
//                           : GridView.builder(
//                               padding: const EdgeInsets.all(8),
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 childAspectRatio: 0.8,
//                                 crossAxisSpacing: 8,
//                                 mainAxisSpacing: 8,
//                               ),
//                               itemCount: filteredItems.length,
//                               itemBuilder: (context, index) {
//                                 final item = filteredItems[index];
//                                 final isLiked = appState.isLiked(item.id);
//                                 return FutureBuilder<String>(
//                                   future: _getImageUrl(item.imageUrl),
//                                   builder: (context, snapshot) {
//                                     return _buildMenuItemCard(
//                                       appState,
//                                       item,
//                                       snapshot.data ?? '',
//                                       isLiked,
//                                     );
//                                   },
//                                 );
//                               },
//                             ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuItemCard(
//       AppState appState, MenuItem item, String imageUrl, bool isLiked) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(color: Colors.orange.shade200, width: 1),
//       ),
//       elevation: 2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Image
//           Expanded(
//             child: ClipRRect(
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(12)),
//               child: _buildImageWidget(imageUrl),
//             ),
//           ),
//           // Details
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'R${item.price.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     color: Colors.orange,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '${item.likes} likes',
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         isLiked ? Icons.favorite : Icons.favorite_border,
//                         color: Colors.red,
//                         size: 20,
//                       ),
//                       onPressed: () => _toggleLike(appState, item),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImageWidget(String imageUrl) {
//     if (imageUrl.isEmpty) {
//       return Container(
//         color: Colors.grey[200],
//         child: const Center(
//           child: Icon(Icons.fastfood, size: 40, color: Colors.orange),
//         ),
//       );
//     }

// ignore_for_file: deprecated_member_use

//     return CachedNetworkImage(
//       imageUrl: imageUrl,
//       fit: BoxFit.cover,
//       placeholder: (context, url) => Container(
//         color: Colors.grey[200],
//         child: const Center(
//           child: Icon(Icons.fastfood, size: 40, color: Colors.orange),
//         ),
//       ),
//       errorWidget: (context, url, error) => Container(
//         color: Colors.grey[200],
//         child: const Center(
//           child: Icon(Icons.broken_image, size: 40, color: Colors.orange),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/auth/login_screen.dart';
import 'package:food_delivery_app/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/app_state.dart';
import 'package:food_delivery_app/models/menu_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'menu_screen.dart';
import 'order_status_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const MenuScreen(),
    const OrderStatusScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'My Orders',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () async {
                final auth = Provider.of<AuthService>(context, listen: false);
                await auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Icon(Icons.logout),
            ),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool _isLoading = true;
  String? _errorMessage;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'icon': Icons.all_inclusive},
    {'name': 'Appetizers', 'icon': Icons.emoji_food_beverage},
    {'name': 'Main Courses', 'icon': Icons.dinner_dining},
    {'name': 'Desserts', 'icon': Icons.icecream},
    {'name': 'Drinks', 'icon': Icons.local_drink},
    {'name': 'Specials', 'icon': Icons.star},
  ];

  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  Future<void> _initializeScreen() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final appState = Provider.of<AppState>(context, listen: false);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        appState.setUserId(user.uid);
      }
      await appState.loadMenuItems();
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading menu: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<String> _getImageUrl(String imagePath) async {
    if (imagePath.isEmpty) return '';
    final cleanedPath =
        imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
    if (cleanedPath.startsWith('http')) return cleanedPath;

    try {
      final ref = FirebaseStorage.instance.ref().child(cleanedPath);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint('Image fetch error for $cleanedPath: $e');
      return '';
    }
  }

  void _toggleLike(AppState appState, MenuItem item) async {
    final isLiked = appState.isLiked(item.id);
    if (isLiked) {
      await appState.unlikeItem(item);
    } else {
      await appState.likeItem(item);
    }
  }

  List<MenuItem> _filterMenuItems(List<MenuItem> items) {
    List<MenuItem> filtered = items;

    // Filter by category first (exact match)
    if (_selectedCategory != 'All') {
      filtered =
          filtered.where((item) => item.category == _selectedCategory).toList();
    }

    // Then filter by search query (name or description)
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        final nameMatch =
            item.name.toLowerCase().contains(_searchQuery.toLowerCase());
        final descMatch =
            item.description.toLowerCase().contains(_searchQuery.toLowerCase());
        return nameMatch || descMatch;
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final filteredItems = _filterMenuItems(appState.menuItems);
    final popularItems =
        appState.menuItems.where((item) => item.likes > 3).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'James\' Foodbar',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.orange.shade50,
        child: Column(
          children: [
            // Welcome and search section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
                image: DecorationImage(
                  image: const AssetImage(
                      'assets/images/background2.jpg'), // Add your image to assets
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(
                        0.99), // Adjust opacity to make text readable
                    BlendMode.dstATop,
                  ),
                ),
              ),
              child: Column(
                children: [
                  const Column(
                    children: [
                      Icon(Icons.fastfood, size: 60, color: Colors.white),
                      SizedBox(height: 8),
                      Text(
                        'Welcome to James\' Foodbar!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Order delicious meals and collect!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(221, 255, 255, 255),
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.white,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for food...',
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                ],
              ),
            ),

            // Popular Now Section
            if (popularItems.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Popular Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  itemCount: popularItems.length,
                  itemBuilder: (context, index) {
                    final item = popularItems[index];
                    return FutureBuilder<String>(
                      future: _getImageUrl(item.imageUrl),
                      builder: (context, snapshot) {
                        return Container(
                          width: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 252, 250, 250),
                                  width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: snapshot.hasData &&
                                            snapshot.data!.isNotEmpty
                                        ? CachedNetworkImage(
                                            imageUrl: snapshot.data!,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child: Icon(Icons.fastfood,
                                                    size: 40,
                                                    color: Colors.orange),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child: Icon(Icons.broken_image,
                                                    size: 40,
                                                    color: Colors.orange),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            color: Colors.grey[200],
                                            child: const Center(
                                              child: Icon(Icons.fastfood,
                                                  size: 40,
                                                  color: Colors.orange),
                                            ),
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'R${item.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],

            // Category filter chips with icons
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  // const Text(
                  //   'Categories',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black87,
                  //   ),
                  // ),
                  const SizedBox(height: 2),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  category['icon'] as IconData,
                                  color: _selectedCategory == category['name']
                                      ? Colors.orange
                                      : const Color.fromARGB(255, 0, 0, 0),
                                  size: 28,
                                ),
                                onPressed: () => setState(() {
                                  _selectedCategory =
                                      category['name'] as String;
                                }),
                              ),
                              Text(
                                category['name'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _selectedCategory == category['name']
                                      ? Colors.orange
                                      : const Color.fromARGB(255, 7, 7, 7),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Selected Category: $_selectedCategory',
              style: const TextStyle(
                  fontSize: 14, color: Color.fromARGB(137, 0, 0, 0)),
            ),
            // Menu items grid
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_errorMessage!),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _initializeScreen,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        )
                      : filteredItems.isEmpty
                          ? const Center(
                              child: Text(
                                'No items found',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.all(8),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: filteredItems.length,
                              itemBuilder: (context, index) {
                                final item = filteredItems[index];
                                final isLiked = appState.isLiked(item.id);
                                return FutureBuilder<String>(
                                  future: _getImageUrl(item.imageUrl),
                                  builder: (context, snapshot) {
                                    return _buildMenuItemCard(
                                      appState,
                                      item,
                                      snapshot.data ?? '',
                                      isLiked,
                                    );
                                  },
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItemCard(
      AppState appState, MenuItem item, String imageUrl, bool isLiked) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
            color: const Color.fromARGB(255, 246, 168, 52), width: 1),
      ),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: _buildImageWidget(imageUrl),
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'R${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.likes} likes',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: () => _toggleLike(appState, item),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(String imageUrl) {
    if (imageUrl.isEmpty) {
      return Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.fastfood, size: 40, color: Colors.orange),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.fastfood, size: 40, color: Colors.orange),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.broken_image, size: 40, color: Colors.orange),
        ),
      ),
    );
  }
}
