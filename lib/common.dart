const NUMBER_OF_DICES = 5;
const CATEGORY_TEXT_SIZE = 16.0;
const ROW_HEIGHT = 22.0;
const NO_VALUE = -1;

// DICE VALUES
List<int> values = [1, 1, 1, 1, 1];

// HOLD INDICATORS
List<bool> hold = [false, false, false, false, false];

// STORED VALUES
List<int> singles = [
  NO_VALUE,
  NO_VALUE,
  NO_VALUE,
  NO_VALUE,
  NO_VALUE,
  NO_VALUE
];
int min = NO_VALUE;
int max = NO_VALUE;
int straight = NO_VALUE;
int fullHouse = NO_VALUE;
int threeOfKind = NO_VALUE;
int fourOfKind = NO_VALUE;
int fiveOfKind = NO_VALUE;
int chance = NO_VALUE;
