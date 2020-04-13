class Song{
  final String song1;
  final String song2;
  Song({this.song1,this.song2});

   factory Song.fromJson(Map<String,dynamic> json){
    return new Song(song1:json['song1'],song2: json['song2']);
  }
}