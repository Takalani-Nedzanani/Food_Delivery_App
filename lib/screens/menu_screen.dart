import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/app_state.dart';
import 'package:food_delivery_app/models/menu_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final Set<String> _likedItemIds = {};
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  Future<void> _loadMenuItems() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      await Provider.of<AppState>(context, listen: false).loadMenuItems();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load menu items: ${e.toString()}';
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

    // Remove any leading slashes
    final cleanedPath =
        imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;

    // Case 1: Already a full URL
    if (cleanedPath.startsWith('http')) {
      return cleanedPath;
    }

    try {
      final ref = FirebaseStorage.instance.ref().child(cleanedPath);
      final url = await ref.getDownloadURL();
      debugPrint('✅ Fetched image URL: $url');
      return url;
    } catch (e) {
      debugPrint('❌ Failed to get download URL for $cleanedPath: $e');
      return '';
    }
  }

  void _toggleLike(MenuItem item) {
    final appState = Provider.of<AppState>(context, listen: false);
    final isLiked = _likedItemIds.contains(item.id);

    setState(() {
      if (isLiked) {
        _likedItemIds.remove(item.id);
        appState.unlikeItem(item);
      } else {
        _likedItemIds.add(item.id);
        appState.likeItem(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Menu', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMenuItems,
          ),
        ],
      ),
      body: _buildBodyContent(),
    );
  }

  Widget _buildBodyContent() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadMenuItems,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Consumer<AppState>(
      builder: (context, appState, child) {
        if (appState.menuItems.isEmpty) {
          return const Center(child: Text('No menu items available'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: appState.menuItems.length,
          itemBuilder: (context, index) {
            final item = appState.menuItems[index];
            return FutureBuilder<String>(
              future: _getImageUrl(item.imageUrl),
              builder: (context, snapshot) {
                final imageUrl = snapshot.data ?? '';
                return _buildMenuItemCard(item, imageUrl);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildMenuItemCard(MenuItem item, String imageUrl) {
    final isLiked = _likedItemIds.contains(item.id);

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
                        onPressed: () => _toggleLike(item),
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
        debugPrint('Image load error: $error');
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
