.uncertainty <-
  c(
    "may",
    "might",
    "could",
    "may be",
    "might have been",
    "may have been",
    "many",
    "most",
    "some",
    "numerous",
    "countless",
    "a majority",
    "few",
    "not many",
    "a small number",
    "hardly any",
    "a minority",
    "often",
    "frequently",
    "commonly",
    "for a long time",
    "usually",
    "sometimes",
    "repeatedly",
    "rarely",
    "infrequently",
    "sporadically",
    "seldom",
    "probably",
    "possibly",
    "unlikely",
    "improbable",
    "doubtful",
    "basically",
    "essentially",
    "generally",
    "kind of",
    "mostly",
    "pretty",
    "rather",
    "slightly",
    "somewhat",
    "sort of",
    "various",
    "virtually",
    "believed",
    "is believed",
    "in a sense"
  )

.sourcing <-
  c(
    "according to",
    "per",
    "as discussed by",
    "as mentioned by",
    "is reporting that",
    "said in an email",
    "the source said",
    "the report",
    "that report",
    "told",
    "said",
    "has claimed",
    "has said",
    "voiced by",
    "concludes",
    "have concluded",
    "reported",
    "sources close to",
    "crediting",
    "citing",
    "issued a statement",
    "in an interview",
    "in a statement",
    "the article",
    "prepared by"
  )

.retractors <-
  c(
    "but",
    "nonetheless",
    "nevertheless",
    "however",
    "although",
    "havent",
    "in spite of",
    "despite",
    "to contrast",
    "in contrast",
    "to the contrary",
    "another",
    "on the other hand",
    "yet",
    "despite",
    "except",
    "apart from",
    "notwithstanding",
    "regardless"
  )

.explanatory <-
  c(
    "because",
    "therefore",
    "in order to",
    "either",
    "or",
    "its like",
    "furthermore",
    "further",
    "therefore",
    "since",
    "that is why",
    "based on their investigation",
    "based on the investigation",
    "based on the research",
    "based on their research",
    "was indeed",
    "lays out"
  )

#' Use a built-in 'sentiment' word/phrase list
#'
#' The package comes with a set of built-in 'sentiment' word/phrase lists
#' for different classifications of "misinformation":\cr
#' - `explanatory`
#' - `retractors`
#' - `sourcing`
#' - `uncertainty`
#' Call the function with one of those names and the corresponding character
#' vector will be returned.
#'
#' @md
#' @param list_name name of built-in 'sentiment' word/phrase list
#' @export
#' @examples
#' mi_use_builtin("retractors")
mi_use_builtin <- function(type = c("uncertainty", "sourcing",
                                    "retractors", "explanatory")) {

  match.arg(
    tolower(trimws(type)),
    c("uncertainty", "sourcing","retractors", "explanatory")
  ) -> type

  switch(
    type,
    "uncertainty" = .uncertainty,
    "sourcing" = .sourcing,
    "retractors" = .retractors,
    "explanatory" = .explanatory
  )

}
