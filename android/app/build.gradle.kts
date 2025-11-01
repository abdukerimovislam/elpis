// (Импорты должны быть в самом верху)
import java.util.Properties
import java.io.FileInputStream
import org.gradle.api.GradleException

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

fun localProperties(): Properties {
    val properties = Properties()
    val localPropertiesFile = rootProject.file("local.properties")
    if (localPropertiesFile.exists()) {
        properties.load(localPropertiesFile.inputStream())
    }
    return properties
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
        create("release") {
            try {
                val props = Properties()
                props.load(FileInputStream(file("../key.properties")))
                storeFile = file(props.getProperty("storeFile"))
                storePassword = props.getProperty("storePassword")
                keyAlias = props.getProperty("keyAlias")
                keyPassword = props.getProperty("keyPassword")
            } catch (e: java.io.FileNotFoundException) {
                throw GradleException("Failed to read key.properties. Make sure the file is in the 'android' directory.", e)
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
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // --- ДОБАВЛЕНО (для Ошибки 1) ---
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.appcompat:appcompat:1.6.1")
}
