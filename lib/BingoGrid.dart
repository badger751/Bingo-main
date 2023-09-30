import 'package:flutter/material.dart';

class BingoGrid extends StatefulWidget {
  @override
  _BingoGridState createState() => _BingoGridState();
}

class _BingoGridState extends State<BingoGrid>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // Specify the vsync parameter
      duration: Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Add padding to create a gap
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, // 5 columns
          mainAxisSpacing: 10.0, // Vertical spacing between items
          crossAxisSpacing: 10.0, // Horizontal spacing between items
        ),
        itemBuilder: (context, index) {
          if (index < 5) {
            // Display the letters for the first column with the specified text style
            return GridTile(
              child: GestureDetector(
                onTapDown: _tapDown,
                onTapUp: _tapUp,
                child: _buildContainer(
                  'BINGO'[index], // Display B, I, N, G, O
                  _scale,
                  hasBorder: false, // Remove border for letters
                ),
              ),
            );
          } else {
            // Display blank square boxes for the remaining columns with the border color
            return GridTile(
              child: GestureDetector(
                onTapDown: _tapDown,
                onTapUp: _tapUp,
                child: _buildContainer(
                  '', // Blank square
                  _scale,
                  hasBorder: true, // Keep border for blank squares
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildContainer(String text, double scale, {bool hasBorder = true}) {
    return GestureDetector(
      onTapDown: _tapDown, // Added onTapDown handler
      onTapUp: _tapUp, // Added onTapUp handler
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 243, 228, 174),
          border: hasBorder
              ? Border.all(
                  width: 5.0, // Border width
                  color: Color(0xFF7C1717), // Color #7C1717
                )
              : null, // Conditionally add the border
          boxShadow: hasBorder
              ? [
                  BoxShadow(
                    offset: Offset(3, 3), // Adjust the offsets for box shadow
                    blurRadius: 0.0,
                    color: Color(0xFF7C1717), // Box shadow color #7C1717
                  ),
                  BoxShadow(
                    offset:
                        Offset(-10, -10), // Adjust the offsets for box shadow
                    blurRadius: 24.0,
                    color: Color(0x3600004D), // Box shadow color #3600004D
                    spreadRadius: -12.0, // Use negative value for inset
                  ),
                  BoxShadow(
                    offset: Offset(10, 10), // Adjust the offsets for box shadow
                    blurRadius: 20.0,
                    color: Color(0xFFFFFF63), // Box shadow color #FFFFFF63
                    spreadRadius: -10.0, // Use negative value for inset
                  ),
                ]
              : null, // Conditionally add the box shadows
        ),
        child: Center(
          child: ScaleTransition(
            scale: _controller.drive(
              Tween<double>(
                begin: 1.0,
                end: 0.9,
              ).chain(
                CurveTween(curve: Curves.easeInOut), // Apply an easing curve
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Changa One',
                fontSize: 49.0,
                fontWeight: FontWeight.w400,
                height:
                    52.0 / 49.0, // Calculate the line height based on font size
                letterSpacing: 0.0,
                color: Color(0xFF7C1717), // Text color #7C1717
              ),
              textAlign: TextAlign.center, // Apply the text alignment here
            ),
          ),
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
