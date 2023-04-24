import 'package:simple_todo/src/tasks/domain/task.dart';
import 'package:simple_todo/src/tasks/db/virtual_db.dart';

class TaskRepository {
  final VirtualDB _db;

  TaskRepository(this._db);

  Future<List<Task>> getAll() async {
    var items = await _db.list();
    return items.map((item) => Task.fromMap(item)).toList();
  }

  Future<Task?> getOne(int id) async {
    var item = await _db.findOne(id);
    return item != null ? Task.fromMap(item) : null;
  }

  Future<void> insert(Task task) async {
    await _db.insert(task.toMap());
  }

  Future<void> update(Task task) async {
    await _db.update(task.toMap());
  }

  Future<void> delete(int id) async {
    await _db.remove(id);
  }
}
