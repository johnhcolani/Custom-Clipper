import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sharper Clipper Shape Example'),
        ),
        body: Center(
          child: ClipPath(
            clipper: CustomMenuClipper2(),
            child: Container(
              width: 300, // Adjust as needed

              height: 50, // Adjust as needed

              color: Colors.blue,


            ),
          ),
        ),
      ),
    );
  }
}
class CustomMenuClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double width = size.width; // Width of the container
    final double height = size.height; // Height of the container

    Path path = Path();

    // Start at the bottom-left corner
    path.moveTo(0, height); // (0, height)

    // First curve: sharp rise to a quarter of the width
    path.quadraticBezierTo(
      width * 0.125,  // Control point x = width / 8
      height,         // Control point y = height
      width * 0.25,   // End point x = width / 4
      height * 0.666, // End point y = height / 1.5
    );

    // Second curve: reach the middle-top point
    path.quadraticBezierTo(
      width * 0.5,    // Control point x = width / 2
      0,             // Control point y = 0 (top of the curve)
      width * 0.75,   // End point x = 3 * width / 4
      height * 0.666, // End point y = height / 1.5
    );

    // Third curve: sharp descent to three-quarters of the width
    path.quadraticBezierTo(
      width * 0.875,  // Control point x = 7 * width / 8
      height,         // Control point y = height
      width,          // End point x = width
      height,         // End point y = height
    );

    // Return the constructed path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}




// class CustomMenuClipper2 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final double width = size.width; // Width of the container
//     final double height = size.height; // Height of the container
//
//     Path path = Path();
//
//     // Start at the bottom-right corner
//     path.moveTo(width, height); // (width, height)
//
//     // First curve: sharp descent to three-quarters of the width
//     path.quadraticBezierTo(
//       width * 0.875,  // Control point x = 7 * width / 8
//       height,         // Control point y = height
//       width * 0.75,   // End point x = 3 * width / 4
//       height * 0.666, // End point y = height / 1.5
//     );
//
//     // Second curve: reach the middle-top point
//     path.quadraticBezierTo(
//       width * 0.5,    // Control point x = width / 2
//       0,              // Control point y = 0 (top of the curve)
//       width * 0.25,   // End point x = width / 4
//       height * 0.666, // End point y = height / 1.5
//     );
//
//     // Third curve: sharp rise to the bottom-left corner
//     path.quadraticBezierTo(
//       width * 0.125,  // Control point x = width / 8
//       height,         // Control point y = height
//       0,              // End point x = 0
//       height,         // End point y = height
//     );
//
//     // Return the constructed path
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }


