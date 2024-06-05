villagers = read.csv('databases/villagers.csv') |> tibble::as_tibble()


# sankey plot ---------------------------------------------------------------------------------------------------------------------
plot.sankey = function(dados, coluna_1, coluna_2, coluna_3){

  sumarizada_1 =
    dados |>
    summarise(Total = n(), .by = c({{coluna_1}},{{coluna_2}}))

  sumarizada_2 =
    dados |>
    summarise(Total = n(), .by = c({{coluna_2}},{{coluna_3}}))

  sankey =
    data.frame(
      source = c(sumarizada_1[[coluna_1]], sumarizada_2[[coluna_2]])
      ,target = c(sumarizada_1[[coluna_2]], sumarizada_2[[coluna_3]])
      ,value = c(sumarizada_1[["Total"]], sumarizada_2[["Total"]])
      ,stringsAsFactors = FALSE
    )

  sankey |>
    e_charts() |>
    e_sankey(source, target, value) |>
    e_tooltip(trigger = 'item') |>
    e_color(viridis::turbo(n=6))
}

villagers |> plot.sankey(coluna_1 = "Gender", coluna_2 = "Personality", coluna_3 = "Species")

pic_villagers <- villagers %>%
  mutate(
    Picture = paste0(
      "<img src=\"",
      Url,
      "\" height=\"30\" data-toggle=\"tooltip\" data-placement=\"right\" title=\"",
      Species,
      "\"></img>"
    )
  ) %>%
  select(Picture, Name, Gender, Species, Birthday, Personality) %>%
  unique()

DT::datatable(pic_villagers,
              options = list(scrollX = TRUE),
              escape = FALSE,
              rownames = FALSE,
              style = "auto")


villager <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/villagers.csv'
  ) %>%
  select(-row_n) %>%
  unique()

items <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/items.csv'
  ) %>% select(-num_id,-sell_currency,-buy_currency,-games_id,-id_full) %>%
  unique()
