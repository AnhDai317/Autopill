plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.autopill"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        
        // SỬA LẠI DÒNG NÀY (Thêm "is" và dấu "="):
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID
        applicationId = "com.example.autopill"
        
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    // SỬA LẠI CÚ PHÁP DEPENDENCIES (Thêm ngoặc đơn và ngoặc kép):
    
    // Lưu ý: Nếu dòng này báo lỗi $kotlin_version, bạn có thể tạm thời comment nó lại vì Flutter thường tự xử lý Kotlin rồi.
    // implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version")

    // THÊM DÒNG NÀY (Chuẩn cú pháp Kotlin):
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}

flutter {
    source = "../.."
}