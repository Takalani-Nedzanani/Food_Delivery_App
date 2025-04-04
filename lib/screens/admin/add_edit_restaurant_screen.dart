import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/storage_service.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/providers/restaurant_provider.dart';
import 'package:food_delivery_app/models/restaurant_model.dart';
import 'package:food_delivery_app/widgets/app_button.dart';
import 'package:food_delivery_app/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddEditRestaurantScreen extends StatefulWidget {
  final Restaurant? restaurant;

  const AddEditRestaurantScreen({super.key, this.restaurant});

  @override
  State<AddEditRestaurantScreen> createState() => _AddEditRestaurantScreenState();
}

class _AddEditRestaurantScreenState extends State<AddEditRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _deliveryTimeController = TextEditingController();
  final _deliveryFeeController = TextEditingController();
  final _minOrderController = TextEditingController();
  final _addressController = TextEditingController();
  
  File? _imageFile;
  bool _isOpen = true;

  @override
  void initState() {
    super.initState();
    if (widget.restaurant != null) {
      _nameController.text = widget.restaurant!.name;
      _descriptionController.text = widget.restaurant!.description;
      _deliveryTimeController.text = widget.restaurant!.deliveryTime.toString();
      _deliveryFeeController.text = widget.restaurant!.deliveryFee.toString();
      _minOrderController.text = widget.restaurant!.minOrder.toString();
      _addressController.text = widget.restaurant!.address;
      _isOpen = widget.restaurant!.isOpen;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _deliveryTimeController.dispose();
    _deliveryFeeController.dispose();
    _minOrderController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
// Update _saveRestaurant method
Future<void> _saveRestaurant() async {
  if (!_formKey.currentState!.validate()) return;
  if (widget.restaurant == null && _imageFile == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select an image')),
    );
    return;
  }

  try {
    final restaurantProvider = Provider.of<RestaurantProvider>(context, listen: false);
    final storageService = Provider.of<StorageService>(context, listen: false);
    
    String imageUrl = widget.restaurant?.imageUrl ?? '';
    
    // Upload new image if selected
    if (_imageFile != null) {
      // Delete old image if exists
      if (widget.restaurant != null && widget.restaurant!.imageUrl.isNotEmpty) {
        await storageService.deleteImage(widget.restaurant!.imageUrl);
      }
      
      // Upload new image
      imageUrl = await storageService.uploadImage(
        'restaurants/${DateTime.now().millisecondsSinceEpoch}',
        _imageFile!,
      );
    }
    
    if (widget.restaurant == null) {
      await restaurantProvider.addRestaurant(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: imageUrl,
        deliveryTime: int.parse(_deliveryTimeController.text),
        deliveryFee: double.parse(_deliveryFeeController.text),
        minOrder: double.parse(_minOrderController.text),
        address: _addressController.text.trim(),
        isOpen: _isOpen,
      );
    } else {
      await restaurantProvider.updateRestaurant(
        id: widget.restaurant!.id,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: imageUrl,
        deliveryTime: int.parse(_deliveryTimeController.text),
        deliveryFee: double.parse(_deliveryFeeController.text),
        minOrder: double.parse(_minOrderController.text),
        address: _addressController.text.trim(),
        isOpen: _isOpen,
      );
    }
    
    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
  }
}
  Future<void> _saveRestaurant() async {
    if (!_formKey.currentState!.validate()) return;
    if (widget.restaurant == null && _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    try {
      final restaurantProvider = Provider.of<RestaurantProvider>(context, listen: false);
      
      if (widget.restaurant == null) {
        // Upload image to Firebase Storage and get URL
        // Then add new restaurant
        await restaurantProvider.addRestaurant(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          imageUrl: 'image_url_after_upload', // Replace with actual URL after upload
          deliveryTime: int.parse(_deliveryTimeController.text),
          deliveryFee: double.parse(_deliveryFeeController.text),
          minOrder: double.parse(_minOrderController.text),
          address: _addressController.text.trim(),
          isOpen: _isOpen,
        );
      } else {
        // Update existing restaurant
        await restaurantProvider.updateRestaurant(
          id: widget.restaurant!.id,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          imageUrl: widget.restaurant!.imageUrl, // Or new image URL if updated
          deliveryTime: int.parse(_deliveryTimeController.text),
          deliveryFee: double.parse(_deliveryFeeController.text),
          minOrder: double.parse(_minOrderController.text),
          address: _addressController.text.trim(),
          isOpen: _isOpen,
        );
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
        title: Text(widget.restaurant == null ? 'Add Restaurant' : 'Edit Restaurant'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : (widget.restaurant?.imageUrl != null
                          ? NetworkImage(widget.restaurant!.imageUrl)
                          : null),
                  child: _imageFile == null && widget.restaurant?.imageUrl == null
                      ? const Icon(Icons.add_a_photo, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _nameController,
                label: 'Restaurant Name',
                hint: 'Enter restaurant name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter restaurant name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Enter restaurant description',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _deliveryTimeController,
                label: 'Delivery Time (minutes)',
                hint: 'Enter estimated delivery time',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter delivery time';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _deliveryFeeController,
                label: 'Delivery Fee',
                hint: 'Enter delivery fee',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter delivery fee';
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
                label: 'Minimum Order',
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
              CustomTextField(
                controller: _addressController,
                label: 'Address',
                hint: 'Enter restaurant address',
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Open'),
                value: _isOpen,
                onChanged: (value) {
                  setState(() {
                    _isOpen = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              AppButton(
                text: widget.restaurant == null ? 'Add Restaurant' : 'Update Restaurant',
                onPressed: _saveRestaurant,
                loading: Provider.of<RestaurantProvider>(context).isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}