import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_bloc/bloc/todo_bloc.dart';

import 'package:to_do_bloc/model/todo.dart';
import 'package:to_do_bloc/ui/widgets/NoToDo.dart';
import 'package:to_do_bloc/ui/widgets/addSheet.dart';
import 'package:to_do_bloc/ui/widgets/loading.dart';
import 'package:to_do_bloc/ui/widgets/searchSheet.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ToDoBloc todoBloc = ToDoBloc();

  final DismissDirection _dismissDirection = DismissDirection.startToEnd;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: Container(child: getToDosWidget()))),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.grey, width: 0.3),
            )),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.indigoAccent,
                      size: 28,
                    ),
                    onPressed: () {
                      todoBloc.getToDosEvent();
                    }),
                Expanded(
                  child: Text(
                    "To Do List",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'RobotoMono',
                        fontStyle: FontStyle.normal,
                        fontSize: 19),
                  ),
                ),
                Wrap(children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 28,
                      color: Colors.indigoAccent,
                    ),
                    onPressed: () {
                      showToDoSearchSheet(context, todoBloc);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                  )
                ])
              ],
            ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 10.0,
          onPressed: () {
            showAddToDoSheet(context, todoBloc);
          },
          backgroundColor: Colors.indigoAccent,
          child: Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          ),
        ));
  }

  Widget getToDosWidget() {
    /**
    The StreamBuilder widget will take stream of data (todos) and construct the UI (with state) based on the stream
    **/

    return StreamBuilder(
      stream: todoBloc.todos,
      builder: (BuildContext context, AsyncSnapshot<List<ToDo>> snapshot) {
        return getToDoCardWidget(snapshot);
      },
    );
  }

  Widget getToDoCardWidget(AsyncSnapshot<List<ToDo>> snapshot) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshot.hasData) {
      //* Check if the received data stream has any records
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                //* Used to claim the current ToDo id
                ToDo todo = snapshot.data[itemPosition];

                final Widget dismissibleCard = Dismissible(
                  background: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "Remove",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                  onDismissed: (direction) {
                    print(todo.id);
                    todoBloc.deleteToDoById(todo.id);
                  },
                  direction: _dismissDirection,
                  key: ObjectKey(todo.id),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[200], width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: ListTile(
                        leading: InkWell(
                          onTap: () {
                            todo.isCompleted = !todo.isCompleted;
                            todoBloc.updateToDo(todo);
                          },
                          child: Container(
                            //decoration: BoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: todo.isCompleted
                                  ? Stack(children: [
                                      Icon(
                                        Icons.check_box_outline_blank,
                                        size: 26.0,
                                        color: Colors.tealAccent,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Icon(
                                          Icons.done,
                                          size: 30.0,
                                          color: Colors.indigoAccent,
                                        ),
                                      ),
                                    ])
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      size: 26.0,
                                      color: Colors.tealAccent,
                                    ),
                            ),
                          ),
                        ),
                        title: Text(
                          todo.description,
                          style: TextStyle(
                              fontSize: 16.5,
                              fontFamily: 'RobotoMono',
                              fontWeight: FontWeight.w500,
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                      )),
                );
                return dismissibleCard;
              },
            )
          : Container(
              child: Center(
              child: noToDoMessageWidget(),
            ));
    } else {
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: loadingData(todoBloc),
      );
    }
  }

  @override
  dispose() {
    todoBloc.dispose();
  }
}
