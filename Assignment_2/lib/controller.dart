import 'api_result.dart';
import 'data_transformer.dart';
import 'mock_api_service.dart';
import 'user_profile.dart';

class ApiDemoController {
  final MockApiService apiService;

  ApiDemoController({MockApiService? service})
      : apiService = service ?? MockApiService(simulatedDelayMs: 400);

  /// Orchestrates and executes all mock API demonstration scenarios
  Future<void> runAllScenarios() async {
    final logger = createActivityLogger(prefix: 'MOCK_API_RUNNER');

    print('================================================================');
    print('  🚀 DART ASYNC, FUTURE & NULL SAFETY DEMO (ASSIGNMENT 2)');
    print('================================================================\n');

    // SCENARIO 1: Complete User Profile Fetch
    print('>>> SCENARIO 1: Fetching Complete User Profile (ID: 101) <<<');
    logger('Dispatching request for User #101...');
    ApiResult<UserProfile> fullUserResult = await apiService.fetchUserProfile(101);
    _handleUserResult(fullUserResult);

    await Future.delayed(const Duration(milliseconds: 200));

    // SCENARIO 2: Partial Profile with Null Fields (Null Safety Handling)
    print('\n>>> SCENARIO 2: Fetching Partial Profile with Null Fields (ID: 102) <<<');
    logger('Dispatching request for User #102...');
    ApiResult<UserProfile> partialUserResult = await apiService.fetchUserProfile(102);
    _handleUserResult(partialUserResult);

    await Future.delayed(const Duration(milliseconds: 200));

    // SCENARIO 3: Resource Not Found / Null API Payload (ID: 404)
    print('\n>>> SCENARIO 3: Fetching Non-Existent User (ID: 404 / Not Found) <<<');
    logger('Dispatching request for User #404...');
    ApiResult<UserProfile> notFoundResult = await apiService.fetchUserProfile(404);
    _handleUserResult(notFoundResult);

    await Future.delayed(const Duration(milliseconds: 200));

    // SCENARIO 4: Simulated Server Error 500 (Exception Handling)
    print('\n>>> SCENARIO 4: Simulated Internal Server Error (ID: 500 / Exception) <<<');
    logger('Dispatching request for User #500...');
    ApiResult<UserProfile> serverErrorResult = await apiService.fetchUserProfile(500);
    _handleUserResult(serverErrorResult);

    await Future.delayed(const Duration(milliseconds: 200));

    // SCENARIO 5: Batch Async Fetching & Generic Higher-Order Transformation
    print('\n>>> SCENARIO 5: Batch Async Fetching & Generic Transformation <<<');
    logger('Fetching Product Catalog batch...');
    ApiResult<List<Map<String, dynamic>>> catalogResult = await apiService.fetchProductsCatalog();

    switch (catalogResult) {
      case ApiSuccess(:final data):
        print('  [SUCCESS] Received ${data.length} catalog items. Applying generic transformer:');
        
        // Transforming Map items into formatted display strings via generic function
        List<String> formattedSummaries = applyTransform<Map<String, dynamic>, String>(
          data,
          (item) {
            String title = (item['title'] as String?) ?? 'Unknown Item';
            double price = (item['price'] as num?)?.toDouble() ?? 0.0;
            int stock = (item['stock'] as int?) ?? 0;
            String stockTag = stock > 0 ? '$stock in stock' : 'OUT OF STOCK';
            return '• $title - \$${price.toStringAsFixed(2)} ($stockTag)';
          },
        );

        for (var summary in formattedSummaries) {
          print('    $summary');
        }

        // Null-coalescing assignment demonstration
        String? defaultCurrency;
        defaultCurrency ??= 'USD (\$)';
        print('  Active Currency (via ??= assignment): $defaultCurrency');
        break;

      case ApiError(:final errorMessage):
        print('  [ERROR] Catalog fetch failed: $errorMessage');
        break;

      case ApiEmpty(:final message):
        print('  [EMPTY] $message');
        break;
    }

    print('\n================================================================');
    print('  ✅ ALL DEMONSTRATION SCENARIOS COMPLETED SUCCESSFULLY');
    print('================================================================');
  }

  /// Processes and displays User Profile results using Dart 3 switch pattern matching
  void _handleUserResult(ApiResult<UserProfile> result) {
    // Demonstrates Dart 3 Switch Expression / Statement pattern matching on sealed classes
    switch (result) {
      case ApiSuccess(:final data, :final statusCode):
        print('  [STATUS: $statusCode OK] User Profile successfully fetched and parsed:');
        data.displayDetails();

      case ApiEmpty(:final message):
        print('  [STATUS: 404 EMPTY] No Data Available.');
        print('  Notice: $message');

      case ApiError(:final errorMessage, :final statusCode):
        print('  [STATUS: ${statusCode ?? "ERROR"}] Request Failed Gracefully!');
        print('  Error Message: $errorMessage');
    }
  }
}
