// ignore_for_file: unused_local_variable

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sms/widgets/custom_text.dart';
import 'package:sms_advanced/sms_advanced.dart';

import '../widgets/Custom_TextField.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SmsQuery query = SmsQuery();
  List<SmsThread> threads = [];
  TextEditingController searchCtn = TextEditingController();
  var ReciveController = ExpandableController(initialExpanded: true);

  @override
  void initState() {
    super.initState();
    query.getAllThreads.then((value) {
      threads = value;
      print(threads);
    });
  }

  bool expand = true;
  int? tapped;
  bool expandRes = true;
  int? tappedRes;
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
          home: Scaffold(
            appBar: AppBar(title: const Text("Messages"), actions: [
              IconButton(
                onPressed: () {
                  query.getAllThreads.then((value) {
                    threads = value;
                    setState(() {});
                  });
                },
                icon: const Icon(Icons.downloading),
              ),
            ]),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
                        CustomTextFormField(
                            onChangedFun: () {
                              setState(() {
                                print("object");
                              });
                              runFilter(searchCtn.text.trim());
                            },
                            hintText: 'Search here ...',
                            prefixIcon: const Icon(Icons.search),
                            controller: searchCtn),
                        foundUsers.isEmpty
                            ? ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: threads.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(bottom: 2.w),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.w, horizontal: 2.w),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          2.w,
                                        ),
                                        color: Colors.grey.withOpacity(.2)),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          expandRes = ((tappedRes == null) ||
                                                  ((index == tappedRes) ||
                                                      !expandRes))
                                              ? !expandRes
                                              : expandRes;
                                          tappedRes = index;
                                        });
                                      },
                                      child: ExpandablePanel(
                                        expanded: const SizedBox(),
                                        controller: ExpandableController(
                                            initialExpanded: expandRes),
                                        header: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  threads[index]
                                                          .contact
                                                          ?.address ??
                                                      'empty',
                                                  style: TextStyle(
                                                      fontSize: 4.w,
                                                      color: Colors.indigo,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "${threads[index].messages.first.date!.day} / ${threads[index].messages.first.date!.month} / ${threads[index].messages.first.date!.year}",
                                                  style:
                                                      TextStyle(fontSize: 4.w),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    text: 'ADE 0.00',
                                                    color: Colors.indigo,
                                                    fontweight: FontWeight.w500,
                                                  ),
                                                  CustomText(
                                                    text: "Click to show",
                                                    fontSize: 3.w,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        collapsed: Container(
                                            padding: EdgeInsets.all(3.w),
                                            width: 100.w,
                                            color: Colors.white,
                                            child: Text(
                                              threads[index]
                                                      .messages
                                                      .last
                                                      .body ??
                                                  'empty',
                                              style: const TextStyle(),
                                            )),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: results.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(bottom: 2.w),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.w, horizontal: 2.w),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          2.w,
                                        ),
                                        color: Colors.grey.withOpacity(.2)),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          expand = ((tapped == null) ||
                                                  ((index == tapped) ||
                                                      !expand))
                                              ? !expand
                                              : expand;
                                          tapped = index;
                                        });
                                      },
                                      child: ExpandablePanel(
                                        expanded: const SizedBox(),
                                        controller: ExpandableController(
                                            initialExpanded: expand),
                                        header: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                    text: results[index]
                                                            .contact
                                                            ?.address ??
                                                        'empty',
                                                    fontSize: 4.w,
                                                    color: Colors.indigo,
                                                    fontweight:
                                                        FontWeight.w500),
                                                CustomText(
                                                    text:
                                                        "${results[index].messages.first.date!.day} / ${results[index].messages.first.date!.month} / ${results[index].messages.first.date!.year}",
                                                    fontSize: 4.w),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    text: 'ADE 0.00',
                                                    color: Colors.indigo,
                                                    fontweight: FontWeight.w500,
                                                  ),
                                                  CustomText(
                                                    text: "Click to show",
                                                    fontSize: 3.w,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        collapsed: Container(
                                            padding: EdgeInsets.all(3.w),
                                            width: 100.w,
                                            color: Colors.white,
                                            child: Text(
                                              results[index]
                                                      .messages
                                                      .last
                                                      .body ??
                                                  'empty',
                                              style: const TextStyle(),
                                            )),
                                      ),
                                    ),
                                  );
                                },
                              )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
                  margin: EdgeInsets.only(top: 2.w),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.indigo),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: 'Total : ',
                            color: Colors.white,
                            fontSize: 4.w,
                            fontweight: FontWeight.w500),
                        CustomText(
                            text: "$total AED ",
                            color: Colors.white,
                            fontSize: 4.w,
                            fontweight: FontWeight.w500)
                      ]),
                )
              ],
            ),
          ));
    });
  }

  List<SmsThread> results = [];
  List<SmsThread> foundUsers = [];
  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = threads;
    } else {
      results = threads
          .where((user) => user.contact!.address!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      foundUsers = results;
    });
  }
}
