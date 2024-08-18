import 'package:app1/login/login.dart';
import 'package:app1/phone_verification/bloc/timer_bloc.dart';
import 'package:app1/phone_verification/cubit/phone_verification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';

class PhoneVerificationView extends StatelessWidget {
  const PhoneVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Verifikasi Nomor \nTelepon",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Kami telah mengirimkan 6 digit kode OTP ke nomor telepon berikut.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "+${context.read<LoginCubit>().state.phoneCode} ${context.read<LoginCubit>().state.phoneNumber}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF737373),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<PhoneVerificationCubit, PhoneVerificationState>(
                    builder: (context, state) {
                      return Pinput(
                        errorText: state.errorMessage,
                        forceErrorState: state.status.isFailure ? true : false,
                        errorPinTheme: PinTheme(
                          textStyle: const TextStyle(
                            color: Color(0xFFED5151),
                            fontWeight: FontWeight.w600,
                          ),
                          height: 70,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFED5151),
                              width: 2,
                            ),
                          ),
                        ),
                        defaultPinTheme: PinTheme(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          height: 70,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF1FA),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        length: 6,
                        onCompleted: (pin) {
                          context
                              .read<PhoneVerificationCubit>()
                              .verifyPhoneNumber();
                        },
                        onChanged: (value) {
                          context
                              .read<PhoneVerificationCubit>()
                              .pinChanged(value);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      const Text("Tidak menerima kode OTP? "),
                      const SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<TimerBloc, TimerState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              state.duration > 0
                                  ? null
                                  : context.read<TimerBloc>().add(
                                        TimerStarted(duration: 60),
                                      );
                              //context.read<LoginCubit>().verifyPhoneNumber();
                            },
                            child: Text(
                              state.duration > 0
                                  ? "Kirim ulang dalam ${state.duration}"
                                  : "Kirim ulang",
                              style: state.duration > 0
                                  ? TextStyle(
                                      color: Color(0xFF999999),
                                      fontWeight: FontWeight.w600,
                                    )
                                  : TextStyle(
                                      color: Color(0xFFFF8324),
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                      decorationColor: Color(0xFFFF8324),
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<PhoneVerificationCubit,
                        PhoneVerificationState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          child: BlocBuilder<PhoneVerificationCubit,
                              PhoneVerificationState>(
                            builder: (context, state) {
                              if (state.status.isInProgress) {
                                return LoadingAnimationWidget.waveDots(
                                  color: Color(0xFFFFFFFF),
                                  size: 20,
                                );
                              } else {
                                return Text(
                                  'Lanjutkan',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                            },
                          ),
                          onPressed: () {
                            state.status.isInitial
                                ? context
                                    .read<PhoneVerificationCubit>()
                                    .verifyPhoneNumber()
                                : null;
                          },
                          style: state.status.isFailure
                              ? ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFACACAC))
                              : ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF262626),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
