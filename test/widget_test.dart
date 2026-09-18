import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pulse_feed/models/post_model.dart';
import 'package:pulse_feed/services/api_service.dart';
import 'package:pulse_feed/services/cache_service.dart';
import 'package:pulse_feed/screens/feed_screen.dart';
import 'package:pulse_feed/widgets/post_card.dart';
import 'package:pulse_feed/widgets/sync_status_bar.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const sampleJson = '''[
    {
      "userId": 1,
      "id": 1,
      "title": "sunt aut facere repellat provident occaecati excepturi optio",
      "body": "quia et suscipit suscipit recusandae consequuntur expedita et cum"
    },
    {
      "userId": 2,
      "id": 2,
      "title": "qui est esse",
      "body": "est rerum tempore vitae sequi sint nihil reprehenderit dolor"
    }
  ]''';

  group('PostModel Tests', () {
    test('Correctly deserializes from JSON map', () {
      final map = {
        'userId': 1,
        'id': 42,
        'title': 'serverless architecture',
        'body': 'scaling microservices with cloud functions',
      };
      final post = PostModel.fromJson(map);

      expect(post.userId, 1);
      expect(post.id, 42);
      expect(post.title, 'serverless architecture');
      expect(post.capitalizedTitle, 'Serverless architecture');
      expect(post.category, 'Cloud Architecture');
      expect(post.readingTime, '1 min read');
    });

    test('Correctly serializes to JSON map', () {
      const post = PostModel(
        id: 5,
        userId: 3,
        title: 'sample title',
        body: 'sample body',
      );
      final json = post.toJson();
      expect(json['id'], 5);
      expect(json['userId'], 3);
      expect(json['title'], 'sample title');
      expect(json['body'], 'sample body');
    });
  });

  group('CacheService Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Saves and retrieves cached JSON', () async {
      final cacheService = CacheService();
      expect(await cacheService.hasCache(), isFalse);

      await cacheService.savePosts(sampleJson);
      expect(await cacheService.hasCache(), isTrue);

      final cached = await cacheService.getCachedJson();
      expect(cached, sampleJson);

      final syncTime = await cacheService.getLastSyncTime();
      expect(syncTime, isNotNull);
    });

    test('Clears cache accurately', () async {
      final cacheService = CacheService();
      await cacheService.savePosts(sampleJson);
      expect(await cacheService.hasCache(), isTrue);

      await cacheService.clearCache();
      expect(await cacheService.hasCache(), isFalse);
      expect(await cacheService.getCachedJson(), isNull);
      expect(await cacheService.getLastSyncTime(), isNull);
    });
  });

  group('ApiService Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Fetches from REST API and caches result on 200 OK', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          sampleJson,
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final cacheService = CacheService();
      final apiService = ApiService(
        cacheService: cacheService,
        client: mockClient,
      );

      final result = await apiService.fetchPosts();
      expect(result.source, DataSource.live);
      expect(result.posts.length, 2);
      expect(result.posts[0].id, 1);

      // Verify that cache was populated
      expect(await cacheService.hasCache(), isTrue);
      final cachedJson = await cacheService.getCachedJson();
      expect(cachedJson, sampleJson);
    });

    test('Falls back to cache when network request fails', () async {
      final cacheService = CacheService();
      await cacheService.savePosts(sampleJson);

      final mockClient = MockClient((request) async {
        return http.Response('Server Error', 500);
      });

      final apiService = ApiService(
        cacheService: cacheService,
        client: mockClient,
      );
      final result = await apiService.fetchPosts();

      expect(result.source, DataSource.cached);
      expect(result.posts.length, 2);
      expect(result.notice, isNotNull);
    });

    test('Throws ApiException when network fails and no cache exists', () async {
      final cacheService = CacheService();
      final mockClient = MockClient((request) async {
        return http.Response('Server Error', 500);
      });

      final apiService = ApiService(
        cacheService: cacheService,
        client: mockClient,
      );
      expect(() => apiService.fetchPosts(), throwsA(isA<ApiException>()));
    });
  });

  group('FeedScreen Widget Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('Renders FutureBuilder states and list items', (WidgetTester tester) async {
      final mockClient = MockClient((request) async {
        return http.Response(
          sampleJson,
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final cacheService = CacheService();
      final apiService = ApiService(
        cacheService: cacheService,
        client: mockClient,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: FeedScreen(
            apiService: apiService,
            cacheService: cacheService,
          ),
        ),
      );

      // Loading state check
      expect(find.byType(FeedScreen), findsOneWidget);

      // Let future complete
      await tester.pumpAndSettle();

      // Verify posts rendered
      expect(find.text('PulseFeed'), findsOneWidget);
      expect(find.byType(PostCard), findsNWidgets(2));
      expect(find.byType(SyncStatusBar), findsOneWidget);

      // Test Search filtering
      await tester.enterText(find.byKey(const Key('search_field')), 'qui est');
      await tester.pumpAndSettle();

      expect(find.byType(PostCard), findsNWidgets(1));
      expect(find.textContaining('Zero-Trust Security'), findsOneWidget);

      // Clear search
      await tester.enterText(find.byKey(const Key('search_field')), '');
      await tester.pumpAndSettle();
      expect(find.byType(PostCard), findsNWidgets(2));

      // Test tapping card to show bottom sheet
      await tester.tap(find.byType(PostCard).first);
      await tester.pumpAndSettle();

      expect(find.text('Post ID: #1'), findsOneWidget);
      expect(find.text('Author Profile ID: 1'), findsOneWidget);
    });
  });
}
