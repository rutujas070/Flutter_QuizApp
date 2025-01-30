import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp_withapi/View.dart';

// ignore: must_be_immutable
class Scorescreen extends StatefulWidget {
  int totalScore;
  int questionCount;
  Scorescreen({super.key,required this.totalScore,required this.questionCount});

  @override
  State<Scorescreen> createState() => _ScorescreenState();
}

class _ScorescreenState extends State<Scorescreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(
          "Quiz End",
          style:GoogleFonts.poppins(
            fontSize:30,
            fontWeight:FontWeight.w700,
            color:Colors.black,
           
          ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 106, 177, 207),

        ),

        body:Column(
          children:[
          const SizedBox(
            height: 200,
          ),
          Row(
          children: [
            const SizedBox(
              width: 100,
            ),
            Container(
              height: 200,
              width: 200,
              padding:const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                color: const Color.fromARGB(255, 198, 238, 254), // Background color of the container
                border: Border.all(
                  color: const Color.fromARGB(255, 106, 177, 207), // Border color
                  width: 3, // Border width
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child:Image.network("https://img.freepik.com/premium-photo/gold-champion-trophy-blue-background_564714-4193.jpg"),
            ),
          ],
          ),
          const SizedBox(
            height: 20,
          ),

           Text(
            "Congratulations!",
            style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: const Color.fromARGB(255, 218, 197, 76),
                  ),
             
            ),

            const SizedBox(
            height: 20,
          ),

           Text(
            "Score: ${widget.totalScore}/${widget.questionCount}",
              style:GoogleFonts.poppins(
                color:  const Color.fromARGB(255, 85, 160, 193),
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: (){ 
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                  return const Viewpage();
                 }));
                //currentOpion(3);
               },
               style: ButtonStyle(
                         side: WidgetStateProperty.all(
                             const BorderSide(color: Color.fromARGB(255, 106, 177, 207), width: 3.0), // Border color and width
                          ),
                          backgroundColor: const WidgetStatePropertyAll(Color.fromARGB(255, 198, 238, 254)),
               ),
              child:Text(
                "Restart",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color:Colors.black,
                ),
               // textAlign: TextAlign.start,
                ),
            ),

          ],
        ),
  
        );
  }
}