#' plot_peptide_seq UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom ggplot2 theme
mod_plot_peptide_seq_ui <- function(id){
  ns <- NS(id)
  tagList(
    # Text box for inputting the peptide sequence
    sidebarLayout(
      sidebarPanel(
        textAreaInput(
          inputId = ns("peptide"),
          label = "Peptide sequence",
          width = 300,
          height = 100,
          placeholder = "Insert peptide sequence"
        )
      ),
      mainPanel(
        # Plot the distribution of amino acids in main panel
        plotOutput(
          outputId = ns("dist")

        )
      )
    )

  )
}

#' plot_peptide_seq Server Functions
#'
#' @noRd
mod_plot_peptide_seq_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # Render distribution plot of amino acids
    output$dist <- renderPlot({
      if(input$peptide == ""){
        NULL
      } else{
        input$peptide |>
          dogmaVis::plot_aa_dist() +
          ggplot2::theme(legend.position = "none")
      }
    })

  })
}

## To be copied in the UI
# mod_plot_peptide_seq_ui("plot_peptide_seq_1")

## To be copied in the server
# mod_plot_peptide_seq_server("plot_peptide_seq_1")
