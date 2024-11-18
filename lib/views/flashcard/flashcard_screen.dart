import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewmodels/flashcard_controller.dart';
import '../../widgets/appbar_widget.dart';

class FlashCard extends StatelessWidget {
  const FlashCard({super.key});

  @override
  Widget build(BuildContext context) {
    final FlashCardController controller = Get.put(FlashCardController());

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
                    Obx(() => CircularProgressIndicator(
                      value: (controller.currentPage.value + 1) / 15,
                      strokeWidth: 4,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.purple),
                      backgroundColor: Colors.transparent,
                    )),
                    Obx(() => Text(
                      "${controller.currentPage.value + 1}/15",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.flashcards.length,
                onPageChanged: (index) {
                  controller.setPage(index);
                },
                itemBuilder: (context, index) {
                  final card = controller.flashcards[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(seconds: 1),
                      child: Obx(() => controller.isFlipped.value
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
                                        controller.flipCard();
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
                  ));
                },
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: controller.previousPage,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Colors.purple,
                        width: 2), 
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text('Previous'),
                ),
                OutlinedButton(
                  onPressed: controller.nextPage,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Colors.purple,
                        width: 2), 
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
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
