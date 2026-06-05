# Karate API Testing — Proyecto Base

Proyecto de automatización de pruebas de API REST construido con **Karate DSL**, **JUnit 5**, **Gradle** y **Cucumber Reporting**. Está diseñado para ser utilizado como **plantilla base**: se clona, se renombran los identificadores del proyecto y se apunta a la API objetivo sin modificar la infraestructura de testing.

---

## Tabla de contenidos

1. [Prerequisitos](#prerequisitos)
2. [Cómo usar este proyecto como base](#cómo-usar-este-proyecto-como-base)
3. [Estructura del proyecto](#estructura-del-proyecto)
4. [build.gradle — explicación detallada](#buildgradle)
5. [karate-config.js — explicación detallada](#karate-configjs)
6. [KarateRunner.java — explicación detallada](#karaterunnerjava)
7. [CucumberReport.java — explicación detallada](#cucumberreportjava)
8. [.gitignore — explicación detallada](#gitignore)
9. [Comandos de ejecución](#comandos-de-ejecución)
10. [Sistema de tags](#sistema-de-tags)

---

## Prerequisitos

| Herramienta | Versión mínima | Verificar con |
|---|---|---|
| Java JDK | 11 | `java -version` |
| Gradle | 7.x | `gradle -v` (o usar el wrapper `./gradlew`) |
| Git | cualquiera | `git --version` |

> Se recomienda usar el Gradle Wrapper incluido (`gradlew` / `gradlew.bat`) para garantizar la misma versión en todos los entornos.

---

## Cómo usar este proyecto como base

Este repositorio está pensado para ser clonado cada vez que se necesite automatizar una nueva API. Los pasos para adaptarlo son:

### 1. Clonar el repositorio

```bash
git clone https://github.com/thegoodalejo/Demo-karate.git mi-nuevo-proyecto
cd mi-nuevo-proyecto
```

### 2. Renombrar el proyecto

Editar `settings.gradle` (o la primera línea de `build.gradle`):

```groovy
// Antes
rootProject.name = 'mi-proyecto-karate'

// Después
rootProject.name = 'nombre-de-tu-proyecto'
```

Editar el `group` en `build.gradle`:

```groovy
// Antes
group = 'com.tuempresa'

// Después
group = 'com.nombreempresa'
```

Renombrar el nombre del proyecto en `CucumberReport.java`:

```java
// Antes
Configuration configuration = new Configuration(reportOutputDirectory, "mi-proyecto-karate");

// Después
Configuration configuration = new Configuration(reportOutputDirectory, "nombre-de-tu-proyecto");
```

### 3. Apuntar a la nueva API

Editar `karate-config.js` — cambiar la URL base y definir los endpoints del nuevo servicio:

```javascript
var baseUrl = karate.properties['baseUrl'] || 'https://tu-nueva-api.com';

var miEndpoint = '/api/v1/recurso';
```

O pasar la URL en tiempo de ejecución sin tocar el código:

```bash
./gradlew test -DbaseUrl=https://tu-nueva-api.com
```

### 4. Agregar nuevas carpetas de features y schemas

```
src/test/resources/karate/nombre-servicio/
src/test/resources/request/nombre-servicio/
```

### 5. Agregar el endpoint al return de `karate-config.js`

```javascript
return Object.assign(
  { baseUrl:       baseUrl       },
  { miEndpoint:    miEndpoint    }
);
```

### 6. Desconectar del repositorio original y vincular al nuevo

```bash
git remote remove origin
git remote add origin https://github.com/tu-usuario/tu-nuevo-repo.git
git push -u origin trunk
```

---

## Estructura del proyecto

```
mi-proyecto-karate/
│
├── build.gradle                        # Configuración de Gradle (dependencias, compilación, ejecución)
├── settings.gradle                     # Nombre del proyecto raíz
├── .gitignore                          # Archivos excluidos del control de versiones
│
├── src/
│   └── test/
│       ├── java/
│       │   ├── karate/
│       │   │   └── KarateRunner.java   # Punto de entrada principal — lanza todos los tests en paralelo
│       │   └── utils/
│       │       └── CucumberReport.java # Genera el reporte HTML con gráficas al finalizar
│       │
│       └── resources/
│           ├── karate-config.js        # Configuración global: URL base, endpoints, timeouts, SSL
│           │
│           ├── karate/                 # Features organizados por servicio
│           │   ├── activities/         # Escenarios positivos y negativos del servicio Activities
│           │   ├── authors/            # Escenarios positivos y negativos del servicio Authors
│           │   ├── books/              # Escenarios positivos y negativos del servicio Books
│           │   ├── coverphotos/        # Escenarios positivos y negativos del servicio CoverPhotos
│           │   └── users/              # Escenarios positivos y negativos del servicio Users
│           │
│           └── request/               # Schemas JSON organizados por servicio
│               ├── activities/
│               │   ├── request-body.json       # Payload para POST y PUT
│               │   └── response-schema.json    # Esquema de validación del response
│               ├── authors/
│               ├── books/
│               ├── coverphotos/
│               └── users/
```

### Convención de nombres de features

| Prefijo del archivo | Tipo de escenario |
|---|---|
| `obtener-todos-los-*.feature` | GET all — lista completa |
| `obtener-*-por-id.feature` | GET by ID — happy path |
| `crear-*.feature` | POST — happy path |
| `actualizar-*.feature` | PUT — happy path |
| `eliminar-*.feature` | DELETE — happy path |
| `obtener-*-no-encontrado.feature` | GET — recurso inexistente (404) |
| `obtener-*-id-invalido.feature` | GET — ID con formato inválido (400) |
| `crear-*-datos-invalidos.feature` | POST — body inválido o vacío (400) |
| `actualizar-*-no-encontrado.feature` | PUT — recurso inexistente (404) |
| `eliminar-*-no-encontrado.feature` | DELETE — recurso inexistente (404) |

---

## build.gradle

### `rootProject.name`

```groovy
rootProject.name = 'mi-proyecto-karate'
```

Nombre del proyecto. Aparece en los reportes de Gradle y en el artefacto generado. **Primer elemento a cambiar al clonar.**

---

### `plugins { id 'java' }`

```groovy
plugins {
    id 'java'
}
```

Activa el plugin de Java en Gradle, que habilita la compilación, el test runner y la gestión de sourceSets. Sin este plugin no existe el task `test` ni la carpeta `src/test`.

---

### `group` y `version`

```groovy
group   = 'com.tuempresa'
version = '1.0-SNAPSHOT'
```

- `group`: identifica la organización o empresa. Se usa en el nombre del artefacto Maven (`group:artifact:version`). **Cambiar al clonar.**
- `version`: versión del artefacto. `SNAPSHOT` indica que es una versión en desarrollo no publicada oficialmente.

---

### `ext {}` — Versiones centralizadas

```groovy
ext {
    karateCoreVersion    = '1.4.1'
    karateApacheVersion  = '0.9.6'
    cucumberVersion      = '5.7.5'
    lombokVersion        = '1.18.34'
}
```

`ext` es un mapa de propiedades globales accesibles en todo el `build.gradle`. Centralizar las versiones aquí significa que al actualizar una librería se cambia **un solo número** y el cambio se propaga a todas las dependencias que lo referencian. Sin esto, si Karate saca una nueva versión habría que buscar y reemplazar en múltiples líneas con riesgo de inconsistencias.

---

### `java {}` — Compatibilidad de versión

```groovy
java {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
}
```

- `sourceCompatibility`: define qué sintaxis de Java puede usar el código fuente. Con `VERSION_11` no se pueden usar features de Java 17+ (records, sealed classes, etc.).
- `targetCompatibility`: define para qué JVM se genera el bytecode. El `.class` compilado correrá en cualquier JVM 11 o superior.

**Por qué importa en equipos:** si cada developer tiene una JDK diferente (11, 17, 21), sin esta configuración cada uno podría compilar con su versión local generando bytecode incompatible. Esto garantiza que todos producen el mismo output independientemente del JDK instalado. Es especialmente crítico en pipelines de CI/CD donde el agente puede tener una JDK diferente a la del developer.

---

### `tasks.withType(JavaCompile)` — Codificación UTF-8

```groovy
tasks.withType(JavaCompile) {
    options.encoding = 'UTF-8'
}
```

Fuerza que el compilador `javac` lea todos los archivos `.java` usando UTF-8. Sin esto, el compilador usa la codificación del sistema operativo:

- **Windows**: `Cp1252` o `windows-1252` por defecto
- **Linux/Mac**: `UTF-8` por defecto

Si el código tiene tildes, eñes o cualquier caracter especial en Strings o comentarios, un developer en Windows sin esta configuración puede generar bytecode con caracteres corruptos que solo falla en producción (Linux). Esta línea elimina esa clase de bugs.

---

### `repositories`

```groovy
repositories {
    mavenCentral()
}
```

Le dice a Gradle dónde buscar y descargar las dependencias. `mavenCentral()` apunta al repositorio central de Maven (https://repo.maven.apache.org), que es el repositorio público más grande y confiable de librerías Java.

---

### `dependencies {}` — Dependencias

```groovy
dependencies {
    testImplementation "com.intuit.karate:karate-core:${karateCoreVersion}"
    testImplementation "com.intuit.karate:karate-apache:${karateApacheVersion}"
    testImplementation "net.masterthought:cucumber-reporting:${cucumberVersion}"
    testImplementation "org.json:json:20231013"
    compileOnly         "org.projectlombok:lombok:${lombokVersion}"
    annotationProcessor "org.projectlombok:lombok:${lombokVersion}"
}
```

| Dependencia | Scope | Para qué |
|---|---|---|
| `karate-core` | `testImplementation` | Motor principal de Karate: DSL, runner, assertions, lógica de features |
| `karate-apache` | `testImplementation` | Cliente HTTP basado en Apache HttpClient — es quien realiza las llamadas REST |
| `cucumber-reporting` | `testImplementation` | Genera el reporte HTML con gráficas de passed/failed a partir de los JSON de Karate |
| `org.json:json` | `testImplementation` | Manipulación de JSON en Java puro (parsear, construir, leer nodos) |
| `lombok` | `compileOnly` | Genera getters/setters/constructores con anotaciones en tiempo de compilación |
| `lombok` | `annotationProcessor` | Procesador de anotaciones necesario para que Lombok funcione — no va al JAR final |

**Por qué Lombok va como `compileOnly` y no `testImplementation`:** Lombok solo existe en tiempo de compilación. Genera código Java antes de que el compilador procese el archivo — el bytecode final ya contiene los métodos generados y no necesita Lombok en runtime. Si se pusiera como `testImplementation`, se incluiría innecesariamente en el classpath de ejecución.

---

### `test {}` — Configuración del task de tests

```groovy
test {
    useJUnitPlatform()
    include '**/karate/**'

    systemProperty 'karate.options', System.properties.getProperty('karate.options')
    systemProperty 'karate.env',     System.properties.getProperty('karate.env')
    systemProperty 'baseUrl',        System.properties.getProperty('baseUrl', 'https://fakerestapi.azurewebsites.net')

    outputs.upToDateWhen { false }
    testLogging.showStandardStreams = true

    testLogging {
        events 'passed', 'skipped', 'failed'
    }
}
```

| Configuración | Para qué |
|---|---|
| `useJUnitPlatform()` | Le dice a Gradle que use JUnit 5 como test runner (sin esto buscaría JUnit 4) |
| `include '**/karate/**'` | Filtra qué clases ejecutar — solo las que estén bajo un paquete llamado `karate`. Evita que `gradle test` mezcle runners de otros frameworks si coexisten en el mismo proyecto |
| `systemProperty 'karate.options'` | Reenvía la propiedad `-Dkarate.options` al proceso JVM de tests. Permite filtrar por tags desde la línea de comandos |
| `systemProperty 'karate.env'` | Reenvía el ambiente activo (`dev`, `qa`, `prod`). Karate carga automáticamente `karate-config-qa.js` si existe |
| `systemProperty 'baseUrl'` | Reenvía la URL base con fallback al default. Permite cambiar la API objetivo sin tocar el código |
| `outputs.upToDateWhen { false }` | Deshabilita el cache incremental de Gradle. Sin esto, si el código no cambió Gradle se saltea los tests diciendo `UP-TO-DATE`. Para tests de API el estado del servidor externo puede cambiar, entonces siempre deben correr |
| `testLogging.showStandardStreams` | Muestra en consola la salida de `System.out` y logs de Karate en tiempo real |
| `testLogging { events }` | Imprime en consola cada test marcado como `passed`, `skipped` o `failed` durante la ejecución |

---

### `sourceSets {}` — Fuentes del proyecto

```groovy
sourceSets {
    test {
        java {
            srcDir file('src/test/java')
        }
        resources {
            srcDir file('src/test/java')
            exclude '**/*.java'
        }
    }
}
```

**El problema que resuelve:** En un proyecto Karate estándar, los archivos `.feature`, `.json` y `.js` viven en `src/test/java` junto a los runners Java. Esto rompe la convención Maven/Gradle donde `src/test/java` es solo código compilable y `src/test/resources` son recursos estáticos.

Por defecto, Gradle **no copia** archivos no-Java de `src/test/java` al classpath, entonces Karate no encontraría los `.feature` en runtime.

La solución:
1. `java { srcDir ... }` → Gradle compila los `.java` de esa carpeta
2. `resources { srcDir ... exclude '**/*.java' }` → Gradle también copia todos los demás archivos (`.feature`, `.json`, `.js`) al directorio de build, haciéndolos disponibles en el classpath

---

## karate-config.js

```javascript
function fn() {
  var baseUrl = karate.properties['baseUrl'] || 'https://fakerestapi.azurewebsites.net';
  // ...
  return Object.assign({ baseUrl: baseUrl }, { miEndpoint: miEndpoint });
}
```

Este archivo es el **núcleo de la configuración global de Karate**. Se ejecuta automáticamente antes de cada feature y todo lo que retorna queda disponible como variable global en cualquier `.feature` del proyecto.

### `karate.properties['baseUrl']`

Lee la propiedad del sistema inyectada por Gradle. El flujo es:

```
Línea de comandos: -DbaseUrl=https://staging.api.com
        ↓
build.gradle: systemProperty 'baseUrl', System.properties.getProperty('baseUrl', 'https://...')
        ↓
karate-config.js: karate.properties['baseUrl']
        ↓
Feature: * url baseUrl
```

El `|| 'https://...'` es el fallback para cuando no se pasa ningún valor, permitiendo correr los tests localmente sin configuración adicional.

### Variables de endpoints

```javascript
var activitiesEndpoint = '/api/v1/Activities';
```

Centralizar los paths de la API en un único lugar garantiza que si un endpoint cambia de nombre, se modifica en un solo lugar y el cambio se propaga a todos los features que lo usan. En los features se consume como:

```gherkin
Given path activitiesEndpoint, 1
# Equivale a: GET /api/v1/Activities/1
```

### `karate.configure()`

| Configuración | Valor | Por qué |
|---|---|---|
| `connectTimeout` | 10000 ms | Tiempo máximo para establecer la conexión TCP con el servidor. Sin esto un servidor caído dejaría el test colgado indefinidamente |
| `readTimeout` | 20000 ms | Tiempo máximo esperando la respuesta una vez conectado. Cubre endpoints lentos o con procesamiento pesado |
| `ssl` | true | Deshabilita la validación de certificados SSL. Necesario en ambientes de QA/staging con certificados auto-firmados |
| `logPrettyRequest` | true | Imprime el request HTTP formateado en consola — facilita el debugging |
| `logPrettyResponse` | true | Imprime el response JSON formateado — permite ver de un vistazo qué devuelve la API |

### `Object.assign()`

Fusiona múltiples objetos en el return. Permite organizar las variables en grupos lógicos a medida que el archivo crece, sin perder legibilidad:

```javascript
return Object.assign(
  { baseUrl: baseUrl },           // URL base
  { activitiesEndpoint: '...' },  // Endpoints de Activities
  { authorsEndpoint: '...' }      // Endpoints de Authors
);
```

**Al clonar:** Borrar los endpoints del servicio anterior y definir los del nuevo servicio. El bloque `karate.configure()` y la lógica de `baseUrl` no requieren cambios.

---

## KarateRunner.java

```java
class KarateRunner {

    public KarateRunner() { super(); }

    @Test
    void testParallel() {
        Results results = Runner
                .path("classpath:karate")
                .outputCucumberJson(true)
                .parallel(3);

        CucumberReport.createCucumberReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
```

Es el **punto de entrada principal** del proyecto. Es la única clase que JUnit 5 ejecuta directamente.

### `Runner.path("classpath:karate")`

Le dice a Karate que escanee recursivamente todo lo que esté bajo `src/test/resources/karate/` buscando archivos `.feature`. Al agregar una nueva carpeta de servicio dentro de `karate/`, el runner la descubre automáticamente sin necesidad de modificar este archivo.

Para restringir la ejecución a una sola carpeta:

```java
Runner.path("classpath:karate/activities")
```

### `.outputCucumberJson(true)`

Indica a Karate que genere archivos `.json` con los resultados en formato compatible con Cucumber. Estos JSON son los que consume `CucumberReport` para construir el reporte HTML. Sin esta línea el reporte visual no tiene datos.

### `.parallel(3)`

Ejecuta los features en 3 threads simultáneos, reduciendo significativamente el tiempo total de ejecución en suites grandes. El número óptimo depende de:

- **Cores del servidor CI**: no tiene sentido usar más threads que cores disponibles
- **Capacidad de la API bajo prueba**: si el servidor no soporta carga concurrente, reducir a 1

Para ejecución secuencial: `.parallel(1)` o cambiar a `.karateEnv("qa")...`

### `assertEquals(0, results.getFailCount(), results.getErrorMessages())`

Hace fallar el build de Gradle si algún escenario falló. Sin esta línea, el task `gradle test` reportaría `BUILD SUCCESSFUL` aunque hubiera features rotos, lo que invalida el propósito de tener CI/CD.

El tercer parámetro es el mensaje de error — `results.getErrorMessages()` incluye el detalle de cada fallo, permitiendo diagnosticar sin abrir el reporte.

---

## CucumberReport.java

```java
public static void createCucumberReport(String reportDir) {
    File reportOutputDirectory = new File(reportDir);

    List<String> jsonFiles = new ArrayList<>();
    File[] files = reportOutputDirectory.listFiles((dir, name) -> name.endsWith(".json"));
    if (files != null) {
        for (File file : files) {
            jsonFiles.add(file.getAbsolutePath());
        }
    }

    Configuration configuration = new Configuration(reportOutputDirectory, "mi-proyecto-karate");
    ReportBuilder reportBuilder = new ReportBuilder(jsonFiles, configuration);
    reportBuilder.generateReports();
}
```

Toma el directorio donde Karate dejó los archivos `.json` con los resultados, los recopila y se los pasa a la librería `net.masterthought:cucumber-reporting` que genera un reporte HTML completo con:

- Gráficas de passed / failed / skipped
- Tiempo de ejecución por feature y scenario
- Detalle de cada step con request/response
- Línea de tiempo de ejecución paralela

El reporte se genera en la misma carpeta que los `.json`, dentro de `build/`.

**Al clonar:** Cambiar `"mi-proyecto-karate"` por el nombre del nuevo proyecto — ese string aparece como título en el reporte HTML.

### ¿Por qué no usa Karate's built-in report?

Karate genera su propio reporte HTML básico. `CucumberReport` agrega un segundo reporte con más detalle visual, historial de ejecuciones y es más fácil de compartir con stakeholders no técnicos que solo quieren ver el semáforo verde/rojo.

---

## .gitignore

```
build/           # Clases compiladas, JARs y reportes generados — se regeneran con gradle build
.gradle/         # Cache interno de Gradle — específico de cada máquina
*.class          # Archivos compilados Java — siempre derivados del código fuente
*.log            # Logs de ejecución — no tienen valor en el historial de cambios
.idea/           # Configuración de IntelliJ IDEA — cada developer tiene la suya
*.iml            # Archivos de módulo de IntelliJ — idem
.vscode/         # Configuración de VSCode — local por developer
karate-reports/  # Reportes generados por ejecuciones locales de Karate
```

**Nota sobre `.vscode/`:** El archivo `.vscode/settings.json` que suprime los falsos positivos de la extensión Cucumber no está versionado porque `.vscode/` está en el `.gitignore`. Si se quiere compartir esa configuración con el equipo, hay dos opciones:

```bash
# Opción 1: Sacar .vscode del .gitignore
# Editar .gitignore y eliminar la línea '.vscode/'
# Luego: git add .vscode/settings.json

# Opción 2: Versionar solo el settings.json ignorando el resto
# Agregar al .gitignore:
.vscode/*
!.vscode/settings.json
```

---

## Comandos de ejecución

### Ejecución completa

```bash
./gradlew test
```

### Cambiar la URL base en tiempo de ejecución

```bash
./gradlew test -DbaseUrl=https://staging.miapi.com
./gradlew test -DbaseUrl=https://prod.miapi.com
./gradlew test -DbaseUrl=http://localhost:8080
```

### Filtrar por ambiente (Karate env)

```bash
./gradlew test -Dkarate.env=qa
./gradlew test -Dkarate.env=prod
```

Karate carga automáticamente `karate-config-qa.js` si existe, permitiendo configs distintas por ambiente.

### Filtrar por tags

```bash
# Solo smoke tests (un scenario representativo por comportamiento)
./gradlew test -Dkarate.options="--tags @smoke"

# Solo un servicio
./gradlew test -Dkarate.options="--tags @activities"
./gradlew test -Dkarate.options="--tags @books"

# Solo escenarios negativos
./gradlew test -Dkarate.options="--tags @negativo"

# Solo escenarios negativos de un servicio
./gradlew test -Dkarate.options="--tags @activities and @negativo"

# Solo recursos no encontrados (404)
./gradlew test -Dkarate.options="--tags @not-found"

# Excluir los negativos
./gradlew test -Dkarate.options="--tags not @negativo"

# Combinaciones: smoke de books y users
./gradlew test -Dkarate.options="--tags (@books or @users) and @smoke"
```

### Filtrar por tags + ambiente + URL

```bash
./gradlew test \
  -DbaseUrl=https://staging.miapi.com \
  -Dkarate.env=qa \
  -Dkarate.options="--tags @smoke"
```

---

## Sistema de tags

Cada feature y scenario tiene tags que permiten filtrar ejecuciones de forma granular:

| Tag | Nivel | Descripción |
|---|---|---|
| `@activities` | Feature | Todos los tests del servicio Activities |
| `@authors` | Feature | Todos los tests del servicio Authors |
| `@books` | Feature | Todos los tests del servicio Books |
| `@coverphotos` | Feature | Todos los tests del servicio CoverPhotos |
| `@users` | Feature | Todos los tests del servicio Users |
| `@negativo` | Feature | Todos los escenarios de fallo y flujos alternos |
| `@smoke` | Scenario | Un escenario representativo del happy path — para validaciones rápidas |
| `@get-all` | Scenario | GET de lista completa |
| `@get-by-id` | Scenario | GET por identificador |
| `@get-by-book` | Scenario | GET por ID de libro (Authors y CoverPhotos) |
| `@create` | Scenario | POST — creación |
| `@update` | Scenario | PUT — actualización |
| `@delete` | Scenario | DELETE — eliminación |
| `@not-found` | Scenario | Recurso no encontrado (404) |
| `@id-invalido` | Scenario | ID con formato inválido (400) |
| `@cuerpo-vacio` | Scenario | Request body vacío |
| `@tipos-invalidos` | Scenario | Request body con tipos de datos incorrectos |
| `@coleccion-vacia` | Scenario | Response vacío esperado (200 con `[]`) |

---

## Agregar un nuevo servicio

Al clonar y apuntar a una nueva API, el flujo para agregar un servicio es:

1. **Crear las carpetas**
   ```
   src/test/resources/karate/nombre-servicio/
   src/test/resources/request/nombre-servicio/
   ```

2. **Crear los schemas JSON**
   ```
   request/nombre-servicio/request-body.json    ← payload de POST/PUT
   request/nombre-servicio/response-schema.json ← esquema de validación con tipos Karate (#number, #string?, etc.)
   ```

3. **Agregar el endpoint en `karate-config.js`**
   ```javascript
   var nombreServicioEndpoint = '/api/v1/NombreServicio';
   // Y agregarlo al return:
   { nombreServicioEndpoint: nombreServicioEndpoint }
   ```

4. **Crear los features** siguiendo la convención de nombres del proyecto (ver tabla de estructura)

5. **El `KarateRunner` los ejecuta automáticamente** — no requiere modificación porque escanea `classpath:karate` recursivamente
