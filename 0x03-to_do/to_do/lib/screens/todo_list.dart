import 'package:flutter/material.dart';
import 'package:to_do/screens/add_list.dart';
import 'package:to_do/services/todo_services.dart';
import 'package:to_do/utils/snackbar_helpers.dart';
import 'package:to_do/widgets/todo_card.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = false;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To Do',
        ),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement:  Center(
              child: Text(
                "All done!",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (context, index){
                  final item = items[index] as Map;
                  return TodoCard(
                      index: index,
                      item: item,
                      navigateEdit: navigateToEditPage,
                      deleteById: deleteById
                  );
            }),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage,
          label: const Text("Add")
      ),
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
        builder: (context) => const AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future <void> fetchTodo() async {

    final response = await TodoService.fetchTodo();
    if(response!=null) {
      setState(() {
        items = response;
      });
    } else {
      showFailMessage(context, message: "Something went wrong");
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await TodoService.deleteById(id);
    if(isSuccess) { //remove from list
      showSuccessMessage(context, message: "Item deleted");
      final filtered = items.where((element) => element['_id']!=id).toList();
      setState(() {
        items = filtered;
      });
    } else { // throw error
      showFailMessage(context, message: "Something went wrong");
    }
  }
}
