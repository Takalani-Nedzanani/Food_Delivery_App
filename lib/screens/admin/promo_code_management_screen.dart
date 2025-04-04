import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/providers/admin_provider.dart';
import 'package:food_delivery_app/screens/admin/add_edit_promo_code_screen.dart';
import 'package:food_delivery_app/models/promo_code_model.dart';

class PromoCodesScreen extends StatefulWidget {
  const PromoCodesScreen({super.key});

  @override
  State<PromoCodesScreen> createState() => _PromoCodesScreenState();
}

class _PromoCodesScreenState extends State<PromoCodesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false).fetchPromoCodes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Promo Codes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditPromoCodeScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: adminProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : adminProvider.promoCodes.isEmpty
              ? const Center(child: Text('No promo codes found'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: adminProvider.promoCodes.length,
                  itemBuilder: (context, index) {
                    final promoCode = adminProvider.promoCodes[index];
                    return Card(
                      child: ListTile(
                        title: Text(promoCode.code),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(promoCode.description),
                            Text(
                              '${promoCode.discountType == 'percentage' ? '${promoCode.discountValue}%' : '\$${promoCode.discountValue}'} off',
                            ),
                            Text(
                              'Valid: ${promoCode.startDate.toLocal().toString().split(' ')[0]} to ${promoCode.endDate.toLocal().toString().split(' ')[0]}',
                            ),
                            Text(
                              promoCode.isActive ? 'Active' : 'Inactive',
                              style: TextStyle(
                                color: promoCode.isActive ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditPromoCodeScreen(
                                      promoCode: promoCode,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _showDeleteDialog(context, promoCode.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  void _showDeleteDialog(BuildContext context, String promoCodeId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Promo Code'),
        content: const Text('Are you sure you want to delete this promo code?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await Provider.of<AdminProvider>(context, listen: false)
                    .deletePromoCode(promoCodeId);
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