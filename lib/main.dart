import 'package:dblitetesting/bloc/todos_dblitebloc.dart';
import 'package:dblitetesting/dblite/db_helper.dart';
import 'package:dblitetesting/models/todos_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoCubit(),
        child: Home(),
      )));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var uuid = Uuid();
  List<Todos> todos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    // todos.clear();
    context.read<TodoCubit>().getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<TodoCubit, TodosEvent>(
        builder: (context, state) {
          if (state is TodoEventLoaded) {
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.todos.length,
                  itemBuilder: (context, i) {
                    return Text(state.todos[i].id!);
                  },
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          var data = Todos(id: uuid.v4(), title: "Test");
                          DatabaseHelper().createTodo(data);
                          setState(() {
                            getData();
                          });
                        },
                        child: Text("Insert"))),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    )));
  }
}
