import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_with_search/constants/colors.dart';
import 'package:todo_app_with_search/model/todo.dart';
import 'package:todo_app_with_search/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Todo> todoList = Todo.todoList();
  late TextEditingController _controller;
  List<Todo> _searchForTodoList = [];

  @override
  void initState() {
    _controller = TextEditingController();
    _searchForTodoList = todoList;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.h, bottom: 12.h),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (Todo todo in _searchForTodoList.reversed)
                        TodoItem(
                          todo: todo,
                          onTodoChanged: _handelTodoChange,
                          onDeleteItem: _deleteTodoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    margin:
                        EdgeInsets.only(bottom: 20.h, right: 20.w, left: 20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Add a new todo task",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.h, right: 20.w),
                  child: ElevatedButton(
                    onPressed: () {
                      _addTodoItem(_controller.text);
                    },
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: tdBlue,
                      minimumSize: Size(60.w, 50.h),
                      elevation: 10,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ... Functions

  // .. handel todo done function
  void _handelTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  // .. delete todo item
  void _deleteTodoItem(String? id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

  // .. add todo to todo list
  void _addTodoItem(String todo) {
    setState(() {
      todoList.add(
        Todo(
            id: DateTime.timestamp().microsecondsSinceEpoch.toString(),
            todoText: todo),
      );
    });

    _controller.clear();
  }

  // .. search functionality
  void _searchFunction(String searchedWord) {
    List<Todo> searchResult = [];

    if (searchedWord.isEmpty) {
      searchResult = todoList;
    } else {
      searchResult = todoList
          .where(
            (element) => element.todoText!.toLowerCase().contains(
                  searchedWord.toLowerCase(),
                ),
          )
          .toList();
    }

    setState(() {
      _searchForTodoList = searchResult;
    });
  }

  // ... Widgets

  PreferredSizeWidget? _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            size: 30.sp,
          ),
          SizedBox(
            height: 40.w,
            width: 40.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                'assets/images/profile-image.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (searchedValue) => _searchFunction(searchedValue),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20.w,
          ),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: const TextStyle(color: tdGrey),
        ),
      ),
    );
  }
}
