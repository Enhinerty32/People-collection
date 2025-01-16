import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A widget that provides a text field with save functionality.
/// The text field can be toggled between read-only and editable states.
/// When in editable state, the text can be submitted and saved.
class TextFieldSave extends StatelessWidget {
  /// A boolean controller to toggle the edit mode.
  final RxBool boolController;

  /// A string controller to hold the text value.
  final RxString stringController;

  /// A function to be executed when the text is submitted.
  final VoidCallback? function;

  /// Creates a [TextFieldSave] widget.
  /// 
/// A widget that provides a text field with save functionality.
/// 
/// The text field can be toggled between read-only and editable states.
/// When in editable state, the text can be submitted and saved.
/// 
/// This widget uses two controllers:
/// - [boolController]: A boolean controller to toggle the edit mode.
/// - [stringController]: A string controller to hold the text value.
/// 
/// The widget displays an edit icon when in read-only mode. When the edit icon
/// is pressed, the text field becomes editable and the icon changes to a send icon.
/// When the send icon is pressed, the text is saved and the text field becomes
/// read-only again.
/// 
/// Additionally, a function can be executed when the text is submitted by
/// providing a [function] callback.
/// 
/// Example usage:
/// 
/// ```dart
/// final RxBool isEditing = false.obs;
/// final RxString textValue = 'Initial text'.obs;
/// 
/// TextFieldSave(
///   boolController: isEditing,
///   stringController: textValue,
///   function: () {
///     print('Text submitted: ${textValue.value}');
///   },
/// );
/// ```
/// 
/// This widget is useful for scenarios where you need to toggle between
/// viewing and editing text, such as in profile editing forms or settings pages.
  TextFieldSave({
    required this.stringController,
    required this.boolController,
    this.function,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the TextEditingController with the current value of stringController.
    final TextEditingController controller = TextEditingController(text: stringController.value);

    // Define the outline input border style.
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    // Define the input decoration for the text field.
    final inputDecoration = InputDecoration(
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: Obx(() {
        // Toggle between edit and send icons based on the value of boolController.
        return IconButton(
          icon: Icon(boolController.value ? Icons.send_outlined : Icons.edit),
          onPressed: () {
            if (boolController.value) {
              // Save the text and disable edit mode.
              stringController.value = controller.text;
              boolController.value = false;
              if (function != null) {
                function!();
              }
            } else {
              // Enable edit mode.
              boolController.value = true;
            }
            // print('Valor de la caja de texto: ${stringController.value}');
          },
        );
      }),
    );

    return Obx(() {
      // Update the TextEditingController text when the RxString changes.
      if (controller.text != stringController.value) {
        controller.text = stringController.value;
      }

      return TextFormField(
        // Toggle read-only mode based on the value of boolController.
        readOnly: !boolController.value,
        controller: controller,
        decoration: inputDecoration,
        onFieldSubmitted: (value) {
          // Save the submitted text and disable edit mode.
          stringController.value = value;
          boolController.value = false;
          if (function != null) {
            function!();
          }
          // print('Submit value ${stringController.value}');
        },
      );
    });
  }
}