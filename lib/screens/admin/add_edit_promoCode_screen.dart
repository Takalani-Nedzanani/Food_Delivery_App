import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/providers/admin_provider.dart';
import 'package:food_delivery_app/models/promo_code_model.dart';
import 'package:food_delivery_app/widgets/app_button.dart';
import 'package:food_delivery_app/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class AddEditPromoCodeScreen extends StatefulWidget {
  final PromoCode? promoCode;

  const AddEditPromoCodeScreen({super.key, this.promoCode});

  @override
  State<AddEditPromoCodeScreen> createState() => _AddEditPromoCodeScreenState();
}

class _AddEditPromoCodeScreenState extends State<AddEditPromoCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _discountValueController = TextEditingController();
  final _minOrderController = TextEditingController();
  final _maxDiscountController = TextEditingController();
  final _usageLimitController = TextEditingController();
  
  String _discountType = 'percentage';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 30));
  bool _isActive = true;
  bool _hasUsageLimit = false;

  @override
  void initState() {
    super.initState();
    if (widget.promoCode != null) {
      _codeController.text = widget.promoCode!.code;
      _descriptionController.text = widget.promoCode!.description;
      _discountType = widget.promoCode!.discountType;
      _discountValueController.text = widget.promoCode!.discountValue.toString();
      _minOrderController.text = widget.promoCode!.minOrder.toString();
      _maxDiscountController.text = widget.promoCode!.maxDiscount?.toString() ?? '';
      _startDate = widget.promoCode!.startDate;
      _endDate = widget.promoCode!.endDate;
      _isActive = widget.promoCode!.isActive;
      _hasUsageLimit = widget.promoCode!.usageLimit != null;
      _usageLimitController.text = widget.promoCode!.usageLimit?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
    _discountValueController.dispose();
    _minOrderController.dispose();
    _maxDiscountController.dispose();
    _usageLimitController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate.isBefore(_startDate)) {
            _endDate = _startDate.add(const Duration(days: 1));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _savePromoCode() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final adminProvider = Provider.of<AdminProvider>(context, listen: false);
      
      final promoCode = PromoCode(
        id: widget.promoCode?.id ?? '',
        code: _codeController.text.trim(),
        description: _descriptionController.text.trim(),
        discountType: _discountType,
        discountValue: double.parse(_discountValueController.text),
        minOrder: double.parse(_minOrderController.text),
        maxDiscount: _maxDiscountController.text.isNotEmpty
            ? double.parse(_maxDiscountController.text)
            : null,
        startDate: _startDate,
        endDate: _endDate,
        isActive: _isActive,
        usageLimit: _hasUsageLimit && _usageLimitController.text.isNotEmpty
            ? int.parse(_usageLimitController.text)
            : null,
        usedCount: widget.promoCode?.usedCount ?? 0,
        createdAt: widget.promoCode?.createdAt ?? DateTime.now(),
      );
      
      if (widget.promoCode == null) {
        await adminProvider.addPromoCode(promoCode);
      } else {
        await adminProvider.updatePromoCode(promoCode);
      }
      
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.promoCode == null ? 'Add Promo Code' : 'Edit Promo Code'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _codeController,
                label: 'Promo Code',
                hint: 'Enter promo code (e.g., SUMMER20)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter promo code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Enter description',
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _discountType,
                items: const [
                  DropdownMenuItem(
                    value: 'percentage',
                    child: Text('Percentage Discount'),
                  ),
                  DropdownMenuItem(
                    value: 'fixed',
                    child: Text('Fixed Amount Discount'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _discountType = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Discount Type',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _discountValueController,
                label: _discountType == 'percentage'
                    ? 'Discount Percentage'
                    : 'Discount Amount',
                hint: _discountType == 'percentage'
                    ? 'Enter percentage (e.g., 20)'
                    : 'Enter amount (e.g., 5)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter discount value';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _minOrderController,
                label: 'Minimum Order Amount',
                hint: 'Enter minimum order amount',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter minimum order amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_discountType == 'percentage')
                CustomTextField(
                  controller: _maxDiscountController,
                  label: 'Maximum Discount (optional)',
                  hint: 'Enter maximum discount amount',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Start Date: ${DateFormat('MMM d, y').format(_startDate)}'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context, true),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('End Date: ${DateFormat('MMM d, y').format(_endDate)}'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context, false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Active'),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Set Usage Limit'),
                value: _hasUsageLimit,
                onChanged: (value) {
                  setState(() {
                    _hasUsageLimit = value;
                  });
                },
              ),
              if (_hasUsageLimit) ...[
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _usageLimitController,
                  label: 'Usage Limit',
                  hint: 'Enter maximum number of uses',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_hasUsageLimit && (value == null || value.isEmpty)) {
                      return 'Please enter usage limit';
                    }
                    if (_hasUsageLimit && int.tryParse(value!) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 30),
              AppButton(
                text: widget.promoCode == null ? 'Add Promo Code' : 'Update Promo Code',
                onPressed: _savePromoCode,
                loading: Provider.of<AdminProvider>(context).isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}