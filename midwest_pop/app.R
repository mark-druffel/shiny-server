library(magrittr)
library(shiny)
library(ggplot2)
library(dplyr)
library(r2d3)
ui <- shiny::fluidPage(
    shiny::titlePanel("Test"),
    shiny::sidebarLayout(
        shiny::sidebarPanel(
            ),
        shiny::mainPanel(
            r2d3::d3Output("bubbles")
        )
    )
)
server <- function(input, output) {
    app_data <- ggplot2::midwest
    state_pop <- app_data %>% 
        dplyr::select(state,poptotal) %>% 
        dplyr::group_by(state) %>% 
        dplyr::summarise(value=sum(poptotal)) %>% 
        dplyr::rename('id'='state')
    output$bubbles <- r2d3::renderD3({
        r2d3::r2d3(data = state_pop, d3_version = 4, script = paste0(here::here(),'/midwest_pop/bubbles.js'))
    })
}
shiny::shinyApp(ui = ui, server = server)

