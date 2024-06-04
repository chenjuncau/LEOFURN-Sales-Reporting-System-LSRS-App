#####Please change the working directory ##########
setwd("D:\\Dropbox\\GT\\2021-Database-CS-6400\\project\\phase3\\LDRS")


#####If the app does not work, install the below packages mannualy#########################################################
list.of.packages = c("shiny", "shinydashboard" ,"DBI","RPostgres" , "DT", "dplyr", "dbplyr","RODBC","rmarkdown")
newpackages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(newpackages) > 0) {install.packages(newpackages)}
lapply(list.of.packages, require, character.only=T)

library(shiny)
library(shinydashboard)
library(DBI)
library(RPostgres)
library(DT)
library(dplyr)
library(dbplyr)
library(RODBC)
library(rmarkdown)

pool <- dbConnect(RPostgres::Postgres(), dbname = "cs6400_sp21_team087", host="localhost", port="5432", user="postgres", password="1234")  

#Used as drop down for store selection
store_numbers = dbGetQuery(pool, "SELECT storenumber FROM store")

#Used as drop down for state name
states_name = dbGetQuery(pool, "SELECT DISTINCT statename from store")

#Used as drop down for report 5 year and month
Sell_year = dbGetQuery(pool, "SELECT DISTINCT date_part('year',DateN) AS years from Sells order by years")
Sell_month = dbGetQuery(pool, "SELECT DISTINCT date_part('month',DateN) AS months from Sells order by months")

