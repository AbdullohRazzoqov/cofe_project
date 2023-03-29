import 'package:cofe_project/coffee.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageViewController =
      PageController(viewportFraction: 0.35);
  final PageController pageTextController = PageController();
  double _currentPage = 0.0;
  double _pageText = 0.0;
  void _coffeeScrollListener() {
    setState(() {
      _currentPage = pageViewController.page!;
    });
  }

  void _textScrollListener() {
    _pageText = _currentPage;
  }

  @override
  void initState() {
    pageViewController.addListener(_coffeeScrollListener);
    pageTextController.addListener(_textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.removeListener(_coffeeScrollListener);
    pageTextController.removeListener(_textScrollListener);
    pageTextController.dispose();
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * 0.22,
            height: size.height * 0.3,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 90,
                    spreadRadius: 45,
                  ),
                ],
              ),
            ),
          ),
          Transform.scale(
            scale: 1.5,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              controller: pageViewController,
              onPageChanged: (value) {
                if (value < coffees.length) {
                  pageTextController.animateTo(value.toDouble(),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                }
              },
              itemBuilder: (cxt, index) {
                if (index == 0) {
                  return const SizedBox.shrink();
                }
                final coffee = coffees[index - 1];
                final result = _currentPage - index + 1;
                final value = -0.4 * result + 1;
                final opacity = value.clamp(0.0, 1.0);
                (coffee);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(
                            0.0,
                            MediaQuery.of(context).size.height /
                                2.6 *
                                (1 - value.abs()))
                        ..scale(value),
                      child: Opacity(
                          opacity: opacity,
                          child: Image.asset(coffee.imageUrls))),
                );
              },
              itemCount: coffees.length,
              scrollDirection: Axis.vertical,
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: 100,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: coffees.length,
                    controller: pageTextController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final opacity =
                          1 - (index - _pageText).abs().clamp(0.0, 1.0);
                      return Text(
                        coffees[index].name,
                        style:const TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    coffees[_currentPage.toInt()].price.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 34, fontWeight: FontWeight.w500),
                    key: Key(coffees[_currentPage.toInt()].name),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
