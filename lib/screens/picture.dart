import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class PicturePage extends StatefulWidget {
  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  final String pdfUrl =
      "https://acsrqbxziftlcohqvztj.supabase.co/storage/v1/object/public/comics/Solo%20leveling%20_compressed.pdf";
  String? filePath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    downloadPDF();
  }

  Future<void> downloadPDF() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/solo_leveling.pdf");

      if (await file.exists()) {
        setState(() {
          filePath = file.path;
          isLoading = false;
        });
        return;
      }

      Response response = await Dio().download(pdfUrl, file.path);
      if (response.statusCode == 200) {
        setState(() {
          filePath = file.path;
          isLoading = false;
        });
      } else {
        throw Exception("Failed to download PDF");
      }
    } catch (e) {
      setState(() => isLoading = false);
      print("Error downloading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Episode 1"),
        centerTitle: true,
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(color: Colors.green)
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/solo.jpg", width: 300), // Cover Image
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA3D749),

                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: filePath == null
                  ? null
                  : () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFViewerPage(filePath!),
                  ),
                );
              },
              child: Text("Read Solo Leveling", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFA3D749),
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          downloadPDF();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final String filePath;

  PDFViewerPage(this.filePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: PDFView(
          filePath: filePath,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: true,
          pageFling: true,
          fitPolicy: FitPolicy.BOTH, // Ensures the PDF fits the screen
        ),
      ),
    );
  }
}

