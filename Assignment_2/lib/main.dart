import 'controller.dart';

void main() async {
  final controller = ApiDemoController();
  await controller.runAllScenarios();
}
