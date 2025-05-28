
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/app_state.dart';
import 'package:food_delivery_app/models/menu_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _isLoading = true;
  String? _errorMessage;

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

      // Set current user ID from Firebase Auth
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        appState.setUserId(user.uid);
      } else {
        // Handle unauthenticated users (optional)
        throw Exception("User not logged in");
      }

      // Load liked items and menu
      // await appState.loadLikedItems();
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
      debugPrint('❌ Image fetch error for $cleanedPath: $e');
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

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Menu', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _initializeScreen,
          ),
        ],
      ),
      body: _isLoading
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
              : appState.menuItems.isEmpty
                  ? const Center(child: Text('No menu items available'))
                  : GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: appState.menuItems.length,
                      itemBuilder: (context, index) {
                        final item = appState.menuItems[index];
                        final isLiked = appState.isLiked(item.id);

                        return FutureBuilder<String>(
                          future: _getImageUrl(item.imageUrl),
                          builder: (context, snapshot) {
                            final imageUrl = snapshot.data ?? '';
                            return _buildMenuItemCard(
                                appState, item, imageUrl, isLiked);
                          },
                        );
                      },
                    ),
    );
  }

  Widget _buildMenuItemCard(
      AppState appState, MenuItem item, String imageUrl, bool isLiked) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.orange.shade200, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/order', arguments: item),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: _buildImageWidget(imageUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
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
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.likes} likes',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
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
      ),
    );
  }

  Widget _buildImageWidget(String imageUrl) {
    if (imageUrl.isEmpty) {
      return Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.fastfood, size: 50, color: Colors.orange),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.fastfood, size: 50, color: Colors.orange),
        ),
      ),
      errorWidget: (context, url, error) {
        return Container(
          color: Colors.grey[200],
          child: const Center(
            child: Icon(Icons.broken_image, size: 50, color: Colors.orange),
          ),
        );
      },
    );
  }
}
