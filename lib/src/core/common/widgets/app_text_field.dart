import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:task/src/core/utils/constants/colors.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final bool isCategorySelected;
  final List<SelectedListItem>? categories;
  final String? Function(String?)? validate;

  const AppTextField({
    required this.textEditingController,
    required this.title,
    required this.hint,
    required this.isCategorySelected,
    this.categories,
    super.key,
    this.validate,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        clearButtonChild: const Text(
          'clear',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.categories ?? [],
        selectedItems: (List<dynamic> selectedList) {
          if (selectedList.isNotEmpty) {
            // تأكد من أنه يتم تعيين القيمة بشكل صحيح
            var item = selectedList.first;
            if (item is SelectedListItem) {
              widget.textEditingController.text = item.name;
              // Notify the UI to reflect changes if needed
              setState(() {});
            }
          }
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(height: 5.0),
        TextFormField(
          readOnly: true,
          validator: widget.validate,
          controller: widget.textEditingController,
          onTap: widget.isCategorySelected
              ? () {
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,
          decoration: InputDecoration(
            suffixIcon: const Icon(
              Icons.arrow_drop_down,
              color: ColorsApp.primaryColor,
            ),
            prefixIcon: const Icon(
              Icons.category,
              color: ColorsApp.primaryColor,
            ),
            filled: true,
            fillColor: Colors.black12,
            hintText: widget.hint,
            border: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(width: 1, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
