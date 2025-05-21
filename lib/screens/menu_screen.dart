import 'package:flutter/material.dart';
import 'package:food_delivery_app/app_state.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/models/menu_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final Set<String> likedItemIds = {}; // Track liked items locally

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<AppState>(context, listen: false).loadMenuItems();
      }
    });
  }

  void toggleLike(MenuItem item, AppState appState) {
    final isLiked = likedItemIds.contains(item.id);

    if (!isLiked) {
      // Like the item
      appState.likeItem(item);
      setState(() {
        likedItemIds.add(item.id);
      });
    } else {
      // Optionally handle unliking, but not supported in backend
      setState(() {
        likedItemIds.remove(item.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _MenuContent(
      likedItemIds: likedItemIds,
      onLikePressed: (item) => toggleLike(item, context.read<AppState>()),
    );
  }
}

class _MenuContent extends StatelessWidget {
  final Set<String> likedItemIds;
  final Function(MenuItem) onLikePressed;

  const _MenuContent({
    required this.likedItemIds,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Menu',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<AppState>().loadMenuItems(),
          ),
        ],
      ),
      body: appState.menuItems.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
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
                final isLiked = likedItemIds.contains(item.id);

                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange.shade200, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/order',
                        arguments: item,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: item.imageUrl.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    item.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        const Center(
                                            child:
                                                Icon(Icons.fastfood, size: 50)),
                                  ),
                                )
                              : const Center(
                                  child: Icon(Icons.fastfood,
                                      size: 50, color: Colors.orange)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${item.likes} likes',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => onLikePressed(item),
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
              },
            ),
    );
  }
}
