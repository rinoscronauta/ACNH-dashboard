md.dashboard_UI = function(id = 'dashboard'){
  ns = NS(id)

  page_fillable(
    layout_columns(
      col_widths = c(6,6)
      ,card(
        card_header('Table of villagers')
        ,dataTableOutput(ns('tbl.villagers'))
        ,full_screen = TRUE
        ,height = '75%'
      )
      ,card(
        card_header('Sankey Villagers')
        ,echarts4rOutput(ns('san.villagers'))
        ,full_screen = TRUE
      )
    )
  )
}

md.dashboard = function(id = 'dashboard', rv){
  moduleServer(id, function(input, output, session) {

    # reactives ---------------------------------------------------------------------
    rc.villagers = reactive({
      rv$villagers
    })

    # outputs -----------------------------------------------------------------------

    output$tbl.villagers = renderDataTable({

      rc.villagers() %>%
        select(Url, Name, Gender, Species, Birthday, Personality) %>%
        unique() %>%
        plot.datatable()

    })

    output$san.villagers = renderEcharts4r({
      rc.villagers()  %>% plot.sankey(coluna_1 = "Gender", coluna_2 = "Personality", coluna_3 = "Species")
    })

  })
}
