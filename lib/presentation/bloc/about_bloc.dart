import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/domain/entities/about_data.dart';

part 'about_event.dart';
part 'about_state.dart';

// class AboutBloc extends Bloc<AboutEvent, AboutData> {
//   AboutBloc() : super(AboutData.empty()) {
//     on<AddAboutData>((AddAboutData event, emit) async {
//       // handle incoming `AddAboutData` event

//       emit(state.copyWith(
//         birthday: event.aboutData.birthday,
//         displayName: event.aboutData.displayName,
//         gender: event.aboutData.gender,
//         zodiac: event.aboutData.zodiac,
//         height: event.aboutData.height,
//         horoscope: event.aboutData.horoscope,
//         pathImage: event.aboutData.pathImage,
//         weight: event.aboutData.weight,
//       ));
//     });
//   }
// }

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutState.init()) {
    ///[AddAboutData] to hold value on properties AboutData
    on<AboutAddData>((AboutAddData event, Emitter<AboutState> emit) async {
      // handle incoming `AddAboutData` event
      AboutData? data = event.aboutData.copyWith(
        displayName: event.aboutData.displayName ?? state.aboutData.displayName,
        birthday: event.aboutData.birthday ?? state.aboutData.birthday,
        gender: event.aboutData.gender ?? state.aboutData.gender,
        height: event.aboutData.height ?? state.aboutData.height,
        horoscope: event.aboutData.horoscope ?? state.aboutData.horoscope,
        pathImage: event.aboutData.pathImage ?? state.aboutData.pathImage,
        weight: event.aboutData.weight ?? state.aboutData.weight,
        zodiac: event.aboutData.zodiac ?? state.aboutData.zodiac,
      );
      emit(state.copyWith(status: AboutStatus.isEditing, aboutData: data));
      // emit(state.copyWith(
      //   birthday: event.aboutData.birthday,
      //   displayName: event.aboutData.displayName,
      //   gender: event.aboutData.gender,
      //   zodiac: event.aboutData.zodiac,
      //   height: event.aboutData.height,
      //   horoscope: event.aboutData.horoscope,
      //   pathImage: event.aboutData.pathImage,
      //   weight: event.aboutData.weight,
      // ));
    });

    ///[AboutEditPressed] to change edit state , when edit state true displaying form add data, vice versa
    on<AboutEditPressed>((AboutEditPressed event, Emitter<AboutState> emit) async {
      // handle incoming `AddAboutData` event
      emit(state.copyWith(status: AboutStatus.isEditing));
    });

    ///[AboutSavePressed] save data has been editing
    on<AboutSavePressed>((AboutSavePressed event, Emitter<AboutState> emit) async {
      // handle incoming `AddAboutData` event
      emit(state.copyWith(
        status: AboutStatus.doneEdit,
        aboutData: state.aboutData,
      ));
    });
  }
}
