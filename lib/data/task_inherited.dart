import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key ? key,
    required Widget child,
  }) : super (key: key, child : child);

  // ignore: non_constant_identifier_names
  final List<Task> TaskList = [
              Task(
                  'Aprender Flutter',
                  'assets/images/dash.png',
                  3),
              Task(
                  'Andar de Bike',
                  'assets/images/bike.webp',
                  2),
              Task(
                  'Meditar',
                  'assets/images/meditar.jpeg',
                  5),
              Task(
                  'Ler',
                  'assets/images/livro.jpg',
                  4),
              Task(
                'Jogar',
                'assets/images/jogar.jpg',
                1),
  ];

  void newTask(String name, String photo, int difficulty) {
    TaskList.add(Task(name, photo, difficulty));
  }

  //metodo que pede um contexto e retorna um objeto
  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) { // responsável por ficar observando o estado da informação pra ver se há alguma atualização
    return oldWidget.TaskList.length != TaskList.length ;
    //verifica se o tamanho do estado anterior (oldWidget) é diferente do atual --> caso seja, o resultado desse boolena é true e o updateShouldNotify vai notificar todo mundo

  }
}