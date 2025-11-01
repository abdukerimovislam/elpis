allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory
    .dir("../../build")
    .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")

    // --- FIX FOR ISAR + AGP 8 (Namespace issue) ---
    // Используем plugins.withId вместо afterEvaluate, чтобы избежать ошибки "Project already evaluated"
    plugins.withId("com.android.library") {
        val android = extensions.findByName("android")
        if (android != null) {
            // Используем Java Reflection, чтобы не зависеть от версии Gradle и импортов
            try {
                val getNamespace = android.javaClass.getMethod("getNamespace")
                val currentNamespace = getNamespace.invoke(android)

                if (currentNamespace == null) {
                    val setNamespace = android.javaClass.getMethod("setNamespace", String::class.java)
                    // Устанавливаем namespace равным группе пакета (например, dev.isar.isar_flutter_libs)
                    setNamespace.invoke(android, group.toString())
                }
            } catch (e: Exception) {
                // Если метод не найден или другая ошибка — игнорируем, чтобы не ломать сборку
                println("Aura fix: Could not set namespace for ${project.name}")
            }
        }
    }
    // ---------------------------------------------
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}