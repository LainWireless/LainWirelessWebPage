+++
title = "Despliegue una página web estática"
weight = 15
chapter = false
author = "Iván Piña Castillo"
cover = "/img/cloud/aws/web/Portada.png"
tags = ["DevOps", "GitOps", "CI/CD", "AWS", "Terraform", "Serverless", "GitHub Actions", "Hugo", "GitHub", "CloudFront", "S3", "ACM", "IAM", "AWS CLI", "Cloud9", "EC2"]
description = "Documentación del proceso realizado para el despliegue de mi blog personal."
readingTime = true
hideComments = true
+++

## **1. Introducción**

El propósito fundamental de este proyecto radica en establecer una **página web estática** mediante un flujo de **Integración Continua/Entrega Continua (CI/CD)** con **GitHub Actions**. Este flujo automatizado despliega la web en **AWS** a partir de archivos **markdown** que subimos al repositorio. Específicamente, los archivos estáticos residirán en un **bucket de S3**.

La gestión de la **infraestructura** se llevará a cabo mediante **Terraform**.

De esta forma, cualquier modificación que realicemos en el repositorio se reflejará automáticamente en la web.

La automatización de tareas es una práctica ampliamente adoptada en el mundo IT, especialmente en la filosofía **DevOps**. Este enfoque nos permite ahorrar tiempo y esfuerzo, al mismo tiempo que reduce la posibilidad de cometer errores.

Por ello, resulta valioso iniciar el aprendizaje con un proyecto de menor envergadura como este, que nos permitirá familiarizarnos con las tecnologías a utilizar y establecerá una base sólida para proyectos más complejos.

