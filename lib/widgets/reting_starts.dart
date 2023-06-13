import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;
  const RatingStars(this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String starts = '';
    for (int i = 0; i < rating; i++) {
      starts += '⭐  ';
    }
    starts.trim();
    return Text(
      starts,
      style: const TextStyle(
        fontSize: 16.0,
      ),
    );
  }
}
