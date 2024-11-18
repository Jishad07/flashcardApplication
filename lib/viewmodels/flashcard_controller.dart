import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FlashCardController extends GetxController {
  // PageController for PageView
  final PageController pageController = PageController();

  // Reactive variables
  var currentPage = 0.obs;
  var isFlipped = false.obs;

  final List<Map<String, String>> flashcards = List.generate(
    15,
    (index) => {
      'word': 'Word $index',
      'meaning': 'Meaning of Word $index',
    },
  );

  // Methods to handle card flipping and page navigation
  void flipCard() {
    isFlipped.value = !isFlipped.value;
  }

  void nextPage() {
    if (currentPage.value < flashcards.length - 1) {
      currentPage.value++;
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      isFlipped.value = false; // Reset flip when changing page
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      isFlipped.value = false; // Reset flip when changing page
    }
  }

  void setPage(int index) {
    currentPage.value = index;
    pageController.jumpToPage(index);
    isFlipped.value = false; // Reset flip when changing page
  }
}
