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
                          widget.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//   Widget build(BuildContext context) {
//     return Column(
//       children: [  
//       MouseRegion(
//           onEnter: (_) {
//             setState(() {
//               _isHovered = true;
//             });
//           },
//           onExit: (_) {
//             setState(() {
//               _isHovered = false;
//             });
//           },
//           child: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Recipe(widget.title),
//                 ),
//               );
//             },
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: _isHovered ? Colors.blue : Colors.black,
//                   width: 3.0,
//                 ),
//                 boxShadow: _isHovered
//                     ? [
//                         BoxShadow(
//                           color: Colors.blue.withOpacity(0.5),
//                           blurRadius: 10,
//                           spreadRadius: 2,
//                         )
//                       ]
//                     : [],
//               ),
//                child: Transform.scale(
//                 scale: _isHovered ? 1.05 : 1.0,
//               child: Image.network(
//                 widget.img,
//                 width: 300,
//                 fit: BoxFit.cover,
//               ),
//                ),
//             ),
//           ),
//         ),
//       Padding(padding:  EdgeInsets.all(16),
//       child:

//       Text (widget.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,)),),
     
      
      
//       ],

      

//     );
//   }
// }