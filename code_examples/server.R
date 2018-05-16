
#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(ggplot2)
library(shiny)
example<-read.csv("updated_will.csv")
#shiny.maxRequestSize=200*1024^2
upload_complete = FALSE
# Define server logic required to draw a histogram
shinyServer(function(input, output, clientData, session) {
  
  # observe({
  #   inFile <- input$file1
  #   if (is.null(inFile))
  #     return(NULL)
  #   read_file<-read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
  #   Quantity<-read_file$Quantity$datapath
  #   NDC<-read_file$NDC$datapath
  #   
  #   #general statistics information
  #   names<-c("Mean")
  #   stats<-c(mean(Quantity))
  #   general_statistics_data_frame<-data.frame(names,stats)
  #   

  # })
  
  observe({
    inFile<-input$file1
    if(!is.null(inFile))
    {
      manufacturer<-manufacturer_frame()
      drug<-drug_frame()
      total_rows_manufacturer<-nrow(manufacturer)
      total_rows_drug<-nrow(drug)
      number_selects_drug<-ceiling(total_rows_drug/10)
      number_selects_manufacturer<-ceiling(total_rows_manufacturer/10)
      selects_manufacturer<-matrix(ncol = number_selects_manufacturer)
      selects_drug<-matrix(ncol = number_selects_drug)
      for(i in 0:number_selects_manufacturer)
      {
        if(i!=number_selects_manufacturer)
        {
          if(i==1)
          {
            selects_manufacturer[1,i] = paste(manufacturer$NDC[1],manufacturer$NDC[i*10],sep=":")
          }
          else
          {
            selects_manufacturer[1,i] = paste(manufacturer$NDC[(i-1)*10],manufacturer$NDC[i*10],sep=":")
          }
        }
        else
        {
          selects_manufacturer[i] = paste(manufacturer$NDC[(i-1)*10],manufacturer$NDC[total_rows_manufacturer],sep=":")
        }
      }
      for(i in 0:number_selects_drug)
      {
        if(i!=number_selects_drug)
        {
          if(i==1)
          {
            selects_drug[1,i] = paste(drug$NDC[1],drug$NDC[i*10],sep=":")
          }
          else
          {
            selects_drug[1,i] = paste(drug$NDC[(i-1)*10],drug$NDC[i*10],sep=":")
          }
        }
        else
        {
          selects_drug[i] = paste(drug$NDC[(i-1)*10],drug$NDC[total_rows_drug],sep=":")
        }
      }
      updateSelectInput(session,"NDC_Manufacturer_Range",choices = as.list(selects_manufacturer))
      updateSelectInput(session,"NDC_Drug_Range",choices = as.list(selects_drug))
    
    }
  })
  
  drug_frame<-reactive({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    NDC<-display_frame()$NDC
    Quantity<-display_frame()$Quantity
    
    #drug type information by NDC
    NDC_Types<-sort(unique(substr(NDC,7,10)))
    
    types_totals<-vector(length = length(NDC_Types))
    
    for (i in 1:length(NDC_Types))
    {
      types_totals[i]<-sum(Quantity[grepl(NDC_Types[i],substr(NDC,7,10))])
    }
    types_data_frame<-data.frame(NDC_Types,types_totals)
  })
  
  
  manufacturer_frame<-reactive({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    NDC<-display_frame()$NDC
    Quantity<-display_frame()$Quantity
    #manufacturer info by NDC
    NDC_Manufacturers<-sort(unique(substr(display_frame()$NDC,0,5)))
    
    manufacturer_totals<-vector(length = length(NDC_Manufacturers))
    
    for (i in 1:length(NDC_Manufacturers))
    {
      manufacturer_totals[i]<-sum(Quantity[grepl(NDC_Manufacturers[i],substr(NDC,0,5))])
    }
    #data frame declarations
    manufacturer_data_frame<-data.frame(NDC_Manufacturers,manufacturer_totals)
    manufacturer_data_frame
  })

  
  display_frame<-reactive({
    inFile<-input$file1
    if(is.null(inFile))
      return(NULL)
    data<-read.csv(inFile$datapath, header=input$header, sep=",", quote=input$quote)
    data
  })
  
  datasetInput <- reactive({
    switch(input$dataset,
           "General Statistics" = write.csv(general_statistics_display(), file="Daily_General_Statistics.csv"),
           "Predictive Statistics" = Predictive_Statistics,
           "Daily Report - Drug Totals" = write.csv(drug_frame(), file="Daily_Report_Drug.csv"),
           "Daily Report - Manufacturer Totals" = write.csv(manufacturer_frame(), file="Daily_Report_Manufacturer.csv"),
           "Example to Upload" = write.csv(example, file="Example_Upload.csv"))
  })
  
  output$NDC_Download <- downloadHandler(
    filename = function() { paste(input$dataset, '.csv', sep='') },
    content = function(file) {
      write.csv(datasetInput(), filename, row.names = FALSE, col.names = FALSE)
    })
  
  output$NDC_Drug_ID_Display <- renderTable({
    drug_frame()
  })
  
  output$data_display <- renderTable({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    display_frame()
  })
  
  output$general_statistics_display <- renderTable({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    
    
    #general statistics information
    names<-c("Occurrences","Mean","Median","Standard Deviation","Maximum","Minimum","Range","Daily Pill Total")
    stats<-c(nrow(display_frame()),mean(display_frame()$Quantity),median(display_frame()$Quantity),
             sd(display_frame()$Quantity),max(display_frame()$Quantity),min(display_frame()$Quantity),
             (max(display_frame()$Quantity)-min(display_frame()$Quantity)),sum(display_frame()$Quantity))
    general_statistics_data_frame<-data.frame(names,stats)
    general_statistics_data_frame
  })
 
  output$NDC_Manufacturer_Display <- renderTable({
    manufacturer_frame()    
  })
  
  output$NDC_Manufacturer_Plot <- renderPlot({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    manufacturer_plot<-plot(manufacturer_frame()$NDC_Manufacturers[input$NDC_Manufacturer_Range],
                            manufacturer_frame()[input$NDC_Manufacturer_Range])
  })
  

  output$NDC_Drug_ID_Plot <- renderPlot({
    inFile <- input$file1

    if (is.null(inFile))
      return(NULL)
    types_plot<-plot(drug_frame()$NDC_Types,drug_frame()$types_totals, xlim=input$NDC_Drug_Range)
  })
  
})
