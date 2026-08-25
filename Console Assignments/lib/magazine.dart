import 'item.dart';

class Magazine extends Item {
  int issueNumber;
  String publishMonth;

  Magazine({
    required super.id,
    required super.title,
    required this.issueNumber,
    required this.publishMonth,
    super.isBorrowed,
  });

  @override
  void displayInfo() {
    String status = isBorrowed ? 'Borrowed' : 'Available';
    print('[Magazine] $id: "$title" (Issue #$issueNumber, $publishMonth) - $status');
  }
}
