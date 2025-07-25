import 'package:postgres/postgres.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  Connection? _connection;

  DatabaseHelper._init();

  Future<void> initConnection() async {
    try {
      _connection = await Connection.open(
        Endpoint(
          host: 'localhost', // Local connection first
          database: 'osmium_db',
          username: 'osmium_user',
          password: 'Gunnerdog15!', // Use the password you set
          port: 5432,
        ),
        settings: ConnectionSettings(sslMode: SslMode.disable),
      );

      print('Database connected successfully!');
      await _createTables();
    } catch (e) {
      print('Database connection failed: $e');
      rethrow;
    }
  }

  Future<void> _createTables() async {

    // Enable UUID extension
    await _connection!.execute('CREATE EXTENSION IF NOT EXISTS "uuid-ossp"');

    // Create goals table
    await _connection!.execute('''
    CREATE TABLE IF NOT EXISTS goals(
      id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      name VARCHAR(255) NOT NULL,
      description TEXT,
      target_value DECIMAL NOT NULL DEFAULT 0,
      current_progress DECIMAL NOT NULL DEFAULT 0,
      is_completed BOOLEAN NOT NULL DEFAULT FALSE,
      parent_id VARCHAR(255) DEFAULT 'null',
      deadline TIMESTAMP,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
  ''');

    // Create tasks table
    await _connection!.execute('''
      CREATE TABLE IF NOT EXISTS tasks(
        id SERIAL PRIMARY KEY,
        FOREIGN KEY (user_id) REFERENCES users(user_id),
        name VARCHAR(255) NOT NULL,
        description TEXT,
        is_completed BOOLEAN NOT NULL DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create progress_logs table
    await _connection!.execute('''
      CREATE TABLE IF NOT EXISTS progress_logs(
        id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
        FOREIGN KEY (user_id) REFERENCES users(user_id),
        name VARCHAR(255) NOT NULL,
        progress_made INTEGER NOT NULL,
        description TEXT,
        parent_id UUID NOT NULL,              -- Links to goals, projects, tasks
        parent_type VARCHAR(20) NOT NULL,     -- 'goal', 'project', 'task'
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create projects table
    await _connection!.execute('''
      CREATE TABLE IF NOT EXISTS projects(
        id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
        FOREIGN KEY (user_id) REFERENCES users(user_id),
        name VARCHAR(255) NOT NULL,
        description TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create users table
    await _connection!.execute('''
      CREATE TABLE IF NOT EXISTS users(
        user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
        name VARCHAR(255) NOT NULL
      )
    ''');

    print('Tables created successfully!');
  }

  Connection get connection => _connection!;

  Future<void> close() async {
    await _connection?.close();
  }
}