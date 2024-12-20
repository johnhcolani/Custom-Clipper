import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
          title: const Text('Sharper Clipper Shape with Shimmer'),
        ),
        body: Stack(
          children: [
            // Background car image
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Positioned.fill(
                  child: Image.asset(
                    'assets/car_image.jpg', // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // ClipPath with shimmer effect and opacity
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipPath(
                  clipper: CombinedSinusoidalClipper(),
                  child: Opacity(
                    opacity: 0.8, // Adjust the opacity of the clipped area
                    child: Shimmer.fromColors(
                      baseColor: Colors.transparent, // Base color of the shimmer
                      highlightColor: Color(0x7b0937ec),
                      period: const Duration(seconds: 5), // Speed of the shimmer effect
                      child: Container(
                        width: 500, // Adjust as needed
                        height: 50, // Adjust as needed
                        color: Color(0x7b0937ec), // Fallback color for the shimmer
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: CombinedSinusoidalClipper(),
                  child: Opacity(
                    opacity: 0.8, // Adjust the opacity of the clipped area
                    child: Shimmer.fromColors(
                      baseColor: Colors.transparent, // Base color of the shimmer
                      highlightColor: Colors.blue, //
                      period: const Duration(seconds: 2), // Speed of the shimmer effect
                      child: Container(
                        width: 500, // Adjust as needed
                        height: 50, // Adjust as needed
                        color: Colors.blue, // Fallback color for the shimmer
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: CombinedSinusoidalClipper(),
                  child: Opacity(
                    opacity: 0.8, // Adjust the opacity of the clipped area
                    child: Shimmer.fromColors(
                      baseColor: Colors.transparent, // Base color of the shimmer
                      highlightColor: Colors.blue, // Highlight shimmer color
                      period: const Duration(seconds: 5), // Speed of the shimmer effect
                      child: Container(
                        width: 500, // Adjust as needed
                        height: 50, // Adjust as needed
                        color: Colors.blue, // Fallback color for the shimmer
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CombinedSinusoidalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double width = size.width;
    final double height = size.height;

    // Define heights for different sections
    double thinHeight = height / 4; // Smaller amplitude for the thin start
    double thickHeight = height / 2; // Larger amplitude for the thick middle
    double bottomCurveDepth = height / 6; // Depth of the concave bottom curve

    Path path = Path();

    // Start at the bottom-left corner
    path.moveTo(0, height - bottomCurveDepth); // (0, height - bottomCurveDepth)

    // First curve (left-to-right): Smooth rise with smaller height
    path.quadraticBezierTo(
      width * 0.125, // Control point x
      height - thinHeight - bottomCurveDepth, // Control point y
      width * 0.25, // End point x
      height - thickHeight - bottomCurveDepth, // End point y
    );

    // Second curve (middle): Smooth thick curve
    path.quadraticBezierTo(
      width * 0.5, // Control point x
      height - thickHeight * 1.5 - bottomCurveDepth, // Control point y (higher amplitude)
      width * 0.75, // End point x
      height - thickHeight - bottomCurveDepth, // End point y
    );

    // Third curve (right-to-left): Smooth descent with smaller height
    path.quadraticBezierTo(
      width * 0.875, // Control point x
      height - thinHeight - bottomCurveDepth, // Control point y
      width, // End point x
      height - bottomCurveDepth, // End point y
    );

    // Add the concave bottom curve
    path.quadraticBezierTo(
      width * 0.5, // Control point x (middle of the screen)
      height - bottomCurveDepth * 7.5, // Control point y (higher for concave effect)
      0, // End point x (back to the left)
      height - bottomCurveDepth, // End point y
    );

    path.close(); // Close the path to ensure a filled shape

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
