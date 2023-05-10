import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_insien/music_play.dart';
import 'package:music_insien/player_controller.dart';
import 'package:music_insien/playlist_page.dart';
import 'package:music_insien/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';


class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  int selected=0;
  int index=0;
  var controller=Get.put(Player());
  List<SongModel>list=[];
  List img=["s1.jpg","s2.jpg","s4.jpg","s3.jpg","s2.jpg"];
  List name=["kho gaye","Alvida","The girl","Ik vaari aa","Alvida"];
  PageController pageController= PageController();
  bool? ischecked=false;
  String sort="Date_added";
  String alertdialog="Create playlist";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffDAFEFE),
      body:Stack(
        children: [
          <Widget>[
            SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0,).copyWith(top: 20),
                child:Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              const Text("Home",style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold),),
                              Expanded(child: Container()),
                              const Icon(Icons.search,color: Colors.black,size: 28,),
                              const SizedBox(width: 10,),
                              InkWell(
                                  onTap: (){
                                    _dialogBuilder(context);
                                  },
                                  child: const Icon(Icons.sort,color: Colors.black,size: 28,)),


                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Column(
                                children:  [
                                  GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          selected=0;
                                        });
                                      },
                                      child:  Text("overview",style: TextStyle(color: selected==0?Colors.black:Colors.grey,fontSize: 20,fontWeight:selected==0? FontWeight.bold:FontWeight.normal),)),
                                  const SizedBox(height: 5,),
                                  Container(
                                    height: 8,
                                    width: 40,
                                    decoration:  BoxDecoration(
                                        color: selected==0? Colors.yellow:Colors.transparent,
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20,),
                              Column(
                                children:  [
                                  GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          selected=1;
                                        });
                                      },
                                      child: Text("playlists",style: TextStyle(color: selected==1?Colors.black:Colors.grey,fontSize: 20,fontWeight:selected==1? FontWeight.bold:FontWeight.normal),)),
                                  const SizedBox(height: 5,),
                                  Container(
                                    height: 8,
                                    width: 40,
                                    decoration:  BoxDecoration(
                                        color:selected==1? Colors.yellow:Colors.transparent,
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20,),
                              Column(
                                children:  [
                                  GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          selected=2;
                                        });
                                      },
                                      child: Text("artists",style: TextStyle(color: selected==2?Colors.black:Colors.grey,fontSize: 20,fontWeight:selected==2? FontWeight.bold:FontWeight.normal),)),
                                  const SizedBox(height: 5,),
                                  Container(
                                    height: 8,
                                    width: 40,
                                    decoration:  BoxDecoration(
                                        color:selected==2? Colors.yellow:Colors.transparent,
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                          child:<Widget>[
                            const Text("Trending Albums",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),),
                            const Text("Trending playlists",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),),
                            const Text("Trending artists",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),),
                          ][selected] ,),

                        const SizedBox(height: 15,),
                        Padding(padding:const EdgeInsets.symmetric(horizontal: 20),
                          child:  <Widget>[
                            Container(
                                height: 120,
                                child:FutureBuilder<List<AlbumModel>>(
                                  future: controller.audioQuery.queryAlbums(
                                      ignoreCase: true,
                                      orderType: OrderType.ASC_OR_SMALLER,
                                      sortType: AlbumSortType.ALBUM,
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
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context,i){

                                            return GestureDetector(
                                              onTap: (){
                                                nextScreen(context, PlaylistPage(playlist_name: snapshot.data![i].album, image: img[i],id:snapshot.data![i].id ,));
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(right: 25),
                                                child: Stack(
                                                    children:<Widget>[
                                                      QueryArtworkWidget(id: snapshot.data![i].id,artworkWidth: 100,artworkHeight: 120,artworkBorder: const BorderRadius.all(Radius.circular(10)), type: ArtworkType.ALBUM,

                                                        nullArtworkWidget: Container(
                                                          height: 120,
                                                          width: 100,
                                                          decoration:   const BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                                              color: Colors.blue,
                                                              image: DecorationImage(image: AssetImage("assets/s1.jpg"),
                                                                  fit: BoxFit.fill)
                                                          ),
                                                        ),),
                                                      Positioned(
                                                          top:105,
                                                          child: Container(
                                                              width: 100,
                                                              height: 15,
                                                              padding: const EdgeInsets.only(left: 4),
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white.withOpacity(0.8),
                                                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                                                              ),
                                                              child: Text(snapshot.data![i].album.toString(),style: const TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),))),
                                                    ]
                                                ),
                                              ),
                                            );
                                          }) ;
                                    }

                                  },


                                )
                            ),
                            Container(
                                height: 100,
                                child:FutureBuilder<List<AlbumModel>>(
                                  future: controller.audioQuery.queryAlbums(
                                      ignoreCase: true,
                                      orderType: OrderType.ASC_OR_SMALLER,
                                      sortType: null,
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
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context,index){
                                            int i=snapshot.data!.length-index-1;
                                            return GestureDetector(
                                              onTap: (){

                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(right: 25),
                                                child: Stack(
                                                    children:<Widget>[
                                                      QueryArtworkWidget(id: snapshot.data![i].id,artworkHeight:100,artworkWidth:100,artworkBorder: const BorderRadius.all(Radius.circular(10)), type: ArtworkType.ALBUM,

                                                        nullArtworkWidget: Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration:   const BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                                              color: Colors.blue,
                                                              image: DecorationImage(image: AssetImage("assets/s1.jpg"),
                                                                  fit: BoxFit.fill)
                                                          ),
                                                        ),),

                                                    ]
                                                ),
                                              ),
                                            );
                                          }) ;
                                    }

                                  },


                                )
                            ),
                            Container(
                                height: 70,
                                child:FutureBuilder<List<ArtistModel>>(
                                  future: controller.audioQuery.queryArtists(
                                      ignoreCase: true,
                                      orderType: OrderType.DESC_OR_GREATER,
                                      sortType: null,
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
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context,index){
                                            int i=snapshot.data!.length-index-1;
                                            return GestureDetector(

                                              child: Container(
                                                margin: const EdgeInsets.only(right: 25),
                                                child: Stack(
                                                    children:<Widget>[
                                                      QueryArtworkWidget(id: snapshot.data![i].id,artworkWidth: 70,artworkHeight: 70, type: ArtworkType.ARTIST,

                                                        nullArtworkWidget: Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration:   const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Colors.blue,
                                                              image: DecorationImage(image: AssetImage("assets/s1.jpg"),
                                                                  fit: BoxFit.fill)
                                                          ),
                                                        ),),
                                                      Positioned(
                                                          top:160,left:10,
                                                          child: Container(
                                                              width: 150,
                                                              child: Text(snapshot.data![i].artist,style: const TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),))),
                                                    ]
                                                ),
                                              ),
                                            );
                                          }) ;
                                    }

                                  },


                                )
                            ),
                          ][selected],
                        ),


                        const SizedBox(height: 20,),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 20),child:  <Widget>[
                          const Text("Top tracks",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),),
                          const Text("Top playlists",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),),
                          const Text("Top artists",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),),
                        ][selected]
                          ,),


                        const SizedBox(height: 10,),
                        <Widget>[
                          Expanded(
                            child: FutureBuilder<List<SongModel>>(
                              future: controller.audioQuery.querySongs(
                                  ignoreCase: true,
                                  orderType: OrderType.DESC_OR_GREATER,
                                  sortType:SongSortType.DATE_ADDED,
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
                                    shrinkWrap: true,
                                    itemBuilder: (context,i){
                                      return Obx(()=>
                                          ListTile(
                                            onTap: (){
                                              if (controller.mainPlayer.value){
                                                controller.mainPlayer(true);
                                                if(controller.playindex==i){
                                                  setState(() {
                                                    list=snapshot.data!;
                                                  });
                                                  nextScreen(context, MusicPLay(img: "", name:"${snapshot.data![i].displayNameWOExt}" , artist:"${snapshot.data![i].artist}" ,songModel:snapshot.data! ,));
                                                }else{

                                                  setState(() {
                                                    list=snapshot.data!;
                                                  });
                                                  nextScreen(context, MusicPLay(img: "", name:"${snapshot.data![i].displayNameWOExt}" , artist:"${snapshot.data![i].artist}" ,songModel:snapshot.data! ,));
                                                  controller.playSong(snapshot.data![i].uri, i);
                                                  controller.playing(true);
                                                }
                                              }else{
                                                controller.mainPlayer(true);
                                                setState(() {
                                                  list=snapshot.data!;
                                                });
                                                nextScreen(context, MusicPLay(img: "", name:"${snapshot.data![i].displayNameWOExt}" , artist:"${snapshot.data![i].artist}" ,songModel:snapshot.data! ,));
                                                controller.playSong(snapshot.data![i].uri, i);
                                                controller.playing(true);
                                              }

                                            },
                                            leading:QueryArtworkWidget(id: snapshot.data![i].id, type: ArtworkType.AUDIO
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
                                            title: Text(snapshot.data![i].displayNameWOExt.length>20?snapshot.data![i].displayNameWOExt.substring(0,20):snapshot.data![i].displayNameWOExt),
                                            subtitle: Text("${snapshot.data![i].artist}") ,
                                            trailing:controller.mainPlayer.value && controller.playindex==i? const Icon(Icons.music_note_outlined):null,
                                          ),
                                      );
                                    },

                                  );
                                }

                              },


                            ),
                          ),
                          Expanded(
                            child: FutureBuilder<List<AlbumModel>>(
                              future: controller.audioQuery.queryAlbums(
                                  ignoreCase: true,
                                  orderType: OrderType.ASC_OR_SMALLER,
                                  sortType: AlbumSortType.NUM_OF_SONGS,
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
                                    shrinkWrap: true,
                                    itemBuilder: (context,i){
                                      return GestureDetector(
                                        child: ListTile(
                                          leading:QueryArtworkWidget(id: snapshot.data![i].id, type: ArtworkType.ALBUM
                                            ,nullArtworkWidget: Container(
                                              height: 50,
                                              width: 50,
                                              margin: const EdgeInsets.only(right: 10),
                                              decoration:    const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  color: Colors.blue,
                                                  image: DecorationImage(image: AssetImage("assets/s1.jpg"),
                                                      fit: BoxFit.fill)
                                              ),
                                            ),),
                                          title: Text("${snapshot.data![i].album}"),
                                          subtitle:Text("Songs-${snapshot.data![i].numOfSongs}") ,
                                          trailing: const Icon(Icons.heart_broken),
                                        ),
                                      );
                                    },

                                  );
                                }

                              },


                            ),
                          ),
                          Expanded(
                            child: FutureBuilder<List<ArtistModel>>(
                              future: controller.audioQuery.queryArtists(
                                  ignoreCase: true,
                                  orderType: OrderType.DESC_OR_GREATER,
                                  sortType: null,
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
                                    shrinkWrap: true,
                                    itemBuilder: (context,i){
                                      return GestureDetector(

                                        child: ListTile(
                                          leading:QueryArtworkWidget(id: snapshot.data![i].id, type: ArtworkType.ARTIST
                                            ,nullArtworkWidget: Container(
                                              height: 50,
                                              width: 50,
                                              margin: const EdgeInsets.only(right: 10),
                                              decoration:    const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  color: Colors.blue,
                                                  image: DecorationImage(image: AssetImage("assets/s1.jpg"),
                                                      fit: BoxFit.fill)
                                              ),
                                            ),),
                                          title: Text("${snapshot.data![i].artist}"),
                                          subtitle: Text("Songs-${snapshot.data![i].numberOfTracks}") ,
                                          trailing: const Icon(Icons.heart_broken),
                                        ),
                                      );
                                    },

                                  );
                                }

                              },


                            ),
                          ),
                        ][selected],







                      ],
                    ),

                  ],
                ),
              ),
            ),
            SafeArea(child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                child:Column(
                  children: [
                    Row(
                      children: [
                        const Text("Playlists",style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold),),
                        Expanded(child: Container()),
                        const Icon(Icons.search,color: Colors.black,size: 28,),
                        const SizedBox(width: 10,),
                        InkWell(
                            onTap: (){
                              pop(context,"",0);
                              setState(() {
                                alertdialog="Create playlist";
                              });
                            },
                            child: const Icon(Icons.add,color: Colors.black,size: 28,)),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    Expanded(
                      child: FutureBuilder<List<PlaylistModel>>(
                        future: controller.audioQuery.queryPlaylists(
                            ignoreCase: true,
                            orderType: OrderType.DESC_OR_GREATER,
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
                                shrinkWrap: true,
                                itemBuilder: (context,i){

                                  return GestureDetector(
                                    child: ListTile(
                                      onTap: (){
                                        setState(() {
                                          alertdialog="Delete playlist";
                                        });
                                        pop(context,snapshot.data![i].playlist,snapshot.data![i].id);
                                      },
                                      leading:QueryArtworkWidget(id: snapshot.data![i].id, type: ArtworkType.PLAYLIST
                                      ,nullArtworkWidget: Container(
                                      height: 60,
                                      width: 60,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration:    const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                          image: DecorationImage(image: AssetImage("assets/s1.jpg"),
                                              fit: BoxFit.fill)
                                      ),
                                    ),),
                                      title: Text(snapshot.data![i].playlist,style: const TextStyle(fontSize: 20),),
                                      subtitle: Text(snapshot.data![i].dateAdded.toString()),
                                    ),
                                  );
                                }) ;
                          }

                        },


                      ),
                    ),
                  ],
                )
            ),)
          ][index],
          Align(
            alignment: Alignment.bottomCenter,
            child: navBar(),
          ),

        ],
      )

    );
  }
  SongSortType type(){
    if(sort=="album"){
      return SongSortType.ALBUM;
    }
    return SongSortType.DATE_ADDED;
  }
  pop(BuildContext context,String hint,int id){
    String p="";
    Future.delayed(Duration.zero,(){
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(alertdialog,style: const TextStyle(fontSize: 20),),
                alertdialog=="Create playlist"?Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Material(
                    color: Colors.transparent,
                    child: TextField(
                      onChanged: (val){
                        setState(() {
                          p=val;
                        });
                      },
                      style: const TextStyle(color:Colors.black ,fontSize: 25),
                      decoration: InputDecoration(
                        hintText: hint,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color:Colors.green),
                            borderRadius: BorderRadius.circular(20),
                          )
                      ),
                    ),
                  ),
                ):const SizedBox(height: 5,)

              ],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child:  Text(alertdialog=="Create playlist"?"create":"Delete"),
              onPressed: () {
                if(alertdialog=="Create playlist"){
                  OnAudioQuery().createPlaylist(p);
                  Navigator.of(context).pop();

                }else{
                  OnAudioQuery().removePlaylist(id);
                  Navigator.of(context).pop();
                }

               setState(() {
               });

              },
            ),
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

  AddSongToPlayist(BuildContext context,int id){
    String p="";
    Future.delayed(Duration.zero,(){
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Add Song",style: TextStyle(fontSize: 20),),
                 Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Material(
                    color: Colors.transparent,
                    child: FutureBuilder<List<PlaylistModel>>(
                      future: controller.audioQuery.queryPlaylists(
                          ignoreCase: true,
                          orderType: OrderType.ASC_OR_SMALLER,
                          sortType: null,
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
                              shrinkWrap: true,
                              itemBuilder: (context,i){

                                return GestureDetector(
                                  child: Text(snapshot.data![i].playlist),
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

  Widget songList(){
    return ListView.builder(
      itemCount:5 ,
      shrinkWrap: true,
      itemBuilder: (context,i){
        return GestureDetector(

          child: ListTile(
            leading: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(right: 10),
              decoration:    BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue,
                  image: DecorationImage(image: AssetImage("assets/"+img[i]),
                      fit: BoxFit.fill)
              ),
            ),
            title: Text(name[i]),
            subtitle:const Text("New song") ,
            trailing: const Icon(Icons.heart_broken),
          ),
        );
      },

    );
  }

  Widget album(){
    return GestureDetector(

      child: Stack(
          children:<Widget>[
            Container(
              height: 200,
              width: 150,
              margin: const EdgeInsets.only(right: 25),
              decoration:   BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue,
                  image: DecorationImage(image: AssetImage("assets/"+img[index]),
                      fit: BoxFit.fill)
              ),
            ),
            Positioned(
                top:160,left:10,
                child: Text(name[index],style: const TextStyle(color: Colors.white,fontSize: 20),)),
          ]
      ),
    );
  }

  navBar(){
    return Obx(()=>
       ClipRect(
         child: BackdropFilter(
           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
           child: Container(
            height: controller.mainPlayer.value?106:60,
            padding: EdgeInsets.only(top:controller.mainPlayer.value?0:10),
            color: Colors.black.withOpacity(0.5),
            child: Column(
              children: [
                   Container(
                    decoration: const BoxDecoration(
                    ),
                    child: controller.mainPlayer.value?Dismissible(
                      key: const Key("1"),
                      child: ListTile(
                        onTap: (){
                          nextScreen(context, MusicPLay(img: "", name:"${list[controller.playindex.value].displayNameWOExt}" , artist:"${list[controller.playindex.value].artist}" ,songModel:list ,));
                        },
                       title: Text(list[controller.playindex.value].displayNameWOExt.substring(0,20),style: const TextStyle(color: Colors.white),),
                        leading:QueryArtworkWidget(id: list[controller.playindex.value].id, type: ArtworkType.AUDIO
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
                        trailing:
                        IconButton(onPressed: (){
                          if (controller.playing.value) {
                            controller.audioPlayer.pause();
                            controller.playing(false);
                          } else {
                            controller.audioPlayer.play();
                            controller.playing(true);
                          }
                        }, icon:Icon(controller.playing.value?Icons.pause:Icons.play_arrow,color: Colors.white,size: 35,)),
                      ),
                      onDismissed: (direction){
                        setState(() {
                          controller.playing(false);
                          controller.mainPlayer(false);
                          controller.audioPlayer.stop();
                        });
                      },
                    ):null,
                  ),
                controller.mainPlayer.value?Divider(height: 2,color:Colors.grey):Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          index=0;
                        });


                      },
                      child: Column(
                        children: [

                           Icon(index==0?Icons.home:Icons.home_outlined,color: Colors.white,size: 30,),
                          Container(
                            height: 4,
                            width: 20,
                            decoration:  BoxDecoration(
                                color:index==0? Colors.white:Colors.transparent,
                                borderRadius: const BorderRadius.all(Radius.circular(10))),),
                          const SizedBox(height: 8,),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          index=1;
                        });
                      },
                      child: Column(
                        children: [

                           Icon(index==1?Icons.bookmark_add:Icons.bookmark_add_outlined,color: Colors.white,size: 30,),
                          Container(
                            height: 4,
                            width: 20,
                            decoration:  BoxDecoration(
                                color:index==1? Colors.white:Colors.transparent,
                                borderRadius: const BorderRadius.all(Radius.circular(10))),),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          index=2;
                        });
                      },
                      child: Column(
                        children: [

                          const Icon(Icons.play_circle_outline,color: Colors.white,size: 30,),
                          Container(
                            height: 4,
                            width: 20,
                            decoration:  BoxDecoration(
                                color:index==2? Colors.white:Colors.transparent,
                                borderRadius: const BorderRadius.all(Radius.circular(10))),),
                          const SizedBox(height: 8,),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          index=3;
                        });
                      },
                      child: Column(
                        children: [

                          const Icon(Icons.group_outlined,color: Colors.white,size: 30,),
                          Container(
                            height: 4,
                            width: 20,
                            decoration:  BoxDecoration(
                                color:index==3? Colors.white:Colors.transparent,
                                borderRadius: const BorderRadius.all(Radius.circular(10))),),
                          const SizedBox(height: 8,),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
      ),
         ),
       ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    List<String> _checked = [];

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: Container(
            height: 150,
            child: Column(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Album'),
                  onPressed: () {
                    setState(() {
                      sort="album";
                    });
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Artist'),
                  onPressed: () {
                    sort="artist";
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Date created'),
                  onPressed: () {
                    sort="date_added";
                  },
                ),
              ],
            ),

          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
