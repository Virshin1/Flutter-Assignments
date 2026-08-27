import 'item.dart';

class Book extends Item {
  String author;
  int pages;
  String genre;

  Book({
    required super.id,
    required super.title,
    required this.author,
    required this.pages,
    required this.genre,
    super.isBorrowed,
  });

  @override
  void displayInfo() {
    String status = isBorrowed ? 'Borrowed' : 'Available';
    print('[Book] $id: "$title" by $author ($pages pages, $genre) - $status');
  }
}
