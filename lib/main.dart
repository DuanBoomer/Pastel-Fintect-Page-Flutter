import 'dart:async';
import 'dart:collection';
import 'dart:html';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class ContainerPatternPainter extends CustomPainter {
  ContainerPatternPainter(
      {required this.backgroundColor,
      required this.foregroundColor,
      this.loadingPercentange = 1,
      this.loadersize = 0});

  Color backgroundColor;
  Color foregroundColor;
  double loadersize;
  double loadingPercentange;

  @override
  void paint(Canvas canvas, Size size) {
    DiagonalStripesLight(
            bgColor: backgroundColor,
            fgColor: foregroundColor,
            featuresCount: (size.width * 0.1).toInt())
        .paintOnWidget(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _MyHomePageState extends State<MyHomePage> {
  String accountSummary = "Account Summary";
  double accountSummaryCardHeight = 100;
  double accountSummaryCardWidth = 250;
  double accountSummarySize = 17;
  double cardGridRowSize = 0.55;
  double loaderCardSize = 520;
  double cardDetailSize = 350;
  String startTrading = "Start Trading";
  double startTradingSize = 14;
  String welcome = "Welcome!";
  double welcomeSize = 38;
  double cashLimitPercentage = 0.4;
  double creditLimitPercentage = 0.1;
  String welcometext =
      "Your profile has been created! Now you can start browsing the trading panel or go to the profile page to complete all the necessary information.";

  double welcometextSize = 14;

  Timer timer = Timer(Duration(milliseconds: 0), () {});

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(milliseconds: 200), (Timer t) => changeLoadingBars());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget accountSummarycard(
    Color color,
    String headingText,
    String text11,
    String text12,
    String text21,
    String text22,
  ) {
    return Container(
      width: accountSummaryCardWidth,
      height: accountSummaryCardHeight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(-3, 3),
              blurRadius: 0,
              spreadRadius: 0,
            )
          ]),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(headingText,
                style: GoogleFonts.robotoMono(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                )),
            Container(
              width: accountSummaryCardWidth * cardGridRowSize,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text11,
                        style: GoogleFonts.robotoMono(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        )),
                    Text(text12,
                        style: GoogleFonts.robotoMono(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        )),
                  ]),
            ),
            Container(
              width: accountSummaryCardWidth * cardGridRowSize,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text21,
                        style: GoogleFonts.robotoMono(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        )),
                    Text(text22,
                        style: GoogleFonts.robotoMono(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        )),
                  ]),
            )
          ]),
    );
  }

  Widget loadingBar(
    String leftHeading,
    String rightHeading,
    String heading,
    double currentLoadPercentage,
    Color color,
  ) {
    double totalBarSize = loaderCardSize - 42;
    double loadedBarSize = totalBarSize * currentLoadPercentage;
    return Container(
      width: loaderCardSize,
      padding: EdgeInsets.all(20),
      decoration:
          BoxDecoration(border: Border.all(width: 0.5, color: Colors.black26)),
      // width: 200,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          heading,
          style: GoogleFonts.robotoMono(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 15),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(leftHeading,
              style: GoogleFonts.robotoMono(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              )),
          Text(rightHeading,
              style: GoogleFonts.robotoMono(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              )),
        ]),
        SizedBox(height: 10),
        Row(mainAxisSize: MainAxisSize.min, children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 20,
            width: loadedBarSize,
            color: Colors.black,
          ),
          CustomPaint(
            painter: ContainerPatternPainter(
              backgroundColor: color,
              foregroundColor: Colors.black26,
              loadersize: totalBarSize - loadedBarSize,
              loadingPercentange: currentLoadPercentage,
            ),
            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: totalBarSize - loadedBarSize,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.5,
                      color: Colors.black,
                      strokeAlign: StrokeAlign.inside),
                )),
          ),
        ])
      ]),
    );
  }

  Widget rewardCard(
    double currentBalance,
    double expireThisMonth,
    double neededToReachTheGoal,
    String date,
  ) {
    return Container(
      width: 250,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(
        width: 0.5,
        color: Colors.black26,
      )),
      child: Column(children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2)),
                child: Icon(
                  Icons.star_border_rounded,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 25),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Reward Points",
                          style: GoogleFonts.robotoMono(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                      SizedBox(height: 10),
                      Text("$currentBalance POINTS",
                          style: GoogleFonts.robotoMono(
                            color: Colors.lime.shade400,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                      Text("Current Balance as on $date",
                          style: GoogleFonts.robotoMono(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          )),
                      SizedBox(height: 20),
                      Text("$expireThisMonth POINTS",
                          style: GoogleFonts.robotoMono(
                            color: Colors.orange.shade300,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                      Text("Expire this month",
                          style: GoogleFonts.robotoMono(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          )),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2)),
                        child: TextButton(
                          onPressed: (() {}),
                          child: Text(
                            "Redeem Now",
                            style: GoogleFonts.robotoMono(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ]),
        SizedBox(height: 20),
        Divider(
          color: Colors.black26,
          height: 30,
          thickness: 1.5,
        ),
        SizedBox(height: 20),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2)),
                child: Icon(
                  Icons.auto_graph_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 25),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text("Reward Goal",
                        style: GoogleFonts.robotoMono(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        )),
                    SizedBox(height: 10),
                    Text("$neededToReachTheGoal POINTS",
                        style: GoogleFonts.robotoMono(
                          color: Colors.orange.shade300,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                    Text("Needed to reach your goal",
                        style: GoogleFonts.robotoMono(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        )),
                  ])),
            ]),
      ]),
    );
  }

  Widget creditCardImage(
    int last4digits,
    String name,
    String date,
  ) {
    String cardNumber = "**** **** **** $last4digits";
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            width: 3,
            color: Colors.black,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(-6, 6),
            ),
          ]),
      child: Column(children: [
        Container(
          height: 150,
          width: cardDetailSize,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.grey.shade700, Colors.grey.shade900, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(cardNumber,
                style: GoogleFonts.robotoMono(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                )),
          ),
        ),

        //pink part of card
        Container(
          width: cardDetailSize,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.pink.shade50,
              Colors.pink.shade100,
              Colors.pink.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          )),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("$name",
                  style: GoogleFonts.robotoMono(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  )),
              Text("$date",
                  style: GoogleFonts.robotoMono(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  )),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget creditCardDetails(
    int last4digits,
    String statementGenerate,
    String paymentAmountDue,
    String minimumAmountDue,
    String totalAmountDue,
  ) {
    String cardNumber = "**** **** **** $last4digits";
    TextStyle textStyle11 = GoogleFonts.robotoMono(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.black54,
    );
    TextStyle textStyle12 = GoogleFonts.robotoMono(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    );

    TextStyle textStyleInvalid = GoogleFonts.robotoMono(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      color: Colors.red.shade700,
    );
    return Container(
      width: cardDetailSize,
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(cardNumber,
              style: GoogleFonts.robotoMono(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              )),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.black,
          )
        ]),
        Divider(
          color: Colors.black,
          height: 40,
          thickness: 3,
        ),
        SizedBox(height: 15),
        Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Statement Generate",
              style: textStyle11,
            ),
            Text(
              statementGenerate,
              style: textStyle12,
            ),
          ]),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Payment Amount Due",
              style: textStyle11,
            ),
            Text(
              paymentAmountDue,
              style: paymentAmountDue.contains("Not")
                  ? textStyleInvalid
                  : textStyle12,
            ),
          ]),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Minimum Amount Due",
              style: textStyle11,
            ),
            Text(
              minimumAmountDue,
              style: textStyle12,
            ),
          ]),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Total Amount Due",
              style: textStyle11,
            ),
            Text(
              totalAmountDue,
              style: textStyle12,
            ),
          ]),
        ])
      ]),
    );
  }

  Widget referSomeone() {
    return Container(
      width: cardDetailSize,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.blue.shade100,
          border: Border.all(
            width: 2,
            color: Colors.black,
          )),
      child: Column(children: [
        Text("Refer someone you know and get lower rates",
            style: GoogleFonts.robotoMono(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            )),
        SizedBox(height: 10),
        TextField(
          style: GoogleFonts.robotoMono(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2),
            ),
            suffixIcon: Icon(
              Icons.send,
              color: Colors.black,
            ),
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(),
            hintText: "Enter email...",
          ),
        ),
        SizedBox(height: 15),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Icon(
            Icons.join_right,
            color: Colors.black,
            size: 25,
          ),
          Icon(
            Icons.join_full,
            color: Colors.black,
            size: 25,
          ),
          Icon(
            Icons.join_left,
            color: Colors.black,
            size: 25,
          ),
        ])
      ]),
    );
  }

  void changeLoadingBars() {
    setState(() {
      if (cashLimitPercentage <= 0.97) {
        cashLimitPercentage += 0.01;
      } else {
        cashLimitPercentage = 0.0;
      }
      if (creditLimitPercentage <= 0.97) {
        creditLimitPercentage += 0.01;
      } else {
        creditLimitPercentage = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                //Pink Container
                Container(
                  padding:
                      EdgeInsets.only(right: 30, top: 40, bottom: 40, left: 60),
                  height: 310,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.pink.shade50,
                    Colors.pink.shade200,
                    Colors.pink.shade300,
                  ])),
                  child: Row(children: [
                    //text column
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(welcome,
                              style: GoogleFonts.robotoMono(
                                fontSize: welcomeSize,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              )),
                          SizedBox(height: 15),
                          Container(
                              width: 400,
                              child: Text(
                                welcometext,
                                style: GoogleFonts.robotoMono(
                                  fontSize: welcometextSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                          SizedBox(height: 40),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.black),
                            child: TextButton(
                              onPressed: (() {}),
                              child: Text(
                                startTrading,
                                style: GoogleFonts.robotoMono(
                                  fontSize: startTradingSize,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ]),
                    // SizedBox(width: 70),
                    //circle gradient
                    Padding(
                      padding: const EdgeInsets.only(left: 70, right: 250),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(2, 2),
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.yellow.shade100,
                                Colors.orange.shade100,
                                Colors.lightBlue.shade100,
                              ]),
                        ),
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 20),
                  //below pink container
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          accountSummary,
                          style: GoogleFonts.robotoMono(
                            fontSize: accountSummarySize,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20),
                        //below account summary
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //account summary cards
                                    Row(children: [
                                      accountSummarycard(
                                          Colors.pink.shade100,
                                          "Current Outstanding",
                                          "Total",
                                          "\$0",
                                          "Unbilled",
                                          "\$0"),
                                      SizedBox(width: 20),
                                      accountSummarycard(
                                          Colors.yellow.shade50,
                                          "Last Payment Mode",
                                          "Amount",
                                          "\$0",
                                          "Date",
                                          "--")
                                    ]),

                                    //loading bars
                                    SizedBox(height: 30),
                                    loadingBar(
                                        "Total: \$2,400",
                                        "Available: \$2,400",
                                        "Credit Limit",
                                        creditLimitPercentage,
                                        Colors.lightBlue.shade100),
                                    SizedBox(height: 30),
                                    loadingBar(
                                        "Total: \$2,400",
                                        "Available: \$2,400",
                                        "Cash Limit",
                                        cashLimitPercentage,
                                        Colors.purple.shade100),
                                  ]),
                              SizedBox(width: 60),
                              rewardCard(890, 123, 567, "18 Dec 2022"),
                            ])
                      ]),
                ),
              ]),
              //Leftside Column boundary
              Container(
                height: 800,
                width: 2,
                color: Colors.black12,
              ),

              Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: cardDetailSize,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Card",
                              style: GoogleFonts.robotoMono(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: Icon(
                                Icons.more_horiz_rounded,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      creditCardImage(
                        1234,
                        "John Wick",
                        "29/02",
                      ),
                      SizedBox(height: 50),
                      creditCardDetails(
                        1234,
                        "29 Feb 2022",
                        "Not Applicable",
                        "\$0.00",
                        "\$0.00",
                      ),
                      SizedBox(height: 20),
                      referSomeone(),
                    ]),
              )
            ]),
      ]),
    );
  }
}
