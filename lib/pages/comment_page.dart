import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/model/aComment.dart';
import 'package:travel_app/model/aTour.dart';
import 'package:travel_app/model/users.dart';
import 'package:travel_app/values/custom_snackbar.dart';
import 'package:travel_app/values/custom_text.dart';

class CommentPage extends StatefulWidget {
  const CommentPage(
      {Key? key,
      required this.tour,
      required this.tourDetails,
      required this.users})
      : super(key: key);
  final aTour tour;
  final tourDetails;
  final Users users;
  @override
  State<CommentPage> createState() => _CommentPageState();
}

late final aComment Comment;

class _CommentPageState extends State<CommentPage> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  final ScrollController _controller = ScrollController();
  final TextEditingController _textController = TextEditingController();
  bool loading = false;

  Stream<List<aComment>> readListComment(String? idTour) => FirebaseFirestore
      .instance
      .collection('Comment')
      .where('idTour', isEqualTo: idTour)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => aComment.fromJson(doc.data())).toList());

  Future createComment(aComment comment) async {
    final docComment = FirebaseFirestore.instance.collection("Comment").doc();

    final json = comment.toJson();
    await docComment.set(json);
    setState(() {
      _textController.clear();
    });
  }

  void scrollToTheEnd() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return Stack(
      children: <Widget>[
        Container(
          //Images Background
          width: size.width,
          height: size.height * 3 / 6,
          child: Image.asset(
              "assets/images/picture_tours/${widget.tourDetails.imageTourDetails}.jpg",
              // child: Image.asset("assets/images/picture_tours/ChinaMounDetails.jpg",
              fit: BoxFit.cover),
        ),
        Positioned(
          //IconBackScreen
          top: 15,
          child: Row(children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 22, top: 65),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                    backgroundColor: Colors.black12,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.arrowLeftLong,
                    size: 33,
                    color: Colors.white,
                  )),
            ),
          ]),
        ),
        Positioned(
            //Container name,location,details,...
            width: size.width,
            height: 600,
            top: size.height * 4 / 10,
            child: Container(
              //Full WhiteScreen
              padding:
                  EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: size.width,
                      height: size.height / 20,
                      child: Row(children: <Widget>[
                        CustomText(
                          //Name tour
                          text: widget.tour.nameTour.toString(),
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.13,
                          height: 1.3,
                          color: Colors.black,
                        ),
                        Spacer(),
                        FloatingActionButton.small(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => Padding(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          right: 20,
                                          left: 20,
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _textController,
                                              decoration: InputDecoration(
                                                hintText: "Type a message",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white)),
                                                // enabledBorder: OutlineInputBorder(
                                                //   borderRadius:
                                                //       BorderRadius.circular(11),
                                                //   borderSide: const BorderSide(
                                                //       color: Colors.white),
                                                // ),
                                                fillColor: Colors.transparent,
                                              ),
                                              maxLines: null,
                                              keyboardType:
                                                  TextInputType.multiline,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.send),
                                            onPressed: () {
                                              final comment = aComment(
                                                idTour: widget.tour.idTour
                                                    .toString(),
                                                nameUser: widget.users.nameUser
                                                    .toString(),
                                                comment: _textController.text,
                                              );
                                              createComment(comment);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ));
                          },
                          child: Icon(
                            Icons.add,
                            size: 22,
                            color: Colors.blueAccent.shade200,
                          ),
                        )
                      ]),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.locationDot,
                          size: 12,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8),
                        CustomText(
                          text: widget.tourDetails.placeTour.toString(),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.13,
                          height: 1.5,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    Container(
                        height: 550, //Đổi ở đây
                        width: size.width,
                        child: StreamBuilder<List<aComment>>(
                            stream: readListComment(widget.tour.idTour),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Something went wrong! ${snapshot.error}');
                              } else if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                final aComment = snapshot.data;
                                return ListView.builder(
                                  itemCount: aComment!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return aComment[index].nameUser ==
                                            widget.users.nameUser
                                        ? Dismissible(
                                            key: UniqueKey(),
                                            child: Card(
                                            color: Colors.white,
                                            child: ListTile(
                                              contentPadding:
                                                  const EdgeInsets.all(16.0),
                                              leading: Row(
                                                mainAxisSize: MainAxisSize
                                                    .min, // Limit leading width
                                                children: [
                                                  CircleAvatar(
                                                    child: Text(
                                                      aComment[index]
                                                          .nameUser!
                                                          .substring(0, 1)
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              title: Text(
                                                aComment[index].nameUser!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                aComment[index].comment!,
                                                maxLines:
                                                    10, // Limit subtitle lines (optional)
                                                overflow: TextOverflow
                                                    .ellipsis, // Add ellipsis for long text
                                              ),
                                            ),
                                          ),
                                            onDismissed: (direction) {
                                              // Implement logic to delete the comment here
                                              // You might need to call a function from your widget
                                              // or access a provider to delete the comment.
                                              CustomSnackbar.show(
                                                  context, "Comment deleted!");
                                            },
                                          )
                                        : Card(
                                            color: Colors.white,
                                            child: ListTile(
                                              contentPadding:
                                                  const EdgeInsets.all(16.0),
                                              leading: Row(
                                                mainAxisSize: MainAxisSize
                                                    .min, // Limit leading width
                                                children: [
                                                  CircleAvatar(
                                                    child: Text(
                                                      aComment[index]
                                                          .nameUser!
                                                          .substring(0, 1)
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              title: Text(
                                                aComment[index].nameUser!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                aComment[index].comment!,
                                                maxLines:
                                                    10, // Limit subtitle lines (optional)
                                                overflow: TextOverflow
                                                    .ellipsis, // Add ellipsis for long text
                                              ),
                                            ),
                                          );
                                  },
                                );
                              } else {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text:
                                          'No comments found for this tour yet.',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.13,
                                      height: 1.5,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                        height:
                                            20.0), // Add some space between text and button
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.pink,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(11),
                                          child: CustomText(
                                              text: 'Reload',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              height: 0,
                                              color: Colors.white),
                                        )),
                                  ],
                                );
                              }
                            })),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
