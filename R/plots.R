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
