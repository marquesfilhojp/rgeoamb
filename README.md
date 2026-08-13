<img src = "man/figures/logo.png" alt = "logo" style = "float: right; vertical-align: top; margin-left: 15px; width: 150px;" />

## *rgeoamb*: Frameworks for Environmental Analyses in R

<div align = "justify">
*rgeoamb* is an R package for environmental analysis designed to automatically delineate **Permanent Preservation Areas** (APPs). 
Key functionalities include the extraction of **Area and Perimeter Calculations**, **APPs on slope angles > 45°**, **Green Area Detection** (*Áreas Verdes*), **Hilltops** (*APPs de Topo de Morros*), **Land Use and Land Cover (LULC) Mapping via Machine Learning** (Pixel-Based),
**Legal Reserve Compliance Percentages on Rural Properties**, **Restricted Use Areas** (*Áreas de Uso Restrito*), **Water Bodies** (*APPs de Corpos Hídricos*), **Water Mask** (*Máscara d'água*) as well as
upcoming features will introduce automated tools for **Remote Sensing Time Series Analysis**.
</div>

#### For instalation:
``` R
install.packages('remotes')
library(remotes)
remotes::install_github("marquesfilhojp/rgeoamb")
library(rgeoamb)
```
## Dependencies

<div align = "justify">
The `rgeoamb` R package currently relies on the dependencies listed below. For proper functionality, we recommend meeting the necessary requirements for installing the `terra` R package and the *System for Automated Geoscientific Analyses* (SAGA GIS, versions 2.3.2, 5.0.0 – 9.2) on Windows (x64) and Linux, either standalone or integrated within the *QGIS* environment.
</div>

<div align = "justify">
**caret**: The version of the `caret` R package used in this package is **7.0.1**. This package is required to support land use and land cover identification through the *landuse_landcover* function.
</div>

<div align = "justify">
**httr2**: The version of the `httr2` R package used in this package is **1.3.0**. This package is required to fetch DEMs via the OpenTopography API in the *elevr* function.
</div>

<div align = "justify">
**Rsagacmd**: The version of the `Rsagacmd` R package used in this package is **0.4.3**. This package is required to support hilltop identification through the *hilltops* function.
</div>

**rstac**: The version of the `rstac` R package used in this package is **1.0.1**. This package is required to fetch images via the Planetary Computer Microsoft API in the *download_stac_services* function.
</div>

<div align = "justify">
**terra**: The version of the `terra` R package used in this package is **1.9-34**. It serves as the foundation for raster data manipulation operations—ranging from basic Boolean algebra to conditional structures—to identify vegetation cover, water bodies, and various Permanent Preservation Areas (APPs).
</div>

<div align = "justify">
**sf**: The version of the `sf` R package used in this package is **1.1-2**. This package is essential for all vector data operations and seamless integration with tabular data processing tools.
</div>

<div align = "justify">
**spatialEco**: The version of the `spatialEco` R package used in this package is **2.0-3**. It is required specifically for vector geometry dissolve operations.
</div>


## ⚙️ Installation by Operating System

<div align="justify">
Currently, the R package *rgeoamb* v.0.2.7 has been developed solely for *Windows* operating systems and *Linux* distributions such as Debian, Ubuntu, and Linux—specifically **version 22.04 LTS Jammy Jellyfish**.
</div>

### 🪟 Windows

<div align = "justify">
It is recommended to use R version 4.5.x or higher and Rtools 45 or higher to install the R package `terra`, which is essential for the operation of this package.
</div>

```https
R v.4.5.x: https://cran.r-project.org/bin/windows/base/old/4.5.3/
Rtools45: https://cran.r-project.org/bin/windows/Rtools/rtools45/rtools.html 
```

### 🐧 Linux

<div align = "justify">
On *Linux* distributions such as Ubuntu 22.04 LTS (Jammy Jellyfish) and other similar systems, it is recommended to initially install the R `terra` package to ensure the proper functioning of this package, for manipulating vector and raster data with following libraries GDAL (>= 2.2.3), GEOS (>= 3.4.0), PROJ (>= 4.9.3), netcdf (>=4.1.3), sqlite3 and tbb.
</div>

```bash
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install libgdal-dev libgeos-dev libproj-dev libtbb-dev libnetcdf-dev
```
<div align = "justify">
This project was developed to contribute to the automation of environmental analyses in `R` in a practical, fast, and efficient way.
</div>
