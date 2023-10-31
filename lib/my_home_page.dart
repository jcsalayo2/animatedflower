import 'package:animated_flower/flower_page.dart';
import 'package:animated_flower/hello_bloc/hello_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HelloBloc>(context)
        .add(StartHelloAnimationEvent(text: title));
    return Scaffold(
      floatingActionButton: const NextFloatingButton(
        isNext: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<HelloBloc, HelloState>(
            builder: (context, state) {
              if (state.animateLetters.isNotEmpty) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var (index, item)
                        in title.replaceAll(' ', '').characters.indexed)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.009),
                        child: AnimatedDefaultTextStyle(
                            style: state.animateLetters[index]
                                ? highlighted(context)
                                : notHighlighted(context),
                            duration: const Duration(milliseconds: 1000),
                            child: Text(
                              item,
                              style: const TextStyle(fontFamily: 'Scriptina'),
                            )),
                      ),
                  ],
                );
              } else {
                return Container();
              }
            },
          )
        ],
      )),
    );
  }

  TextStyle notHighlighted(BuildContext context) {
    return TextStyle(
      color: Colors.black,
      fontSize: MediaQuery.of(context).size.width * 0.1,
    );
  }

  TextStyle highlighted(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: MediaQuery.of(context).size.width * 0.1,
    );
  }
}

class NextFloatingButton extends StatelessWidget {
  const NextFloatingButton({
    super.key,
    required this.isNext,
  });

  final bool isNext;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isNext
            ? Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FlowerPage()),
              )
            : Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          shape: BoxShape.circle,
        ),
        height: 75,
        width: 75,
        child: Center(
            child: Icon(
          isNext ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
        )),
      ),
    );
  }
}
