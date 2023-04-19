
import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  late Duration duration;
  late bool? isAnimating;
  late bool smallLike;
  late Widget? toWhichAnimationWillPerform;
  late VoidCallback? animationonEndFuncion;

   LikeAnimation({super.key, this.duration = const Duration(microseconds: 5000),
   this.smallLike = false, this.isAnimating, this.toWhichAnimationWillPerform,
   this.animationonEndFuncion});

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin {
  late Animation<double> scaleAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: widget.duration );
    scaleAnimation = Tween(begin: 1.0, end: 3.0).animate(animationController);

 // animationController = AnimationController(vsync: this, duration: Duration(microseconds: 5000));
    // animation = Tween(begin: 4.0, end: 100).animate(animationController);

    // animationController.addListener(() {
    //   print(animation.value);
      
    // });

    // animationController.forward();


  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
   
    super.didUpdateWidget(oldWidget);
    if(widget.isAnimating!=oldWidget.isAnimating){
      startAnimateOurWidget();
      


    }

    
  }
  startAnimateOurWidget()async{
    await animationController.forward(); 
    //animation srart gari agadi badauxa
   // await animationController.reverse();
    await Future.delayed(Duration(microseconds: 5000));

   //to end animation
   if(widget.animationonEndFuncion!=null){
    widget.animationonEndFuncion!();
   }

  }

  
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: widget.toWhichAnimationWillPerform,

    );
  }
}