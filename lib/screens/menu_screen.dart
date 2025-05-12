// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/app_state.dart';
// import 'package:provider/provider.dart';

// class MenuScreen extends StatefulWidget {
//   @override
//   _MenuScreenState createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Delay the initialization until after the widget is mounted
//     Future.microtask(() {
//       if (mounted) {
//         Provider.of<AppState>(context, listen: false).loadMenuItems();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Assuming AppState is provided at a higher level (like in main.dart)
//     // We'll just consume it here without creating a new provider

//     return _MenuContent();
//   }
// }

// class _MenuContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // This context now properly has access to AppState
//     final appState = context.watch<AppState>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Menu'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => context.read<AppState>().loadMenuItems(),
//           ),
//         ],
//       ),
//       body: appState.menuItems.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : GridView.builder(
//               padding: const EdgeInsets.all(8),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.8,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//               ),
//               itemCount: appState.menuItems.length,
//               itemBuilder: (context, index) {
//                 final item = appState.menuItems[index];
//                 return Card(
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.pushNamed(
//                         context,
//                         '/order',
//                         arguments: item,
//                       );
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Expanded(
//                           child: item.imageUrl.isNotEmpty
//                               ? Image.network(
//                                   item.imageUrl,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       const Center(
//                                           child:
//                                               Icon(Icons.fastfood, size: 50)),
//                                 )
//                               : const Center(
//                                   child: Icon(Icons.fastfood, size: 50)),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item.name,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 '\$${item.price.toStringAsFixed(2)}',
//                                 style: const TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:food_delivery_app/app_state.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    // Wait until after the first frame so context has access to Provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<AppState>(context, listen: false).loadMenuItems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MenuContent();
  }
}

class _MenuContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
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
                return Card(
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
                              ? Image.network(
                                  item.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                          child:
                                              Icon(Icons.fastfood, size: 50)),
                                )
                              : const Center(
                                  child: Icon(Icons.fastfood, size: 50)),
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
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${item.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.green,
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
            ),
    );
  }
}
