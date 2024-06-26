####  Source:  ####
#https://drsimonj.svbtle.com/creating-corporate-colour-palettes-for-ggplot2

####  Colors  ####
gmri_colors <- c(
  `orange`     =  "#EA4F12",
  `yellow`     =  "#EACA00",
  `gmri green` =  "#ABB400",
  `light green`=  "#ABB400",
  `dark green` =  "#3B4620",
  `green`      =  "#407331",
  `teal`       =  "#00736D",
  `blue`       =  "#00608A",
  `gmri blue`  =  "#00608A",
  `light gray` =  "#E9E9E9",
  `dark gray`  =  "#535353"
)


#' @title Retrieve GMRI Hex Color(s)
#'
#' @description Return hex codes in return for named GMRI colors.
#' Available options are: orange, yellow, gmri_green, dark green,
#' green, teal, gmri blue, light gray, & dark gray.
#'
#' @param ... Character names of official GMRI colors
#' @export
#'
#' @examples
#'
#' #Pull a single Hex code
#' gmri_cols("gmri blue")
#'
#' #Multiple colors
#' gmri_cols("gmri blue", "gmri green")
#'
#' #Get the whole list of colors
#' gmri_cols()
#'
#' #Add select colors to ggplot3 functions
#' ggplot2::ggplot(mtcars, ggplot2::aes(hp, mpg)) +
#'   ggplot2::geom_point(color = gmri_cols("gmri blue"), size = 4, alpha = .8)
#'
gmri_cols <- function(...) {
  cols <- c(...)

  if (is.null(cols)){
      return (gmri_colors)
  }


  # If nothing is entered into the function return them all
  return_cols <- gmri_colors[cols]
  names(return_cols) <- NULL
  return_cols
}





####  Palettes  ####
gmri_palettes <- list(
  # Main palette
  `main`  = gmri_cols("gmri blue", "green", "gmri green",  "yellow", "orange"),

  # Cool palette
  `cool`  = gmri_cols("gmri blue", "dark green", "teal"),

  # Hot palette
  `hot`   = gmri_cols("gmri green", "yellow", "orange"),

  # Mixed palette
  `mixed` = gmri_cols("orange", "yellow", "gmri green", "dark green", "green", "teal", "gmri blue"),

  # Gray
  `gray`  = gmri_cols("light gray", "dark gray"),

  # Grey for british people
  `grey`  = gmri_cols("light gray", "dark gray")
)



#' @title GMRI Color Palettes
#'
#' @description Interpolation tool for a gmri color palettes using
#' colorRampPalette(). This is the workhorse for scale_color_gmri()
#' and for scale_fill_gmri().
#'
#' @param palette Character name of palette in gmri_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#' @export
#'
#' @examples
#' #You can now get interpolated color ranges using the palettes
#' gmri_pal("cool")(10)
#'
gmri_pal <- function(palette = "main", reverse = FALSE, ...) {
  pal <- gmri_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  grDevices::colorRampPalette(pal, ...)
}


#' @title GMRI-ggplot2 Scale Color Palettes
#'
#' @param palette Character name of palette in gmri_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#' @export
#'
#' @examples
#' #Color by discrete variable using default palette
#' # ggplot2::ggplot(iris, ggplot2::aes(Sepal.Width, Sepal.Length, color = Species)) +
#' #  ggplot2::geom_point(size = 4) +
#' #  scale_color_gmri()
#'
#' #Color by numeric variable with cool palette
#' # ggplot2::ggplot(iris, ggplot2::aes(Sepal.Width, Sepal.Length, color = Sepal.Length)) +
#' #  ggplot2::geom_point(size = 4, alpha = .6) +
#' #  scale_color_gmri(discrete = FALSE, palette = "cool")
#'
scale_color_gmri <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- gmri_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("colour", paste0("gmri_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_color_gradientn(colours = pal(256), ...)
  }
}




#' @title GMRI-ggplot2 Scale Fill Palettes
#'
#' @param palette Character name of palette in gmri_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#' @export
#'
#' @examples
#' #Fill by discrete variable with different palette + remove legend (guide)
#' #ggplot2::ggplot(mpg, ggplot2::aes(manufacturer, fill = manufacturer)) +
#' #  ggplot2::geom_bar() +
#' #  ggplot2::theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
#' #  scale_fill_gmri(palette = "mixed", guide = "none")
#'
scale_fill_gmri <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- gmri_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("fill", paste0("gmri_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }
}



####  Blog theme

# # Adding Logo to plot
#
# logo_path <- paste0(system.file("stylesheets", package = "gmRi"), "/gmri_logo.png")
# lab_logo <- magick::image_read(logo_path)
# (test_plot <- ggplot(palmerpenguins::penguins, aes(bill_length_mm, flipper_length_mm, color = species)) +
#     geom_point(show.legend = F) + labs(x = "Bill length", y = "Flipper Length", subtitle = "Penguin Example Plot",
#                                        caption = "Source: Gulf of Maine Research Institute") +
#     gmRi::scale_color_gmri() +
#     theme(plot.caption = element_text(colour = "gray25", size = 6)))
# grid::grid.raster(lab_logo, x = 0.08, y = 0.03, just = c('left', 'bottom'), width = unit(0.8, 'inches'))
