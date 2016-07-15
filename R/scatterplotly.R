#' @title scatterplotly
#'
#' @description
#' Create scatterplots using \href{https://plot.ly/r}{plotly's R API}.
#' Type \code{scatterplotly()} for visual help.
#'
#' @details
#' Internally, \code{plot_ly()} is used to generate all plots. All of the above arguments are
#' mapped to specific arguments to \code{plot_ly()}. The function assigns default values to
#' many \code{plot_ly()} arguments like marker-size, marker-opacity etc. to allow for
#' an easier interface.
#'
#' Type \code{plotlyvis::scatterplotly} to see the source code. Alternatively you can press F2
#' if using R-Studio.
#'
#' Currently, four color themes are built in: BLUE, YELLOW, LIGHTGRAY and DARKGRAY.
#'
#' @note
#' The \emph{title}, \emph{subtitle} and \emph{description} are added as annotations.
#' By default the \code{xref} and \code{yref} arguments are set to \emph{paper}.
#' See \href{https://plot.ly/r/reference/#layout-annotationsplot}{plotly - annotations}
#' for more details.
#'
#' @author Riddhiman Roy
#'
#' @seealso
#' \code{\link[plotly]{plot_ly}}
#' \code{\link[plotly]{plotly_build}}
#'
#' @param x  A vector of x-coordinates
#' @param y  A vector of y-coordinates
#' @param xlab  x-axis label (optional)
#' @param ylab  y-axis label (optional)
#' @param theme  color theme (see details below)
#' @param groupcolor  a vector specifying group level color mapping
#' @param groupsize  a vector specifying group level size mapping
#' @param groupsymbol  a vector specifying group level marker-type mapping
#' @param title  Chart title
#' @param subtitle  Chart subtitle (optional)
#' @param title.size  Chart title size (default: 30)
#' @param title.fontface  Chart title (and subtitle) font family(default: Times New Roman)
#' @param description  Character vector to specify additional description (optional)
#' @param desc.x  Description annotation's x position (default: 0.7)
#' @param desc.y  Description annotation's y position (default: 0.2)
#' @param desc.size  Description annotation's font size (default: 12)
#' @param desc.fontface  Description annotation's font family (default: arial)
#' @param markersize  Point size (in px) (default: 5)
#' @param markeropacity  Point alpha (0  1) (default: 1)
#' @param markertype  Point style (default: circle)
#' @param markerlinewidth  Width of line around point (default: 1)
#' @param markerlinecolor  Color of line around point (default: Black)
#' @param width  Canvas width (default: 800)
#' @param height  Canvas height (default: 600)
#' @param xaxis.range  xaxis limits (a numeric vector of size two specifying lower and upper limits)
#' @param yaxis.range  yaxis limits (a numeric vector of size two specifying lower and upper limits)
#' @param legendorientation Specify the location of the legend ("v" or "h)
#' @param ... Other arguments that can be passed to plot_ly()
#'
#' @importFrom stats rnorm
#' @importFrom magrittr %>%
#'
#' @return
#' Returns a plotly built object. Use $ for further manipulations and edits.
#'
#' @examples
#' library(plotlyvis)
#'
#' # Simple scatter plot
#' scatterplotly(x = rnorm(1000), y = rnorm(1000), title = "Simple scatter plot")
#'
#' # Group level mappings
#' n = 500
#' x = seq(-1, 1, length.out = n)
#' y = round(2 * x^2 + rnorm(n, sd = 0.25),2)
#' size = c(1:250, 250:1)
#' color = sample(LETTERS[1:4], size = n, replace = TRUE)
#' symbol = sample(letters[1:3], size = n, replace = TRUE)
#' scatterplotly(x = x, y = y,
#'               groupcolor = color,
#'               groupsize = size,
#'               groupsymbol = symbol,
#'               title = "Advanced scatterplot",
#'               subtitle = "Scatterplot with group level color, size and symbol mappings")
#'
#' #Theme
#' scatterplotly(x = rnorm(1000), y = rnorm(1000), title = "Simple scatter plot", theme = "BLUE")
#'
#' @export
scatterplotly <- function(x, y, xlab = NULL, ylab = NULL,
                          theme,
                          groupcolor, groupsize, groupsymbol,
                          title = "",
                          subtitle = "",
                          title.size = 30,
                          title.fontface = "Times New Roman",
                          description = "",
                          desc.x = 0.7,
                          desc.y = 0.2,
                          desc.size = 12,
                          desc.fontface = "arial",
                          markersize = 5,
                          markeropacity = 0.8,
                          markertype = "circle",
                          markerlinewidth = 1,
                          markerlinecolor = "black",
                          width = NULL,
                          height = NULL,
                          xaxis.range = NULL,
                          yaxis.range = NULL,
                          legendorientation = "v",
                          ...){

  # Help plot -----------------------------------------------------------------
  # If both x and y are missing show a help plot
  # This will serve as a help document as well

  if (missing(x) && missing(y)) {
    set.seed(123)
    p <- scatterplotlyhelp()
    print(p)
    return("No data provided. Showing help instead...")
  }

  # Handle single x/y arguments -----------------------------------------------
  # If only x is specified (like in base plot)
  # Force to y
  if ((!missing(x) && missing(y))) {

    ylab <- paste0("<b>", deparse(substitute(x)), "</b><br>",
                   "<sup> Type:", class(x), "</sup>")
    xlab <- "Index"
    y <- x
    x <- 1:length(y)
  }

  # If only y is specified
  if ((missing(x) && !missing(y))) {

    ylab <- paste0("<b>", deparse(substitute(y)), "</b><br>",
                   "<sup> Type:", class(x), "</sup>")

    xlab <- "Index"
    y <- y
    x <- 1:length(y)
  }

  # Create x-axis and y-axis labels -------------------------------------------
  if (is.null(xlab)) {
    xlab <- paste0("<b>", deparse(substitute(x)), "</b><br>",
                   "<sup> Type:", class(x), "</sup>")
  }

  if (is.null(ylab)) {
    ylab <- paste0("<b>", deparse(substitute(y)), "</b><br>",
                   "<sup> Type:", class(y), "</sup>")
  }

  # Create hoverinfo ----------------------------------------------------------
  hovertxt <- if (!missing(groupcolor)) {
    paste0("<b>x:</b> ", x, "<br>",
           "<b>y:</b> ", y, "<br>",
           "<b>Color:</b> ", groupcolor, "<br>")
  }else{
    paste0("<b>x:</b> ", x, "<br>",
           "<b>y:</b> ", y, "<br>")}

  if (!missing(groupsize)) {
    hovertxt <- paste0(hovertxt, "<b>Size:</b>", groupsize)
  }

  # Create plot ---------------------------------------------------------------
  # Create colorbar only if input is numeric
  if (!missing(groupcolor)) {
    if (is.numeric(groupcolor)) {
      colorbarlist <-  list(title = deparse(substitute(groupcolor)))
    }else{
      colorbarlist <-  NA
    }

  }else{
    colorbarlist <- NA
  }

  # Create markerlist based on inputs
  markerlist <- list(line = list(width = markerlinewidth, color = markerlinecolor),
                     opacity = markeropacity,
                     colorbar = colorbarlist)

  #if(!missing(groupsize))markerlist$size <- markerSizeScale(groupsize, maxScale = maxMarkerSize)
  if (missing(groupsize)) markerlist$size <- markersize
  if (missing(groupsymbol)) markerlist$symbol <- markertype

  # Change x and y axis domains
  if (legendorientation != "v" && legendorientation != "h") {
    stop('legendorientation must be either "v" (vertical) or "h" (horizontal)')
  }

  if (legendorientation == "v") {
    xaxis.domain = c(0, 1)
    yaxis.domain = c(0.01, 0.9)
  }

  if (legendorientation == "h") {
    xaxis.domain = c(0, 0.97)
    yaxis.domain = c(0.05, 0.9)
  }

  # Plot
  p <- plotly::plot_ly(x = x, y = y,
                       color = groupcolor,
                       size = groupsize,
                       symbol = groupsymbol,
                       type = "scatter",
                       mode = "markers",
                       marker = markerlist,
                       hoverinfo = "text",
                       text = hovertxt, ...) %>%

    plotly::layout(xaxis = list(title = xlab, range = xaxis.range, domain = xaxis.domain),
                   yaxis = list(title = ylab, domain = yaxis.domain, range = yaxis.range),
                   font = list(family = "arial"),

                   #margin = list(b = 0, t = 0, l = 0, r = 0),
                   width = width, height = height,

                   #Legend options
                   legend = list(orientation = legendorientation,
                                 bgcolor = "transparent"),

                   annotations = list(
                     # Title and sub-title
                     list(xref = "paper", yref = "paper",
                          xanchor = "left", yanchor = "top",
                          showarrow = F,
                          x = 0, y = 1.05,
                          align = "left",
                          font = list(size = title.size, family = title.fontface),
                          text = paste0("<b>", title, "</b><br><sup>", subtitle, "</sup>")),

                     # Description
                     list(xref = "paper", yref = "paper",
                          xanchor = "left", yanchor = "top",
                          showarrow = F,
                          x = desc.x, y = desc.y,
                          align = "left",
                          font = list(size = desc.size, family = desc.fontface),
                          text = paste0(description))
                   )
    )

  # Add theme -----------------------------------------------------------------
  if (!missing(theme)) p <- colorscheme(p, theme = theme)

  # Return --------------------------------------------------------------------
  return(p)
}

