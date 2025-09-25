import '../database/database_helper.dart';
import '../models/progressLog.dart';
import 'package:postgres/postgres.dart';

class ProgressLogRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;

  //get all logs
  Future<List<ProgressLog>> getAll() async {
    final result = await _db.connection.execute('SELECT * FROM progress_logs ORDER BY created_at DESC');
    return result.map((row) => ProgressLog.fromMap(row.toColumnMap())).toList();
  }

  // Get logs for a specific goal
  Future<List<ProgressLog>> getLogsForGoal(String goalId) async {
    final result = await _db.connection.execute(
      Sql.named('''
        SELECT * FROM progress_logs 
        WHERE parent_id = @parent_id AND parent_type = 'goal'
        ORDER BY created_at DESC
      '''),
      parameters: {'parent_id': goalId},
    );
    return result.map((row) => ProgressLog.fromMap(row.toColumnMap())).toList();
  }

  Future<void> update(ProgressLog log) async {
    await _db.connection.execute(
      Sql.named('''
        UPDATE progress_logs SET 
          name = @name,
          description = @description,
          current_progress = @current_progress,
          is_completed = @is_completed,
          parent_id = @parent_id,
          deadline = @deadline
        WHERE id = @id
      '''),
      parameters: log.toMap(),
    );
  }

  // Get logs for a specific project
  Future<List<ProgressLog>> getLogsForProject(String projectId) async {
    final result = await _db.connection.execute(
      Sql.named('''
        SELECT * FROM progress_logs 
        WHERE parent_id = @parent_id AND parent_type = 'project'
        ORDER BY created_at DESC
      '''),
      parameters: {'parent_id': projectId},
    );
    return result.map((row) => ProgressLog.fromMap(row.toColumnMap())).toList();
  }

  // Create log for goal
  Future<String> createGoalLog(String goalId, String name, int progress, String description) async {
    final log = ProgressLog(
      name: name,
      progressMade: progress,
      description: description,
      parentId: goalId,
      parentType: 'goal',
    );
    return await create(log);
  }

  // Create log for project
  Future<String> createProjectLog(String projectId, String name, int progress, String description) async {
    final log = ProgressLog(
      name: name,
      progressMade: progress,
      description: description,
      parentId: projectId,
      parentType: 'project',
    );
    return await create(log);
  }

  // Generic create method
  Future<String> create(ProgressLog log) async {
    final result = await _db.connection.execute(
      Sql.named('''
        INSERT INTO progress_logs (name, progress_made, description, parent_id, parent_type)
        VALUES (@name, @progress_made, @description, @parent_id, @parent_type)
        RETURNING id
      '''),
      parameters: log.toMap()..remove('id'),
    );
    return result.first.first as String;
  }
}