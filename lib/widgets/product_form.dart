import 'package:flutter/material.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/widgets/custom_textfield.dart';
import 'package:flutter_project/utilities/extensions.dart';
import 'package:flutter_project/widgets/text.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({Key? key, this.productModel, required this.onSubmitted})
      : super(key: key);
  final ProductModel? productModel;
  final Function(String title, String description, bool isUpdate) onSubmitted;
  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isUpdate = false;
  @override
  void initState() {
    setState(() {
      isUpdate = widget.productModel != null;
      if (isUpdate) {
        _titleController.text = widget.productModel!.title;
        _descriptionController.text = widget.productModel!.description;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.85,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InputField(
            controller: _titleController,
            labelText: 'Title',
            hintText: 'Enter the title',
          ),
          InputField(
            controller: _descriptionController,
            labelText: 'Description',
            hintText: 'Enter your description',
          ),
          12.verticalSpacer,
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: context.width * 0.85,
            child: ElevatedButton(
              onPressed: () => widget.onSubmitted(
                _titleController.text,
                _descriptionController.text,
                isUpdate,
              ),
              child: text(
                isUpdate ? 'Update' : 'Create',
                size: context.textTheme.headlineSmall?.fontSize,
                fontweight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
