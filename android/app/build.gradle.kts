// (Импорты должны быть в самом верху)
import java.util.Properties
import java.io.FileInputStream
import org.gradle.api.GradleException

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
}

fun localProperties(): Properties {
    val properties = Properties()
    val localPropertiesFile = rootProject.file("local.properties")
    if (localPropertiesFile.exists()) {
        properties.load(localPropertiesFile.inputStream())
    }
    return properties
}

val releaseKeyPropertiesFile = rootProject.file("key.properties")
val hasReleaseSigning = releaseKeyPropertiesFile.exists()
val isReleaseTaskRequested = gradle.startParameter.taskNames.any {
    it.contains("release", ignoreCase = true)
}
val releaseKeyProperties = Properties().apply {
    if (hasReleaseSigning) {
        load(FileInputStream(releaseKeyPropertiesFile))
    }
}

android {
    namespace = "com.midas.bloom_mama" // (Убедитесь, что здесь ваше уникальное имя)
    compileSdk = 36 // <-- ИСПРАВЛЕНО (было 34)
    ndkVersion = "27.0.12077973"

    compileOptions {
        // --- ДОБАВЛЕНО (для Ошибки 1) ---
        isCoreLibraryDesugaringEnabled = true
        // ---
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
        }
    }

    defaultConfig {
        applicationId = "com.midas.bloom_mama" // (Убедитесь, что здесь ваше уникальное имя)
        minSdk = flutter.minSdkVersion
        targetSdk = 35 // <-- ИСПРАВЛЕНО (было 34)
        versionCode = 1
        versionName = "1.0.0"
    }

    // (Этот блок для подписи релиза)
    signingConfigs {
        if (hasReleaseSigning) {
            create("release") {
                storeFile = file(releaseKeyProperties.getProperty("storeFile"))
                storePassword = releaseKeyProperties.getProperty("storePassword")
                keyAlias = releaseKeyProperties.getProperty("keyAlias")
                keyPassword = releaseKeyProperties.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            if (hasReleaseSigning) {
                signingConfig = signingConfigs.getByName("release")
            }
        }
    }
}

if (isReleaseTaskRequested && !hasReleaseSigning) {
    throw GradleException(
        "Release signing is not configured. Add android/key.properties and a keystore before building a release."
    )
}

flutter {
    source = "../.."
}

dependencies {
    // --- ДОБАВЛЕНО (для Ошибки 1) ---
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.appcompat:appcompat:1.6.1")
}
