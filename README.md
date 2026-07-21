<img src="man/figures/logo.png" align="right" width="150" />

## rgeoamb: Bases para análises ambientais em R

rgeoamb é um pacote experimental R para análises ambientais, com base no código florestal para delimitação de forma automática de Áreas de Preservação Permanente (APPs). 
Por exemplo, Topo de Morro, Corpos Hídricos, > 45° e também Áreas de Uso Restrito, Cálculo de Área e Perímetro e avaliar o percentual das reservas legais sobre imóveis rurais. 

#### For instalation:
``` R
install.packages('remotes')
library(remotes)
remotes::install_github("marquesfilhojp/rgeoamb")
library(rgeoamb)

```
## Dependências

O pacote R `slope` atualmente usa as seguintes dependências abaixo e recomendamos, os requisitos necessários para a instalação do pacote R `terra` e do software *System for Automated Geoscientific Analyses*  2.3.2, 5.0.0 - 9.2 em Windows (x64) e Linux, de modo isolado ou em conjunto ao ambiente *QGIS* para o adequado funcionamento. 
* **terra**: 
* **sf**:
* **spatialEco**:
* **Rsagacmd**:


## Instalação nos Sistemas Operacionais
Atualmente, o pacote R *slope* v.0.4.5 foi desenvolvido somente para os sistemas operacionais *Windows* e distribuições *Linux* como Debian, Ubuntu, e especificadamente **version 22.04 LTS Jammy Jellyfish**.

### Windows
It is recommended to use R version 4.5.x or higher and Rtools 45 or higher to install the R package `terra`, which is essential for the operation of this package.

### Linux

On *Linux* distributions such as Ubuntu 22.04 LTS (Jammy Jellyfish) and other similar systems, it is recommended to initially install the R `terra` package to ensure the proper functioning of this package.

```bash
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install libgdal-dev libgeos-dev libproj-dev libtbb-dev libnetcdf-dev
```
This procedure is necessary to install the following libraries for manipulating vector and raster data, GDAL (>= 2.2.3), GEOS (>= 3.4.0), PROJ (>= 4.9.3), netcdf (>=4.1.3), sqlite3 and tbb.




