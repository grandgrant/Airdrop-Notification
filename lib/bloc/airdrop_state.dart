part of 'airdrop_bloc.dart';

@immutable
sealed class AirdropState extends Equatable {
  const AirdropState();
}

final class AirdropInitial extends AirdropState {
  const AirdropInitial();

  @override
  List<Object?> get props => [];
}

final class AirdropLoading extends AirdropState {
  @override
  List<Object?> get props => [];
}

final class AirdropLoaded extends AirdropState {
  final List<AirdropModel> listAirdrop;

  const AirdropLoaded(this.listAirdrop);

  @override
  List<Object?> get props => [listAirdrop];
}

final class AirdropError extends AirdropState {
  final String errMessage;

  const AirdropError(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}
