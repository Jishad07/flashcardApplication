// import 'package:flutter/material.dart';

// // Step 1: Create a Custom Clipper for the curved shape
// class CurvedAppBarClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, 0);  // Start from the top-left corner
//     path.quadraticBezierTo(
//       size.width / 2, // Control point X
//       size.height / 1, // Control point Y (height control for curve)
//       size.width, // End X (right edge)
//       0, // End Y (same height as the top)
//     );
//     path.lineTo(size.width, size.height);  // Bottom right corner
//     path.lineTo(0, size.height);  // Bottom left corner
//     path.close();  // Close the path
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false; // We don't need to reclip as the shape does not change
//   }
// }


// import 'package:flutter/material.dart';

// // Step 1: Custom Clipper for Curved Bottom of the AppBar
// class FlashCardAppBarClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, 0);  // Start from the top-left corner
//     path.lineTo(size.width, 0); // Top right corner
//     path.quadraticBezierTo(
//       size.width / 2, size.height / 2, 0, size.height // Draw a curve
//     );
//     path.close(); // Close the path
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }



import 'package:flutter/material.dart';

// Custom Clipper for Bottom Rounded AppBar
class BottomRoundedAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    
    // Start at the top-left corner
    path.lineTo(0, 0);
    
    // Draw a straight line to the top-right corner
    path.lineTo(size.width, 0);
    
    // Create a rounded bottom (half-circle shape)
    path.lineTo(size.width, size.height - 30);  // Move down before starting the curve
    path.quadraticBezierTo(
      size.width / 2, size.height + 30, 0, size.height - 30); // Half circle curve
    
    // Close the path
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // No need to reclip since the shape doesn't change dynamically
  }
}

// import 'package:flutter/material.dart';

// // class AppBar extends StatelessWidget {
// //   const AppBar({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 20,
// //       width: double.infinity,
// //       color: Colors.amber,
// //     );
// //   }
// // }