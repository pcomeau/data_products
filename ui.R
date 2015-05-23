

shinyUI(navbarPage("",
tabPanel("Calculator",
  pageWithSidebar(
    headerPanel("Health Stats Calculator"),
      sidebarPanel(
        selectInput('metric', "System:", choices = c('Metric'='M','English'='E')),
        numericInput('age', 'Age', 25),
        numericInput('weight', 'Weight (pounds)', 100),
        numericInput('height', 'Height (inches)', 60),
        selectInput('gender', "Gender:", choices = c('M'='M','F'='F')),
        selectInput('activity', "Activity Level:", 
                    choices = c('sedentary'='sedentary',
                                'lightly active'='lightly_active',
                                'moderatetely active' = 'moderatetely_active',
                                'very active' = 'very_active',
                                'extra active' = 'extra_active')
        )
                                
      ),
      mainPanel(
        tableOutput("values") 
      )
    )
  ),

  tabPanel("About",
           h3('Welcome to my health stats calculator'),
           h4('First select your preferred system of measure'),
           h4('Then enter your age in years, weight, height, gender, and activity level'),
           h5('sedentary = little or no exercise'),
           h5('lightly active = exercise 1-3 times per week'),
           h5('moderatetely  active = exercise 3-5 times per week'),
           h5('very active = exercise 6-7 times per week'),
           h5('lightly active = exercise 6-7 times per week plus more'),
           h4(''),
           h4('Your health stats will be computed and diplayed'),
           h5('Basal Metabolic Rate (BMR) is the amount of calories you would burn if you were asleep all day'),
           h5('Total daily energy expenditure (calories) is the number of calories needed to maintain your current'),
           h5('weight and is computed using the Harris Benedict Equation')
  )
  
)
)