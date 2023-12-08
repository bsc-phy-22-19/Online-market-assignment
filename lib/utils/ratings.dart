import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;

  StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating) {
          return const Icon(Icons.star, color: Colors.yellow);
        } else {
          return const Icon(Icons.star_border, color: Colors.grey);
        }
      }),
    );
  }
}


class StarRatingFeedback extends StatefulWidget {
  final int rating;

  StarRatingFeedback({required this.rating});

  @override
  _StarRatingFeedbackState createState() => _StarRatingFeedbackState();
}

class _StarRatingFeedbackState extends State<StarRatingFeedback> {
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    _rating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index < _rating) {
          return IconButton(
            icon: Icon(Icons.star),
            color: Colors.yellow,
            onPressed: () {
              setState(() {
                _rating = index + 1;
                print('Rating: $_rating');
              });
            },
          );
        } else {
          return IconButton(
            icon: Icon(Icons.star_border),
            color: Colors.grey,
            onPressed: () {
              setState(() {
                _rating = index + 1;
                print('Rating: $_rating');
              });
            },
          );
        }
      }),
    );
  }
}

