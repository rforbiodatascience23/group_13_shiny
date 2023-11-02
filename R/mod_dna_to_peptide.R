#' dna_to_peptide UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_dna_to_peptide_ui <- function(id){
    ns <- NS(id)
  tagList(
    fluidRow(
      column(8, shiny::uiOutput(ns("DNA"))),
      # A numeric input field for writing the length of the DNA sequence
      column(4, shiny::numericInput(
        inputId = ns("dna_length"),
        value = 6000,
        min = 3,
        max = 100000,
        step = 3,
        label = "Random DNA length"
      ),
      # Button for generating the DNA sequence
      shiny::actionButton(
        inputId = ns("generate_dna"),
        label = "Generate random DNA", style = "margin-top: 18px;"
      ))
    ),
    # Wrapped output text box for peptide sequence
    shiny::verbatimTextOutput(outputId = ns("peptide")) |>
      shiny::tagAppendAttributes(style = "white-space: pre-wrap;")
  )
}

#' dna_to_peptide Server Functions
#'
#' @noRd
mod_dna_to_peptide_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # The DNA sequnce should be reactive to user input
    dna <- reactiveVal()

    # The DNA input strand should be updateable in the input field
    output$DNA <- renderUI({
      textAreaInput(
        inputId = ns("DNA"),
        label = "DNA sequence",
        placeholder = "Insert DNA sequence",
        value = dna(),
        height = 100,
        width = 600
      )
    })

    # Generate random DNA sequence when action button is pressed
    observeEvent(input$generate_dna, {
      dna(
        dogmaVis::generate_dna(input$dna_length)
      )
    })

    # Generate peptide sequence from DNA when DNA is changed
    output$peptide <- renderText({
      # Ensure input is not NULL and is longer than 2 characters
      if (is.null(input$DNA)) {
        NULL
      } else if (nchar(input$DNA) < 3) {
        NULL
      } else {
        input$DNA |>
          toupper() |>
          dogmaVis::T_to_U() |>
          dogmaVis::format_to_codons() |>
          dogmaVis::translate_codons()
      }
    })

  })
}

## To be copied in the UI
# mod_dna_to_peptide_ui("dna_to_peptide_1")

## To be copied in the server
# mod_dna_to_peptide_server("dna_to_peptide_1")
