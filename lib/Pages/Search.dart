
import 'package:coachyp/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Searchpage extends StatelessWidget {
  const Searchpage({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            IconButton(onPressed: (){}, icon: const Icon(LineIcons.arrowLeft)),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 340,
                padding: const EdgeInsets.all(8),
                color: AppColors.background,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      
                      children: [
                        Icon(LineIcons.search,color: Colors.grey[700],size: 19,),
                        const SizedBox(width: 3,),
                        Text("Search",style: TextStyle(fontFamily: "Jersey15",color: Colors.grey[700],fontSize: 19),),
                      ],
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.clear,color: Colors.grey[700],))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text("Search"),
      ),
      backgroundColor: AppColors.primary,
     
    );
     }
}