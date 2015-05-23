
bmr <- function(weight,height,age,gender,metric) {
  
  if(metric == "M") {
    if(gender == "F") {
      655 + ( 9.6 * weight) + ( 1.8 * height) - ( 4.7 * age)
    }
    else {
      66 + ( 13.7 * weight) + ( 5 * height) - ( 6.8 * age)
    }
  }
  else {
    if(gender == "F") { 
      655 + (4.35*weight) + (4.7*height) - (4.7*age)
    }
    else {
      66 + (6.23*weight) + (12.7*height) - (6.8*age)
    }
  }
  
}

bmi <- function(weight,height,age,gender,metric) {
  if(metric == "M") {
    meters <- height/100
    round(weight/(meters^2),digits=2)
  }
  else {
    round((weight*703)/(height^2),digits=2)
  }
}

ideal_weight <- function(weight,height,age,gender,metric) {
  
 if(metric == "M") {
   ## normal BMI 19.1 - 25.8
   meters <- height/100
   if(gender == "F") {
    low_normal <- 19.1 * (meters^2)
    high_normal<- 25.8 * (meters^2)
   }
   else {
     low_normal <- 20.7 * (meters^2)
     high_normal<- 26.4 * (meters^2)     
   }
   paste(round(low_normal, digits = 0),"-",round(high_normal, digits = 0),"kgs")
 }
 else {
   (weight*703)/(height^2)
   if(gender == "F") {
     low_normal <- 19.1 * (height^2) / 703
     high_normal<- 25.8 * (height^2) / 703
   }
   else {
     low_normal <- 20.7 * (height^2) / 703
     high_normal<- 26.4 * (height^2) / 703     
   }
   paste(round(low_normal, digits = 0),"-",round(high_normal, digits = 0),"lbs")
 }
 
}

daily_expediture <- function(weight,height,age,gender,metric,activity) {
  if(activity == "sedentary") factor <- 1.2
  if(activity == "lightly_active") factor <- 1.375
  if(activity == "moderatetely_active") factor <-  1.55
  if(activity == "very_active") factor <- 1.725
  if(activity == "extra_active") factor <- 1.9

  round(bmr(weight,height,age,gender,metric) * factor,digits=0)
}

shinyServer(
  function(input, output, clientData, session) {
    observe({
      c_metric <- input$metric
      
      if(c_metric == "M") {
        updateNumericInput(session, "height", label = "Height (cm)", value = 160)
        updateNumericInput(session, "weight", label = "Weight (kg)", value = 45)
      }
      else {
        updateNumericInput(session, "height", label = "Height (inches)", value = 60)
        updateNumericInput(session, "weight", label = "Weight (lb)", value = 100)
      }
    })
    
    # Reactive expression to compose a data frame containing all of
    # the values
    healthStats <- reactive({
      
      # Compose data frame
      data.frame(
        Stat = c("Basal Metabolic Rate (BMR)",
                 "Body Mass Index (BMI)", 
                 "Ideal Weight",
                 "Total daily energy expenditure (calories)"),
        Value = c(bmr(input$weight,input$height,input$age,input$gender,input$metric), 
                      bmi(input$weight,input$height,input$age,input$gender,input$metric),
                      ideal_weight(input$weight,input$height,input$age,input$gender,input$metric),
                      daily_expediture(input$weight,input$height,input$age,input$gender,input$metric,input$activity)), 
        stringsAsFactors=FALSE)
    }) 
    
    
    # Show the values using an HTML table
    output$values <- renderTable({
      healthStats()
    },include.rownames=FALSE)
    
    
  }
)