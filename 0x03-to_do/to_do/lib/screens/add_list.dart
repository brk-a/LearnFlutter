import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_do/services/todo_services.dart';
import 'package:to_do/utils/snackbar_helpers.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if(todo!=null){
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            isEdit ? "Edit item" : "Add Item",
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children:  [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 20,),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    isEdit ? "Update" : "Done",
                ),
              ),
          ),
        ],
      ),
    );
  }

  Future<void> submitData() async {
    //get data from form
    final title = titleController.text;
    final description = descriptionController.text;
    final body = jsonEncode({
      "title": title,
      "description": description,
      "is_completed": false,
    });

    //submit data to server
    final isSuccess = await TodoService.submitData(body);

    //show success/fail msg based on status
    if(isSuccess){
      titleController.text = '';
      descriptionController.text = '';
      if(mounted) {
        showSuccessMessage(context, message: "Item created!");
      }
    } else {
      if(mounted) {
        showFailMessage(context, message: "Something went wrong");
      }
    }
  }

  Future<void> updateData() async {
    //get data
    final todo = widget.todo;
    if(todo==null){
      return;
    }

    final id = todo['_id'];
    // final isCompleted = todo['is_completed'];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = jsonEncode({
      "title": title,
      "description": description,
      "is_completed": false,
    });

    //submit data to server
    final isSuccess = await TodoService.updateData(id, body);

    //show success/fail msg based on status
    if(isSuccess){
      titleController.text = '';
      descriptionController.text = '';
      if(mounted) {
        showSuccessMessage(context, message: "Item updated!");
      }
    } else {
      if(mounted) {
        showFailMessage(context, message: "Something went wrong");
      }
    }
  }
}
