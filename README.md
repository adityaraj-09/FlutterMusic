# music_insien

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
FadeInLeft(
duration: const Duration(milliseconds: 500),
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
borderRadius: const BorderRadius.all(Radius.circular(30),),color:sel==0? Colors.cyan:Colors.white
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
                            sel=1;
                            setState(() {

                            });
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration:  BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(30),),color:sel==1? Colors.cyan:Colors.white
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
                    Transform.scale(
                        scale: 1.5,
                        child: const Icon(
                          Icons.ios_share,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                                      activeColor: Colors.cyan,
                                      inactiveColor: const Color(0xffA4E2EAFF),
                                      max: controller.max.value,
                                      min: 0.0,
                                      onChanged: (value) {
                                        controller
                                            .changeDurationToSeconds(value.toInt());
                                        value = value;
                                        if(value==controller.max.toDouble()){

                                        }

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
                                  const Icon(
                                    Icons.repeat,
                                    color: Colors.white,
                                    size: 28,
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
                                      icon: const Icon(
                                        Icons.fast_rewind,
                                        color: Colors.white,
                                        size: 28,
                                      )),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.cyan,
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
                                  const Icon(
                                    Icons.shuffle,
                                    color: Colors.white,
                                    size: 28,
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

              ][sel]
            ],
          ),

Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
SizedBox(height: 18,),
Row(
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
borderRadius: const BorderRadius.all(Radius.circular(30),),color:sel==0? Colors.cyan:Colors.white
),
child: Row(
children:const [
SizedBox(width: 25,),
Text("Playing"),
SizedBox(width: 10,),
Icon(Icons.play_circle_fill,),
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
                                borderRadius: const BorderRadius.all(Radius.circular(30),),color:sel==1? Colors.cyan:Colors.white
                            ),
                            child: Center(
                              child: Row(
                                children:const [
                                  SizedBox(width: 20,),
                                  Text(""),
                                  SizedBox(width: 10,),
                                  Icon(Icons.shuffle,),
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
                Expanded(
                    child: FutureBuilder<List<SongModel>>(
                      future: controller.audioQuery.querySongs(
                          ignoreCase: true,
                          orderType: null,
                          sortType: SongSortType.DISPLAY_NAME,
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
                                  ListTile(

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
                              );
                            },

                          );
                        }

                      },


                    )
                ),

              ],
            )
