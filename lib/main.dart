import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_app/features/auth/data/datasource/auth_datasource_implementation.dart';
import 'package:salon_app/features/auth/data/repositoy/repository_implementation.dart';
import 'package:salon_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:salon_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:salon_app/features/auth/presentation/ui/screen_login.dart';
import 'package:salon_app/features/profile/data/datasource/profile_datasorceimplementation.dart';
import 'package:salon_app/features/profile/data/datasource/profile_datasource.dart';
import 'package:salon_app/features/profile/data/repository/profile_repositoryimpl.dart';
import 'package:salon_app/features/profile/domain/usecase/profile_usecase.dart';
import 'package:salon_app/features/profile/presentation/bloc/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  final remoteDataSource = AuthRemoteDataSourceImpl(auth, firestore);
  final repository = AuthRepositoryImpl(remoteDataSource);
  final useCases = AuthUseCases(repository);

  final profileDataSource = ProfileDatasorceimplementation(
    firestore: firestore,
  );
  final profilerepository = ProfileRepositoryImpl(remote: profileDataSource);
  final profileusecase = ProfileUseCases(repository: profilerepository);
  runApp(MyApp(useCases: useCases,profileusecase: profileusecase,));
}

class MyApp extends StatelessWidget {
  final AuthUseCases useCases;
  final ProfileUseCases profileusecase;
  const MyApp({super.key, required this.useCases,required this.profileusecase});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AuthBloc>(create: (_) => AuthBloc(useCases)),
      BlocProvider<ProfileBloc>(create: (_)=>ProfileBloc(profileusecase))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: LoginScreen(),
      ),
    );
  }
}
