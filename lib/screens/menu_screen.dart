import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppState>(context, listen: false).loadMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: ListView.builder(
        itemCount: appState.menuItems.length,
        itemBuilder: (context, index) {
          final item = appState.menuItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.description),
            trailing: Text('\$${item.price.toStringAsFixed(2)}'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/order',
                arguments: item,
              );
            },
          );
        },
      ),
    );
  }
}