#######################################################################################################################
ui <- dashboardPage(
  dashboardHeader(title = "LSRS"),skin = "red",
  dashboardSidebar(width = 250,sidebarMenu(id = "tabs",
    menuItem("Main Menu", tabName = "mainMenu", icon = icon("dashboard"),
      menuItem('View Statistics', tabName = "viewStats", icon = icon("table")), 
        menuItem('Settings', tabName = "settings", icon = icon("cog"),
        menuSubItem('Edit Holiday Information', tabName = "holidayEntry", icon = icon("keyboard")),
        menuSubItem('Edit childcaretimelimit Information', tabName = "childEntry", icon = icon("keyboard")),
        menuSubItem('Edit City Population', tabName = "cityPopEntry", icon = icon("keyboard")))),
    menuItem("Report 1", tabName = "report1", icon = icon("table")),
    menuItem("Report 2", tabName = "report2", icon = icon("table")),
    menuItem("Report 3", tabName = "report3", icon = icon("table")),
    menuItem("Report 4", tabName = "report4", icon = icon("table")),
    menuItem("Report 5", tabName = "report5", icon = icon("table")),
    menuItem("Report 6", tabName = "report6", icon = icon("table")),
    menuItem("Report 7", tabName = "report7", icon = icon("table")),
    menuItem("Report 8", tabName = "report8", icon = icon("table")),
    menuItem("Report 9", tabName = "report9", icon = icon("table")))),   
    
  dashboardBody(tabItems(
    tabItem(tabName = "viewStats",
      fluidRow(column(12, includeMarkdown("Code/Html/team087_p3_viewStats.html"))), tableOutput("countStat"),
#      tags$head(tags$style("#countStat table {background-color: white; ;}", media="screen", type="text/css")), #color: blue
      fluidRow(column(12, includeMarkdown("Code/Html/team087_p3_reportButtons.html"))),                                       
      actionButton('jumpToR1', "Link to Report 1"),
      actionButton('jumpToR2', "Link to Report 2"),
      actionButton('jumpToR3', "Link to Report 3"),
      actionButton('jumpToR4', "Link to Report 4"),
      actionButton('jumpToR5', "Link to Report 5"),
      actionButton('jumpToR6', "Link to Report 6"),
      actionButton('jumpToR7', "Link to Report 7"),
      actionButton('jumpToR8', "Link to Report 8"),
      actionButton('jumpToR9', "Link to Report 9"),      
      actionButton('jumpToHAD', "Link to Edit Holiday Information"),
      actionButton('jumpToMAD', "Link to Edit childcare timelimit Information"),
      actionButton('jumpToCAD', "Link to Edit City Population Information")),  
      
    tabItem(tabName = "holidayEntry",
      actionButton('jumpToviewStats0.1', "Link to Main Menu"), 
      h3("Add or Delete Holiday Information"),
      DT::dataTableOutput("holidays"), tags$hr(),
      h5("To delete, type the exact field information and click the delete button"),
      h5("Please enter date in YYYY-MM-DD format only"),
      textInput("holidaydate", "Holiday Date", ""),
      textInput("holidayname", "Holiday Name", ""),
      actionButton("add", "Add"),
      actionButton("delete", "Delete")),   
    
    tabItem(tabName = "childEntry",
        actionButton('jumpToviewStats0.4', "Link to Main Menu"), 
        h3("Update childcare timelimit Information"),
        DT::dataTableOutput("addChildInfo"), tags$hr(),
        h5("To update, type the exact field information and click the update button"),
        textInput("storenumber", "store number", ""),
        h5("Please enter integer"),
        textInput("timelimit", "time limit", ""),
        actionButton("update2", "Update time limit")),             

            
    tabItem(tabName = "cityPopEntry",
      actionButton('jumpToviewStats0.4', "Link to Main Menu"), 
      h3("Update City Information"),
      DT::dataTableOutput("addCityInfo"), tags$hr(),
      h5("To update, type the exact field information and click the update button"),
      textInput("cityname", "City", ""),
      h5("Please enter state code."),
      textInput("statename", "State", ""),
      h5("Please enter integer."),
      textInput("population", "Population", ""),
      actionButton("update", "Update population")),             
            
    tabItem("report1", 
      actionButton('jumpToviewStats1', "Link to Main Menu"), 
      h3("Report 1 Category Report"),
      h5("Please ensure to click on Open in Browser to download as CSV"),
      DTOutput("tbl1"),
      verbatimTextOutput("selected_manufacturer"),
      DTOutput("tbl1DD")),
      
    tabItem(tabName = "report2",
      actionButton('jumpToviewStats2', "Link to Main Menu"),
      h3("Report 2 Actual versus Predicted Revenue for Couches and Sofas"),
      h5("Please ensure to click on Open in Browser to download as CSV"),
      DTOutput("tbl2")),       
                         
    tabItem(tabName = "report3",
        actionButton('jumpToviewStats3', "Link to Main Menu"),
        h3("Report 3 Revenue by Year by State"),
        selectInput(inputId= "state",
                    label = "Select state from the below drop down",
                    choices = states_name[1]),
        h5("Please ensure to click on Open in Browser to download as CSV"),
        DTOutput("tbl3")),

    tabItem(tabName = "report4", 
        actionButton('jumpToviewStats4', "Link to Main Menu"),
        h3("Report 4 - Outdoor Furniture on GroundHog Day"),
        h5("Please ensure to click on Open in Browser to download as CSV"),
        DTOutput("tbl4")),

    tabItem(tabName = "report5",
       actionButton('jumpToviewStats5', "Link to Main Menu"),
       h3("Report 5 - State with Highest Volume for each Category"),
       selectInput(inputId= "sale_year",
       label = "Select sell year",
       choices = Sell_year[1]),
       selectInput(inputId= "sale_month",
                   label = "Select sell month",
                   choices = Sell_month[1]),       
       DTOutput("tbl5")),

    tabItem(tabName = "report6",
        actionButton('jumpToviewStats6', "Link to Main Menu"),
        h3("Report 6 - Revenue by Population"),
        h5("Please ensure to click on Open in Browser to download as CSV"),
        DTOutput("tbl6")),  

    tabItem(tabName = "report7",
        actionButton('jumpToviewStats7', "Link to Main Menu"),
        h3("Report 7 - Childcare Sales Volume"),
        h5("Please ensure to click on Open in Browser to download as CSV"),
        DTOutput("tbl7")),

    tabItem(tabName = "report8",
                actionButton('jumpToviewStats8', "Link to Main Menu"),
                h3("Report 8 - Restaurant Impact on Category Sales"),
                h5("Please ensure to click on Open in Browser to download as CSV"),
                DTOutput("tbl8")),
                
    tabItem(tabName = "report9",
      actionButton('jumpToviewStats9', "Link to Main Menu"),
      h3("Report 9 -  Advertising Campaign Analysis"),
      h5("Please ensure to click on Open in Browser to download as CSV"),
      DTOutput("tbl9")) 
            
)))

