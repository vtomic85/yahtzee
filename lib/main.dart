import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/brain.dart';
import 'package:flutter_app/common.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiceMe',
      home: SafeArea(child: MyHomePage(title: 'Dice Game')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: drawAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            drawDicesRow(),
            drawHoldButtonsRow(),
            drawRollButtonRow(),
            drawResultsPane(),
          ],
        ),
      ),
    );
  }

  Padding drawResultsPane() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            drawCategoryColumn(),
            drawValueColumn(),
            drawStoreButtonsColumn()
          ],
        ),
      );

  Column drawCategoryColumn() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: drawAllCategoryTexts(),
      );

  Column drawValueColumn() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: drawAllValueTexts(),
      );

  Column drawStoreButtonsColumn() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: drawAllStoreButtons(),
      );

  List<Widget> drawAllCategoryTexts() => <Widget>[
        drawSingleNormalText('1'),
        drawSingleNormalText('2'),
        drawSingleNormalText('3'),
        drawSingleNormalText('4'),
        drawSingleNormalText('5'),
        drawSingleNormalText('6'),
        drawSingleBoldText('TOTAL'),
        drawSingleNormalText('Min'),
        drawSingleNormalText('Max'),
        drawSingleBoldText('TOTAL'),
        drawSingleNormalText('Straight'),
        drawSingleNormalText('Three of a kind'),
        drawSingleNormalText('Four of a kind'),
        drawSingleNormalText('Five of a kind'),
        drawSingleNormalText('Full house'),
        drawSingleNormalText('Chance'),
        drawSingleBoldText('TOTAL'),
        drawSingleBoldText('GRAND TOTAL'),
      ];

  List<Widget> drawAllValueTexts() => <Widget>[
        drawStoredOrPossibleValueForSingles(1),
        drawStoredOrPossibleValueForSingles(2),
        drawStoredOrPossibleValueForSingles(3),
        drawStoredOrPossibleValueForSingles(4),
        drawStoredOrPossibleValueForSingles(5),
        drawStoredOrPossibleValueForSingles(6),
        drawSingleBoldValue(Brain.calculateSumOfSingles()),
        drawStoredOrPossibleValueForMin(Brain.calculatePossibleTotal()),
        drawStoredOrPossibleValueForMax(Brain.calculatePossibleTotal()),
        drawSingleBoldValue(Brain.calculateSumOfMinMax()),
        drawStoredOrPossibleValueForStraight(Brain.calculatePossibleStraight()),
        drawStoredOrPossibleValueForThreeOfKind(
            Brain.calculatePossibleManyOfKind(3)),
        drawStoredOrPossibleValueForFourOfKind(
            Brain.calculatePossibleManyOfKind(4)),
        drawStoredOrPossibleValueForFiveOfKind(
            Brain.calculatePossibleManyOfKind(5)),
        drawStoredOrPossibleValueForFullHouse(
            Brain.calculatePossibleFullHouse()),
        drawStoredOrPossibleValueForChance(Brain.calculatePossibleTotal()),
        drawSingleBoldValue(Brain.calculateSumOfSpecials()),
        drawSingleBoldValue(Brain.calculateSumOfSums())
      ];

  List<Widget> drawAllStoreButtons() => <Widget>[
        singles[0] == NO_VALUE ? drawStoreSinglesButton(1) : drawStoreDivider(),
        singles[1] == NO_VALUE ? drawStoreSinglesButton(2) : drawStoreDivider(),
        singles[2] == NO_VALUE ? drawStoreSinglesButton(3) : drawStoreDivider(),
        singles[3] == NO_VALUE ? drawStoreSinglesButton(4) : drawStoreDivider(),
        singles[4] == NO_VALUE ? drawStoreSinglesButton(5) : drawStoreDivider(),
        singles[5] == NO_VALUE ? drawStoreSinglesButton(6) : drawStoreDivider(),
        drawStoreDivider(),
        min == NO_VALUE ? drawStoreMinButton() : drawStoreDivider(),
        max == NO_VALUE ? drawStoreMaxButton() : drawStoreDivider(),
        drawStoreDivider(),
        straight == NO_VALUE ? drawStoreStraightButton() : drawStoreDivider(),
        threeOfKind == NO_VALUE
            ? drawStoreThreeOfKindButton()
            : drawStoreDivider(),
        fourOfKind == NO_VALUE
            ? drawStoreFourOfKindButton()
            : drawStoreDivider(),
        fiveOfKind == NO_VALUE
            ? drawStoreFiveOfKindButton()
            : drawStoreDivider(),
        fullHouse == NO_VALUE ? drawStoreFullHouseButton() : drawStoreDivider(),
        chance == NO_VALUE ? drawStoreChanceButton() : drawStoreDivider(),
        drawStoreDivider(),
        drawStoreDivider()
      ];

  SizedBox drawStoreSinglesButton(int number) => SizedBox(
        height: ROW_HEIGHT,
        child: MaterialButton(
            child: Text("Store"),
            onPressed: () {
              setState(() {
                singles[number - 1] = Brain.calculateSingles(number);
              });
            }),
      );

  SizedBox drawStoreMinButton() => SizedBox(
        height: ROW_HEIGHT,
        child: MaterialButton(
          child: Text("Store"),
          onPressed: () {
            setState(() {
              min = Brain.calculatePossibleTotal();
            });
          },
        ),
      );

  SizedBox drawStoreMaxButton() => SizedBox(
        height: ROW_HEIGHT,
        child: MaterialButton(
          child: Text("Store"),
          onPressed: () {
            setState(() {
              max = Brain.calculatePossibleTotal();
            });
          },
        ),
      );

  SizedBox drawStoreStraightButton() => SizedBox(
        height: ROW_HEIGHT,
        child: MaterialButton(
          child: Text("Store"),
          onPressed: () {
            setState(() {
              straight = Brain.calculatePossibleStraight();
            });
          },
        ),
      );

  SizedBox drawStoreThreeOfKindButton() => SizedBox(
        height: ROW_HEIGHT,
        child: MaterialButton(
          child: Text("Store"),
          onPressed: () {
            setState(() {
              threeOfKind = Brain.calculatePossibleManyOfKind(3);
            });
          },
        ),
      );

  SizedBox drawStoreFourOfKindButton() => SizedBox(
        height: ROW_HEIGHT,
        child: MaterialButton(
          child: Text("Store"),
          onPressed: () {
            setState(() {
              fourOfKind = Brain.calculatePossibleManyOfKind(4);
            });
          },
        ),
      );

  SizedBox drawStoreFiveOfKindButton() => SizedBox(
        height: ROW_HEIGHT,
        child: MaterialButton(
          child: Text("Store"),
          onPressed: () {
            setState(() {
              fiveOfKind = Brain.calculatePossibleManyOfKind(5);
            });
          },
        ),
      );

  SizedBox drawStoreFullHouseButton() => SizedBox(
        height: ROW_HEIGHT,
        child: MaterialButton(
          child: Text("Store"),
          onPressed: () {
            setState(() {
              fullHouse = Brain.calculatePossibleFullHouse();
            });
          },
        ),
      );

  SizedBox drawStoreChanceButton() => SizedBox(
        height: ROW_HEIGHT,
        child: MaterialButton(
          child: Text("Store"),
          onPressed: () {
            setState(() {
              chance = Brain.calculatePossibleTotal();
            });
          },
        ),
      );

  SizedBox drawStoreDivider() => SizedBox(height: ROW_HEIGHT);

  SizedBox drawStoredOrPossibleValueForSingles(int number) =>
      (singles[number - 1] >= 0)
          ? drawSingleNormalValue(singles[number - 1])
          : drawSinglePossibleValue(Brain.calculateSingles(number));

  SizedBox drawStoredOrPossibleValueForMin(int number) => min == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(min);

  SizedBox drawStoredOrPossibleValueForMax(int number) => max == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(max);

  SizedBox drawStoredOrPossibleValueForChance(int number) => chance == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(chance);

  drawStoredOrPossibleValueForFullHouse(int number) => fullHouse == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(fullHouse);

  drawStoredOrPossibleValueForStraight(int number) => straight == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(straight);

  drawStoredOrPossibleValueForThreeOfKind(int number) => threeOfKind == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(threeOfKind);

  drawStoredOrPossibleValueForFourOfKind(int number) => fourOfKind == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(fourOfKind);

  drawStoredOrPossibleValueForFiveOfKind(int number) => fiveOfKind == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(fiveOfKind);

  SizedBox drawSingleNormalValue(int value) =>
      drawSingleValue(value, false, true);

  SizedBox drawSingleBoldValue(int value) => drawSingleValue(value, true, true);

  SizedBox drawSinglePossibleValue(int value) =>
      drawSingleValue(value, false, false);

  SizedBox drawSingleValue(int value, bool bold, bool stored) => SizedBox(
        height: ROW_HEIGHT,
        child: Text(
          value.toString(),
          style: TextStyle(
              fontSize: CATEGORY_TEXT_SIZE,
              color: stored ? Colors.white : Colors.red,
              backgroundColor: stored ? Colors.red : Colors.white,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal),
        ),
      );

  SizedBox drawSingleNormalText(String text) => drawSingleText(text, false);

  SizedBox drawSingleBoldText(String text) => drawSingleText(text, true);

  SizedBox drawSingleText(String text, bool bold) => SizedBox(
        height: ROW_HEIGHT,
        child: Text(
          text,
          style: TextStyle(
              fontSize: CATEGORY_TEXT_SIZE,
              color: Colors.white,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal),
        ),
      );

  AppBar drawAppBar() => AppBar(
        title: Text(
          widget.title,
        ),
        backgroundColor: Colors.blueGrey.shade800,
      );

  Row drawRollButtonRow() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          drawRollButton(),
        ],
      );

  Row drawDicesRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          drawDice(0),
          drawDice(1),
          drawDice(2),
          drawDice(3),
          drawDice(4),
        ],
      );

  Row drawHoldButtonsRow() => Row(
        children: <Widget>[
          drawHoldButton(0),
          drawHoldButton(1),
          drawHoldButton(2),
          drawHoldButton(3),
          drawHoldButton(4),
        ],
      );

  void rollDices() => setState(() {
        for (int i = 0; i < NUMBER_OF_DICES; i++) {
          if (!hold[i]) values[i] = Random().nextInt(6) + 1;
        }
      });

  void holdOrRollDice(int i) => setState(() {
        hold[i] = !hold[i];
      });

  Expanded drawDice(int num) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image(
            height: 50,
            image: AssetImage('images/dice${values[num]}.png'),
          ),
        ),
      );

  Expanded drawHoldButton(int num) => Expanded(
        child: FlatButton(
          color: hold[num] ? Colors.white : Colors.red,
          child: Text(
            'Hold',
            style: TextStyle(color: hold[num] ? Colors.red : Colors.white),
          ),
          onPressed: () => holdOrRollDice(num),
        ),
      );

  FlatButton drawRollButton() => FlatButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        color: Colors.white,
        onPressed: rollDices,
        child: Text(
          'Roll!',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      );
}
