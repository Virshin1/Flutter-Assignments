class Item {
  String title;
  bool isBorrowed;

  Item(this.title, {this.isBorrowed = false});

  void displayInfo() {
    print('Title: $title | Borrowed: $isBorrowed');
  }
}

class Book extends Item {
  String author;
  int pages;

  Book(String title, this.author, this.pages) : super(title);

  @override
  void displayInfo() {
    String status = isBorrowed ? 'Already Borrowed' : 'Available';
    print('Book: "$title" by $author ($pages pages) -> Status: $status');
  }
}

class Library {
  String libraryName;
  List<Book> books = [];

  Library(this.libraryName);

  void addBook(Book book) {
    books.add(book);
    print('Added: "${book.title}" to $libraryName');
  }

  void showAllBooks() {
    print('\n--- All Books in $libraryName ---');
    for (int i = 0; i < books.length; i++) {
      String status = books[i].isBorrowed ? 'Already Borrowed' : 'Available';
      print('${i + 1}. "${books[i].title}" by ${books[i].author} (${books[i].pages} pages) -> Status: $status');
    }
  }

  void borrowBook(String bookTitle) {
    bool found = false;
    for (Book book in books) {
      if (book.title.toLowerCase() == bookTitle.toLowerCase()) {
        found = true;
        if (book.isBorrowed) {
          print('\nSorry, "${book.title}" is already borrowed.');
        } else {
          book.isBorrowed = true;
          print('\nSuccess: You borrowed "${book.title}".');
        }
        break;
      }
    }

    if (!found) {
      print('\nBook "$bookTitle" was not found in the library.');
    }
  }
}

double calculateLateFee(int daysLate) {
  double ratePerDay = 2.0;
  return daysLate * ratePerDay;
}

void main() {
  print('=== Welcome to the Simple Library System ===\n');

  String studentName = 'Alex';
  int daysLate = 3;
  double fee = calculateLateFee(daysLate);

  print('Student Name: $studentName');
  print('Late Days: $daysLate, Total Fee: \$$fee\n');

  Library myLibrary = Library('City Library');

  Book book1 = Book('Harry Potter', 'J.K. Rowling', 350);
  Book book2 = Book('The Hobbit', 'J.R.R. Tolkien', 310);
  Book book3 = Book('Dart Basics', 'Google', 120);

  myLibrary.addBook(book1);
  myLibrary.addBook(book2);
  myLibrary.addBook(book3);

  myLibrary.showAllBooks();

  myLibrary.borrowBook('Harry Potter');
  myLibrary.borrowBook('Harry Potter');

  myLibrary.showAllBooks();

  print('\n--- Counting down library closing time ---');
  int countdown = 3;
  while (countdown > 0) {
    print('Closing in $countdown minutes...');
    countdown--;
  }
  print('Library is now closed!');
}
