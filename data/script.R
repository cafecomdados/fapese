library(rvest)
library(dplyr)

url <- "http://estagio.fapese.org.br/manager/transparencia/financeiro/projeto/836/tipoRelatorio/3"

pagina <- read_html(url)

tabela_bolsas <- pagina %>%
  html_nodes("table.conteudo") %>%
  .[[1]] %>%
  html_table(fill = TRUE) %>%
  as.data.frame() %>%
  setNames(unlist(.[1, ])) %>%
  slice(-1) %>%
  select(-Documento)

write.csv(tabela_bolsas, file = "tabela_bolsas.csv", row.names = FALSE)
