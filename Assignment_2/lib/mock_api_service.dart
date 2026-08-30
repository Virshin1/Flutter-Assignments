import 'dart:async';
import 'api_result.dart';
import 'error_handler.dart';
import 'user_profile.dart';

class MockApiService {
  // Late final field with lazy initialization
  late final String apiEndpoint = _initEndpoint();

  final int simulatedDelayMs;

  MockApiService({this.simulatedDelayMs = 600});

  String _initEndpoint() {
    return 'https://api.crossapp.internal/v1';
  }

  /// Internal mock database map
  final Map<int, Map<String, dynamic>?> _mockUserDatabase = {
    // User 101: Complete Profile with full data
    101: {
      'id': 101,
      'name': 'Virshin Kumar',
      'email': 'virshin@example.com',
      'bio': 'Passionate Cross-Platform Mobile & Dart Developer',
      'phoneNumber': '+91 98765 43210',
      'rating': 4.9,
      'skills': ['Dart', 'Flutter', 'Async Programming', 'State Management'],
      'preferences': {
        'theme': 'Dark Mode (AMOLED)',
        'notificationsEnabled': true,
      },
    },

    // User 102: Partial Profile with null / missing optional fields
    102: {
      'id': 102,
      'name': 'Priya Sharma',
      'email': 'priya.sharma@example.com',
      'bio': null,              // Nullable field
      'phoneNumber': null,      // Nullable field
      'rating': null,           // Nullable field
      'skills': null,           // Nullable list
      'preferences': null,      // Nullable map
    },

    // User 404: Returns explicit null to simulate missing resource
    404: null,
  };

  /// Raw fetch method simulating HTTP GET over the network
  Future<Map<String, dynamic>?> fetchRawUserData(int userId) async {
    // Simulating asynchronous network delay
    await Future.delayed(Duration(milliseconds: simulatedDelayMs));

    // Simulate 500 Internal Server Error
    if (userId == 500) {
      throwApiException(
        'Internal Server Error: Database cluster unreachable.',
        statusCode: 500,
      );
    }

    // Simulate 403 Forbidden Error
    if (userId == 403) {
      throwApiException(
        'Authentication Failure: Provided bearer token is invalid or expired.',
        statusCode: 403,
      );
    }

    // Lookup user in mock database
    if (!_mockUserDatabase.containsKey(userId)) {
      return null;
    }

    return _mockUserDatabase[userId];
  }

  /// High-level async method returning a sealed ApiResult<UserProfile>
  Future<ApiResult<UserProfile>> fetchUserProfile(int userId) async {
    try {
      print('  -> Initiating async network request to: $apiEndpoint/users/$userId');
      
      Map<String, dynamic>? rawResponse = await fetchRawUserData(userId);

      // Null check to handle 404 / Missing resource
      if (rawResponse == null) {
        return ApiEmpty(
          message: 'User with ID #$userId was not found on the server (404 Not Found).',
        );
      }

      // Validate payload integrity
      validatePayloadPresence(rawResponse, contextName: 'User Profile Payload');

      // Parse payload using null-safe factory constructor
      UserProfile profile = UserProfile.fromMap(rawResponse);
      return ApiSuccess(profile, statusCode: 200);

    } on ApiException catch (e) {
      // Catch known custom API exceptions
      return ApiError(e.message, statusCode: e.statusCode);
    } catch (e) {
      // Catch any unexpected general exceptions
      return ApiError('Unexpected network anomaly: $e', statusCode: 520);
    }
  }

  /// Fetches a batch list of product maps for generic transformation demo
  Future<ApiResult<List<Map<String, dynamic>>>> fetchProductsCatalog() async {
    try {
      await Future.delayed(Duration(milliseconds: simulatedDelayMs));

      List<Map<String, dynamic>> products = [
        {'id': 'P-1', 'title': 'Mechanical Keyboard', 'price': 89.99, 'stock': 15},
        {'id': 'P-2', 'title': '4K IPS Monitor', 'price': 349.50, 'stock': 4},
        {'id': 'P-3', 'title': 'Wireless Gaming Mouse', 'price': 59.00, 'stock': 28},
        {'id': 'P-4', 'title': 'USB-C Multi-Port Hub', 'price': 35.25, 'stock': 0},
      ];

      return ApiSuccess(products);
    } catch (e) {
      return ApiError('Failed to fetch product catalog: $e');
    }
  }
}
