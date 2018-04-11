#' Tools to Perform 'Misinformation' Analysis on a Text Corpus
#'
#' @md
#' @name misinfo
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @importFrom tools file_path_as_absolute file_path_sans_ext
#' @importFrom dplyr filter rename count data_frame mutate summarise group_by distinct left_join
#' @importFrom purrr map_df
#' @importFrom processx run
#' @import tidytext
#' @import stringi
#' @import viridis
#' @import hrbrthemes
#' @importFrom ggplot2 ggplot aes geom_tile scale_x_discrete scale_y_discrete labs
NULL


#' misinfo exported operators
#'
#' The following functions are imported and then re-exported
#' from the misinfo package.
#'
#' @name misinfo-exports
NULL

#' @importFrom magrittr %>%
#' @name %>%
#' @export
#' @rdname misinfo-exports
NULL