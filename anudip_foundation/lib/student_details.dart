import 'package:flutter/material.dart';
import 'package:anudip_foundation/components/rounded_button.dart';
import 'package:anudip_foundation/components/rounded_input_field.dart';
import 'package:anudip_foundation/constants.dart';
import 'package:anudip_foundation/crude.dart';
import 'Login/components/background.dart';
class StudentDetails extends StatefulWidget {
  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
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
    objCrude.getSearchedData(uidTemp).then((value) {
      setState(() {
        studentStream=value;
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
                  name : snapshot.data.documents[index].data['studentName'],
                  coarse:snapshot.data.documents[index].data['course'] ,
                  region:snapshot.data.documents[index].data['region'] ,
                  desc: snapshot.data.documents[index].data['description'],
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
        body:SingleChildScrollView(
          child: Background(
            child: Column(
              children: <Widget>[
                Container(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    height: size.height*0.1,
                    width: double.infinity,
                    child: RoundedInputField(
                      hintText: 'search',
                      icon: Icons.search,
                      onChanged: (value){
                        setState(() {
                          searchString = value;
                        });
                      },
                    ),
                  ),
                ),
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
  final String name,coarse,region,desc;

  const CardData({Key key, this.name,this.region,this.desc,this.coarse}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle text= TextStyle(fontSize: 20,fontWeight: FontWeight.w600);

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        height: size.height*0.21,
        decoration: BoxDecoration(
            color: kPrimaryLightColor,

            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 10),
                blurRadius: 10,
              ),

            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Name:$name',textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25,),),
            Text('Course:$coarse',textAlign: TextAlign.center ,
              style:text),
            Text('Description:$desc',textAlign: TextAlign.center ,
                style:text),
            Text('Region:$region',textAlign: TextAlign.center ,
                style:text),
          ],
        ),
      ),
    );
  }
}
