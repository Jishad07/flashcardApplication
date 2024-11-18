import 'package:get/get.dart';

class FlashCardController extends GetxController {
  // Observable current page index
  var currentPage = 0.obs;

  // Method to go to the next page
  void nextPage() {
    if (currentPage < 14) {  // Ensure we don't go past the last card
      currentPage++;
    }
  }

  // Method to go to the previous page
  void previousPage() {
    if (currentPage > 0) {  // Ensure we don't go before the first card
      currentPage--;
    }
  }
}
