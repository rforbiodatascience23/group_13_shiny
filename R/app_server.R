#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  # Module for generating peptide sequence from DNA
  mod_dna_to_peptide_server("dna_to_peptide_1")

  # Module for the visualization of the peptide sequence
  mod_plot_peptide_seq_server("plot_peptide_seq_1")
}