####################################################################################################################################
server <- function(input, output, session){

  #View Statistics
  output$countStat <- renderTable({
    sqlString <- paste(readLines('Code/Sql/team087_p3_view_stats.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString)})
  
  #Buttons in Main Menu to Link Tabs
  observeEvent(input$jumpToR1, 
               {newtab <- switch(input$tabs,"report1")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToR2, 
               {newtab <- switch(input$tabs,"report2")
               updateTabItems(session, "tabs", newtab)})              
  
  observeEvent(input$jumpToR3, 
               {newtab <- switch(input$tabs,"report3")
               updateTabItems(session, "tabs", newtab)})                                   
  
  observeEvent(input$jumpToR4, 
               {newtab <- switch(input$tabs,"report4")
               updateTabItems(session, "tabs", newtab)})   
  
  observeEvent(input$jumpToR5, 
               {newtab <- switch(input$tabs,"report5")
               updateTabItems(session, "tabs", newtab)})   
  
  observeEvent(input$jumpToR6, 
               {newtab <- switch(input$tabs,"report6")
               updateTabItems(session, "tabs", newtab)})  
  
  observeEvent(input$jumpToR7, 
               {newtab <- switch(input$tabs,"report7")
               updateTabItems(session, "tabs", newtab)})  

  observeEvent(input$jumpToR8, 
               {newtab <- switch(input$tabs,"report8")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToR9, 
               {newtab <- switch(input$tabs,"report9")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToHAD, 
               {newtab <- switch(input$tabs,"holidayEntry")
               updateTabItems(session, "tabs", newtab)})  
  
  observeEvent(input$jumpToMAD, 
               {newtab <- switch(input$tabs,"childEntry")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToCAD, 
               {newtab <- switch(input$tabs,"cityPopEntry")
               updateTabItems(session, "tabs", newtab)}) 
  
  #Buttons from Reports to Switch back to Main Menu
  observeEvent(input$jumpToviewStats0.4,
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)})

  observeEvent(input$jumpToviewStats0.1, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats0.2, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats0.3, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats1, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)})  
  
  observeEvent(input$jumpToviewStats2, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)})  
  
  observeEvent(input$jumpToviewStats3, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats4, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats5, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats6, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)}) 
  
  observeEvent(input$jumpToviewStats7, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)})  
 
  observeEvent(input$jumpToviewStats8, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)})  
  
  observeEvent(input$jumpToviewStats9, 
               {newtab <- switch(input$tabs,"viewStats")
               updateTabItems(session, "tabs", newtab)})  
  
  
  #---------Add/Delete Holiday------------#
  addData <- function() {
    query = paste0("INSERT INTO holiday (daten,holidayname)",
                 " VALUES ('",paste(input$holidaydate,"'",",","'",input$holidayname,"')",sep=""))
    #Error handling
    results = tryCatch({
      dbSendQuery(pool, query)
      #If error on query send, this will catch and update won't be executed.
    }
    , error = function(e){
    # print('Got error expected')
    # print('Holiday already exists')
    # print(input$holidaydate)
    # print(input$holidayname)
    # print(query)
     showNotification("Holiday already exists", type = "warning")
    }
    )
  }
  
  deleteData <- function(data) {
    query = paste0("DELETE FROM holiday where ",
                   " daten = '",paste(input$holidaydate,"'"," and holidayname = ","'",input$holidayname,"'",sep=""))

    dbSendQuery(pool, query)
  }
  loadData <- function() {
    query <- sprintf("SELECT * FROM holiday ORDER BY daten DESC") 
    data <- dbGetQuery(pool, query)
  }
  
  observeEvent(input$add, {
    addData()    
  })
  
  observeEvent(input$delete, {
    deleteData(formData())
  })
  output$holidays <- DT::renderDataTable({
    input$add
    input$delete
    loadData()
  })

  # #-------------UPDATE childcare time limit Information-----------#
  updateDataChild <- function() {
    query = paste0("UPDATE childcare SET timelimit = ",input$timelimit," WHERE storenumber=",input$storenumber)
    print(query)    
    dbSendQuery(pool, query)}
  
  loadDataChild <- function() {
    query <- sprintf("SELECT * FROM childcare ORDER BY storenumber ASC") 
    data <- dbGetQuery(pool, query)}
  
  observeEvent(input$update2, {
    updateDataChild()})
  
  output$addChildInfo <- DT::renderDataTable({
    input$update2
    loadDataChild()})

  #-------------------UPDATE City Population Information---------------------#
  updateData <- function() {
    query = paste0("UPDATE updates SET population = ",input$population," WHERE cityname='",input$cityname,"' AND statename='",input$statename,"'")
    dbSendQuery(pool, query)}

  loadDataCity <- function() {
    query <- sprintf("SELECT * FROM updates ORDER BY cityname ASC") 
    data <- dbGetQuery(pool, query)}
  
  observeEvent(input$update, {
    updateData()})

  output$addCityInfo <- DT::renderDataTable({
    input$update
    loadDataCity()})

  #Report 1
  output$tbl1 <- renderDT({
    sqlString <- paste(readLines('Code/Sql/team087_p3_report1.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))
  
  #Report 2
  output$tbl2 <- renderDT({
    sqlString <- paste(readLines('Code/Sql/team087_p3_report2.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))

  #Report 3
  output$tbl3 <- renderDT({
    sqlString <- paste(readLines('Code/Sql/team087_p3_report3.sql'), collapse=' \n ')
    sqlString2 <- gsub('<state>', paste("'",input$state,"'",sep=""), sqlString)
    print(sqlString2)
    dbGetQuery(pool, sqlString2)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))

  #Report 4
  output$tbl4 <- renderDT({
    sqlString <- paste(readLines('Code/Sql/team087_p3_report4.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))

  #Report 5
  output$tbl5 <- renderDT({
    sqlString <- paste(readLines('Code/Sql/team087_p3_report5.sql'), collapse=' \n ')
    sqlString2 <- gsub('<sale_year>', paste("'",input$sale_year,"'",sep=""), sqlString)
    sqlString3 <- gsub('<sale_month>', paste("'",input$sale_month,"'",sep=""), sqlString2)
    print(sqlString3)
    dbGetQuery(pool, sqlString3)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))
  
  #Report 6
  output$tbl6 <- renderDT({
    sqlString <- paste(readLines('Code/Sql/team087_p3_report6.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))
  
  #Report 7
  output$tbl7 <- renderDT({
    sqlString <- paste(readLines('Code/Sql/team087_p3_report7.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))
  
  #Report 8
  output$tbl8 <- renderDT({
    sqlString <- paste(readLines('Code/Sql/team087_p3_report8.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))

  #Report 9
  output$tbl9 <- renderDT({
    sqlString <- paste(readLines('Code/Sql/team087_p3_report9.sql'), collapse=' \n ')
    dbGetQuery(pool, sqlString)}, filter = 'top',rownames = FALSE, extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = c('copy', 'print', 'csv')))

}

shinyApp(ui, server)

