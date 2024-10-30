import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Components/ColorStyle.dart';
import 'package:todo_app/Model/ManageSearchBox.dart';

class SearchLabel extends StatefulWidget{
  // late String label;
  // late bool isVisibility; 
  // SearchLabel({
  //   required String label,
  //   required bool visibilityState, 
  // }){
  //   this.label = label;
  //   this.isVisibility = visibilityState;
  // }
  @override
  State<StatefulWidget> createState() => _SearchLabelState();
}

class _SearchLabelState extends State<SearchLabel>{
  // late String label;
  // late bool isVisibility;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   label = widget.label;
  //   isVisibility = widget.isVisibility;
  // }
  @override
  Widget build(BuildContext context) {
    final searchModel = Provider.of<Managesearchbox>(context);
    return Visibility(
      visible: searchModel.isShowSearchResult,
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
            decoration: BoxDecoration(
              color: Colorstyle().btnColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              searchModel.keyword,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white
              ),
            ),
          ),
          Positioned(
            top: -5.0,
            right: -5.0,
            child: GestureDetector(
              onTap: (){
                searchModel.turnOffModeSearch();
              },
              child: Icon(
                Icons.close,
                size: 20,
                color: Colors.grey
              ),
            )
          ),
        ],
      )
    );
  }

}