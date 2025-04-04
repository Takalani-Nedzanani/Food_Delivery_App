import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/providers/restaurant_provider.dart';
import 'package:food_delivery_app/models/food_model.dart';
import 'package:food_delivery_app/widgets/app_button.dart';
import 'package:food_delivery_app/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddEditFoodScreen extends StatefulWidget {
  final Food? food;

  const AddEditFoodScreen({super.key, this.food});

  @override
  State<AddEditFoodScreen> createState() => _AddEditFoodScreenState();
}

class _AddEditFoodScreenState extends State<AddEditFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  
  File? _imageFile;
  String? _selectedRestaurantId;
  bool _isPopular = false;
  bool _isRecommended = false;

  @override
  void initState() {
    super.initState();
    if (widget.food != null) {
      _nameController.text = widget.food!.name;
      _descriptionController.text = widget.food!.description;
      _priceController.text = widget.food!.price.toString();
      _categoryController.text = widget.food!.category;
      _selectedRestaurantId = widget.food!.restaurantId;
      _isPopular = widget.food!.isPopular;
      _isRecommended = widget.food!.isRecommended;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
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

  Future<void> _saveFood() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedRestaurantId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a restaurant')),
      );
      return;
    }
    if (widget.food == null && _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    try {
      final restaurantProvider = Provider.of<RestaurantProvider>(context, listen: false);
      
      if (widget.food == null) {
        // Upload image to Firebase Storage and get URL
        // Then add new food
        await restaurantProvider.addFood(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          price: double.parse(_priceController.text),
          imageUrl: 'image_url_after_upload', // Replace with actual URL after upload
          restaurantId: _selectedRestaurantId!,
          category: _categoryController.text.trim(),
          isPopular: _isPopular,
          isRecommended: _isRecommended,
        );
      } else {
        // Update existing food
        await restaurantProvider.updateFood(
          id: widget.food!.id,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          price: double.parse(_priceController.text),
          imageUrl: widget.food!.imageUrl, // Or new image URL if updated
          restaurantId: _selectedRestaurantId!,
          category: _categoryController.text.trim(),
          isPopular: _isPopular,
          isRecommended: _isRecommended,
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
    final restaurantProvider = Provider.of<RestaurantProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food == null ? 'Add Food Item' : 'Edit Food Item'),
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
                      : (widget.food?.imageUrl != null
                          ? NetworkImage(widget.food!.imageUrl)
                          : null),
                  child: _imageFile == null && widget.food?.imageUrl == null
                      ? const Icon(Icons.add_a_photo, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedRestaurantId,
                items: restaurantProvider.restaurants
                    .map((restaurant) => DropdownMenuItem(
                          value: restaurant.id,
                          child: Text(restaurant.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRestaurantId = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Restaurant',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a restaurant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _nameController,
                label: 'Food Name',
                hint: 'Enter food name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter food name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Enter food description',
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
                controller: _priceController,
                label: 'Price',
                hint: 'Enter price',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _categoryController,
                label: 'Category',
                hint: 'Enter category (e.g., Pizza, Burger)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Popular'),
                value: _isPopular,
                onChanged: (value) {
                  setState(() {
                    _isPopular = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Recommended'),
                value: _isRecommended,
                onChanged: (value) {
                  setState(() {
                    _isRecommended = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              AppButton(
                text: widget.food == null ? 'Add Food Item' : 'Update Food Item',
                onPressed: _saveFood,
                loading: restaurantProvider.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}