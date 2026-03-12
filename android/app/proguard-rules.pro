## Flutter / Dart
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

## Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

## Firestore
-keep class com.google.cloud.firestore.** { *; }

## Firebase Auth
-keep class com.google.firebase.auth.** { *; }

## Audioplayers
-keep class xyz.luan.audioplayers.** { *; }

## Vibration
-keep class com.benjaminabel.vibration.** { *; }

## In App Review
-keep class com.google.android.play.core.** { *; }

## Share Plus
-keep class dev.fluttercommunity.plus.share.** { *; }

## Không xóa thông tin lỗi (giúp debug crash trên Google Play Console)
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

## Không cảnh báo các thư viện bên thứ ba
-dontwarn org.conscrypt.**
-dontwarn org.bouncycastle.**
-dontwarn org.openjsse.**
