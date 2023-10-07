library(rvest)
library(dplyr)

url <- "http://estagio.fapese.org.br/manager/transparencia/financeiro/projeto/836/tipoRelatorio/3"

pagina <- read_html(url)

tabela_geral <- pagina %>%
  html_nodes("table.conteudo") %>%
  .[[1]] %>%
  html_table(fill = TRUE) %>%
  as.data.frame() %>%
  setNames(unlist(.[1, ])) %>%
  slice(-1) %>%
  select(-Documento)


tabela_bolsas <- tabela_geral |> 
  filter(Rubrica == 'Bolsa Acadêmica')

ultimos_lancamentos <- tabela_geral |>
  mutate(Data2 = as.Date(Data, format = "%d/%m/%Y")) |> 
  filter(Data2 == max(Data2)) |> 
  select(-Data2)


write.csv(tabela_geral, file = "data/tabela_bolsas.csv", row.names = FALSE)
write.csv(tabela_bolsas, file = "data/tabela_bolsas.csv", row.names = FALSE)
write.csv(ultimos_lancamentos, file = "data/ultimos_lancamentos.csv", row.names = FALSE)
