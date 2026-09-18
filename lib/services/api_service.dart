import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import 'cache_service.dart';

enum DataSource { live, cached }

class FeedResult {
  final List<PostModel> posts;
  final DataSource source;
  final DateTime? syncedAt;
  final String? notice;

  const FeedResult({
    required this.posts,
    required this.source,
    this.syncedAt,
    this.notice,
  });

  bool get isLive => source == DataSource.live;
  bool get isCached => source == DataSource.cached;

  String get formattedSyncTime {
    if (syncedAt == null) return 'Unknown';
    final h = syncedAt!.hour % 12 == 0 ? 12 : syncedAt!.hour % 12;
    final m = syncedAt!.minute.toString().padLeft(2, '0');
    final s = syncedAt!.second.toString().padLeft(2, '0');
    final p = syncedAt!.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m:$s $p';
  }
}

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

class ApiService {
  final CacheService _cacheService;
  final http.Client _client;

  ApiService({
    CacheService? cacheService,
    http.Client? client,
  })  : _cacheService = cacheService ?? CacheService(),
        _client = client ?? http.Client();

  static const String endpoint = 'https://jsonplaceholder.typicode.com/posts';

  List<PostModel> parsePosts(String jsonString) {
    final List<dynamic> list = jsonDecode(jsonString) as List<dynamic>;
    return list.map((item) => PostModel.fromJson(item as Map<String, dynamic>)).toList();
  }

  /// Fetches posts from REST API, falling back to local cache if offline
  Future<FeedResult> fetchPosts({bool forceRefresh = false}) async {
    try {
      final response = await _client.get(
        Uri.parse(endpoint),
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'PulseFeed-Client/1.0',
        },
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        // Save fresh response directly to SharedPreferences cache
        await _cacheService.savePosts(response.body);

        final posts = parsePosts(response.body);
        return FeedResult(
          posts: posts,
          source: DataSource.live,
          syncedAt: DateTime.now(),
        );
      } else {
        throw ApiException('Server returned status code: ${response.statusCode}');
      }
    } on SocketException catch (_) {
      return _loadFallbackCache('Network unavailable. Displaying offline cache.');
    } on TimeoutException catch (_) {
      return _loadFallbackCache('Request timed out. Displaying offline cache.');
    } on HttpException catch (_) {
      return _loadFallbackCache('HTTP transport error. Displaying offline cache.');
    } catch (e) {
      return _loadFallbackCache('Network error: $e. Displaying offline cache.');
    }
  }

  Future<FeedResult> _loadFallbackCache(String offlineNotice) async {
    final cachedJson = await _cacheService.getCachedJson();
    final lastSync = await _cacheService.getLastSyncTime();

    if (cachedJson != null && cachedJson.trim().isNotEmpty) {
      try {
        final posts = parsePosts(cachedJson);
        return FeedResult(
          posts: posts,
          source: DataSource.cached,
          syncedAt: lastSync,
          notice: offlineNotice,
        );
      } catch (_) {
        throw const ApiException(
          'Corrupted offline cache. Connect to the internet to refresh feed.',
        );
      }
    }

    throw const ApiException(
      'Unable to connect to REST API and no offline cache was found.',
    );
  }
}
