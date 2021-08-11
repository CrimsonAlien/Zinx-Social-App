import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:zinx/ui/shared/app_colors.dart';
import 'package:zinx/viewmodels/LoadingScreenModel.dart';


class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoadingScreenModel>.reactive(
      onModelReady: (model) => model.handleLoginLogic(),
      builder: (context,model,child){
        final size = MediaQuery.of(context).size;
        final height = MediaQuery.of(context).size.height;
        print(height);

        return ResponsiveBuilder(
          builder: (context, sizingInformation) {

            if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
              return Container(color:Colors.blue);
            }

            if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
              return Container(color:Colors.red);
            }

            if (sizingInformation.deviceScreenType == DeviceScreenType.watch) {
              return Container(color:Colors.yellow);
            }

            return SafeArea(
                child: Scaffold(

                  backgroundColor: AppColor.purpleBrush,
                )


            );
          },


        );
      },

      viewModelBuilder: () =>LoadingScreenModel(),
    );
  }

}
