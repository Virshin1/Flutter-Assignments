/// Generic transformation function to transform a list of items of type T to type R
/// Demonstrates generic higher-order functions from Advanced Functions
List<R> applyTransform<T, R>(List<T> items, R Function(T) transformer) {
  List<R> output = [];
  for (var item in items) {
    output.add(transformer(item));
  }
  return output;
}

/// Closure creator that maintains state (call count) for tracking network logs
/// Demonstrates state-capturing closures from Functions / Advanced Functions
void Function(String message) createActivityLogger({String prefix = 'API_LOG'}) {
  int logSequence = 0;
  return (String message) {
    logSequence++;
    print('  [$prefix #$logSequence] $message');
  };
}
