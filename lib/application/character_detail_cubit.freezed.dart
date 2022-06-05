// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'character_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CharacterDetailState {
  Character get character => throw _privateConstructorUsedError;
  List<Episode> get episodes => throw _privateConstructorUsedError;
  BlocStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CharacterDetailStateCopyWith<CharacterDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterDetailStateCopyWith<$Res> {
  factory $CharacterDetailStateCopyWith(CharacterDetailState value,
          $Res Function(CharacterDetailState) then) =
      _$CharacterDetailStateCopyWithImpl<$Res>;
  $Res call({Character character, List<Episode> episodes, BlocStatus status});
}

/// @nodoc
class _$CharacterDetailStateCopyWithImpl<$Res>
    implements $CharacterDetailStateCopyWith<$Res> {
  _$CharacterDetailStateCopyWithImpl(this._value, this._then);

  final CharacterDetailState _value;
  // ignore: unused_field
  final $Res Function(CharacterDetailState) _then;

  @override
  $Res call({
    Object? character = freezed,
    Object? episodes = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      character: character == freezed
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as Character,
      episodes: episodes == freezed
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
    ));
  }
}

/// @nodoc
abstract class _$$_CharacterDetailStateCopyWith<$Res>
    implements $CharacterDetailStateCopyWith<$Res> {
  factory _$$_CharacterDetailStateCopyWith(_$_CharacterDetailState value,
          $Res Function(_$_CharacterDetailState) then) =
      __$$_CharacterDetailStateCopyWithImpl<$Res>;
  @override
  $Res call({Character character, List<Episode> episodes, BlocStatus status});
}

/// @nodoc
class __$$_CharacterDetailStateCopyWithImpl<$Res>
    extends _$CharacterDetailStateCopyWithImpl<$Res>
    implements _$$_CharacterDetailStateCopyWith<$Res> {
  __$$_CharacterDetailStateCopyWithImpl(_$_CharacterDetailState _value,
      $Res Function(_$_CharacterDetailState) _then)
      : super(_value, (v) => _then(v as _$_CharacterDetailState));

  @override
  _$_CharacterDetailState get _value => super._value as _$_CharacterDetailState;

  @override
  $Res call({
    Object? character = freezed,
    Object? episodes = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_CharacterDetailState(
      character: character == freezed
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as Character,
      episodes: episodes == freezed
          ? _value._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
    ));
  }
}

/// @nodoc

class _$_CharacterDetailState implements _CharacterDetailState {
  const _$_CharacterDetailState(
      {required this.character,
      required final List<Episode> episodes,
      required this.status})
      : _episodes = episodes;

  @override
  final Character character;
  final List<Episode> _episodes;
  @override
  List<Episode> get episodes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  @override
  final BlocStatus status;

  @override
  String toString() {
    return 'CharacterDetailState(character: $character, episodes: $episodes, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CharacterDetailState &&
            const DeepCollectionEquality().equals(other.character, character) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(character),
      const DeepCollectionEquality().hash(_episodes),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_CharacterDetailStateCopyWith<_$_CharacterDetailState> get copyWith =>
      __$$_CharacterDetailStateCopyWithImpl<_$_CharacterDetailState>(
          this, _$identity);
}

abstract class _CharacterDetailState implements CharacterDetailState {
  const factory _CharacterDetailState(
      {required final Character character,
      required final List<Episode> episodes,
      required final BlocStatus status}) = _$_CharacterDetailState;

  @override
  Character get character => throw _privateConstructorUsedError;
  @override
  List<Episode> get episodes => throw _privateConstructorUsedError;
  @override
  BlocStatus get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CharacterDetailStateCopyWith<_$_CharacterDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}
