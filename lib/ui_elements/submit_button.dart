import 'package:csh_app/my_theme.dart';
import 'package:flutter/material.dart';








class SubmitButton extends StatefulWidget {
  bool isLoading= false;
  List<bool> conditions =[];
  SubmitButton({ super.key,required this.isLoading,required this.conditions });

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {

  late bool isActive =false;
  late Color btnColor=MyTheme.grey_153;

  @override
  void initState() {
    checkButtonsIsActive();
    super.initState();
  }

  checkButtonsIsActive(){
    if(widget.isLoading){
      setState(() {
        btnColor=MyTheme.accent_color_shadow;
        
        
      });
    }
    if(!widget.conditions.first){
      return MyTheme.grey_153;
    }
    else{
      return MyTheme.accent_color;
    }


  }




  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}





// class SubmitButton {

//   late bool isButtonActive = false;

//   static bool checkisButtonActive(conditions){
//   return false;
// // _formKey.currentState == null ||
// //         !_formKey.currentState!.isValid ||
// //         categoriesIds.isEmpty


//   }

//   static Color bgColor() {
    

//     if (isButtonActive) {
//       return MyTheme.grey_153;
//     }
//     if (_isLoading) {
//       return MyTheme.accent_color_shadow;
//     }

//     return MyTheme.accent_color;
//   }

//   static Widget buildSubmitButton(text,conditions,isLoading){

//     return Container(child: Text('xx'),);
//     // return Padding(
//     //                       padding: const EdgeInsets.only(top: 8.0),
//     //                       child: SizedBox(
//     //                         width: 130,
//     //                         child: TextButton(
//     //                           style: TextButton.styleFrom(
//     //                             // primary: Colors.white,
//     //                             backgroundColor: bgColorSub(),
//     //                             shape: RoundedRectangleBorder(
//     //                                 borderRadius: BorderRadius.circular(8.0)),
//     //                             padding: !_isLoading
//     //                                 ? const EdgeInsets.symmetric(vertical: 12)
//     //                                 : null,
//     //                           ),
//     //                           onPressed: _formKey.currentState != null &&
//     //                                   _formKey.currentState!.isValid &&
//     //                                   categoriesIds.isNotEmpty
//     //                               ? () {
//     //                                   onPressedMerchantRegister();
//     //                                 }
//     //                               : null,
//     //                           child: _isLoading
//     //                               ? const SizedBox(
//     //                                   height: 36, // Set the desired height
//     //                                   child: LoadingIndicator(
//     //                                     indicatorType: Indicator.ballPulseSync,
//     //                                     colors: [
//     //                                       Color.fromARGB(255, 255, 255, 255)
//     //                                     ], // Customize the color if needed
//     //                                     strokeWidth:
//     //                                         2, // Customize the stroke width if needed
//     //                                     backgroundColor: Colors
//     //                                         .transparent, // Customize the background color if needed
//     //                                   ))
//     //                               : Text(
//     //                                   AppLocalizations.of(context)!.continue_b,
//     //                                   style: TextStyle(
//     //                                     color: MyTheme.white,
//     //                                     fontSize: 16,
//     //                                     fontWeight: FontWeight.normal,
//     //                                   ),
//     //                                 ),
//     //                         ),
//     //                       ),
//     //                     );

    
//   }  

// }