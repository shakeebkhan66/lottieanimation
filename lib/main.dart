
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lottie Animation',
      home: LottieAnimation(),
    );
  }
}

class LottieAnimation extends StatefulWidget {
  const LottieAnimation({Key? key}) : super(key: key);

  @override
  _LottieAnimationState createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 2), vsync: this);

    // To Hide the done.lottie msg and coming back we'll use this code
    _controller.addStatusListener((status) async{
      if(status == AnimationStatus.completed){
        Navigator.pop(context);
        // for resetting animation
        _controller.reset();
      }
    });
  }

 
  

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  void showDoneDialog() => showDialog(
    barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
                "assets/done.json",
                repeat: false,
                controller: _controller,
            // to start the animation we'll use this code
              onLoaded: (composition){
                  _controller.forward();
              }
            ),
            Text("Enjoy Your Order",
            style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 16),
          ],
        ),
      )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lottie Animations"),
        centerTitle: true,
      ),
      body: Center(
        // child: Lottie.network(
        //     "https://assets2.lottiefiles.com/packages/lf20_4pbyzxfg.json",
        // animate: true,
        // ),
        child: Column(
          children: [
            Lottie.asset(
              "assets/lot.json",
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 15),
                textStyle: TextStyle(fontSize: 20),
              ),
                onPressed: showDoneDialog,
                icon: Icon(Icons.delivery_dining,size: 40),
                label: Text("Order Burger"),
            ),
          ],
        )
      ),
    );
  }
}

