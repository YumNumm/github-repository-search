// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'theme_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ThemeModel {
  /// テーマモード
  ThemeMode get themeMode => throw _privateConstructorUsedError;

  /// 可能な場合、ダイナミックカラーを利用するか
  bool get useDynamicColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeModelCopyWith<ThemeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeModelCopyWith<$Res> {
  factory $ThemeModelCopyWith(
          ThemeModel value, $Res Function(ThemeModel) then) =
      _$ThemeModelCopyWithImpl<$Res, ThemeModel>;
  @useResult
  $Res call({ThemeMode themeMode, bool useDynamicColor});
}

/// @nodoc
class _$ThemeModelCopyWithImpl<$Res, $Val extends ThemeModel>
    implements $ThemeModelCopyWith<$Res> {
  _$ThemeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? useDynamicColor = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      useDynamicColor: null == useDynamicColor
          ? _value.useDynamicColor
          : useDynamicColor // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ThemeModelCopyWith<$Res>
    implements $ThemeModelCopyWith<$Res> {
  factory _$$_ThemeModelCopyWith(
          _$_ThemeModel value, $Res Function(_$_ThemeModel) then) =
      __$$_ThemeModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ThemeMode themeMode, bool useDynamicColor});
}

/// @nodoc
class __$$_ThemeModelCopyWithImpl<$Res>
    extends _$ThemeModelCopyWithImpl<$Res, _$_ThemeModel>
    implements _$$_ThemeModelCopyWith<$Res> {
  __$$_ThemeModelCopyWithImpl(
      _$_ThemeModel _value, $Res Function(_$_ThemeModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? useDynamicColor = null,
  }) {
    return _then(_$_ThemeModel(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      useDynamicColor: null == useDynamicColor
          ? _value.useDynamicColor
          : useDynamicColor // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ThemeModel implements _ThemeModel {
  const _$_ThemeModel(
      {this.themeMode = ThemeMode.system, this.useDynamicColor = true});

  /// テーマモード
  @override
  @JsonKey()
  final ThemeMode themeMode;

  /// 可能な場合、ダイナミックカラーを利用するか
  @override
  @JsonKey()
  final bool useDynamicColor;

  @override
  String toString() {
    return 'ThemeModel(themeMode: $themeMode, useDynamicColor: $useDynamicColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThemeModel &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.useDynamicColor, useDynamicColor) ||
                other.useDynamicColor == useDynamicColor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, themeMode, useDynamicColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ThemeModelCopyWith<_$_ThemeModel> get copyWith =>
      __$$_ThemeModelCopyWithImpl<_$_ThemeModel>(this, _$identity);
}

abstract class _ThemeModel implements ThemeModel {
  const factory _ThemeModel(
      {final ThemeMode themeMode, final bool useDynamicColor}) = _$_ThemeModel;

  @override

  /// テーマモード
  ThemeMode get themeMode;
  @override

  /// 可能な場合、ダイナミックカラーを利用するか
  bool get useDynamicColor;
  @override
  @JsonKey(ignore: true)
  _$$_ThemeModelCopyWith<_$_ThemeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
