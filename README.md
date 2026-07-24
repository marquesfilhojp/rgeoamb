<img src = "man/figures/logo.png" alt = "logo" style = "float: right; vertical-align: top; margin-left: 15px; width: 150px;" />

## *rgeoamb*: Bases para análises ambientais em R

<div align = "justify">
*rgeoamb* é um pacote R para análises ambientais, para delimitação de forma automática de **Áreas de Preservação Permanente** (APPs). 
Por exemplo, **Topo de Morros**, **Corpos Hídricos** (Lagos e Lagoas), **APPs > 45°** nas encostas e também **Áreas de Uso Restrito**, **Cálculo de Área e Perímetro**, **Detecção de Áreas Verdes** e o **Percentual das Reservas Legais sobre Imóveis Rurais**. 
Em breve as funções automáticas para **Mapeamento de Cobertura e Uso da Terra por Aprendizado de Máquina** (Pixel ou Objeto) e **Análise de Séries Temporais com Sensoriamento Remoto**. 
</div>

#### For instalation:
``` R
install.packages('remotes')
library(remotes)
remotes::install_github("marquesfilhojp/rgeoamb")
library(rgeoamb)

```
## Dependências

<div align = "justify">
O pacote R `rgeoamb` atualmente usa as seguintes dependências abaixo e recomendamos, os requisitos necessários para a instalação do pacote R `terra` e do software *System for Automated Geoscientific Analyses*  2.3.2, 5.0.0 - 9.2 em Windows (x64) e Linux, de modo isolado ou em conjunto ao ambiente *QGIS* para o adequado funcionamento. 
</div>

<div align = "justify">
**terra**: A versão do pacote R `terra` usada no presente pacote é **1.9-34**. A base do nosso pacota para operações de manipulação de dados matriciais, desde operações básicas de algebra booleana até estrutura condicionantes, para identificar às áreas de vegetação, de corpos hídricos e as diferentes Áreas de Preservação Permanente. 
</div>

<div align = "justify">
**sf**: A versão do pacote R `sf` usada no presente pacote é **1.1-11**. Este pacote é fundamental somente parra as diversas aplicações com dados vetoriais e integração com pacotes de tratamento para dados tabulares. 
</div>

<div align = "justify">
**spatialEco**: A versão do pacote R  `spatialEco` usada no presente pacote é **2.0-5**. Somente é necessário para efetuar a operação geométrica de dissolução, a nível de dados vetoriais. 
</div>

<div align = "justify">
**Rsagacmd**: A versão do pacote R `Rsagacmd` usada no presente pacote é **0.4.4**. Esta aplicação é necessária para fundamentar identificar às áreas de topo de morros, a partir da função *app_topo_morro*. 
</div>

## ⚙️ **Instalação nos Sistemas Operacionais**

<div align = "justify">
Atualmente, o pacote R *rgeoamb* v.0.1.0 foi desenvolvido somente para os sistemas operacionais *Windows* e distribuições *Linux* como Debian, Ubuntu, e especificadamente **version 22.04 LTS Jammy Jellyfish**.
</div>

### 🪟 **Windows**

<div align = "justify">
É recomendável usar a versão R 4.5.x e Rtools 45 ou superiores para instalar o pacote `terra`, que é essencial para o funcionamento deste pacote.
</div>

```https
R v.4.5.x: https://cran.r-project.org/bin/windows/base/old/4.5.3/
Rtools45: https://cran.r-project.org/bin/windows/Rtools/rtools45/rtools.html 
```

### 🐧 **Linux**

<div align = "justify">
Nas distribuições *Linux* como Ubuntu 22.04 LTS (Jammy Jellyfish) e outros sistemas similares, é recommendável a instalação do pacote R `terra` para o adequado funcionamento deste pacote. Recomenda-se seguir as etapas a seguir para a instalação dos pré-requisitos do pacote R `terra`. Para manipulação de dados matriciais e vetoriais, GDAL (>= 2.2.3), GEOS (>= 3.4.0), PROJ (>= 4.9.3), netcdf (>=4.1.3), sqlite3 and tbb.
</div>

```bash
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install libgdal-dev libgeos-dev libproj-dev libtbb-dev libnetcdf-dev
```
<div align = "justify">
Este projeto foi desenvolvido para contribuir na automatização de análises ambientais em `R`, de modo prático, rápido e eficiente. 
</div>


