part of 'add_new_projects_cubit.dart';

@immutable
abstract class AddNewProjectsState {}

class AddNewProjectsInitial extends AddNewProjectsState {}

class LoadingAddNewProject extends AddNewProjectsState {}

class ErrorAddNewProject extends AddNewProjectsState {}

class SuccessAddNewProject extends AddNewProjectsState {}

class ChangeDateState extends AddNewProjectsState {}

class ChangeImageState extends AddNewProjectsState {}
