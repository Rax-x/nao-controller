import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This provider will be ovverrided in main.dart file
// beacuse SharedPreferences.getInstance() is asyncronous, 
// this way we avoid FutureProvider() and AsyncValue()
// see main.dart for implementation of this provider
//
// https://stackoverflow.com/questions/68170238/riverpod-create-service-with-async-dependency-better-elegant-way
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError("Will be ovverided in main.dart")
);