Este enfoque nos brinda también la posibilidad de **poner en marcha una web estática (ligera) sin costo adicional**, utilizando los **niveles gratuitos de AWS** ([lista de servicios gratuitos](https://aws.amazon.com/es/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all)).

El único gasto a considerar será el registro de un dominio.

{{% notice tip %}}
En mi caso, he usado [PiensaSolutions](https://www.piensasolutions.com/) ya que ofrece dominios a precios muy competitivos.
{{% /notice %}}

{{% notice info %}}
Podríamos obtener un dominio con Route 53 para mantenernos dentro del ecosistema de AWS, aunque suele ser más costoso en comparación con otros proveedores (según disponibilidad y ofertas).
{{% /notice %}}

#### **Tecnologías**

### **1.1. Amazon Web Services (AWS)**

- [Amazon Web Services](https://aws.amazon.com/es/) se destaca como un proveedor líder de servicios en la nube, ofreciendo una amplia gama de soluciones que abarcan desde almacenamiento y computación hasta bases de datos y más, en el ámbito del cloud computing.

A lo largo de este proyecto, se hará uso de varios servicios clave de AWS:

- **IAM**: [Identity and Access Management](https://aws.amazon.com/es/iam/)  proporciona una gestión segura de acceso a los recursos de AWS. Permite la creación de usuarios con permisos específicos para administrar los recursos, siguiendo las mejores prácticas al evitar el uso del usuario root de la cuenta.

- **ACM**: [Amazon Certificate Manager](https://aws.amazon.com/es/certificate-manager/) facilita la gestión de certificados SSL/TLS para los dominios utilizados.

- **S3**: [Amazon Simple Storage Service](https://aws.amazon.com/es/s3/) es un servicio de almacenamiento de objetos que ofrece escalabilidad, seguridad y rendimiento. Se empleará para almacenar los archivos estáticos de la web.

- **CloudFront**: [Amazon CloudFront](https://aws.amazon.com/es/cloudfront/) actúa como una Content Delivery Network (CDN), permitiendo la distribución de contenido global con baja latencia y velocidades de transferencia rápidas. Aunque su impacto puede ser limitado en este proyecto debido a la cantidad modesta de contenido, explorar su funcionamiento resulta valioso para proyectos futuros más complejos.

- **AWS CLI**: [AWS Command Line Interface](https://aws.amazon.com/es/cli/) es una herramienta que facilita la interacción con los servicios de AWS mediante la línea de comandos. Se utilizará para cargar archivos estáticos en S3.

- **Cloud9**: [AWS Cloud9](https://aws.amazon.com/es/cloud9/) es un entorno de desarrollo integrado (IDE) basado en la nube que permite escribir, ejecutar y depurar código desde un navegador web. Se utilizará como entorno para trabajar con nuestro repositorio de GitHub.

{{% notice info %}}
Es relevante destacar que AWS ofrece diversas ubicaciones (regiones) para implementar recursos. En este caso, la infraestructura se situará en la región us-east-1 (Norte de Virginia) debido a su amplia disponibilidad de servicios e integraciones.
{{% /notice %}}

### **1.2. Terraform**

- [Terraform](https://www.terraform.io/) es una potente herramienta de infraestructura como código (IaC). Su función principal radica en la creación, modificación y versionado seguro y eficiente de la infraestructura en distintos proveedores de servicios en la nube. Este proyecto empleará Terraform para la construcción de la infraestructura necesaria en AWS.

### **1.3. Hugo**

- [Hugo](https://gohugo.io/) reconocido como el generador de sitios web estáticos más veloz según su propia web, es un framework escrito en Go. Su utilidad principal en este proyecto reside en la capacidad para generar la web a partir de los archivos markdown que se subirán al repositorio de GitHub.

### **1.4. GitHub Actions**

- [GitHub Actions](https://github.com/features/actions) destaca como un servicio de integración y entrega continua (CI/CD). Este servicio automatiza tareas críticas al detectar cambios en el repositorio, ejecutando los pasos necesarios para generar y desplegar la web en AWS. GitHub Actions se comunica con Hugo, Terraform y AWS CLI durante este proceso de forma coordinada.

## **2. Preparación del entorno**

Antes de sumergirnos en la configuración de la infraestructura, es crucial preparar nuestro entorno de trabajo.

Si aún no cuentas con una cuenta en Amazon Web Services(AWS) y GitHub, este es el momento oportuno para crearlas antes de proceder. Estas plataformas serán fundamentales para el desarrollo y despliegue exitoso de nuestro proyecto..

### **2.1. Configuración de la MFA**

Lo primero que se debe hacer es configurar la autenticación multifactor (MFA). Dado que AWS es un servicio que podría generar considerables gastos en tu cuenta bancaria, cualquier medida adicional de protección contra posibles robos de credenciales debería ser considerada.

Para configurar la MFA, accederemos a la consola web de AWS y buscaremos el servicio IAM. Una vez dentro, veremos una notificación indicando que MFA no está activado para nuestra cuenta. Deberemos seguir las instrucciones proporcionadas para activarlo.

![AWS-MFA](/img/cloud/aws/web/AWS-MFA.png)

En mi caso he usado la app [Aegis](https://getaegis.app) debido a su código abierto y su efectividad.

![AWS-MFA2](/img/cloud/aws/web/AWS-MFA2.png)

Con MFA activado, el siguiente paso es crear un usuario alternativo al usuario root de la cuenta de AWS.

### **2.2. Creación del usuario de IAM**

Crearemos un usuario con acceso programático. Accederemos como usuario root a la consola web de AWS y buscaremos el servicio IAM:

![IAM1](/img/cloud/aws/web/IAM1.png)

Nos dirigimos a la sección de usuarios y crearemos un nuevo usuario:

![IAM2](/img/cloud/aws/web/IAM2.png)

Le asignaremos un nombre (**ataraxia**) al usuario:

![IAM3](/img/cloud/aws/web/IAM3.png)

En la siguiente pantalla, seleccionaremos la opción **Permissions policies** y buscaremos la política **AdministratorAccess**:

![IAM4](/img/cloud/aws/web/IAM4.png)

Haremos clic, asignaremos etiquetas según sea necesario, revisaremos que todo esté correcto y crearemos el usuario:

![IAM5](/img/cloud/aws/web/IAM5.png)

Con el usuario creado, es necesario generar credenciales de acceso. Para ello, haremos clic en el usuario:

![IAM6](/img/cloud/aws/web/IAM6.png)

Y seleccionaremos **Security credentials**:

![IAM7](/img/cloud/aws/web/IAM7.png)

Bajamos hasta la sección **Access Keys** y elegimos **Create access key**:

![IAM8](/img/cloud/aws/web/IAM8.png)

Seleccionaremos el caso de uso:

![IAM9](/img/cloud/aws/web/IAM9.png)

En la siguiente pantalla, podremos asignar una descripción a la clave si lo consideramos necesario. Una vez hecho esto, habríamos terminado de crear la clave:

![IAM10](/img/cloud/aws/web/IAM10.png)

{{% notice warning %}}
En este punto se nos mostrará la clave de acceso y la clave secreta. Debemos guardarlas en un lugar seguro ya que no volveremos a tener acceso a la clave secreta.
{{% /notice %}}

{{% notice info %}}
A partir de este punto, nos loguearemos con el usuario que acabamos de crear.
{{% /notice %}}

### **2.3. Creación del certificado SSL**

Para habilitar HTTPS en nuestra web, es necesario obtener un certificado SSL. Para lograrlo de forma gratuita y sencilla, utilizaremos AWS Certificate Manager (ACM).

Accederemos a la consola web de AWS y buscaremos el servicio ACM:

![ACM1](/img/cloud/aws/web/ACM1.png)

Seleccionaremos **Request a certificate** y elige el tipo **Public**:

![ACM2](/img/cloud/aws/web/ACM2.png)

![ACM3](/img/cloud/aws/web/ACM3.png)

En la siguiente pantalla, introduciremos nuestro dominio (en mi caso, lainwireless.es y www.lainwireless.es). Las demás opciones pueden permanecer por defecto (Validación DNS y RSA 2048):

![ACM4](/img/cloud/aws/web/ACM4.png)

![ACM5](/img/cloud/aws/web/ACM5.png)

Una vez completado, podremos ver el certificado y una notificación indicando que está pendiente de validación:

![ACM6](/img/cloud/aws/web/ACM6.png)

Para validar el certificado, necesitaremos crear un registro DNS. Los datos necesarios se encuentran en el certificado:

![ACM7](/img/cloud/aws/web/ACM7.png)

Copiaremos estos datos y accederemos a nuestro proveedor de dominio. Agregaremos los registros DNS correspondientes y esperaremos a que se validen:

![ACM8](/img/cloud/aws/web/ACM8.png)

Después de unos minutos, el certificado estará validado:

![ACM9](/img/cloud/aws/web/ACM9.png)

Ahora que disponemos del certificado SSL, podremos proceder a crear el repositorio para subir el código que generaremos a continuación.

### **2.4. Creación del nuestro entorno IDE en Cloud9**

Accederemos a la consola web de AWS y buscaremos el servicio Cloud9:

![Cloud91](/img/cloud/aws/web/Cloud91.png)

Crearemos un nuevo entorno, le daremos un nombre, una descripción y el tipo de entorno que queremos (en mi caso, New EC2 instance):

![Cloud92](/img/cloud/aws/web/Cloud92.png)

Procederemos tambien a seleccionar el tipo de instancia que queremos usar (en mi caso, t2.micro), la plataforma (en mi caso, Amazon Linux 2) y el timeout (en mi caso, 30 minutos):

![Cloud93](/img/cloud/aws/web/Cloud93.png)

En cuanto a la configuración de la red, dejaremos todo por defecto que es AWS Systems Manager (SSM):

![Cloud94](/img/cloud/aws/web/Cloud94.png)

Tras revisar que todo esté correcto, crearemos el entorno:

![Cloud95](/img/cloud/aws/web/Cloud95.png)

Al acceder nos encontraremos con una terminal que además tendrá un editor de texto, un explorador de archivos y muchísimas más opciones que nos facilitarán el trabajo:

![GitHub1](/img/cloud/aws/web/GitHub1.png)

### **2.5. Creación del repositorio de GitHub**

Para la gestión del código, usaremos Git y GitHub. Primero crearemos una clave SSH para poder conectarnos a GitHub sin necesidad de introducir usuario y contraseña cada vez que hagamos un push. Para ello, ejecutaremos los siguientes comandos en la terminal de Cloud9:

```bash
ssh-keygen -t rsa
cat /home/ec2-user/.ssh/id_rsa.pub
```

Nos dirigiremos a nuestro GitHub y accederemos a la configuración de nuestra cuenta:

![GitHub4](/img/cloud/aws/web/GitHub4.png)

En la sección de SSH and GPG keys, crearemos una nueva clave SSH:

![GitHub5](/img/cloud/aws/web/GitHub5.png)

Le daremos un nombre y pegaremos la clave que nos ha generado Cloud9:

![GitHub6](/img/cloud/aws/web/GitHub6.png)

Con la clave SSH creada, crearemos un repositorio en GitHub (en mi caso llamado `LainWirelessWebPage`).

![GitHub7](/img/cloud/aws/web/GitHub7.png)

A continuación, crearemos una carpeta local en Cloud9 para almacenar todo el código que generaremos, y la conectaremos a nuestro repositorio remoto:

```bash
mkdir LainWirelessWebPage
cd LainWirelessWebPage
echo "# LainWireless Web Page" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:LainWireless/LainWirelessWebPage.git
git push -u origin main
```

Estos comandos crean la estructura básica de un repositorio local, lo inicializan como un repositorio Git, añaden un archivo README, realizan el primer commit, establecen la rama principal como "main", conectan el repositorio local con el remoto en GitHub y finalmente, suben el código al repositorio remoto. Ahora tendremos nuestro repositorio creado y vinculado a nuestra carpeta local, listo para almacenar el código del proyecto.

## **3. Terraform**

Para la configuración de nuestra infraestructura, utilizaremos Terraform, una herramienta de código abierto desarrollada por HashiCorp que nos permite crear, modificar y versionar la infraestructura de forma sencilla mediante un enfoque **declarativo**. 

Los archivos de configuración de Terraform se escriben en el lenguaje HCL (HashiCorp Configuration Language).

Nuestro flujo de trabajo con Terraform consta de 3 fases:

- **terraform init**: Inicializa nuestro proyecto, descargando los plugins necesarios para los proveedores que hemos declarado en nuestra configuración (en este caso, AWS). 

- **terraform plan**: Revisa los cambios que se van a realizar según los archivos de configuración que hemos escrito.

- **terraform apply**: Aplica los cambios que se mostraron en la fase anterior.

Cada objeto gestionado por Terraform es un recurso, que puede ser una instancia, una base de datos, un certificado, entre otros. Gestiona el ciclo de vida de los recursos de manera integral, desde su creación hasta su destrucción. Terraform se encargará de crear, modificar y eliminar los recursos que definamos en nuestros archivos de configuración.

Si algún recurso es modificado de manera paralela a través de la consola web de AWS u otra herramienta, al ejecutar posteriormente un terraform apply, Terraform se asegurará de restaurar el recurso al estado que definimos en nuestros archivos de configuración, revirtiendo los cambios realizados.

Los cambios en el estado de la infraestructura son guardados por Terraform en un archivo de estado. Este archivo puede almacenarse localmente o en un backend remoto. Dado el alcance de nuestro proyecto, optaremos por guardar el archivo de estado en un bucket de S3 (backend remoto). Por lo tanto, es necesario crear el bucket antes de empezar con la configuración de Terraform.


### **3.1. Creación del bucket de S3 para el estado remoto**

Accedemos a la consola web de AWS y buscamos el servicio S3, para posteriormente crear un bucket:

![S31](/img/cloud/aws/web/S31.png)

Asignamos un nombre único (`lainwireless-terraform-state`) al bucket y seleccionamos la región de preferencia (us-east-1). No es necesario realizar ajustes en las demás opciones, dejándolas en sus valores predeterminados:

![S32](/img/cloud/aws/web/S32.png)

![S33](/img/cloud/aws/web/S33.png)

Con el bucket creado para el almacenamiento remoto del estado, ahora podemos avanzar hacia la configuración de Terraform.

### **3.2. Configuración de Terraform**

En el repositorio que creamos anteriormente, estableceremos una nueva carpeta llamada Terraform con varios archivos de configuración. Para organizar de manera eficiente, optaré por crear un archivo para cada recurso. A continuación, se presentan los archivos necesarios y su estructura:

```bash
mkdir Terraform
cd Terraform
touch remote-state.tf provider.tf variables.tf bucket-s3.tf cloudfront.tf
```

- **remote-state.tf**: Archivo de configuración del estado remoto.

```terraform
/*
  remote-state.tf
  Archivo de configuración del estado remoto.
*/

terraform {
  backend "s3" {
    bucket = "lainwireless-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

{{% notice info %}}
Este archivo establece la configuración para el estado remoto, indicando el uso del servicio S3 como backend.
{{% /notice %}}

- **provider.tf**: Archivo con la configuración de los providers de Terraform. Un provider es un plugin que nos permite interactuar con un proveedor de infraestructura (en nuestro caso, AWS).

```terraform
/*
  providers.tf
  Archivo con la configuración de los providers de Terraform. Un provider es un plugin que nos permite interactuar con un proveedor de infraestructura (en nuestro caso, AWS).
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
```

{{% notice info %}}
En este archivo, especificamos que requerimos el provider de AWS (hashicorp/aws) con una versión igual o superior a la 5.0.0. Además, se le pasa la región a través de una variable.
{{% /notice %}}

- **variables.tf**: Archivo con las variables que usaremos en los archivos de configuración de los recursos.

```terraform
/*
  variables.tf
  Archivo con las variables que usaremos en los archivos de configuración de los recursos.

  Variables en uso en los ficheros:
    - providers.tf
    - bucket-s3.tf
    - cloudfront.tf
*/

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "domain" {
  type = string
  default = "www.lainwireless.es"
}

variable "aws_arn_certificado" {
  type = string
  default = "arn:aws:acm:us-east-1:413330159251:certificate/9f9c1db3-e440-4ed0-b3a0-5081b3c68824"
}
```

{{% notice info %}}
Aquí, definimos la región de AWS que usaremos, dándole el valor por defecto de us-east-1 (Norte de Virginia), el dominio de nuestra web y el ARN (Amazon Resource Name) del certificado SSL que creamos anteriormente.
{{% /notice %}}

- **bucket-s3.tf**: Archivo de configuración del bucket de S3.

```terraform
/*
  bucket-s3.tf
  Archivo de configuración del bucket de S3.
*/

// Creación del bucket de S3 con el nombre de la variable "domain":
resource "aws_s3_bucket" "bucket-s3" {
  bucket = var.domain
  force_destroy = true
}

// Configuración para habilitar el almacenamiento de sitios web estáticos en el bucket de S3:
resource "aws_s3_bucket_website_configuration" "bucket-s3-static" {
  bucket = aws_s3_bucket.bucket-s3.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "404.html"
  }
}

// Configuraciones para habilitar el acceso público al bucket de S3:
resource "aws_s3_bucket_public_access_block" "bucket-s3-public" {
  bucket = aws_s3_bucket.bucket-s3.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket-s3-policy" {
  bucket = aws_s3_bucket.bucket-s3.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.bucket-s3.arn}/*"
        ]
      }
    ]
  })
}
```

{{% notice info %}}
Este archivo define la creación del bucket de S3, configurándolo para habilitar el almacenamiento de sitios web estáticos, permitir acceso público y establecer una política de acceso.
{{% /notice %}}

- **cloudfront.tf**: Archivo de configuración para la distribución de CloudFront.

```terraform
/*
  cloudfront.tf
  Archivo de configuración para la distribución de CloudFront.
*/

// Política de caché para la distribución de CloudFront:
data "aws_cloudfront_cache_policy" "Managed-CachingOptimized" {
  id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
}

// Creación de la distribución de CloudFront:
resource "aws_cloudfront_distribution" "cloudfront" {
  enabled             = true
  is_ipv6_enabled     = false
  aliases = [var.domain]
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket_website_configuration.bucket-s3-static.website_endpoint
    origin_id   = aws_s3_bucket_website_configuration.bucket-s3-static.website_endpoint
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket_website_configuration.bucket-s3-static.website_endpoint
    cache_policy_id = data.aws_cloudfront_cache_policy.Managed-CachingOptimized.id
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn = var.aws_arn_certificado
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
```

{{% notice info %}}
En este archivo, se define la creación de la distribución de CloudFront, indicando su configuración, política de caché, origen y demás parámetros.
{{% /notice %}}

Ahora que tenemos estos archivos listos, los subimos a GitHub:

```bash
git add .
git commit -m "Archivos Terraform"
git push
```

Nuestra estructura de archivos debería verse así (aprovecho para enseñaros también como se ve usando Cloud9):

![Terraform1](/img/cloud/aws/web/Terraform1.png)

## **4. Hugo**

### **4.1. Instalación y configuración de Hugo**

Para la creación de la web estática, utilizaremos Hugo. En mi caso, he instalado Hugo en mi entorno de desarrollo siguiendo estos pasos:

```bash
wget https://github.com/gohugoio/hugo/releases/download/v0.120.3/hugo_0.120.3_Linux-64bit.tar.gz
tar zxvf hugo_0.120.3_Linux-64bit.tar.gz
mkdir -p ~/bin
mv hugo ~/bin/
rm hugo_0.120.3_Linux-64bit.tar.gz README.md LICENSE
```

Para asegurarnos de que Hugo se ha instalado correctamente, ejecutamos los siguientes comando:

```bash
wich hugo
hugo version
```

![Hugo1](/img/cloud/aws/web/Hugo1.png)

Luego, creamos la carpeta del nuevo sitio de la siguiente manera:

```bash
cd LainWirelessWebPage
hugo new site "LainWireless"
cd LainWireless
```

Instalamos el tema que queramos, en mi caso, [Learn](https://learn.netlify.app/en/):

```bash
git submodule add https://github.com/matcornic/hugo-theme-learn.git themes/learn
```

o

```bash
git clone https://github.com/matcornic/hugo-theme-learn.git themes/learn
```

En la primera opción, se crea un submódulo, que es una referencia a un repositorio externo, en este caso, el tema. En la segunda opción, se clona el repositorio directamente. En mi caso, he usado la segunda opción ya que quiero que el tema forme parte de mi repositorio para poder modificarlo si lo necesito.

Para configurar el tema, editaremos el archivo config.toml según la [documentación](https://learn.netlify.app/en/basics/configuration/) y lo ajustaremos a nuestro gusto.

{{% notice warning %}}
Para evitar problemas, he eliminado el parámetro baseURL del archivo config.toml, como se indica en [esta issue de GitHub](https://github.com/gohugoio/hugo/issues/8587#issuecomment-851018525). Ya que al mantener este parámetro, podríamos experimentar problemas al cargar la web en AWS.
{{% /notice %}}

Para crear nuevas entradas, podemos ejecutar comandos como los siguientes:

```bash
hugo new --kind chapter basics/_index.md
hugo new basics/first-content.md
hugo new basics/second-content/_index.md
hugo new posts/entrada-prueba.md
```

Esto creará los archivos markdown correspondientes a cada entrada con el contenido por defecto. También podemos crear archivos markdown vacíos y editarlos a nuestro gusto o cargar archivos markdown ya existentes.

Tras redactarla, podemos ver el resultado con:

```bash
hugo server -D
```

Y accediendo a la dirección que nos indique (normalmente [http://localhost:1313/](http://localhost:1313/)). Sin embargo, en este caso al estar usando Cloud9, no podremos acceder a una dirección local.

![Hugo2](/img/cloud/aws/web/Hugo2.png)

### **4.2. Configuración de instacias EC2 para la previsualización de la web**

Para poder solucionar este problema nos dirigiremos a la barra de busqueda de AWS y buscaremos EC2. Una vez dentro, accederemos a **Instances (running)**:

![Hugo3](/img/cloud/aws/web/Hugo3.png)

Nos dirigiremos a la instacia que tenemos creada de Cloud9:

![Hugo4](/img/cloud/aws/web/Hugo4.png)

Veremos muchas opciones, pero nos dirigiremos a **Security**:

![Hugo5](/img/cloud/aws/web/Hugo5.png)

En la siguiente pantalla, nos dirigiremos a **Security groups**:

![Hugo6](/img/cloud/aws/web/Hugo6.png)

Añadiremos una nueva regla de entrada haciendo clic en **Add rule** en el apartado de **Edit inbound rules**:

![Hugo7](/img/cloud/aws/web/Hugo7.png)

Deberemos seleccionar **HTTP** en el desplegable de **Type**, el puerto **8080** en el desplegable de **Port range** y **Anywhere** en el desplegable de **Source**. Ponemos 0.0.0.0/0 para que sea accesible desde cualquier IP y si queremos añadimos una descripción:

![Hugo8](/img/cloud/aws/web/Hugo8.png)

Tras esto, guardamos los cambios haciendo clic en **Save rules** y volvemos a nuestro IDE de Cloud9.

Aquí, utilizaremos el siguiente comando para visualizar que IP tiene nuestra instancia de Cloud9:

```bash
curl ipinfo.io
```

Y la utilizaremos a la hora de generar la previsualización de la web:

```bash
hugo server --bind=0.0.0.0 --port=8080 --baseURL=http://100.26.22.73/
```

Para comprobar que funciona, accederemos a la dirección que nos indique (en mi caso, [http://100.26.22.73:8080/] (http://100.26.22.73:8080/)):

![Hugo9](/img/cloud/aws/web/Hugo9.png)

Luego de confirmar su correcto funcionamiento, eliminaremos la carpeta `resources` generada al ejecutar el comando anterior:

```bash
rm -rf resources
```

Finalmente, subiremos el contenido a GitHub:

```bash
git add .
git commit -m "Archivos Hugo"
git push
```

## **5. GitHub**

### **5.1. GitHub Actions**

En cuanto a la automatización del proceso de creación y despliegue de la web estática, implementaremos un **workflow** de GitHub Actions que se activará cada vez que se realiza un push a los directorios pertinentes, ya sea en Terraform o en el directorio del blog. Este flujo de trabajo consta de dos etapas: la primera verifica y despliega la infraestructura con Terraform, y la segunda construye el sitio web con Hugo y lo despliega en el bucket S3.

Creamos el archivo YAML `workflow.yaml` en la carpeta `.github/workflows`:

```bash
mkdir -p .github/workflows
touch .github/workflows/workflow.yaml
```

Se encargará de orquestar estas tareas de la siguiente manera:

```yaml
#
# hugo-deploy.yaml
# Archivo de configuración de GitHub Actions para:
# 1. Verificar y desplegar la infraestructura con Terraform cuando se haga push a alguno de los directorios "Terraform" o "LainWireless"
# 2. Construir el sitio web con Hugo y desplegarlo en S3 cuando se haga push al directorio "LainWireless"
#

name: "Workflow"

on:
  push:
    branches:
      - main
    paths:
      - "Terraform/**"
      - "LainWireless/**"

env:
  AWS_REGION: "us-east-1"
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

jobs:
  terraform:
    name: "Terraform"
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: "Terraform"
    steps:
      - name: "Clonar repositorio"
        uses: actions/checkout@v3
      - name: "Setup Terraform"
        uses: hashicorp/setup-terraform@v2.0.3
      - name: "Terraform Init"
        timeout-minutes: 2
        run: terraform init -input=false
      - name: "Terraform Apply"
        run: terraform apply -auto-approve
  hugo-deploy:
    needs: terraform
    name: "Hugo + Deploy"
    runs-on: ubuntu-latest
    steps:
      - name: "Clonar repositorio incluyendo submódulos (para el tema)"
        uses: actions/checkout@v3
        with:
          submodules: recursive
      - name: "Configurar credenciales AWS CLI"
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ env.AWS_REGION }}
      - name: "Setup Hugo"
        uses: peaceiris/actions-hugo@v2.6.0
        with:
          hugo-version: "latest"
          extended: true
      - name: "Build"
        run: |
          cd "LainWireless"
          hugo --minify
      - name: "Deploy to S3"
        run: |
          cd "LainWireless/public"
          aws s3 sync \
            --delete \
            . s3://www.lainwireless.es
      - name: "CloudFront Invalidation"
        run: |
          aws cloudfront create-invalidation \
            --distribution-id ${{ secrets.CLOUDFRONT_DISTRIBUTION_ID }} \
            --paths "/*"
```

Este archivo se encargará de activar el flujo de trabajo en la rama `main` con cada push en los directorios pertinentes. Se definen variables de entorno para las credenciales de AWS y la región. Luego, se especifican dos trabajos: **terraform** y **hugo-deploy**. El segundo depende del primero para asegurarse de que la infraestructura esté lista antes de construir y desplegar el sitio web.

El workflow ejecutará una serie de pasos para cada trabajo, asegurando una ejecución ordenada y eficiente de las tareas:

    Clonar repositorio: Se asegura de tener la última versión del código.

    Configurar credenciales AWS CLI: Permite el acceso seguro a los servicios de AWS.

    Setup Terraform: Prepara el entorno para Terraform.

    Terraform Init y Apply: Inicializa Terraform y aplica los cambios necesarios en la infraestructura.

    Setup Hugo: Prepara el entorno para Hugo.

    Build: Construye el sitio web con Hugo.

    Deploy to S3: Sincroniza los archivos del sitio web con el bucket de S3.

    CloudFront Invalidation: Invalida la caché de CloudFront para reflejar los cambios de inmediato.

Este workflow automatizado garantizará la coherencia entre la infraestructura y el contenido del sitio web, proporcionando una implementación robusta y eficiente.

### **5.2. Secrets**

La configuración de GitHub Actions para este proyecto depende de la presencia de ciertos `secrets` para garantizar la seguridad y la autenticación con servicios externos. Para ello en la web de GitHub vamos a `Settings > Secrets and variables > Actions > New repository secret` y creamos los siguientes, con sus respectivos valores:

![GitHub8](/img/cloud/aws/web/GitHub8.png)

    AWS_ACCESS_KEY_ID: Este secreto contiene la clave de acceso de AWS.

    AWS_SECRET_ACCESS_KEY: Este secreto contiene la clave secreta de AWS.

    CLOUDFRONT_DISTRIBUTION_ID: Este secreto contiene el ID de distribución de CloudFront.


Para conseguir nuestro **CLOUDFRONT_DISTRIBUTION_ID** ejecutaremos el siguiente comando en nuestra terminal Cloud9:

```bash
aws cloudfront list-distributions
```

Este comando proporcionará información sobre todas las distribuciones de CloudFront asociadas a nuestra cuenta de AWS.


Hecho esto, ya tendremos todo listo para que nuestro **workflow** funcione correctamente y se despliegue nuestra web estática.
