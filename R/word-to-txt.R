#' Convert a Word document to a plaintext document
#'
#' @md
#' @note Requires a working `pandoc` installation; this comes with RStudio, so
#'       if the caller is using RStudio, `pandoc` should be available.
#' @param in_path,out_path source and destination files. These can be
#'        abbreviated path names (e.g. `~/in/word.docx`, `~/out/word.txt`) but
#'        they _must_ be paths to file names. Extensions are not automatically
#'        added by this function
#' @return the `path.expand`ed `out_path` (invisibly)
#' @export
#' @examples \dontrun{
#' word_doc_to_txt("~/in/word.docx", "~/out/word.txt")
#' }
word_doc_to_txt <- function(in_path, out_path) {

  pandoc <- Sys.which("pandoc")
  if (pandoc == "") stop("pandoc not found. Please install pandoc.", call.=FALSE)

  in_path <- path.expand(in_path)
  in_path <- tools::file_path_as_absolute(in_path)


  if (!file.exists(in_path)) stop(sprintf("File [%s] not found.", in_path), call.=FALSE)

  out_path <- path.expand(out_path)

  processx::run(pandoc, c("--to=plain", in_path, "--wrap=none", sprintf("--output=%s", out_path)))

  invisible(out_path)

}
