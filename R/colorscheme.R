colorscheme <- function(obj, theme = "BLUE", ...){
  # Add some themes for visual appeal
  # Convert to a plotly_built object for making changes
  obj <- plotly::plotly_build(obj)

  # Add theme related elements to the plotly_built object
  if (theme == "BLUE") {
    obj$layout$plot_bgcolor = "#516C8D"
    obj$layout$paper_bgcolor = "#516C8D"
    obj$layout$font = list(color = "#ffffff")
  }

  if (theme == "YELLOW") {
    obj$layout$plot_bgcolor = "#FFD460"
    obj$layout$paper_bgcolor = "#FFD460"
    obj$layout$font = list(color = "2D4059")
  }

  if (theme == "LIGHTGRAY") {
    obj$layout$plot_bgcolor = "#cccccc"
    obj$layout$paper_bgcolor = "#f2f2f2"
    obj$layout$font = list(color = "#595959")
  }

  if (theme == "DARKGRAY") {
    obj$layout$plot_bgcolor = "#393E46"
    obj$layout$paper_bgcolor = "#222831"
    obj$layout$font = list(color = "#EEEEEE")
    obj$layout$xaxis$gridcolor = "#737373"
    obj$layout$yaxis$gridcolor = "#737373"
    obj$layout$xaxis$zerolinecolor = "#737373"
    obj$layout$yaxis$zerolinecolor = "#737373"
  }

  return(p = obj)
}
