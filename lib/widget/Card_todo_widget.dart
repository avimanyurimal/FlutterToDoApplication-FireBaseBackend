// import 'dart:js_interop_unsafe';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
// import 'package:todo/model/todo_model.dart';
import 'package:todoapp/provider/service_provider.dart';

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchDataProvider);
    return todoData.when(
      data: (todoData) {
        Color catagoryColor = Colors.white;

        final getCategory = todoData[getIndex].category;

        switch (getCategory) {
          case 'Learning':
            catagoryColor = Colors.green;
            break;

          case 'Working':
            catagoryColor = Colors.blue.shade700;
            break;

          case 'General':
            catagoryColor = Colors.amber.shade700;
            break;
        }

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: catagoryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                width: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: IconButton(
                            icon: Icon(CupertinoIcons.delete),
                            onPressed: () => ref
                                .read(serviceProvider)
                                .deleTask(todoData[getIndex].docID),
                          ),
                          title: Text(
                            todoData[getIndex].titleTask,
                            maxLines: 2,
                            style: TextStyle(
                                decoration: todoData[getIndex].isDone
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          subtitle: Text(
                            todoData[getIndex].description,
                            maxLines: 2,
                            style: TextStyle(
                                decoration: todoData[getIndex].isDone
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.blue.shade800,
                              shape: const CircleBorder(),
                              value: todoData[getIndex].isDone,
                              onChanged: (value) => ref
                                  .read(serviceProvider)
                                  .updateTask(todoData[getIndex].docID, value),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -12),
                          child: Container(
                              child: Column(
                            children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade200,
                              ),
                              Row(
                                children: [
                                  const Text('Today'),
                                  const Gap(12),
                                  Text(todoData[getIndex].timeTask)
                                ],
                              ),
                            ],
                          )),
                        )
                      ]),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(stackTrace.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
