import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_with_search/constants/colors.dart';
import 'package:todo_app_with_search/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onTodoChanged;
  final Function(String?) onDeleteItem;
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onTodoChanged,
      required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          todo.todoText ?? "",
          style: TextStyle(
            fontSize: 14.sp,
            color: tdBlack,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          height: 30.h,
          width: 30.w,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              onDeleteItem(todo.id);
            },
            iconSize: 18.sp,
            color: Colors.white,
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ),
      ),
    );
  }
}
