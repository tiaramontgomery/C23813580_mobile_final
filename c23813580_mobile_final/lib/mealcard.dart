import 'package:flutter/material.dart';
import 'recipe.dart';


class Mealcard extends StatefulWidget {
  final String img;
  final String title;
  final double opacity;
  const Mealcard(this.img, this.title, {this.opacity = 1.0, super.key});

  @override
  State<Mealcard> createState() => _MealcardState();
}

class _MealcardState extends State<Mealcard> {
  bool _isHovered = false;

  @override
 Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.opacity,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Recipe(widget.title),
              ),
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: (_isHovered
    ? (Matrix4.identity()..translate(0, -8, 0)..scale(1.03))
    : Matrix4.identity()),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(12),
            child: Card(
              elevation: _isHovered ? 10 : 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: 1500,
                height: 250,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.img,
                          width: 150,
                          fit: BoxFit.cover,
                         
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          wid