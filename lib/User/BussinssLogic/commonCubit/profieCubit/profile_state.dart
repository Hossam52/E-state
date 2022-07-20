part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class LoadingGetProfileStatus extends ProfileState {}

class SuccessGetProfileStatus extends ProfileState {}

class ChangeVisibility extends ProfileState {}

class LoadingChangePassStatus extends ProfileState {}

class SuccessChangePassStatus extends ProfileState {}

class ErrorChangePassStatus extends ProfileState {}

class ChangeImageState extends ProfileState{}

class LoadingUploadStatus extends ProfileState {}

class SuccessUploadStatus extends ProfileState {}

class ErrorUploadStatus extends ProfileState {}

class ChangeMessageText extends ProfileState{}