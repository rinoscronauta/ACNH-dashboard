server = function(input, output, session) {

  rv = reactiveValues()

  observe({

    #dataframes

    rv$villagers = read.csv('databases/villagers.csv') |> tibble::as_tibble()
  })

  # updating rv$ -----------------------------------------
  # module.filter(rv = rv, data = data)


  # dashboard module -------------------------------------
  md.dashboard(rv = rv)
}
