import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'NavBar.dart';


class PlaylistPage extends StatefulWidget {
  String playlist_name;
  String image;
  int id;

   PlaylistPage({Key? key,required this.playlist_name,required this.image,required this.id}) : super(key: key);

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  int sel=0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffDAFEFE),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
                  const Text("Playlists",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),),
                  const Icon(Icons.more_vert,color: Colors.black,),
                ],
              ),
              const SizedBox(height: 15,),
              Center(
                child:QueryArtworkWidget(id: widget.id, type: ArtworkType.ALBUM,artworkWidth: 210,
                artworkHeight: 250,artworkBorder:BorderRadius.all(Radius.circular(20)) ,
                nullArtworkWidget: Container(
                  height: 250,
                  width: 210,
                  margin: const EdgeInsets.only(right: 25),
                  decoration:    BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.blue,
                      image: DecorationImage(image: AssetImage("assets/"+widget.image),
                          fit: BoxFit.fill)
                  ),
                ),)
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.playlist_name,style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 15,
              ),
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30),),
                ),
                child: Container(
                  height: 60,
                  width: 240,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30),),color: Colors.white
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            sel=0;
                          });
                        },
                        child: Container(
                          height: 80,
                          width: 120,
                          decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(30),),color:sel==0? Colors.green:Colors.white
                          ),
                          child: Row(
                            children:const [
                              SizedBox(width: 25,),
                              Text("Play"),
                              SizedBox(width: 10,),
                              Icon(Icons.play_circle_fill,),
                            ],
                          ),
                        ),
                      ),

                     GestureDetector(
                       onTap: (){
                         setState(() {
                           sel=1;
                         });
                       },
                       child: Container(
                           height: 80,
                           width: 120,
                          decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(30),),color:sel==1? Colors.green:Colors.white
                          ),
                          child: Center(
                            child: Row(
                              children:const [
                                SizedBox(width: 20,),
                                Text("Shuffle"),
                                SizedBox(width: 10,),
                                Icon(Icons.shuffle,),
                              ],
                            ),
                          ),
                        ),
                     ) ,

                    ],
                  ),
                  
                ),
              ),
              Container(
                height: 350,
                child: ListView.builder(
                  itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context,i){
                  return ListTile(
                    leading: Text((i+1).toString(),style: const TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w500),),
                    title: Text(widget.playlist_name.length>15?widget.playlist_name.substring(0,15):widget.playlist_name),
                    trailing: const Icon(Icons.more_vert),
                  );
                }),
              )
            ],
          ),
        )),
      ),
    );
  }
}
