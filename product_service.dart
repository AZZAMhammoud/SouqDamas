import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/category.dart';

class ProductService extends ChangeNotifier {
  List<Product> _products = [];
  List<Category> _categories = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String? _selectedCategoryId;

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String? get selectedCategoryId => _selectedCategoryId;

  List<Product> get filteredProducts {
    var filtered = _products;

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((product) =>
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    if (_selectedCategoryId != null) {
      filtered = filtered.where((product) => product.categoryId == _selectedCategoryId).toList();
    }

    return filtered;
  }

  List<Product> getFeaturedProducts() {
    return _products.where((product) => product.isFeatured).toList();
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock data for demo
      _products = [
        Product(
          id: '1',
          name: 'سجادة دمشقية أصيلة',
          description: 'سجادة يدوية الصنع من الحرير الطبيعي بتصاميم دمشقية تراثية',
          price: 250000,
          imageUrl: 'assets/images/carpet.jpg',
          categoryId: '1',
          isFeatured: true,
          rating: 4.8,
          reviewCount: 25,
          stock: 5,
        ),
        Product(
          id: '2',
          name: 'عود شامي فاخر',
          description: 'عود طبيعي من أجود أنواع الخشب الشامي برائحة عطرة',
          price: 180000,
          imageUrl: 'assets/images/oud.jpg',
          categoryId: '2',
          isFeatured: true,
          rating: 4.9,
          reviewCount: 18,
          stock: 12,
        ),
        Product(
          id: '3',
          name: 'حلقوم دمشقي بالفستق',
          description: 'حلقوم طبيعي محضر بالطريقة التقليدية مع الفستق الحلبي',
          price: 120000,
          imageUrl: 'assets/images/halawat.jpg',
          categoryId: '3',
          isFeatured: true,
          rating: 4.7,
          reviewCount: 42,
          stock: 20,
        ),
        Product(
          id: '4',
          name: 'صندوق خشبي مطعم بالصدف',
          description: 'صندوق خشبي مصنوع يدوياً ومطعم بالصدف بنقوش دمشقية',
          price: 300000,
          imageUrl: 'assets/images/box.jpg',
          categoryId: '1',
          isFeatured: false,
          rating: 4.6,
          reviewCount: 15,
          stock: 8,
        ),
        Product(
          id: '5',
          name: 'زيت الياسمين الدمشقي',
          description: 'زيت عطري طبيعي من زهور الياسمين الدمشقي الأصيل',
          price: 85000,
          imageUrl: 'assets/images/jasmine_oil.jpg',
          categoryId: '2',
          isFeatured: false,
          rating: 4.5,
          reviewCount: 33,
          stock: 15,
        ),
        Product(
          id: '6',
          name: 'معمول بالتمر والجوز',
          description: 'معمول شامي تقليدي محشو بالتمر والجوز المفروم',
          price: 95000,
          imageUrl: 'assets/images/maamoul.jpg',
          categoryId: '3',
          isFeatured: true,
          rating: 4.8,
          reviewCount: 28,
          stock: 25,
        ),
      ];

      _categories = [
        Category(
          id: '1',
          name: 'الحرف اليدوية',
          description: 'منتجات حرفية تراثية مصنوعة يدوياً',
          iconUrl: 'assets/icons/handicrafts.png',
        ),
        Category(
          id: '2',
          name: 'العطور والبخور',
          description: 'عطور ومواد عطرية طبيعية',
          iconUrl: 'assets/icons/perfumes.png',
        ),
        Category(
          id: '3',
          name: 'الحلويات الشامية',
          description: 'حلويات تراثية دمشقية أصيلة',
          iconUrl: 'assets/icons/sweets.png',
        ),
        Category(
          id: '4',
          name: 'الملابس التراثية',
          description: 'ملابس تقليدية وتراثية',
          iconUrl: 'assets/icons/clothes.png',
        ),
        Category(
          id: '5',
          name: 'المجوهرات',
          description: 'مجوهرات وإكسسوارات تراثية',
          iconUrl: 'assets/icons/jewelry.png',
        ),
      ];

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchProducts(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void filterByCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategoryId = null;
    notifyListeners();
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  Category? getCategoryById(String id) {
    try {
      return _categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Product> getProductsByCategory(String categoryId) {
    return _products.where((product) => product.categoryId == categoryId).toList();
  }
}

