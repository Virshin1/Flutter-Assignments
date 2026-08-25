import 'book.dart';
import 'magazine.dart';
import 'member.dart';
import 'item.dart';
import 'library.dart';
import 'fee_calculator.dart';

void runLibrarySystem() {
  final library = Library('Central City Library');

  library.addItem(Book(
    id: 'B101',
    title: 'Clean Code',
    author: 'Robert C. Martin',
    pages: 464,
    genre: 'Software Engineering',
  ));

  library.addItem(Book(
    id: 'B102',
    title: 'The Pragmatic Programmer',
    author: 'Andrew Hunt & David Thomas',
    pages: 352,
    genre: 'Programming',
  ));

  library.addItem(Magazine(
    id: 'M201',
    title: 'National Geographic',
    issueNumber: 840,
    publishMonth: 'August 2026',
  ));

  final member1 = Member(memberId: 'MEM01', name: 'Alice');
  final member2 = Member(memberId: 'MEM02', name: 'Bob');
  library.registerMember(member1);
  library.registerMember(member2);

  library.displayInventory();

  print('\n>>> BORROWING ITEMS <<<');
  library.borrowItem(itemId: 'B101', memberId: 'MEM01');
  library.borrowItem(itemId: 'M201', memberId: 'MEM02');
  library.borrowItem(itemId: 'B101', memberId: 'MEM02');

  print('\n>>> MEMBER STATUS <<<');
  member1.showBorrowedItems();
  member2.showBorrowedItems();

  print('\n>>> SEARCHING FOR "Programmer" <<<');
  List<Item> searchResults = library.searchItems('Programmer');
  for (Item item in searchResults) {
    item.displayInfo();
  }

  print('\n>>> RETURNING ITEM & CALCULATING OVERDUE FEE <<<');
  library.returnItem(itemId: 'B101', memberId: 'MEM01');

  int daysOverdue = 4;
  double fee = calculateLateFee(daysLate: daysOverdue, dailyRate: 1.50);
  print('Overdue fee for $daysOverdue days late: \$$fee');

  library.displayInventory();
}

void main() {
  runLibrarySystem();
}
