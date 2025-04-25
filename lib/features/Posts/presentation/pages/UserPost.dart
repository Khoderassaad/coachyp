import 'package:coachyp/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Userpost extends StatelessWidget {
  final String name;
  final String sportcoach;
  final String imagepath;
  final String desc;

  const Userpost(
      {super.key, required this.name,
      required this.imagepath,
      required this.desc,
      required this.sportcoach});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(.0),
            child: Container(
               height: 370,
              width: 420,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
                // Adjust radius as needed
              ),
              // ignore: sort_child_properties_last
              child: Column(
                children: [
                  SizedBox(
                    height: 340,
                    width: 420,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: const BoxDecoration(
                                        color: Colors.black38,
                                        shape: BoxShape.circle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          sportcoach,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                             const Icon(
                                LineIcons.verticalEllipsis,
                                color: Colors.black87,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RichText(
                              text: TextSpan(
                                  text: desc,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                        ),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                width: 340,
                                height: 350,
                                child: Image.asset(
                                  imagepath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                            Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                            child: Container(
                              width: 395,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.s2,
                                borderRadius: BorderRadius.circular(
                                    12), // Adjust radius as needed
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add,color: AppColors.background,),
                                    Text(
                                      "Book Session",
                                      style: TextStyle(
                                        color: AppColors.background,
                                        fontSize: 20,
                                        fontFamily: 'Jersey15',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                      ],
                      
                    ),
                  ),
                  // const Divider(),
                  
                  const SizedBox(
                    width: 4,
                  )
                ],
              ),
             
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.favorite,
                    size: 15,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.share,
                  size: 15,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

