import 'item.dart';

class Member {
  String memberId;
  String name;
  List<Item> borrowedItems = [];

  Member({
    required this.memberId,
    required this.name,
  });

  void showBorrowedItems() {
    print('Borrowed items for $name ($memberId):');
    if (borrowedItems.isEmpty) {
      print('  No items currently borrowed.');
      return;
    }
    for (Item item in borrowedItems) {
      print('  - ${item.title} (ID: ${item.id})');
    }
  }
}
