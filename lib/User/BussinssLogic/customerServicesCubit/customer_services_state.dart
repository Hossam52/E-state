part of 'customer_services_cubit.dart';

@immutable
abstract class CustomerServicesState {}

class CustomerServicesInitial extends CustomerServicesState {}

class LoadingSendMessageToCustomerServices extends CustomerServicesState {}

class SuccesSendMessageToCustomerServises extends CustomerServicesState {}

class ErrorSendMessageToCustomerServises extends CustomerServicesState {}

class ErrorInputTypedataCustmerServices extends CustomerServicesState {}
