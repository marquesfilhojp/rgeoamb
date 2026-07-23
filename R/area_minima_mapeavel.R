#' Área Mínima Mapeável
#'
#'\strong{Área Mínima Mapeável}
#'
#'Calcula a Área Mínima Mapeável
#'
#'@param escala Númerico. Escala cartográfica de mapeamento.
#'@param res Númerico. Resolução da imagem.
#'
#'@examples
#'\dontrun{
#' library(rgeoamb)
#' amm <- rgeoamb::area_minima_mapeavel(25000, 10)
#' }
#'@export
area_minima_mapeavel <- function(escala, res){
  ds <- (scale * 0.002)**2
  amm <- ds/(res^2)
  if(amm >= 9 && amm < 16){
    print('Tamanho de Janela Móvel 3x3')
  }
  else if(amm >= 16 && amm < 25 ){
    print('Tamanho de Janela Móvel 4x4')
  }
  else if(amm >= 25 && amm < 36){
    print('Tamanho de Janela Móvel 5x5')
  }
  else if(amm >= 36 && amm < 49){
    print('Tamanho de Janela Móvel 6x6')
  }
  else if(amm >= 49 && amm < 64){
    print('Tamanho de Janela Móvel 7x7')
  }
  else if(amm >= 64 && amm < 81){
    print('Tamanho de Janela Móvel 8x8')
  }
  else if(amm >= 81){
    print('Tamanho de Janela Móvel 9x9')
  }
  else{
    print('Tamanho de janela móvel muito grande e pode impactar sua imagem.')
  }
  return(amm)
}
