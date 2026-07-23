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
import 'package:salon_app/features/bookings/data/datasource/booking_datasource.dart';
import 'package:salon_app/features/bookings/data/repository/booking_repoimplementation.dart';
import 'package:salon_app/features/bookings/domain/usecase/booking_usecase.dart';
import 'package:salon_app/features/bookings/presentation/bloc/booking_bloc.dart';
import 'package:salon_app/features/home/data/datasource/serviceuser_datasource.dart';
import 'package:salon_app/features/home/data/repository/serviceuser_repoimplementation.dart';
import 'package:salon_app/features/home/domain/usecase/serviceuser_usecase.dart';
import 'package:salon_app/features/home/presentation/bloc/service_user_bloc.dart';
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

  //servics and staffs
  final serviceRemote = ServiceUserRemoteDataSource(firestore);

  final serviceRepo = ServiceUserRepositoryImpl(serviceRemote);

  final getServices = GetServices(serviceRepo);
  final getStaffByService = GetStaffByService(serviceRepo);

  //booking
  final bookingRemote = BookingRemoteDataSource(firestore);
  final bookingRepo = BookingRepositoryImpl(bookingRemote);
  final bookingusecase = CreateBooking(bookingRepo);
  runApp(
    MyApp(
      useCases: useCases,
      profileusecase: profileusecase,
      getServices: getServices,
      getStaffByService: getStaffByService,
      bookingusecase: bookingusecase,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthUseCases useCases;
  final ProfileUseCases profileusecase;
  final GetServices getServices;
  final GetStaffByService getStaffByService;
  final CreateBooking bookingusecase;
  const MyApp({
    super.key,
    required this.useCases,
    required this.profileusecase,
    required this.getServices,
    required this.getStaffByService,
    required this.bookingusecase,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(useCases)),
        BlocProvider<ProfileBloc>(create: (_) => ProfileBloc(profileusecase)),
        BlocProvider<ServiceUserBloc>(
          create: (_) => ServiceUserBloc(getServices, getStaffByService),
        ),
        BlocProvider<BookingBloc>(create: (_)=>BookingBloc(bookingusecase)),
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
