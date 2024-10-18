


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/const/basic_method.dart';
import '../common/widget/widget_custom_text_box.dart';
import '../provider/collection_of_basic_state_provider.dart';

class AlertContentForSliderWiget extends ConsumerWidget {
  final double initialValue;
  final double min;
  final double max;
  final String metric;
  final Function(double) onChange;
  const AlertContentForSliderWiget({
    super.key,
    required this.initialValue,
    required this.min,
    required this.max,
    required this.metric,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double maxWidth = (MediaQuery.of(context).size.width) * 0.8;
    double maxHeight = (MediaQuery.of(context).size.height) * 0.5;
    double fontSize = (maxWidth / 10).clamp(10, 22);
    double state = ref.watch(insertDoubleValueProvider(initialValue));
    // 값을 바꾸는 함수 설정
    return SizedBox(
      // color: constSemiLightColor,
      width: maxWidth,
      height: maxHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: maxWidth * 0.8,
            height: maxHeight * 0.1,
            child: Slider(
              min: min,
              max: max,
              divisions: ((max - min) / 0.1).round(),
              label: state.toStringAsFixed(1),
              value: state,
              onChanged: (newValue) {
                onChange(changeValue(state, newValue));
                
              },
            ),
          ),
    // 버튼을 통해서 5단위로 입력을 조절할 수 있게함
          SizedBox(
            width: maxWidth * 0.8,
            height: maxHeight * 0.2,
            child: Row(
              children: [
                SizedBox(
                  width: (maxWidth * 0.8) / 3,
                  child: IconButton(
                      onPressed: () {
                        onChange(changeValue(state, state-5));    
                      },
                      icon: Icon(
                        Icons.remove,
                        size: fontSize,
                      )),
                ),
                SizedBox(
                  width: (maxWidth * 0.8) / 3,
                  child: WidgetCustomTextBox(msg: "5", fontSize: fontSize),
                ),
                SizedBox(
                  width: (maxWidth * 0.8) / 3,
                  child: IconButton(
                      onPressed: () {
                        onChange(changeValue(state, state+5));        
                      },
                      icon: Icon(
                        Icons.add,
                        size: fontSize,
                      )),
                ),
              ],
            ),
          ),
    // 버튼을 통해서 1단위로 입력을 조절할 수 있게함
          SizedBox(
            width: maxWidth * 0.8,
            height: maxHeight * 0.2,
            child: Row(
              children: [
                SizedBox(
                  width: (maxWidth * 0.8) / 3,
                  child: IconButton(
                      onPressed: () {
                        onChange(changeValue(state, state-1));        
    
                      },
                      icon: Icon(
                        Icons.remove,
                        size: fontSize,
                      )),
                ),
                SizedBox(
                  width: (maxWidth * 0.8) / 3,
                  child: WidgetCustomTextBox(msg: "1", fontSize: fontSize),
                ),
                SizedBox(
                  width: (maxWidth * 0.8) / 3,
                  child: IconButton(
                      onPressed: () {
                        onChange(changeValue(state, state+1));        
    
                      },
                      icon: Icon(
                        Icons.add,
                        size: fontSize,
                      )),
                ),
              ],
            ),
          ),
    // 버튼을 통해서 0.1단위로 입력을 조절할 수 있게함
          SizedBox(
            width: maxWidth * 0.8,
            height: maxHeight * 0.2,
            child: Row(
              children: [
                SizedBox(
                  width: (maxWidth * 0.8) / 3,
                  child: IconButton(
                      onPressed: () {
                        onChange(changeValue(state, state-0.1));        
    
                      },
                      icon: Icon(
                        Icons.remove,
                        size: fontSize,
                      )),
                ),
                SizedBox(
                  width: (maxWidth * 0.8) / 3,
                  child: WidgetCustomTextBox(msg: "0.1", fontSize: fontSize),
                ),
                SizedBox(
                  width: (maxWidth * 0.8) / 3,
                  child: IconButton(
                      onPressed: () {
                        onChange(changeValue(state, state+0.1));        
                      },
                      icon: Icon(
                        Icons.add,
                        size: fontSize,
                      ),
                      ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetCustomTextBox(
                verAlign: 2,
                fontAlign: 2,
                width: (maxWidth * 0.8) /2,
                height: maxHeight*0.2,                  
                msg: state.toString(),
                fontSize: fontSize*1.4
                ),
              WidgetCustomTextBox(
                verAlign: 2,
                fontAlign: 0,
                width: (maxWidth * 0.8) / 4,
                height: maxHeight*0.2,                  
                msg: "  $metric",
                fontSize: fontSize
                ),
            ],
          )
        ],
      ),
    );
  }

  double changeValue(double value, double newValue) {
    if (newValue >= min && newValue <= max) {
      onChange(roundMethod(newValue));
      return roundMethod(newValue);
    }
    // print("state : $state");
    return value;
  }
} //end Class
