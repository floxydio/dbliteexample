import 'package:dblitetesting/dblite/db_helper.dart';
import 'package:dblitetesting/models/todos_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TodosEvent extends Equatable {}

class TodosInitial extends TodosEvent {
  @override
  List<Object?> get props => [];
}

class TodoEventLoaded extends TodosEvent {
  final List<Todos> todos;

  TodoEventLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodoCubit extends Cubit<TodosEvent> {
  TodoCubit() : super(TodosInitial());

  void getData() async {
    final res = await DatabaseHelper().getItem();
    emit(TodoEventLoaded(res));
  }
}
