import 'package:food_app_project/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final List<GlobalKey<_AnimatedContentState>> _animationKeys = 
    List.generate(4, (_) => GlobalKey<_AnimatedContentState>());

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: bgColIntro,
      pages: [
        _buildAnimatedPage(
          'Crypto Trading - Made Easy',
          'Trade smarter, not harder.',
          "assets/utilities/intro_img1.png",
          _animationKeys[0],
        ),
        _buildAnimatedPage(
          'Encrypted',
          'Your data, your control.',
          "assets/utilities/intro_img2.png",
          _animationKeys[1],
        ),
        _buildAnimatedPage(
          '24/7 Customer Support',
          'Your support, our priority, 24/7.',
          "assets/utilities/intro_img3.png",
          _animationKeys[2],
        ),
        _buildAnimatedPage(
          'Always, Up to Date',
          'Up-to-date, every day.',
          "assets/utilities/intro_img4.png",
          _animationKeys[3],
        ),
      ],
      showDoneButton: true,
      done: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Done', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: textCol1)),
          const SizedBox(width: 5),
          Icon(Icons.check, size: 22, color: textCol1),
        ],
      ),
      onDone: () {
        Get.offNamed('/splash', arguments: 2);
      },
      onSkip: () {
        Get.offNamed('/splash', arguments: 2);
      },
      showNextButton: true,
      next: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Next', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: textCol1)),
          const SizedBox(width: 5),
          Icon(Icons.arrow_forward_ios_outlined, size: 18, color: textCol1),
        ],
      ),
      showBackButton: true,
      back: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.arrow_back_ios_new_outlined, size: 18, color: textCol1,),
          const SizedBox(width: 5),
          Text('Back', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: textCol1)),
        ],
      ),
      onChange: (index) {
        _animationKeys[index].currentState?.restartAnimation();
      },
      curve: Curves.easeInOut,
      dotsDecorator: DotsDecorator(
        color: dotCol1.withOpacity(0.25),
        activeColor: dotCol1,
      ),
    );
  }

  PageViewModel _buildAnimatedPage(String title, String body, String imagePath, GlobalKey<_AnimatedContentState> key) {
    return PageViewModel(
      titleWidget: _AnimatedContent(
        key: key,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            title,
            style: TextStyle(
              color: textCol2,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      image: _AnimatedContent(
        child: Material(
          color: Colors.transparent,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 225,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
      ),
      bodyWidget: _AnimatedContent(
        child: Text(
          body,
          style: TextStyle(
            color: textCol2,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      decoration: const PageDecoration(
        imageFlex: 5,
        bodyFlex: 1,
        imagePadding: EdgeInsets.only(bottom: 0),
        titlePadding: EdgeInsets.only(bottom: 0),
      ),
    );
  }
}

class _AnimatedContent extends StatefulWidget {
  final Widget child;

  const _AnimatedContent({Key? key, required this.child}) : super(key: key);

  @override
  _AnimatedContentState createState() => _AnimatedContentState();
}

class _AnimatedContentState extends State<_AnimatedContent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  void restartAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.only(top: _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
