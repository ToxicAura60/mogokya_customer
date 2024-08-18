import 'package:country_picker/country_picker.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app1/login/login.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  backgroundColor: Color(0xFFED5151),
                  content: Row(
                    children: [
                      Icon(
                        Icons.dangerous,
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(state.errorMessage!),
                    ],
                  )),
            );
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF5FAFF),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Halo!',
                    style: TextStyle(
                      fontSize: 80,
                      height: 1.2,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Daftar/masuk ke akun',
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nomor Hp",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            ),
                            onPressed: () {
                              showCountryPicker(
                                  showPhoneCode: true,
                                  context: context,
                                  onSelect: (country) {
                                    context.read<LoginCubit>().countryChanged(
                                          countryCode: country.countryCode,
                                          phoneCode: country.phoneCode,
                                        );
                                  });
                            },
                            child: BlocBuilder<LoginCubit, LoginState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    Text("+" + state.phoneCode),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flag.fromString(
                                      state.countryCode,
                                      height: 18,
                                      width: 24,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  context
                                      .read<LoginCubit>()
                                      .phoneNumberChanged(value);
                                },
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  fillColor: Color(0xFFFFFFFE),
                                  filled: true,
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "xxx-xxx-xxx",
                                  counterText: "",
                                ),
                                maxLength: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state.status.isInitial || state.status.isFailure) {
                        return GestureDetector(
                          onTap: () {
                            context.read<LoginCubit>().verifyPhoneNumber(
                              onCodeSent: () {
                                context.go('/login/verification');
                              },
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Lanjut',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF000000),
                                    borderRadius: BorderRadius.circular(15)),
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Icon(Icons.arrow_forward_rounded,
                                    color: Color(0xFFFFFFFE)),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return LoadingAnimationWidget.inkDrop(
                            color: Color(0xFF000000), size: 30);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
