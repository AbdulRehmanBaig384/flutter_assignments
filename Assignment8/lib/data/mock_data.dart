import '../models/models.dart';

// Mock Products
const List<Product> mockProducts = [
  Product(
    id: '1',
    title: 'Fundamentals of Algorithms',
    category: 'Computer Science Dept.',
    price: 45.00,
    condition: 'LIKE NEW',
    imageUrl: 'books',
  ),
  Product(
    id: '2',
    title: 'MacBook Pro 14" M1',
    category: 'Tech & Gadgets',
    price: 850.00,
    condition: '2022 MODEL',
    imageUrl: 'laptop',
  ),
  Product(
    id: '3',
    title: 'Modern Sociology Vol. 1',
    category: 'Social Sciences',
    price: 25.00,
    condition: 'ANNOTATED',
    imageUrl: 'books2',
  ),
  Product(
    id: '4',
    title: 'Mechanical Keyboard',
    category: 'Accessories',
    price: 65.00,
    condition: 'WIRELESS',
    imageUrl: 'keyboard',
  ),
  Product(
    id: '5',
    title: 'Smartwatch Series 6',
    category: 'Wearables',
    price: 120.00,
    condition: 'UNBOXED',
    imageUrl: 'watch',
  ),
  Product(
    id: '6',
    title: 'Graphing Calculator',
    category: 'Math',
    price: 15.00,
    condition: 'ESSENTIAL',
    imageUrl: 'calculator',
  ),
];

// Mock News Items
const List<NewsItem> mockNews = [
  NewsItem(
    id: '1',
    title: 'New Research Grant Awarded to Engineering Faculty',
    category: 'ACADEMIC',
    description:
        'The \$2.4M grant will fund sustainable energy initiatives across the campus for t...',
    imageUrl: 'building',
    isFeatured: true,
  ),
  NewsItem(
    id: '2',
    title: 'Registration for Fall ...',
    category: 'ADMIN',
    description: 'Check your enrollment window in the portal.',
    imageUrl: 'registration',
  ),
  NewsItem(
    id: '3',
    title: 'Annual Career Fair: 5...',
    category: 'EVENTS',
    description: 'Prepare your digital portfolio for next Tuesday.',
    imageUrl: 'career',
  ),
  NewsItem(
    id: '4',
    title: 'AI & Ethics Worksho...',
    category: 'WORKSHOP',
    description: 'Join the philosophy and tech departments this Friday.',
    imageUrl: 'ai',
  ),
];

// Filter chips for marketplace
const List<String> marketplaceFilters = [
  'All Items',
  'Textbooks',
  'Laptops',
  'Electronics',
  'Furniture',
  'Notes',
];

// Departments
const List<String> departments = [
  'Computer Science & Engineering',
  'Electrical Engineering',
  'Mechanical Engineering',
  'Business Administration',
  'Social Sciences',
  'Mathematics',
  'Physics',
  'Chemistry',
];
