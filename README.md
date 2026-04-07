# Actividad 2: Automatización y Despliegue Controlado en AWS

**Autor:** Armando Betancourt
**Curso:** Fundamentos de DevOps
**Institución:** Tecmilenio

---

## 1. Descripción del Proyecto

Este proyecto implementa una solución de automatización para la gestión de infraestructura en la nube utilizando Amazon Web Services (AWS). El desarrollo consta de una serie de scripts diseñados bajo principios de modularidad y escalabilidad, permitiendo la administración de instancias EC2 y la generación de respaldos en S3 de manera eficiente.

La solución se centra en la eliminación de valores estáticos (hardcoding) y en la integración de un flujo de orquestación que simula un entorno de despliegue controlado.

---

## 2. Estructura del Repositorio

* ec2/: Contiene la lógica en Python (Boto3) para la gestión de instancias
* s3/: Contiene el script en Bash para compresión y respaldo
* config/: Archivos de configuración
* logs/: Registro de ejecuciones
* deploy.sh: Script principal de orquestación

---

## 3. Componentes de la Solución

### Gestión de Instancias (EC2)

Se desarrolló un script en Python utilizando Boto3 que permite listar, iniciar, detener y terminar instancias mediante parámetros.

### Backup y Almacenamiento (S3)

Script en Bash que valida directorios, comprime archivos con tar y los sube a un bucket S3.

### Orquestador de Despliegue

El script deploy.sh ejecuta de forma secuencial la gestión de EC2 y el backup en S3, incluyendo validaciones y logs.

---

## 4. Instrucciones de Uso

Comando:
./deploy.sh <accion_ec2> <instance_id> <directorio_local> <nombre_bucket>

Ejemplo:
./deploy.sh iniciar i-0abc123def456789 ./mi_data backup-servidor-01

---

## 5. Estrategia de Control de Versiones (Flujo Git)

* main: versión estable
* develop: integración de cambios
* feature/: desarrollo de funcionalidades

Se utilizaron commits progresivos para mantener control del proyecto.

---

## 6. Justificación Técnica y Reflexión

### Commits Progresivos

Permiten controlar cada cambio y facilitar la detección de errores.

### Evitar el Hardcoding

El uso de parámetros permite reutilizar scripts sin modificar código.

### Rol de deploy.sh

Centraliza la ejecución de procesos y reduce errores manuales.

### Uso de Configuración

Facilita mantenimiento y cambios sin afectar la lógica.

---

## 7. Justificación

En este proyecto realicé la implementación de una solución basada en scripts para automatizar la gestión de recursos en AWS, específicamente en los servicios de EC2 y S3, así como su integración mediante un script de despliegue.

En primer lugar, desarrollé scripts reutilizables, ya que cada componente fue construido de manera modular. El script de EC2 permite gestionar instancias de forma independiente, el script de S3 se encarga exclusivamente de los respaldos, y el script deploy.sh integra ambos procesos. Esta separación permite reutilizar cada script en distintos escenarios sin necesidad de modificar su estructura interna.

Asimismo, apliqué la separación entre configuración y lógica mediante el uso de parámetros de entrada. Esto evita el uso de valores fijos dentro del código, permitiendo que los scripts sean más flexibles y adaptables a diferentes entornos, instancias o buckets sin realizar cambios en la implementación.

Finalmente, logré una automatización real del flujo de trabajo, ya que el script deploy.sh coordina la ejecución de múltiples tareas de forma secuencial, incluyendo la gestión de instancias EC2, la generación de backups en S3 y el registro de logs. Esto reduce la intervención manual, minimiza errores humanos y mejora la eficiencia en la administración de la infraestructura.
