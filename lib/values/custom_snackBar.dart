import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

//Custom hiện thông báo nha
class ShowMessage extends StatelessWidget {
  const ShowMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('Show Awesome SnackBar'),
              onPressed: () {
                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'On Snap!',
                    message:
                    'This is an example error message that will be shown in the body of snackbar!',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.failure,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              },
            ),
          ],
        ),
      ),
    );
  }
    // return Builder(
    //   builder: (BuildContext context) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Stack(children: <Widget>[
    //           Container(
    //             padding: EdgeInsets.all(16),
    //             height: 90,
    //             decoration: BoxDecoration(
    //               color: Color(0xFFC72C41),
    //               borderRadius: BorderRadius.all(Radius.circular(20)),
    //             ),
    //             child: Row(children: <Widget>[
    //               const SizedBox(width: 40),
    //               Expanded(
    //                 child: Column(
    //                   children: <Widget>[
    //                     Text("Oh snap",
    //                         style:
    //                             TextStyle(fontSize: 18, color: Colors.white)),
    //                     Text(
    //                       "Flutter default SnackBar is showing",
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 12,
    //                       ),
    //                       maxLines: 2,
    //                       overflow: TextOverflow.ellipsis,
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ]),
    //           ),
    //         ]),
    //         behavior: SnackBarBehavior.floating,
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //       ),
    //     );
    //     return Container(); // Trả về một widget bất kỳ để đảm bảo rằng hàm trả về một widget.
    //   },
    // );
  }
