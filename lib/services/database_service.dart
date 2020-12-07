import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration_example/app/locator.dart';
import 'package:sqflite_migration_service/sqflite_migration_service.dart';
import '../models/todo.dart';

const String DB_NAME = 'todo_database.sqlite';
const String TodoTableName = 'todos';

class DatabaseService {
  final _migrationService = locator<DatabaseMigrationService>();
  Database _database;

  Future initialise() async {
    _database = await openDatabase(DB_NAME, version: 1);

    // Apply migration on every start
    await _migrationService.runMigration(
      _database,
      migrationFiles: ['1_create_schema.sql', '2_add_description.sql'],
      verbose: true,
    );
  }

  Future<List<Todo>> getTodos() async {
    // Gets all the data in the TodoTableName
    List<Map> todoResults =
        await _database.query(TodoTableName, where: 'complete = 0');
    // Maps it to a Todo object and returns it
    return todoResults.map((todo) => Todo.fromJson(todo)).toList();
  }

  Future addTodo({String title, String description}) async {
    try {
      await _database.insert(
          TodoTableName, Todo(title: title, description: description).toJson());
    } catch (e) {
      print('Could not insert the todo: $e');
    }
  }

  Future updateCompleteForTodo({int id, bool complete}) async {
    try {
      await _database.update(
          TodoTableName,
          // We only pass in the data that we want to update. The field used here
          // has to already exist in the schema.
          {
            'complete': complete ? 1 : 0,
          },
          where: 'id = ?',
          whereArgs: [id]);
    } catch (e) {
      print('Could not update the todo: $e');
    }
  }

  Future updateTodo({int id, String title, String description}) async {
    try {
      await _database.update(
          TodoTableName,
          // We only pass in the data that we want to update. The field used here
          // has to already exist in the schema.
          {
            'title': title,
            'description': description,
          },
          where: 'id = ?',
          whereArgs: [id]);
    } catch (e) {
      print('Could not update the todo: $e');
    }
  }
}
