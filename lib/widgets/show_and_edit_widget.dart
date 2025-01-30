import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:people_collection/data/storage_provider.dart';
import '../models/user_model.dart';

class ListController extends GetxController {
  RxList<String> items = <String>[].obs;
  final TextEditingController textEditController = TextEditingController();

  @override
  void onClose() {
    textEditController.dispose();
    super.onClose();
  }
}

class ShowAndEditWidget extends StatelessWidget {
  const ShowAndEditWidget({
    required this.title,
    required this.subTitle,
    required this.listItems,
    required this.titleSelectObj,
    required this.nameSelectObj,
    required this.person,
  });

  final ListPerson person;
  final String title;
  final String subTitle;
  final List<String> listItems;
  final String titleSelectObj;
  final String nameSelectObj;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Expanded(
          child: ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            title: Text(subTitle),
            children: [
              listItems.isEmpty ? const Text("No hay datos") :_showListItems(),
            ],
          ),
        ),
        IconButton(
          onPressed: () => _showMultiSelect(context),
          icon: const Icon(Icons.edit, size: 20),
        ),
      ],
    );
  }

  void _showMultiSelect(BuildContext context) {
    final storageProvider = Get.put(
      StorageProvider<UserModel>(
        collectionPath: "users",
        modelFactory: (json) => UserModel.fromJson(json),
      ),
    );
    final itemsController = Get.put(ListController());

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(titleSelectObj),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MultiSelectDialogField(
                cancelText:
                    const Text('Cancelar', style: TextStyle(color: Colors.red)),
                confirmText:
                    const Text('Ok', style: TextStyle(color: Colors.white)),
                itemsTextStyle: const TextStyle(color: Colors.white),
                buttonText: Text(nameSelectObj),
                items: listItems.map((e) => MultiSelectItem(e, e)).toList(),
                listType: MultiSelectListType.LIST,
                onConfirm: (values) => itemsController.items.value = values,
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildTextButton(
                        "Agregar",
                        () => _addSelectedItems(
                            storageProvider, itemsController)),
                    _buildTextButton(
                        "Eliminar",
                        () => _removeSelectedItems(
                            storageProvider, itemsController)),
                    _buildTextButton("Cancelar", () {
                      Get.delete<ListController>();
                      Get.back();
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _removeSelectedItems(StorageProvider<UserModel> storageProvider,
      ListController itemsController) async {
     UserModel?  user =  storageProvider.model.value;
    if (user != null) {
      listItems.removeWhere((item) => itemsController.items.contains(item));
      storageProvider.updateModel(user);
      Get.delete<ListController>();
      Get.back();
    }
  }

  Future<void> _addSelectedItems(StorageProvider<UserModel> storageProvider,
      ListController itemsController) async {
      UserModel?  user =  storageProvider.model.value;
    if (user != null) {
      String value = 'sadfgsdfgdsf';
      listItems.add(value);
      storageProvider.updateModel(user);
      
      Get.delete<ListController>();
      Get.back();
    }
  }

  Widget _showListItems() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listItems.length,
      itemBuilder: (context, index) => SizedBox(
        width: 200,
        child: Text(listItems[index]),
      ),
    );
  }

  Widget _buildTextButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
