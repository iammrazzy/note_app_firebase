import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:marquee/marquee.dart';
import 'package:note_project/Model/note_model.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({super.key, required this.note});

  final NoteModel note;

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  // Share button
  void shareContent(String noteDescription) async {
    await Share.share(noteDescription);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Shimmer.fromColors(
              baseColor: Colors.deepPurple,
              highlightColor: Colors.cyan,
              child: Marquee(
                text: widget.note.noteTitle,
                style: GoogleFonts.kantumruyPro(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                blankSpace: 10.0,
                velocity: 100.0,
                pauseAfterRound: const Duration(seconds: 3),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Note Articles',
                      style: GoogleFonts.kantumruyPro(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            'Created: ${DateFormat().format(widget.note.noteID.toDate())}',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Text(
                          '[ ${widget.note.noteCategory} ]',
                          style: GoogleFonts.kantumruyPro(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Divider(
                      color: Colors.deepPurple.withOpacity(.5),
                    ),
                    SelectableText(
                      widget.note.noteDescription,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.kantumruyPro(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('──────────'),
                        const SizedBox(width: 5.0),
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              ClipboardData data = ClipboardData(
                                text: widget.note.noteDescription,
                              );
                              // Copy the text to the clipboard.
                              Clipboard.setData(data);
                              print(data);
                            },
                            icon: const Icon(Icons.copy_rounded),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  widget.note.isLoved = !widget.note.isLoved;
                                },
                              );
                            },
                            icon: widget.note.isLoved
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              shareContent(
                                '[ Note description ]: ${widget.note.noteDescription}',
                              );
                            },
                            icon: const Icon(Icons.share),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        const Text('──────────'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
