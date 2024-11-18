import 'package:flutter/material.dart';

import '../../widgets/appbar_widget.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({super.key});

  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> flashcards = List.generate(
    15,
    (index) => {
      'word': 'Word $index',
      'meaning': 'Meaning of Word $index',
    },
  );

  bool isFlipped = false;

  void _flipCard() {
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  void _nextPage() {
    if (_currentPage < flashcards.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage++;
        isFlipped = false;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage--;
        isFlipped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: ClipPath(
          clipper: BottomRoundedAppBarClipper(),
          child: AppBar(
            backgroundColor: Colors.purple,
            elevation: 0,
            title: const Text(
              'FlashCard',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Everyday Phrases',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: (_currentPage + 1) / 15,
                      strokeWidth: 4,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.purple),
                      backgroundColor: Colors.transparent,
                    ),
                    Text(
                      "${_currentPage + 1}/15",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: flashcards.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    isFlipped = false;
                  });
                },
                itemBuilder: (context, index) {
                  final card = flashcards[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: isFlipped
                          ? Card(
                              key: ValueKey('back-${card['word']}'),
                              color: Colors.purple,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                width: 300,
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    card['meaning']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Card(
                              key: ValueKey('front-${card['word']}'),
                              color: Colors.purple,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                width: 300,
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const SizedBox(height: 20),
                                    Text(
                                      card['word']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.volume_up,
                                        color: Colors.white,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _flipCard();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                              Icons.arrow_forward_ios_outlined),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: _previousPage,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Colors.purple,
                        width: 2), // Border color and width
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Square corners
                    ),
                  ),
                  child: const Text('Previous'),
                ),
                OutlinedButton(
                  onPressed: _nextPage,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Colors.purple,
                        width: 2), // Border color and width
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Square corners
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
