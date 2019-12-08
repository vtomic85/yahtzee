import 'package:flutter_app/common.dart';

class Brain {
  // For calculating sums of individual numbers
  static int calculateSingles(int number) {
    int total = 0;
    for (int i = 0; i < NUMBER_OF_DICES; i++) {
      if (values[i] == number) {
        total += values[i];
      }
    }
    return total;
  }

  // For calculating minimum, maximum and chance
  static int calculatePossibleTotal() {
    int total = 0;
    for (int i = 0; i < NUMBER_OF_DICES; i++) {
      total += values[i];
    }
    return total;
  }

  static int calculatePossibleStraight() {
    return ((countDicesForNumber(2) == 1 &&
                countDicesForNumber(3) == 1 &&
                countDicesForNumber(4) == 1 &&
                countDicesForNumber(5) == 1) &&
            (countDicesForNumber(1) == 1 || countDicesForNumber(6) == 1))
        ? 50
        : 0;
  }

  static int calculatePossibleFullHouse() {
    List<int> dices = [0, 0, 0, 0, 0];
    for (int i = 0; i < 5; i++) {
      dices[i] = values[i];
    }
    dices.sort();
    if (((dices[0] == dices[1] && dices[1] == dices[2]) &&
            (dices[3] == dices[4])) ||
        ((dices[0] == dices[1]) &&
            (dices[2] == dices[3] && dices[3] == dices[4]))) {
      return dices[0] + dices[1] + dices[2] + dices[3] + dices[4];
    }
    return 0;
  }

  static int calculatePossibleManyOfKind(int howMany) {
    for (int i = 1; i <= 6; i++) {
      var sum = calculatePossibleManyOfKindForNumber(howMany, i);
      if (sum > 0) {
        return sum;
      }
    }
    return 0;
  }

  // For calculating three of a kind, four of a kind and five of a kind for certain number
  static int calculatePossibleManyOfKindForNumber(int howMany, int number) {
    return (countDicesForNumber(number) >= howMany) ? howMany * number : 0;
  }

  // For determining if certain results are available (three of a kind, four of a kind, five of a kind or full house)
  static int countDicesForNumber(int number) {
    int count = 0;
    for (int i = 0; i < NUMBER_OF_DICES; i++) {
      if (values[i] == number) {
        count++;
      }
    }
    return count;
  }

  static int calculateSumOfSingles() {
    int sum = 0;
    for (int i = 0; i < 6; i++) {
      if (singles[i] >= 0) sum += singles[i];
    }
    return sum;
  }

  static int calculateSumOfMinMax() {
    return (max >= 0 && min >= 0 && singles[0] >= 0)
        ? (max - min) * singles[0]
        : 0;
  }

  static int calculateSumOfSpecials() {
    int sum = 0;
    if (straight >= 0) sum += straight;
    if (fullHouse >= 0) sum += fullHouse;
    if (threeOfKind >= 0) sum += threeOfKind;
    if (fourOfKind >= 0) sum += fourOfKind;
    if (fiveOfKind >= 0) sum += fiveOfKind;
    if (chance >= 0) sum += chance;
    return sum;
  }

  static int calculateSumOfSums() {
    return calculateSumOfSingles() +
        calculateSumOfMinMax() +
        calculateSumOfSingles();
  }
}
