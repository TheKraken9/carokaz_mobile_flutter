import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

  class _LoginState extends State<Login> with TickerProviderStateMixin {
    late final AnimationController _controller;

    @override
    void initState() {
      super.initState();
      _controller = AnimationController(vsync: this);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.blue,
                Colors.blueAccent,
                Colors.blue[200]!,
                Colors.blue[100]!,
                Colors.blue[50]!
              ]
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Lottie.asset('assets/animations/Animation4.json',
                controller: _controller, onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    });
                },
              ),
              Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        //borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          const Text("Login", style: TextStyle(color: Colors.blue, fontSize: 40, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 30,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                                  ),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      hintText: "Email or Phone number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                                  ),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40,),
                          const Text("Forgot Password?", style: TextStyle(color: Colors.grey),),
                          const SizedBox(height: 40,),
                          Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue[900]
                            ),
                            child: const Center(
                              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          const Text("Continue with social media", style: TextStyle(color: Colors.grey),),
                          const SizedBox(height: 30,),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.blue[200]
                                  ),
                                  child: const Center(
                                    child: Text("Gmail", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30,),
                              Expanded(
                                  child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.black
                                      ),
                                      child: const Center(
                                        child: Text("Facebook", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      )
                                  ),
                              )
                            ]
                          )
                        ],
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      );
    }
  }