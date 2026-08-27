abstract class Item {
  String id;
  String title;
  bool isBorrowed;

  Item({
    required this.id,
    required this.title,
    this.isBorrowed = false,
  });

  void displayInfo();
}
