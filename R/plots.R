plot.datatable = function(df){

  pic_df = df %>%
    mutate(
      Picture = paste0(
        "<img src=\"",
        Url,
        "\" height=\"30\" data-toggle=\"tooltip\" data-placement=\"right\"></img>"
      ),
    ) %>% select(Picture, everything(), -c(Url))

  datatable(pic_df,
            options = list(scrollX = TRUE),
            escape = FALSE,
            rownames = FALSE,
            style = "auto")
}

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
    e_sankey(source, target, value,
             levels =
               list(
                 list(depth = 0, itemStyle = list(color = "hsl(208, 100%, 23%)"), lineStyle = list(color = "hsl(208, 100%, 23%)", opacity = 0.15))
                 ,list(depth = 1, itemStyle = list(color = "hsl(208, 54%, 63%)"), lineStyle = list(color = "hsl(208, 100%, 23%)", opacity = 0.15))
                 ,list(depth = 2, itemStyle = list(color = "hsl(208, 22%, 63%)"))
               )) |>
    e_tooltip(trigger = 'item')
}
