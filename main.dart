import 'dart:convert';

import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

import 'package:shelf_router/shelf_router.dart';

void main() async {
  final app = Router();
  final env = DotEnv(includePlatformEnvironment: true)..load();

  final client = SupabaseClient(
    env['SUPABASE_URL']!,
    env['SUPABASE_API_KEY']!,
  );

  app.get('/api/blogs', (Request request) async {
    final blogs = await client.from('blogs').select().execute();
    print(blogs.data);
    return Response.ok(
      json.encode({"data": blogs.data}),
    );
  });

  app.get('/api/blogs/<id>', (Request request, String id) async {
    final blogs = await client.from('blogs').select().eq('id', id).execute();
    print(blogs.data);
    return Response.ok(
      json.encode({"data": blogs.data}),
    );
  });

  io.serve(app, 'localhost', 8080);
}
