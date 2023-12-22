import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faculty_colloboration/provider/user_provider.dart';
import 'package:faculty_colloboration/resource/firestore_methods.dart';
import 'package:faculty_colloboration/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:faculty_colloboration/screens/comments_screen.dart';
import 'package:faculty_colloboration/utils/colors.dart';
import 'package:faculty_colloboration/widgets/like_animation.dart';
import 'package:faculty_colloboration/model/user.dart' as model;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final Map<String, dynamic> snap;

  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;
  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        err.toString(),
        context,
      );
    }
    setState(() {});
  }

  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        err.toString(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  widget.snap['profImage'].toString(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.snap['username'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              widget.snap['uid'].toString() == user.uid
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            useRootNavigator: false,
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shrinkWrap: true,
                                    children: [
                                      'Delete',
                                    ]
                                        .map(
                                          (e) => InkWell(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                child: Text(e),
                                              ),
                                              onTap: () {
                                                deletePost(
                                                  widget.snap['postId']
                                                      .toString(),
                                                );
                                                // remove the dialog box
                                                Navigator.of(context).pop();
                                              }),
                                        )
                                        .toList()),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    : Container(),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.snap['description'].toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onDoubleTap: () {
              // Handle double tap
              // You may want to implement like functionality here
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.snap['postUrl'].toString(),
                    fit: BoxFit.cover,
                     // Adjust the height as needed
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      widget.snap['likes'].contains('userUid')
                          ? Icons.thumb_up_alt
                          : Icons.thumb_up,
                      color: widget.snap['likes'].contains('userUid')
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    onPressed: () {
                      FireStoreMethods().likePost(
                        widget.snap['postId'].toString(),
                        user.uid,
                        widget.snap['likes'],
                      );
                    setState(() {
                      isLikeAnimating = true;
                    });
                    },
                  ),
                  Text(
                    widget.snap['likes'].length.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 20,),
                  
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        postId: widget.snap['postId'].toString(),
                      ),
                    ),
                  );
                },
                child: Text(
                  'View all $commentLen comments',
                  style: TextStyle(
                    fontSize: 16,
                    color: secondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:faculty_colloboration/model/user.dart' as model;
// import 'package:faculty_colloboration/provider/user_provider.dart';
// import 'package:faculty_colloboration/resource/firestore_methods.dart';
// import 'package:faculty_colloboration/screens/comments_screen.dart';
// import 'package:faculty_colloboration/utils/colors.dart';
// import 'package:faculty_colloboration/utils/global_variable.dart';
// import 'package:faculty_colloboration/Utils/utils.dart';
// import 'package:faculty_colloboration/widgets/like_animation.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class PostCard extends StatefulWidget {
//   final snap;
//   const PostCard({
//     Key? key,
//     required this.snap,
//   }) : super(key: key);

//   @override
//   State<PostCard> createState() => _PostCardState();
// }

// class _PostCardState extends State<PostCard> {
//   int commentLen = 0;
//   bool isLikeAnimating = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchCommentLen();
//   }

//   fetchCommentLen() async {
//     try {
//       QuerySnapshot snap = await FirebaseFirestore.instance
//           .collection('posts')
//           .doc(widget.snap['postId'])
//           .collection('comments')
//           .get();
//           commentLen = snap.docs.length;
//       } catch (err) {
//     showSnackBar(
//         err.toString(),
//         context,
//       );
//     }
//     setState(() {});
//     }

//   deletePost(String postId) async {
//     try {
//     await FireStoreMethods().deletePost(postId);
//     } catch (err) {
//     showSnackBar(
//         err.toString(),
//         context,
//       );
//     }
//   }

//    @override
//   Widget build(BuildContext context) {
//     final model.User user = Provider.of<UserProvider>(context).getUser;
//     final width = MediaQuery.of(context).size.width;

//     return Container(
// // boundary needed for web
//         decoration: BoxDecoration(
//         border: Border.all(
//           color: width > webScreenSize ? secondaryColor : mobileBackgroundColor,
//         ),
//         color: mobileBackgroundColor,
//     ),
//     padding: const EdgeInsets.symmetric(
//     vertical: 6,
//     ),
//          child: Column(
//           children: [
// // HEADER SECTION OF THE POST
//               Container(
//                padding: const EdgeInsets.symmetric(
//               vertical: 4,
//               horizontal: 16,
//                ).copyWith(right: 0),
//                child: Row(
//                 children: <Widget>[
//                  CircleAvatar(
//                    radius: 16,
//                   backgroundImage: NetworkImage(
//                    widget.snap['profImage'].toString(),
//                       ),
//                   ),
//                   Expanded(
//                    child: Padding(
//                      padding: const EdgeInsets.only(
//                      left: 8,
//                       ),
//                       child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                       DefaultTextStyle(
//                       style: Theme.of(context)
//                           .textTheme
//                           .titleSmall!
//                           .copyWith(fontWeight: FontWeight.w800),
//                       child: Text(
//                         '${widget.snap['likes'].length} likes',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       )
//                       ),
//                       Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.only(
//                             top: 8,
//                           ),
//                           child: RichText(
//                             text: TextSpan(
//                               style: const TextStyle(color: primaryColor),
//                               children: [
//                                 TextSpan(
//                                   text: widget.snap['username'].toString(),
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: '\n${user.university}', // Display University name here
//                                   style: const TextStyle(
//                                     fontStyle: FontStyle.italic,
//                                     color: secondaryColor, // Choose the color you want for the University name
//                                 ),
//                                 if(widget.snap['profImage'] == null ||
//                                     widget.snap['profImage'].toString().isEmpty)
//                                   TextSpan(
//                                     text: ' - ${widget.snap['description']}',
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: ' ${widget.snap['description']}',
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
                      
//                 InkWell(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     child: Text(
//                       'View all $commentLen comments',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: secondaryColor,
//                       ),
//                     ),
//                   ),
//                   onTap: () => Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => CommentsScreen(
//                         postId: widget.snap['postId'].toString(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 4),
//                   child: Text(
//                     DateFormat.yMMMd()
//                         .format(widget.snap['datePublished'].toDate()),
//                     style: const TextStyle(
//                       color: secondaryColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ),
//       ]
//     )
//     )
//   ]));
//   }
// }

