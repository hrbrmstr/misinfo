#' Plot raw frequency count summary from a processed corpus
#'
#' @md
#' @param corpus a document corpus processed with [mi_analyze_document()]
#' @param normalized if `TRUE`, normalized values will be used, otherwise
#'        raw counts will be used; Default : `TRUE`
#' @return ggplot2 object
#' @export
#' @examples \dontrun{
#' mi_analyze_document(
#'   system.file("extdat", package="misinfo"),
#'   pattern=".*txt$",
#'   bias_type = "explanatory",
#'   sentiment_list = mi_use_builtin("explanatory")
#' ) -> corpus
#'
#' mi_plot_individual_frequency(corpus)
#' mi_plot_individual_frequency(corpus, FALSE)
#' }
mi_plot_individual_frequency <- function(corpus, normalized = TRUE) {

  if (normalized) {

    dplyr::mutate(corpus$individual_frequency, pct = ifelse(pct == 0, NA, pct)) %>%
      ggplot(aes(doc_num, keyword, fill = pct)) +
      geom_tile(color = "#2b2b2b", size = 0.125) +
      scale_x_discrete(expand = c(0, 0)) +
      scale_y_discrete(expand = c(0, 0)) +
      viridis::scale_fill_viridis(direction = -1, na.value = "white") +
      labs(
        x = NULL, y = NULL,
        title = sprintf('"%s" Frequency (normalized)', corpus$bias_type)
      ) +
      theme_ipsum_rc(grid = "")

  } else {

    dplyr::mutate(corpus$individual_frequency, ct = ifelse(ct == 0, NA, ct)) %>%
      ggplot(aes(doc_num, keyword, fill = ct)) +
      geom_tile(color = "#2b2b2b", size = 0.125) +
      scale_x_discrete(expand = c(0, 0)) +
      scale_y_discrete(expand = c(0, 0)) +
      viridis::scale_fill_viridis(direction = -1, na.value = "white") +
      labs(
        x = NULL, y = NULL,
        title = sprintf('"%s" Frequency', corpus$bias_type)
      ) +
      theme_ipsum_rc(grid = "")

  }

}

#' Plot raw frequency count summary from a processed corpus
#'
#' @md
#' @param corpus a document corpus processed with [mi_analyze_document()]
#' @param normalized if `TRUE`, normalized values will be used, otherwise
#'        raw counts will be used; Default : `TRUE`
#' @return ggplot2 object
#' @export
#' @examples \dontrun{
#' mi_analyze_document(
#'   system.file("extdat", package="misinfo"),
#'   pattern=".*txt$",
#'   bias_type = "explanatory",
#'   sentiment_list = mi_use_builtin("explanatory")
#' ) -> corpus
#'
#' mi_plot_document_summary(corpus)
#' mi_plot_document_summary(corpus, FALSE)
#' }
mi_plot_document_summary <- function(corpus, normalized = TRUE) {

  if (normalized) {

    dplyr::mutate(corpus$frequency_summary, pct = ifelse(pct == 0, NA, pct)) %>%
      ggplot(aes(doc_num, pct)) +
      geom_segment(aes(xend = doc_num, yend = 0), size = 5, color = "lightslategray") +
      scale_y_percent() +
      labs(
        x = "Document #", y = NULL,
        title = sprintf("Percent of '%s' words of total words in document corpus",
                        corpus$bias_type)
      ) +
      theme_ipsum_rc(grid = "Y")

  } else {

    dplyr::mutate(corpus$frequency_summary, n = ifelse(n == 0, NA, n)) %>%
      ggplot(aes(doc_num, n)) +
      geom_segment(aes(xend = doc_num, yend = 0), size = 5, color = "lightslategray") +
      scale_y_comma() +
      labs(
        x = "Document #", y = NULL,
        title = sprintf("Count of '%s' words of total words in document corpus",
                        corpus$bias_type)
      ) +
      theme_ipsum_rc(grid = "Y")

  }

}
