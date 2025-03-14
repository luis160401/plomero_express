// Configuración de repositorios para todos los subproyectos
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Directorio de compilación personalizado
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Asegura que todos los subproyectos dependen de ":app"
subprojects {
    project.evaluationDependsOn(":app")
}

// Limpieza de archivos de compilación
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// 🔥 Agregar el bloque de configuración de Gradle Build Tools y Google Services
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.1.0") // Ajusta la versión si es necesario
        classpath("com.google.gms:google-services:4.3.15") // 🔥 Agrega Google Services
    }
}