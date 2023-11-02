#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      h1("DogmaViz"),
      tabsetPanel(
        tabPanel(title = "Generate peptide sequence from DNA",
                 mod_dna_to_peptide_ui("dna_to_peptide_1")),
        tabPanel(title = "Visualize peptide sequence",
                 mod_plot_peptide_seq_ui("plot_peptide_seq_1"))
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "DogmaViz"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
