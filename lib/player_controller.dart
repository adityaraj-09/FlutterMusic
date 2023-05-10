
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_insien/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';



class Player extends GetxController{
  final audioQuery= OnAudioQuery();
  final audioPlayer=AudioPlayer();
  var playing=false.obs;
  var playindex=0.obs;
  var duration="".obs;
  var position=''.obs;
  var max=0.0.obs;
  var value=0.0.obs;
  var mainPlayer=false.obs;
  var repeat=true.obs;


  @override
  void onInit(){
    super.onInit();
    checkPermissions();
  }
  updatePosition(){
    audioPlayer.durationStream.listen((d) {
      duration.value=d.toString().split(".")[0];
      max.value=d!.inSeconds.toDouble();

    });
    audioPlayer.positionStream.listen((p) {
      position.value=p.toString().split(".")[0];
      value.value=p.inSeconds.toDouble();
    });

  }
  changeDurationToSeconds(seconds){
    var duration=Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }
  playSong(String? uri,index){
    playindex.value=index;
   try{
     audioPlayer.setAudioSource(
         AudioSource.uri(Uri.parse(uri!))
     );
     audioPlayer.play();
     mainPlayer(true);
     playing(true);
     updatePosition();
   }on Exception catch(e){
     print(e.toString());
   }
  }
  checkPermissions()async{
    var perm=await Permission.storage.request();
    if(perm.isGranted){
    }else{
      checkPermissions();
    }
  }

}