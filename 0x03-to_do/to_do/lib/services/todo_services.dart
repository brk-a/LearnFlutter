import 'dart:convert';

import 'package:http/http.dart' as http;

// class TodoService's method perform API calls
class TodoService{
  // delete a user by id
  static Future<bool> deleteById(String id) async {
    final url = "https://api.nstock.in/v1/todos/$id";
    final uri = Uri.parse(url);

    //send DELETE request
    final response = await http.delete(
      uri,
      headers: {
        "accept": "application/json",
      },
    );

    return response.statusCode==200;
  }

  //fetch all to-do items
  static Future<List?> fetchTodo() async {
    const url = "https://api.nstack.in/v1/todos?page=1&limit=10";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {
        "accept": "application/json",
      },
    );

    if(response.statusCode==200){
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      return result;
    } else {
      return null;
    }
  }

  // create a to-do item
  static Future<bool> submitData(String body) async {
    //submit data to server
    const url = "https://api.nstock.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    return response.statusCode==200 || response.statusCode==201;
  }

  // update a to-do item
  static Future<bool> updateData(String id, String body) async {
    //submit data to server
    final url = "https://api.nstock.in/v1/todos$id";
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json",
      },
      body: body,
    );

    return response.statusCode==200 || response.statusCode==201;
  }
}
