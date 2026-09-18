import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String _postsCacheKey = 'pulse_feed_cached_posts_json';
  static const String _lastSyncKey = 'pulse_feed_last_sync_timestamp';

  /// Persists raw JSON and records the current timestamp
  Future<void> savePosts(String rawJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_postsCacheKey, rawJson);
    await prefs.setString(_lastSyncKey, DateTime.now().toIso8601String());
  }

  /// Retrieves cached raw JSON string if available
  Future<String?> getCachedJson() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_postsCacheKey);
  }

  /// Retrieves timestamp of the last successful sync
  Future<DateTime?> getLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_lastSyncKey);
    if (raw == null) return null;
    try {
      return DateTime.parse(raw);
    } catch (_) {
      return null;
    }
  }

  /// Verifies if a valid cache currently exists
  Future<bool> hasCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_postsCacheKey);
    return cached != null && cached.trim().isNotEmpty;
  }

  /// Flushes the cached posts and timestamp
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_postsCacheKey);
    await prefs.remove(_lastSyncKey);
  }
}
