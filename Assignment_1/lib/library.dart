import 'item.dart';
import 'member.dart';

class Library {
  String libraryName;
  List<Item> items = [];
  Map<String, Member> members = {};

  Library(this.libraryName);

  void addItem(Item item) {
    items.add(item);
  }

  void registerMember(Member member) {
    members[member.memberId] = member;
  }

  void displayInventory() {
    print('\n================ $libraryName INVENTORY ================');
    if (items.isEmpty) {
      print('No items available.');
      return;
    }

    for (int i = 0; i < items.length; i++) {
      items[i].displayInfo();
    }
  }

  bool borrowItem({required String itemId, required String memberId}) {
    Member? member = members[memberId];
    if (member == null) {
      print('Member $memberId not found.');
      return false;
    }

    Item? targetItem;
    int index = 0;
    while (index < items.length) {
      if (items[index].id == itemId) {
        targetItem = items[index];
        break;
      }
      index++;
    }

    if (targetItem == null) {
      print('Item with ID $itemId not found.');
      return false;
    }

    if (targetItem.isBorrowed) {
      print('Item "${targetItem.title}" is already checked out.');
      return false;
    }

    targetItem.isBorrowed = true;
    member.borrowedItems.add(targetItem);
    print('Success: ${member.name} borrowed "${targetItem.title}".');
    return true;
  }

  bool returnItem({required String itemId, required String memberId}) {
    Member? member = members[memberId];
    if (member == null) {
      print('Member $memberId not found.');
      return false;
    }

    Item? targetItem;
    for (Item item in member.borrowedItems) {
      if (item.id == itemId) {
        targetItem = item;
        break;
      }
    }

    if (targetItem == null) {
      print('Member does not have item $itemId.');
      return false;
    }

    targetItem.isBorrowed = false;
    member.borrowedItems.remove(targetItem);
    print('Success: ${member.name} returned "${targetItem.title}".');
    return true;
  }

  List<Item> searchItems(String keyword) {
    List<Item> results = [];
    for (Item item in items) {
      if (item.title.toLowerCase().contains(keyword.toLowerCase())) {
        results.add(item);
      }
    }
    return results;
  }
}
