import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'CalculateControllerProvider.dart';
import 'Colors.dart';
import 'CustomAppButton.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "00",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    var calculateProvider = Provider.of<CalculateControllerProvider>(context);

    return Scaffold(
      backgroundColor: LightColors.scaffoldBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            outPutSection(calculateProvider),
            inPutSection(calculateProvider),
          ],
        ),
      ),
    );
  }

  Widget inPutSection(CalculateControllerProvider calculateProvider) {
    return Container(
      padding: const EdgeInsets.fromLTRB(3, 3, 3, 50),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 70, 70, 70),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: buttons.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return CustomAppButton(
                buttonTapped: () {
                  calculateProvider.clearInputAndOutput();
                },
                color: Color.fromARGB(255, 134, 137, 136),
                textColor: const Color.fromARGB(255, 255, 255, 255),
                text: buttons[index],
              );
            case 1:
              return CustomAppButton(
                buttonTapped: () {
                  calculateProvider.deleteBtnAction();
                },
                color: Color.fromARGB(255, 128, 131, 130),
                textColor: const Color.fromARGB(255, 255, 255, 255),
                text: buttons[index],
              );
            case 19:
              return CustomAppButton(
                buttonTapped: () {
                  calculateProvider.equalPressed();
                },
                color: Color.fromARGB(255, 128, 131, 130),
                textColor: const Color.fromARGB(255, 255, 255, 255),
                text: buttons[index],
              );
            default:
              return CustomAppButton(
                buttonTapped: () {
                  calculateProvider.onBtnTapped(buttons, index);
                },
                color: isOperator(buttons[index])
                    ? Color.fromRGBO(3, 162, 242, 1)
                    : Color.fromARGB(255, 224, 224, 224),
                textColor:
                    isOperator(buttons[index]) ? Colors.white : Colors.black,
                text: buttons[index],
              );
          }
        },
      ),
    );
  }

  Widget outPutSection(CalculateControllerProvider calculateProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 70),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  calculateProvider.userInput,
                  style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 38),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  calculateProvider.userOutput,
                  style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool isOperator(String y) {
    return y == "%" || y == "/" || y == "x" || y == "-" || y == "+" || y == "=";
  }
}
