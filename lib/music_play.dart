import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_insien/player_controller.dart';
import 'package:music_insien/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';



class MusicPLay extends StatefulWidget {
  String img;
  String name;
  String artist;
  List<SongModel> songModel;

  MusicPLay(
      {Key? key,
      required this.img,
      required this.name,
      required this.artist,
      required this.songModel})
      : super(key: key);

  @override
  State<MusicPLay> createState() => _MusicPLayState();
}

class _MusicPLayState extends State<MusicPLay> {
  bool isplaying = false;
  int sel=0;
  double currentSliderValue = 0;
  var controller = Get.find<Player>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Obx(
      () => QueryArtworkWidget(
        id: widget.songModel[controller.playindex.value].id,
        type: ArtworkType.AUDIO,
        artworkHeight: MediaQuery.of(context).size.height,
        artworkWidth: MediaQuery.of(context).size.width,
        artworkFit: BoxFit.cover,
        nullArtworkWidget: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black,
              image: DecorationImage(
                  image: AssetImage("assets/s1.jpg"), fit: BoxFit.cover)),
        ),
      ),
        ),
         BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: Container(
        color: Colors.black45,
      ),
        ),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      child: Obx(
          () => <Widget>[
            Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FadeInRight(
                duration: const Duration(milliseconds: 500),
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Transform.scale(
                            scale: 1.5,
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ))),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sel=0;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration:  BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(30),),color:sel==0? Colors.black:Colors.white
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 25,),
                                Text("Playing",style: TextStyle(color:sel==0? Colors.white:Colors.white),),
                                SizedBox(width: 10,),
                                Icon(Icons.play_circle_fill,color:sel==0? Colors.white:Colors.white,),
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            sel=1;
                            setState(() {

                            });
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration:  BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(30),),color:sel==1? Colors.black:Colors.white
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Text("Up Next",style: TextStyle(color:sel==1? Colors.white:Colors.black),),
                                  SizedBox(width: 10,),
                                  Icon(Icons.shuffle,color:sel==1? Colors.white:Colors.black),
                                ],
                              ),
                            ),
                          ),
                        ) ,

                      ],
                    ),
                    Transform.scale(
                        scale: 1.5,
                        child: InkWell(
                          onTap: (){
                            AddSongToPlayist(context, widget.songModel[controller.playindex.value].id);
                          },
                          child: const Icon(
                            Icons.bookmark_add_outlined,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Center(
                child: QueryArtworkWidget(
                  id: widget.songModel[controller.playindex.value].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Container(
                    height: 250,
                    width: 210,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage("assets/s1.jpg"),
                            fit: BoxFit.fill)),
                  ),
                  artworkHeight: 250,
                  artworkWidth: 210,
                  artworkQuality: FilterQuality.high,
                  artworkBorder: const BorderRadius.all(Radius.circular(20)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Text(
                    widget.songModel[controller.playindex.value]
                        .displayNameWOExt,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.songModel[controller.playindex.value].artist
                        .toString(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  height: 125,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Obx(
                            () => Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: const TextStyle(color: Colors.white),
                            ),
                            Expanded(
                              child: Slider(
                                value: controller.value.value,
                                activeColor: Colors.black,
                                inactiveColor: const Color(0xffA4E2EAFF),
                                max: controller.max.value,
                                min: 0.0,
                                onChanged: (value) {
                                  controller
                                      .changeDurationToSeconds(value.toInt());
                                  value = value;

                                },


                              ),
                            ),
                            Text(
                              controller.duration.value,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                            () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                if(controller.repeat.value){
                                  controller.repeat(false);
                                  controller.audioPlayer.setLoopMode(LoopMode.off);
                                }else{
                                  controller.repeat(true);
                                  controller.audioPlayer.setLoopMode(LoopMode.all);
                                }
                              },
                              child:  Icon(
                                controller.repeat.value?Icons.repeat_one_outlined:Icons.repeat,
                                color: controller.repeat.value?Colors.blue:Colors.white,
                                size: 28,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  controller.playSong(
                                      widget
                                          .songModel[
                                      controller.playindex.value - 1]
                                          .uri,
                                      controller.playindex.value - 1);
                                },
                                icon:  Icon(
                                  Icons.fast_rewind,
                                  color: controller.playindex==0?Colors.grey:Colors.white,
                                  size: 28,
                                )),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black,
                              child: IconButton(
                                  onPressed: () {
                                    controller.mainPlayer(true);
                                    if (controller.playing.value) {
                                      controller.audioPlayer.pause();
                                      controller.playing(false);
                                    } else {
                                      controller.audioPlayer.play();
                                      controller.playing(true);
                                    }
                                  },
                                  icon: Icon(
                                    controller.playing.value
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 32,
                                  )),
                            ),
                            IconButton(
                                onPressed: () {
                                  controller.playSong(
                                      widget
                                          .songModel[
                                      controller.playindex.value + 1]
                                          .uri,
                                      controller.playindex.value + 1);
                                },
                                icon: const Icon(
                                  Icons.fast_forward,
                                  color: Colors.white,
                                  size: 28,
                                )),
                            InkWell(
                              onTap: (){

                              },
                              child:  Icon(
                                Icons.shuffle,
                                color:controller.playindex==widget.songModel.length-1? Colors.grey:Colors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 18,),
                FadeInLeft(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Transform.scale(
                              scale: 1.5,
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ))),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                sel=0;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 120,
                              decoration:  BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(30),),color:sel==0? Colors.black:Colors.white
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 25,),
                                  Text("Playing",style: TextStyle(color:sel==0? Colors.white:Colors.black),),
                                  SizedBox(width: 10,),
                                  Icon(Icons.play_circle_fill,color:sel==0? Colors.white:Colors.black),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: (){
                              sel=1;
                              setState(() {

                              });
                            },
                            child: Container(
                              height: 50,
                              width: 120,
                              decoration:  BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(30),),color:sel==1? Colors.black:Colors.white
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    Text("Up Next",style: TextStyle(color:sel==1? Colors.white:Colors.black),),
                                    SizedBox(width: 10,),
                                    Icon(Icons.shuffle,color:sel==1? Colors.white:Colors.black),
                                  ],
                                ),
                              ),
                            ),
                          ) ,

                        ],
                      ),
                      Transform.scale(
                          scale: 1.5,
                          child: const Icon(
                            Icons.ios_share,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Expanded(
                    child: FutureBuilder<List<SongModel>>(
                      future: controller.audioQuery.querySongs(
                          ignoreCase: true,
                          orderType:  OrderType.DESC_OR_GREATER,
                          sortType: SongSortType.DATE_ADDED,
                          uriType: UriType.EXTERNAL
                      ),
                      builder: (BuildContext context,snapshot){
                        if(snapshot.data==null){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(snapshot.data!.isEmpty){
                          return const Center(child: Text("No song Found"));
                        }else{
                          return ListView.builder(
                            itemCount:snapshot.data!.length-controller.playindex.value-1 ,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context,i){
                              return Obx(()=>
                                  GestureDetector(
                                    onLongPress: (){
                                      AddSongToPlayist(context, snapshot.data![i+controller.playindex.value+1].id);
                                    },
                                    child: ListTile(
                                      onTap: (){
                                        controller.playSong(snapshot.data![i+controller.playindex.value+1].uri,i+controller.playindex.value+1 );
                                        controller.playing(true);
                                        controller.mainPlayer(true);
                                        setState(() {
                                          sel=0;
                                        });
                                      },
                                      leading:QueryArtworkWidget(id: snapshot.data![i+controller.playindex.value+1].id, type: ArtworkType.AUDIO
                                        ,nullArtworkWidget: Container(
                                          height: 50,
                                          width: 50,
                                          margin: const EdgeInsets.only(right: 10),
                                          decoration:    const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey,
                                              image: DecorationImage(image: AssetImage("assets/s1.jpg"),
                                                  fit: BoxFit.fill)
                                          ),
                                        ),),
                                      title: Text(snapshot.data![i+controller.playindex.value+1].displayNameWOExt.length>20?snapshot.data![i+controller.playindex.value+1].displayNameWOExt.substring(0,20):snapshot.data![i+controller.playindex.value+1].displayNameWOExt,
                                      style: TextStyle(color: Colors.white),),
                                      subtitle: Text("${snapshot.data![i+controller.playindex.value+1].artist}",style: TextStyle(color: Colors.white),) ,
                                    ),
                                  ),
                              );
                            },

                          );
                        }

                      },


                    )
                ),

              ],
            )

          ][sel]
      ),
          ),
        ),
      ]),
    );
  }
  AddSongToPlayist(BuildContext context,int id){
    String p="";
    Future.delayed(Duration.zero,(){
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                const Text("Add Song to Playlist",style: TextStyle(fontSize: 20,color: Colors.blueAccent),),

                Container(
                  height: 100,
                  child: Material(
                    color: Colors.transparent,
                    child: FutureBuilder<List<PlaylistModel>>(
                      future: controller.audioQuery.queryPlaylists(
                          ignoreCase: true,
                          orderType: null,
                          sortType: PlaylistSortType.DATE_ADDED,
                          uriType: UriType.EXTERNAL
                      ),
                      builder: (BuildContext context,snapshot){
                        if(snapshot.data==null){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(snapshot.data!.isEmpty){
                          return const Center(child: Text("No song Found"));
                        }else{

                          return ListView.builder(
                              itemCount:snapshot.data!.length ,
                              physics: const BouncingScrollPhysics(),

                              itemBuilder: (context,i){

                                return GestureDetector(
                                  onTap: (){
                                    OnAudioQuery().addToPlaylist(snapshot.data![i].id, id);
                                    showSnakbar(context, Colors.green, "Added song to ${snapshot.data![i].playlist} ");
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(snapshot.data![i].playlist,style: TextStyle(color: Colors.black,fontSize: 20),),
                                  ),
                                );
                              }) ;
                        }

                      },


                    ),
                  ),
                )

              ],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    });
  }

}
