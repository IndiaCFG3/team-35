import 'package:flutter/material.dart';
import 'package:anudip_foundation/components/rounded_button.dart';
import 'package:anudip_foundation/components/rounded_input_field.dart';
import 'package:anudip_foundation/constants.dart';
import 'package:anudip_foundation/crude.dart';
import 'Login/components/background.dart';
class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  Stream studentStream;
  CrudeMethods objCrude = CrudeMethods();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();

  }
  setData()async{
    var uidTemp=await objCrude.getUserId();
    objCrude.getImageData().then((value) {
      setState(() {
        studentStream=value;
        print(studentStream);
      });
    });
  }

  Widget StudentsList() {
    return studentStream !=  null    ?
    ListView(

      shrinkWrap: true,
      children:<Widget>[
        StreamBuilder(
          stream: studentStream,
          builder: (context,snapshot) {
            return snapshot.data ==null?Container(
              child: CircularProgressIndicator(),
            ): ListView.builder(
              itemCount: snapshot.data.documents.length,
              shrinkWrap: true,
              controller: _controller,
              itemBuilder: (context, index) {
                return CardData(
                  place : snapshot.data.documents[index].data['place'],
                  url:snapshot.data.documents[index].data['url'] ,
                );
              },);
          },

        ),
      ],
    )

        : Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String searchString;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Posts'),
        ),
        body:SingleChildScrollView(
          child: Background(
            child: Column(
              children: <Widget>[

                Container(
                  height: size.height * 0.8,
                  width: double.infinity,
                  child:StudentsList(),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
class CardData extends StatelessWidget {
  final String url,place;

  const CardData({Key key, this.url,this.place}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle text= TextStyle(fontSize: 20,fontWeight: FontWeight.w600);

    return  Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                url.toString(),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  place.toString(),
                  style: TextStyle(fontSize: 26, color:Colors.white70,fontWeight: FontWeight.w600),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
