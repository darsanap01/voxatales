
// import 'package:flutter/material.dart';
// import 'package:storyapplication/models/stories.dart';
// import 'package:storyapplication/service/load_json.dart';
// import 'package:storyapplication/service/tts_service.dart';
// import 'package:storyapplication/story_detail_screen.dart'; 

// class StoryScreen extends StatefulWidget {
//   @override
//   _StoryScreenState createState() => _StoryScreenState();
// }

// class _StoryScreenState extends State<StoryScreen> {
//   late Future<List<Story>> _storiesFuture;
//   final TtsService _ttsService = TtsService();
//   Story? _currentStory;

//   @override
//   void initState() {
//     super.initState();
//     _storiesFuture = loadStories();
//     _ttsService.init();
//   }

//   @override
//   void dispose() {
//     _ttsService.dispose();
//     super.dispose();
//   }

//   void _playStory(Story story) {
//     _ttsService.speak(story.text);
//     setState(() {
//       _currentStory = story;
//     });
//   }

//   void _stopStory() {
//     _ttsService.stop();
//     setState(() {
//       _currentStory = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     appBar: PreferredSize(
//   preferredSize: const Size.fromHeight(110),
//   child: ClipPath(
//     clipper: _CurvedAppBarClipper(),
//     child: AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       centerTitle: true,
//       title: const Text(
//         'The Story Vault',
//         style: TextStyle(
//           fontSize: 22,
//           fontWeight: FontWeight.w700,
//           letterSpacing: 1.3,
//           color: Colors.white,
//         ),
//       ),
//       flexibleSpace: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFFF8C00), 
//               Color(0xFFFFC371), 
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//       ),
//     ),
//   ),
// ),


//       body: FutureBuilder<List<Story>>(
//         future: _storiesFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             return ListView.separated(
//               padding: const EdgeInsets.all(12),
//               separatorBuilder: (context, index) {
//                 return const SizedBox(height: 10);
//               },
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final story = snapshot.data![index];
//                 final isPlaying = _currentStory?.id == story.id;

//                 return InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             StoryDetailScreen(story: story),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                       side: BorderSide(color: Colors.grey.shade300),
//                     ),
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 100,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               image: DecorationImage(
//                                 image: NetworkImage(story.image),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: ListTile(
//                               contentPadding: EdgeInsets.zero,
//                               title: Text(
//                                 story.title,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.orange,
//                                 ),
//                               ),
//                               subtitle: Text(
//                                 story.description,
//                                 maxLines: 3,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   color: Colors.grey.shade700,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text('No stories found'));
//           }
//         },
//       ),
//     );
//   }
// }

// class _CurvedAppBarClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, size.height - 30);
//     path.quadraticBezierTo(
//       size.width / 2,
//       size.height,
//       size.width,
//       size.height - 30,
//     );
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

import 'package:flutter/material.dart';
import 'package:storyapplication/models/stories.dart';
import 'package:storyapplication/service/appdata.dart';
import 'package:storyapplication/service/load_json.dart';
import 'package:storyapplication/service/tts_service.dart';

class StoryScreen extends StatefulWidget {
  final String? category;

  StoryScreen({super.key, this.category});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late Future<List<Story>> _storiesFuture;
  final TtsService _ttsService = TtsService();
  Story? _currentStory;

  @override
  void initState() {
    super.initState();
    _storiesFuture = loadStories();
    _ttsService.init();
  }

  @override
  void dispose() {
    _ttsService.dispose();
    super.dispose();
  }

  void _playStory(Story story) {
    _ttsService.speak(story.text);
    AppData.addToHistory(story);
    setState(() {
      _currentStory = story;
    });
  }

  void _stopStory() {
    _ttsService.stop();
    setState(() {
      _currentStory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category == null ? 'Story Telling App' : '${widget.category} Stories')),
      body: FutureBuilder<List<Story>>(
        future: _storiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final stories = snapshot.data!;
            return ListView.builder(
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];
                final isPlaying = _currentStory?.id == story.id;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(story.title),
                    subtitle: Text(
                      story.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: Icon(isPlaying ? Icons.stop : Icons.volume_up),
                      onPressed: () {
                        if (isPlaying) {
                          _stopStory();
                        } else {
                          _playStory(story);
                        }
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No stories found'));
          }
        },
      ),
    );
  }
}