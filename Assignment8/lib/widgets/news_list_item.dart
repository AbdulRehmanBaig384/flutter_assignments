import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class NewsListItem extends StatelessWidget {
  final NewsItem news;

  const NewsListItem({super.key, required this.news});

  String _getImageURL(String imageUrl) {
    switch (imageUrl) {
      case 'registration':
        return "home2.jpg";
      case 'career':
        return "home3.jpg";
      case 'ai':
        return "home4.jpg";
      default:
        return "home3.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset("assets/images/${_getImageURL(news.imageUrl)}")),
      title: Text(
        news.title,
        style: const TextStyle(
          color: AppTheme.textDark,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          news.description,
          style: const TextStyle(
            color: AppTheme.textMedium,
            fontSize: 13,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: AppTheme.textLight,
      ),
      onTap: () {},
    );
  }
}
