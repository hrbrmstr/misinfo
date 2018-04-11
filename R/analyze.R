#' Run a one or more documents through a misinformation/bias sentiment analysis
#'
#' @md
#' @param path a character vector of full path names; the default corresponds to
#'        the working directory, `getwd()`. Tilde expansion (see `path.expand``) is
#'        performed. Missing values will be ignored.
#' @param pattern an optional regular expression. Only file names which match
#'        the regular expression will be returned. (e.g. "`.*\\.txt$`)
#' @param bias_type a one-word (no punctuation or spaces) description of the
#'        bias type of the sentiment list being used. This will be used to tag
#'        the output so it can be used later when aggregating results of multiple
#'        bias-type analyses.
#' @param sentiment_list a character vector of words/phrases. The built-in sentiment
#'        bias lists can be used via [mi_use_builtin()] _or_ the caller can pass
#'        in a charcter vector of lower-case words/phrases
#' @return a `list` (classed as `misinfo_corpus`) with:
#' - `bias_type` (the bias type label passed in to the function)
#' - `corpus` (the raw data from the processed document corpus)
#' - `frequency_summary` (frequncy summary for each document in corpus)
#' - `individual_frequency` (individual component frequency for each phrase in
#'    each document in the corpus)
#' @export
#' @examples
#' mi_analyze_document(
#'   system.file("extdat", package="misinfo"),
#'   pattern=".*txt$",
#'   bias_type = "explanatory",
#'   sentiment_list = mi_use_builtin("explanatory")
#' )
mi_analyze_document <- function(path = ".", pattern = NULL, bias_type, sentiment_list) {

  # pre-process the corpus for tidytext and add some metadata to make it
  # easier to label things later on

  list.files(path = path, pattern = pattern, full.names = TRUE) %>%
    purrr::map_df(~{
      dplyr::data_frame(
        doc = basename(.x) %>%
          tools::file_path_sans_ext() %>% # doubling this since file name cld be "a.docx.txt"
          tools::file_path_sans_ext(),
        text = stri_read_lines(.x) %>%
          paste0(collapse = " ") %>%
          stri_trans_tolower()
      )
    }) %>%
    dplyr::mutate(text = stri_replace_all_regex(text, "[[:punct:]]", "")) %>%
    dplyr::mutate(doc_id = stri_sub(doc, 1, 30)) -> corpus

  # process the corpus into words to get raw word counts

  tidytext::unnest_tokens(corpus, word, text) %>%
    dplyr::filter(!stri_detect_regex(word, "[[:digit:]]")) -> one_grams

  dplyr::count(one_grams, doc_id) %>%
    dplyr::rename(total_words = n) -> total_words

  # count the phrases

  purrr::map_df(sentiment_list, ~{
    dplyr::group_by(corpus, doc_id) %>%
      dplyr::summarise(keyword = .x, ct = stri_count_regex(text, sprintf("\\W%s\\W", .x)))
  }) %>%
    dplyr::mutate(doc_num = as.character(as.numeric(factor(doc_id)))) -> bias_df

  # compute frequncy summary for each document in corpus

  dplyr::count(bias_df, doc_id, wt = ct) %>%
    dplyr::mutate(doc_num = as.character(as.numeric(factor(doc_id)))) %>%
    dplyr::left_join(total_words, "doc_id") %>%
    dplyr::mutate(pct = n / total_words) -> frequency_summary

  # compute individual component frequency for each phrase in each document in the corpus

  dplyr::left_join(bias_df, total_words, "doc_id") %>%
    dplyr::mutate(pct = ct / total_words) -> individual_frequency

  list(
    bias_type = bias_type,
    corpus = corpus,
    frequency_summary = frequency_summary,
    individual_frequency = individual_frequency
  ) -> out

  class(out) <- c("misinfo_corpus")

  out

}

# path <- system.file("extdat", package="misinfo")
# pattern <- ".*txt$"
# bias_type <-  "explanatory"
# sentiment_list <-  mi_use_builtin("explanatory")
#
