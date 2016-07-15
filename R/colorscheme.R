colorscheme <- function(obj, theme = "BLUE", ...){
  # Add some themes for visual appeal
  # Convert to a plotly_built object for making changes
  # obj <- plotly::plotly_build(obj)

  # Add theme related elements to the plotly_built object
  if (theme == "BLUE") {
    obj$x$layout$plot_bgcolor = "#516C8D"
    obj$x$layout$paper_bgcolor = "#516C8D"
    obj$x$layout$font = list(color = "#ffffff")
  }

  if (theme == "YELLOW") {
    obj$x$layout$plot_bgcolor = "#FFD460"
    obj$x$layout$paper_bgcolor = "#FFD460"
    obj$x$layout$font = list(color = "2D4059")
  }

  if (theme == "LIGHTGRAY") {
    obj$x$layout$plot_bgcolor = "#cccccc"
    obj$x$layout$paper_bgcolor = "#f2f2f2"
    obj$x$layout$font = list(color = "#595959")
  }

  if (theme == "DARKGRAY") {
    obj$x$layout$plot_bgcolor = "#393E46"
    obj$x$layout$paper_bgcolor = "#222831"
    obj$x$layout$font = list(color = "#EEEEEE")
    obj$x$layout$xaxis$gridcolor = "#737373"
    obj$x$layout$yaxis$gridcolor = "#737373"
    obj$x$layout$xaxis$zerolinecolor = "#737373"
    obj$x$layout$yaxis$zerolinecolor = "#737373"
  }

  return(p = obj)
}
