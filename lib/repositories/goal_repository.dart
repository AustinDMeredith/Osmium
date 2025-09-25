import '../database/database_helper.dart';
import '../models/goal.dart';
import 'package:postgres/postgres.dart';

class GoalRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;

  Future<String> create(Goal goal) async {
    final result = await _db.connection.execute(
      Sql.named('''
        INSERT INTO goals (name, description, target_value, current_progress, is_completed, parent_id, deadline)
        VALUES (@name, @description, @target_value, @current_progress, @is_completed, @parent_id, @deadline)
        RETURNING id
      '''),
      parameters: goal.toMap()..remove('id'), // Remove id for insert
    );
    return result.first.first as String;
  }

  Future<List<Goal>> getAll() async {
    final result = await _db.connection.execute('SELECT * FROM goals ORDER BY created_at DESC');
    return result.map((row) => Goal.fromMap(row.toColumnMap())).toList();
  }

  Future<Goal?> getById(String id) async {
    final result = await _db.connection.execute(
      Sql.named('SELECT * FROM goals WHERE id = @id'),
      parameters: {'id': id},
    );
    return result.isNotEmpty ? Goal.fromMap(result.first.toColumnMap()) : null;
  }

  Future<void> update(Goal goal) async {
    await _db.connection.execute(
      Sql.named('''
        UPDATE goals SET 
          name = @name,
          description = @description,
          target_value = @target_value,
          current_progress = @current_progress,
          is_completed = @is_completed,
          parent_id = @parent_id,
          deadline = @deadline
        WHERE id = @id
      '''),
      parameters: goal.toMap(),
    );
  }

  Future<void> delete(String id) async {
    await _db.connection.execute(
      Sql.named('DELETE FROM goals WHERE id = @id'),
      parameters: {'id': id},
    );
  }
}