# 🛍️ ProductStore — Dynamic Product Listing with Search, Filter & Cart

**Author**: R Virshin Kumar  
**Registration Number**: 150096724147  
**Workspace**: `Cross-App / Assignments / product_app`  
**Git Branch**: `assignment_6`  
**Framework**: Flutter SDK (Channel Stable 3.47.0, Dart 3.13.0)  
**Architecture**: Component-Driven Layered Architecture with `StatefulWidget` & `setState`  

---

A production-grade, intermediate-level Flutter application demonstrating dynamic catalog virtualization using `ListView.builder`, an object-oriented domain model (`Product` & `CartItem`), and multi-criteria reactive search and filtering functionality managed explicitly through `setState()`.

---

## 🚀 Key Features

### 1. Dynamic List Virtualization (`ListView.builder`)
- **Memory-Efficient Rendering**: Employs Flutter's virtualized scroll window to lazily instantiate, layout, and recycle product tiles on-demand.
- **Stable Identity Tracking**: Uses `ValueKey(product.id)` on each card for consistent identity preservation across filter updates, sorting reorders, and state mutations.

### 2. Comprehensive Domain Data Modeling
- **Dart 3 Features**: Enums with pattern-matching switch expressions (`ProductCategory`, `ProductSortOption`) encapsulating display labels, vector icons, and theme colors.
- **Computed Getters**:
  - `formattedPrice`: Clean currency formatting (`$199.99`).
  - `formattedOriginalPrice`: Null-safe original price string (`$249.99`).
  - `hasDiscount` & `discountPercentage`: Computed markdown savings percentage (`-20%`).
  - `stockStatus` & `stockColor`: Dynamic inventory badges (`In Stock`, `Only 4 left`, `Out of Stock`).
- **Immutable State Handling**: `copyWith()` method for non-destructive state duplication.

### 3. Reactive Search & Multi-Criteria Filtering via `setState()`
- **Real-Time Substring Search**: Instant query matching against product titles, brand names, technical descriptions, and tag arrays.
- **Horizontal Category Selector**: Scrollable category pill chips with vector icons and dynamically calculated product count badges.
- **Sort & Filter Modal Sheet**: Slide-up sheet allowing users to sort by **Featured**, **Price: Low to High**, **Price: High to Low**, and **Top Rated**, alongside an **In Stock Only** availability toggle.
- **Empty State with One-Tap Reset**: Contextual fallback view displaying search feedback and a single-tap "Reset All Filters" CTA.

### 4. Interactive Shopping Cart System
- **Real-Time Cart Badge**: Displays dynamic line-item count in the AppBar.
- **Slide-Up Cart Modal Sheet (`CartSheet`)**:
  - Itemized display of products with photo thumbnails, brand, title, unit price, and subtotal.
  - **Quantity Stepper Controls** (`[-] [qty] [+]`) with automatic item removal when quantity reaches zero.
  - Line-item delete button for instant removal.
  - Financial summary breakdown: Subtotal, Shipping (`FREE`), and Grand Total.
  - **Checkout Action**: Places the order, resets cart state, and displays celebratory confirmation feedback.
  - **Empty Cart State**: Visual fallback state with "Start Shopping" button.

### 5. Curated Design Tokens (`AppPalette`)
- Aligns with the workspace design system established in `dashboard/` and `todo_app/`.
- Slate surface neutrals (`#F8FAFC`, `#FFFFFF`, `#E2E8F0`), Rich Indigo accent (`#4F46E5`), Ocean Teal (`#0D9488`), Amber (`#F59E0B`), and Coral Red (`#EF4444`).

---

## 📁 Project Structure

```
product_app/
├── README.md                           # Public overview, features, and quickstart guide
├── DOCUMENTATION.pdf                   # Formatted 8-page PDF technical report (excluding screenshots)
├── DOCUMENTATION.docx                  # Formatted Microsoft Word report with tables & styled callouts
├── DOCUMENTATION.md                    # Comprehensive technical documentation (2,200+ words)
├── pubspec.yaml                        # Flutter package dependencies and configuration
├── lib/
│   ├── main.dart                       # App entrypoint and Material 3 theme configuration
│   ├── constants/
│   │   └── app_palette.dart            # Design tokens, semantic colors, and shadow styles
│   ├── models/
│   │   ├── product.dart                # Product domain entity, categories, and sort options
│   │   └── cart_item.dart              # Shopping cart line item model with computed subtotal
│   ├── widgets/
│   │   ├── product_card.dart           # Virtualized list item with photo, badges, rating, and CTA
│   │   ├── search_filter_header.dart   # Search field with clear button and filter modal trigger
│   │   ├── category_selector.dart      # Horizontally scrollable category pills with count badges
│   │   ├── filter_modal_sheet.dart     # Bottom sheet modal for sorting criteria & availability
│   │   ├── product_detail_sheet.dart   # Modal sheet displaying full product specs and CTA
│   │   ├── cart_sheet.dart             # Interactive slide-up cart with quantity stepper & checkout
│   │   └── empty_state_view.dart       # Responsive fallback view when search yields zero results
│   └── screens/
│       └── product_list_screen.dart    # Master stateful coordinator managing setState lifecycle
└── test/
    └── widget_test.dart                # Automated component, search, filter, and cart integration tests
```

---

## 🧪 Testing & Verification

The project includes an automated test suite verifying all primary user journeys and state transitions:

```bash
# Run automated widget & integration tests
flutter test

# Run static analysis
dart analyze
```

### Verified Test Cases:
1. ✅ **Initial Catalog Rendering**: Confirms app bar title, search input, category chips, and product cards render properly.
2. ✅ **Real-Time Text Search**: Verifies typing `"Headphones"` isolates the matching item, and clear button restores the catalog.
3. ✅ **Category Selection**: Verifies tapping `'Electronics'` filters catalog down strictly to electronics products.
4. ✅ **Favorite Toggle**: Tests heart icon tap, verifying state mutation via `setState` and SnackBar alert.
5. ✅ **Empty State & Reset**: Confirms non-matching query triggers `EmptyStateView`, and tapping "Reset All Filters" restores items.
6. ✅ **Shopping Cart Flow**: Verifies adding items updates the badge, opening `CartSheet` renders line items with steppers, and calculates free shipping and checkout total.
7. ✅ **Static Analysis**: `dart analyze` passes with 0 errors and 0 warnings.

---

## 🏃 Running Locally

```bash
# Navigate to project directory
cd Assignments/product_app

# Run on Chrome (web)
flutter run -d chrome

# Or run on macOS Desktop (requires Xcode CLI tools)
flutter run -d macos
```

### Interactive Hot Reload / Restart:
- Press **`r`** to Hot Reload changes.
- Press **`R`** to Hot Restart the application state.
- Press **`q`** to quit the session.