# Scatterplotly help plot
# Just a visual way to relay all the important arguments
scatterplotlyhelp <- function(scalefactor = 5){

  p <- plotly::plot_ly(x = rnorm(500), y = rnorm(500),
                       color = sample(LETTERS[1:2], size = 100, replace = T),
                       symbol = sample(letters[1:2], size = 100, replace = T),
                       type = "scatter",
                       mode = "markers",
                       marker = list(size = sample(1:5, size = 100, replace = T) * scalefactor,
                                     line = list(width = 1, color = "black"),
                                     opacity = 0.7),
                       hoverinfo = "none") %>%

    plotly::layout(xaxis = list(title = "X-Axis"),
                   yaxis = list(title = "Y-Axis", domain = c(0.01, 0.9)),
                   font = list(family = "arial"),

                   annotations = list(
                     # Title and sub-title
                     list(xref = "paper", yref = "paper",
                          xanchor = "left", yanchor = "top",
                          showarrow = F,
                          x = 0, y = 1.05,
                          align = "left",
                          font = list(size = 30, family = "Times New Roman"),
                          text = paste0("<b>", "Title here...", "</b><br><sup>",
                                        "Subtitle here...", "</sup>")),

                     # Description
                     list(xref = "paper", yref = "paper",
                          xanchor = "left", yanchor = "top",
                          showarrow = F,
                          x = 0.8, y = 0.2,
                          align = "left",
                          font = list(size = 12, family = "arial"),
                          text = paste0("Description can be<br>inserted here...")),

                     # Help annotations
                     list(xref = "paper", yref = "paper",
                          xanchor = "left", yanchor = "top",
                          x = 0.15, y = 0.95,
                          ax = 45, ay = 45,
                          align = "left",
                          font = list(size = 12),
                          text = paste0("Title and subtitle are shown here.<br>",
                                        "Use the <em>title</em> and <em>subtitle</em> arguments.<br>",
                                        "<b>Note:</b> <em>title.size</em> controls both title and subtitle size"),
                          bgcolor = "#d9d9d9"),

                     list(xref = "paper", yref = "paper",
                          xanchor = "left", yanchor = "top",
                          x = 0.85, y = 0.10,
                          ax = -45, ay = 35,
                          align = "left",
                          font = list(size = 12),
                          text = paste0("A Description can be added (optional) ",
                                        "using the <em>description</em> argument.<br>",
                                        "Location and size can controlled using the ",
                                        "<em>desc.x, desc.y and desc.size</em> arguments."),
                          bgcolor = "#d9d9d9"),

                     list(xref = "paper", yref = "paper",
                          xanchor = "left", yanchor = "top",
                          x = 0.0, y = 0.33,
                          ax = 35, ay = 35,
                          align = "left",
                          font = list(size = 12),
                          text = paste0("Axis labels can added using<br>",
                                        " the <em>xlab and ylab</em> arguments"),
                          bgcolor = "#d9d9d9"),

                     list(xref = "paper", yref = "paper",
                          xanchor = "left", yanchor = "top",
                          x = 0.8, y = 0.6,
                          ax = 45, ay = -45,
                          align = "left",
                          font = list(size = 12),
                          text = paste0("X and Y axis data can be added using the <em>x</em> and <em>y</em> arguments.<br>",
                                        "group level mapping can be specified using the following:<br>",
                                        "<em>groupcolor</em>, <em>groupsize</em> and <em>groupsymbol</em>"),
                          bgcolor = "#d9d9d9")
                   )
    )

  return(p)
}
