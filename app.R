
# =====================================================
# LATIN SQUARE MIXED MODELS APP
# =====================================================

source("global.R")
# =====================================================
# UI
# =====================================================

ui <- dashboardPage(
  
  skin = "green",
  
  dashboardHeader(
    title = "Latin Square Mixed Models",
    titleWidth = 500
  ),
  
  dashboardSidebar(
    
    sidebarMenu(
      
      menuItem(
        "Home",
        tabName = "Home",
        icon = icon("home")
      ),
      
      menuItem(
        "Model guide",
        tabName = "Guide",
        icon = icon("book")
      ),
      
      
      menuItem(
        HTML("Load data and <br> define model<br>structure"),
        tabName = "Data",
        icon = icon("table")
      ),
      
      # menuItem(
      #   HTML("View Design <br> Structure"),
      #   tabName = "Design",
      #   icon = icon("diagram-project")
      # ),
      
      menuItem(
        "Descriptive",
        tabName = "Descriptive",
        icon = icon("chart-simple")
      ),
      
     
      
      
      menuItem(
        "Model fitting",
        tabName = "ModelFit",
        icon = icon("cogs")
      ),
      
      menuItem(
        "Diagnostics",
        tabName = "Diagnostics",
        icon = icon("stethoscope")
      ),
      
      menuItem(
        "Effects",
        tabName = "Effects",
        icon = icon("chart-gantt")
      ),
      menuItem(
        "Power analysis",
        tabName = "Power",
        icon = icon("bolt")
      )
    )
  ),
  
  dashboardBody(
    
    tabItems(
      
      # =====================================================
      # HOME
      # =====================================================
      
      tabItem(
        
        tabName = "Home",
        
        fluidRow(
          
          box(
            
            width = 4,
            title = "Latin Square Mixed Models",
            status = "primary",
            solidHeader = TRUE,
            
            h3("Supported designs"),
            
            tags$ul(
              tags$li("Classical Latin Squares"),
              tags$li("Replicated Latin Squares"),
              tags$li("Repeated-measures Latin Squares"),
              tags$li("General mixed models"),
              tags$li("Flexible random-effects structures")
            )
          ),
          box(
            width = 8,
            # title = "Repeated Latin Square Design",
            # status = "primary",
            # solidHeader = TRUE,
            
            tags$img(
              src = "vacas.jpg",
              width = "100%"
            )
          )
        )
      ),
      
      # =====================================================
      # DATA
      # =====================================================
      
      tabItem(
        
        tabName = "Data",
        
        fluidRow(
          
          box(
            
            width = 4,
            title = "Read data",
            status = "success",
            solidHeader = TRUE,
            
            fileInput(
              "file",
              "Upload data file",
              accept = c(
                ".csv",
                ".xls",
                ".xlsx"
              )
            ),
            
            uiOutput("varSelectUI")
          ),
          
          box(
            
            width = 4,
            title = "Model specification",
            status = "warning",
            solidHeader = TRUE,
            
            uiOutput("modelSpecUI")
          ),
          
          box(
            
            width = 4,
            title = "Preview data",
            status = "success",
            solidHeader = TRUE,
            
            DTOutput("preview_data")
          )
        )
      ),
      
      # =====================================================
      # DESIGN
      # =====================================================
      
      tabItem(
        
        tabName = "Design",
        
        collapsibleTreeOutput("Tree",height = "600px")
      ),
      
      # =====================================================
      # DESCRIPTIVE
      # =====================================================
      
      tabItem(
        
        tabName = "Descriptive",
        
        fluidRow(
          
          box(
            
            width = 3,
            title = "Subject selection",
            status = "success",
            solidHeader = TRUE,
            
            uiOutput("SelectAnimal"),
            
            sliderInput(
              "yScaleProdAnimal",
              "Y-axis scale",
              value = c(0,20),
              min = 0,
              max = 100
            )
          ),
          
          box(
            
            width = 9,
            title = "Response by subject",
            status = "success",
            solidHeader = TRUE,
            
            plotOutput("Production_by_Animal")
          )
        ),
        
        fluidRow(
          
          box(
            
            width = 12,
            title = "Latin square visualization",
            status = "success",
            solidHeader = TRUE,
            
            uiOutput("SelectLS"),
            
            plotOutput("Production_by_LS")
          )
        )
      ),
      
      
      # =====================================================
      # MODEL GUIDE
      # =====================================================
      
      tabItem(
        
        tabName = "Guide",
        
        fluidRow(
          
          box(
            
            width = 6,
            title = "Fixed effects",
            status = "primary",
            solidHeader = TRUE,
            
            HTML("
      <p><b>Fixed effects</b> correspond to factors whose levels are specifically selected and interpreted.</p>
      
      <p>Typical examples:</p>
      
      <ul>
        <li>Treatment</li>
        <li>Diet</li>
        <li>Drug dose</li>
        <li>Time</li>
      </ul>
      
      <p>Use fixed effects when inference is restricted to the observed levels.</p>
      ")
          ),
          
          box(
            
            width = 6,
            title = "Random effects",
            status = "warning",
            solidHeader = TRUE,
            
            HTML("
      <p><b>Random effects</b> represent variability from subjects or experimental units sampled from a larger population.</p>
      
      <p>Typical examples:</p>
      
      <ul>
        <li>Animals</li>
        <li>Cows</li>
        <li>Subjects</li>
        <li>Replicated Latin squares</li>
      </ul>
      
      <p>Random effects model heterogeneity and correlation.</p>
      ")
          )
        ),
        
        fluidRow(
          
          box(
            
            width = 12,
            title = "Nested structures",
            status = "info",
            solidHeader = TRUE,
            
            HTML("
      <p><b>Nested effects</b> occur when the levels of one factor only exist within another factor.</p>
      
      <p>Example:</p>
      
      <pre>
(1 | LS:Cow)
      </pre>
      
      <p>This means cows are unique within each Latin square.</p>
      
      <p>Nested effects are extremely common in replicated Latin square designs.</p>
      ")
          )
        ),
        
        fluidRow(
          
          box(
            
            width = 12,
            title = "Suggested model selection strategy",
            status = "success",
            solidHeader = TRUE,
            
            HTML("
      <ul>
      
      <li><b>Treatment:</b> usually fixed</li>
      
      <li><b>Animals/subjects:</b> usually random</li>
      
      <li><b>Days:</b> usually fixed in longitudinal studies</li>
      
      <li><b>Rows/Periods:</b> fixed when systematic temporal effects are expected</li>
      
      <li><b>Latin squares:</b> random when replicated</li>
      
      </ul>
      ")
          )
        ),
        
        fluidRow(
          
          box(
            
            width = 12,
            title = "Common modeling problems",
            status = "danger",
            solidHeader = TRUE,
            
            HTML("
      <ul>
      
      <li>Too many random effects may produce singular fits</li>
      
      <li>Repeated measurements require correlation modeling</li>
      
      <li>Ignoring subject variability inflates significance</li>
      
      <li>Overparameterized models may fail to converge</li>
      
      <li>Variance estimates near zero suggest unnecessary random effects</li>
      
      </ul>
      ")
          )
        )
      ),
      
      
      # =====================================================
      # MODEL FIT
      # =====================================================
      
      tabItem(
        
        tabName = "ModelFit",
        
        fluidRow(
          column(6,
          
          box(
            
            width = 12,
            title = "Model formula",
            status = "success",
            solidHeader = TRUE,
            
            verbatimTextOutput("Formula")
          ),
          box( width = 12, title = "Interpretation of the selected model", status = "info", solidHeader = TRUE, 
               htmlOutput("ModelInterpretation") ),
          box(
            
            width = 12,
            title = "Model summary",
            status = "success",
            solidHeader = TRUE,
            
            verbatimTextOutput("SummaryModel")
        )
        ),
        column(6,
        
          box(
            
            width = 12,
            title = "ANOVA",
            status = "success",
            solidHeader = TRUE,
            
            verbatimTextOutput("AnovaModel")
          ),
          box(
            
            width = 12,
            title = "Intra Class Correlation (ICC)",
            status = "success",
            solidHeader = TRUE,
            h4(uiOutput("ICC"))
          )
          )
        ),
        
        fluidRow(
          
          conditionalPanel(
            
            condition = "input.randomEffects.length > 0",
            
            box(
              
              width = 4,
              title = "Variance components",
              status = "success",
              solidHeader = TRUE,
              
              tableOutput("VarCompModel")
            )
          ),
          
          conditionalPanel(
            
            condition = "input.repeated == true",
            
            box(
              
              width = 8,
              title = "Observed vs predicted trajectories",
              status = "success",
              solidHeader = TRUE,
              
              uiOutput("SelectLSPredictions"),
              
              plotOutput(
                "ObservedPredictedPlot",
                height = "700px"
              )
            )
          )
        )
      ),
      
      
      # =====================================================
      # DIAGNOSTICS
      # =====================================================
      
      tabItem(
        
        tabName = "Diagnostics",
        
        fluidRow(
          
          box(
            
            width = 6,
            title = "Residuals vs fitted",
            status = "primary",
            solidHeader = TRUE,
            
            plotOutput("ResidualsFitted")
          ),
          
          box(
            
            width = 6,
            title = "Normal Q-Q plot",
            status = "primary",
            solidHeader = TRUE,
            
            plotOutput("QQPlot")
          )
        ),
        fluidRow(
          
          box(
            
            width = 12,
            title = "Residuals by treatment",
            status = "primary",
            solidHeader = TRUE,
            
            plotOutput("ResidualsByTreatment")
          )
        ),
        
        fluidRow(
          
          box(
            
            width = 12,
            title = "Model warnings",
            status = "warning",
            solidHeader = TRUE,
            
            verbatimTextOutput("ModelWarnings")
          )
        )
      ),
      
      # =====================================================
      # EFFECTS
      # =====================================================
      
      tabItem(
        
        tabName = "Effects",
        
        # =====================================================
        # ESTIMATED TREATMENT MEANS
        # =====================================================
        
        fluidRow(
          
          box(
            
            width = 6,
            title = "Estimated treatment means",
            status = "primary",
            solidHeader = TRUE,
            
            plotOutput("PlotTreatmentMeans")
          ),
          
          box(
            
            width = 6,
            title = "Estimated treatment means table",
            status = "primary",
            solidHeader = TRUE,
            
            DTOutput("TableTreatmentMeans")
          )
        ),
        
        # =====================================================
        # RAW VS ADJUSTED
        # =====================================================
        
        fluidRow(
          
          box(
            
            width = 6,
            title = "Raw vs adjusted means",
            status = "info",
            solidHeader = TRUE,
            
            plotOutput("PlotRawAdjusted")
          ),
          
          box(
            
            width = 6,
            title = "Compact letter display",
            status = "info",
            solidHeader = TRUE,
            
            DTOutput("TableLetters")
          )
        ),
        
        # =====================================================
        # MEANS OVER TIME
        # =====================================================
        
        conditionalPanel(
          
          condition = "input.repeated == true",
          
          fluidRow(
            
            box(
              
              width = 6,
              title = "Treatment means over time",
              status = "warning",
              solidHeader = TRUE,
              
              plotOutput("PlotMeansOverTime")
            ),
            
            box(
              
              width = 6,
              title = "Treatment means over time table",
              status = "warning",
              solidHeader = TRUE,
              
              DTOutput("TableMeansOverTime")
            )
          )
        ),
        
        # =====================================================
        # PAIRWISE COMPARISONS
        # =====================================================
        
        fluidRow(
          
          box(
            
            width = 6,
            title = "Pairwise comparisons plot",
            status = "success",
            solidHeader = TRUE,
            
            plotOutput("PlotCIComparisons")
          ),
          
          box(
            
            width = 6,
            title = "Pairwise comparisons table",
            status = "success",
            solidHeader = TRUE,
            
            DTOutput("TableCIComparisons")
          )
        ),
        box(width = 6,
            h3(HTML("<b>Interpretation:</b> The estimated marginal means shown in this section are 
                   adjusted according to the fitted model structure (including random effects, 
                   nesting, and repeated measures when applicable). Pairwise comparisons among treatments 
                   use Tukey-adjusted inference to control the overall Type I error rate across multiple comparisons.")))
      ),
      
      # =====================================================
      # POWER ANALYSIS
      # =====================================================
      
      tabItem(
        
        tabName = "Power",
        
        fluidRow(
          
          box(
            
            width = 4,
            title = "Design summary",
            status = "primary",
            solidHeader = TRUE,
            
            tableOutput("PowerDesignSummary")
          ),
          
          box(
            
            width = 4,
            title = "Variance components",
            status = "warning",
            solidHeader = TRUE,
            
            tableOutput("PowerVariance")
          ),
          
          box(
            
            width = 4,
            title = "Power settings",
            status = "success",
            solidHeader = TRUE,
            
            numericInput(
              "alphaPower",
              "Alpha",
              value = 0.05,
              min = 0.001,
              max = 0.20,
              step = 0.01
            ),
            
            numericInput(
              "targetPower",
              "Target power",
              value = 0.80,
              min = 0.50,
              max = 0.99,
              step = 0.01
            )
          )
        ),
        
        fluidRow(
          
          box(
            
            width = 6,
            title = "Minimum detectable difference",
            status = "info",
            solidHeader = TRUE,
            
            verbatimTextOutput("DetectableDifference")
          ),
          
          box(
            
            width = 6,
            title = "Approximate power curve",
            status = "success",
            solidHeader = TRUE,
            
            plotOutput("PowerCurve")
          )
        )
        ,
        
        # fluidRow(
        #   
        #   box(
        #     
        #     width = 12,
        #     title = "Simulation-based power (optional)",
        #     status = "danger",
        #     solidHeader = TRUE,
        #     
        #     p("Requires simr package"),
        #     
        #     actionButton(
        #       "RunPowerSimulation",
        #       "Run simulation power"
        #     ),
        #     
        #     br(),
        #     br(),
        #     
        #     verbatimTextOutput("SimulationPower")
        #   )
        # )
      )
      
    )
  )
)

# =====================================================
# SERVER
# =====================================================

server <- function(input, output, session) {
  
  # =====================================================
  # READ DATA
  # =====================================================
  
  rawData <- reactive({
    
    req(input$file)
    
    ext <- tools::file_ext(input$file$name)
    
    validate(
      need(
        ext %in% c("csv","xls","xlsx"),
        "Upload a valid file"
      )
    )
    
    # CSV
    
    if (ext == "csv") {
      
      first_line <- readLines(
        input$file$datapath,
        n = 1
      )
      
      sep_detected <- ifelse(
        stringr::str_count(first_line, ";") >
          stringr::str_count(first_line, ","),
        ";",
        ","
      )
      
      df <- read.csv(
        input$file$datapath,
        sep = sep_detected,
        header = TRUE,
        stringsAsFactors = FALSE,
        check.names = FALSE
      )
    }
    
    # Excel
    
    if (ext %in% c("xls","xlsx")) {
      
      df <- readxl::read_excel(
        input$file$datapath
      ) %>%
        as.data.frame()
    }
    
    return(df)
  })
  
  # =====================================================
  # VARIABLE SELECTION
  # =====================================================
  
  output$varSelectUI <- renderUI({
    
    req(rawData())
    
    cols <- names(rawData())
    
    tagList(
      
      selectInput(
        "latinSquareVar",
        "Latin square",
        choices = cols
      ),
      
      selectInput(
        "rowVar",
        "Row factor",
        choices = cols
      ),
      
      selectInput(
        "colVar",
        "Column factor",
        choices = cols
      ),
      
      selectInput(
        "treatVar",
        "Treatment factor",
        choices = cols
      ),
      
      selectInput(
        "measureVar",
        "Measurement variable",
        choices = cols
      ),
      
      hr(),
      
      checkboxInput(
        "repeated",
        "Repeated measurements",
        FALSE
      ),
      
      conditionalPanel(
        
        condition = "input.repeated == true",
        
        selectInput(
          "daysVar",
          "Repeated factor",
          choices = cols
        ),
        
        selectInput(
          "subjectVar",
          "Experimental subject",
          choices = cols
        )
      )
    )
  })
  
  # =====================================================
  # MODEL SPECIFICATION
  # =====================================================
  
  output$modelSpecUI <- renderUI({
    
    req(rawData())
    
    cols <- names(rawData())
    
    fixed_default <- NULL
    
    if (!is.null(input$treatVar)) {
      fixed_default <- input$treatVar
    }
    
    random_default <- NULL
    
    candidate_random <- c(
      input$latinSquareVar,
      input$rowVar,
      input$colVar
    )
    
    candidate_random <- candidate_random[
      candidate_random %in% cols
    ]
    
    tagList(
      
      checkboxGroupInput(
        "fixedEffects",
        "Fixed effects",
        choices = cols,
        selected = fixed_default
      ),
      
      checkboxGroupInput(
        "randomEffects",
        "Random effects",
        choices = cols,
        selected = candidate_random
      ),
      
      checkboxInput(
        "includeInteractions",
        "Treatment × repeated interaction",
        TRUE
      ),
      
      checkboxInput(
        "nestedRows",
        "Rows nested within Latin square",
        TRUE
      ),
      
      checkboxInput(
        "nestedCols",
        "Columns nested within Latin square",
        TRUE
      )
    )
  })
  
  # =====================================================
  # PROCESS DATA
  # =====================================================
  
  processedData <- reactive({
    
    req(rawData())
    req(input$measureVar)
    
    df <- rawData()
    
    factor_vars <- c(
      input$latinSquareVar,
      input$rowVar,
      input$colVar,
      input$treatVar,
      input$fixedEffects,
      input$randomEffects
    )
    
    if (isTRUE(input$repeated)) {
      
      factor_vars <- c(
        factor_vars,
        input$daysVar,
        input$subjectVar
      )
    }
    
    # remove invalid names
    
    factor_vars <- unique(factor_vars)
    
    factor_vars <- factor_vars[
      !is.na(factor_vars)
    ]
    
    factor_vars <- factor_vars[
      factor_vars != ""
    ]
    
    factor_vars <- factor_vars[
      factor_vars %in% names(df)
    ]
    
    # convert to factors
    
    for (v in factor_vars) {
      
      df[[v]] <- factor(df[[v]])
    }
    
    # response
    
    validate(
      need(
        input$measureVar %in% names(df),
        "Select a valid measurement variable"
      )
    )
    
    df[[input$measureVar]] <- as.numeric(
      df[[input$measureVar]]
    )
    
    return(df)
  })
  
  # =====================================================
  # PREVIEW
  # =====================================================
  
  output$preview_data <- renderDT({
    
    DT::datatable(
      processedData()
    )
  })
  
  # =====================================================
  # TREE
  # =====================================================
  
  output$Tree <- renderCollapsibleTree({
    
    req(processedData())
    
    data.tree <- processedData()
    
    nodes <- c(
      input$latinSquareVar,
      input$rowVar,
      input$colVar,
      input$treatVar
    )
    
    if (isTRUE(input$repeated)) {
      
      nodes <- c(
        nodes,
        input$daysVar
      )
    }
    
    nodes <- nodes[
      !is.na(nodes)
    ]
    
    nodes <- nodes[
      nodes != ""
    ]
    
    nodes <- nodes[
      nodes %in% names(data.tree)
    ]
    
    req(length(nodes) > 0)
    
    data.tree[nodes] <- lapply(
      nodes,
      function(col) {
        
        paste0(
          col,
          ": ",
          data.tree[[col]]
        )
      }
    )
    
    collapsibleTree(
      data.tree,
      hierarchy = c(
        nodes,
        input$measureVar
      ),
      collapsed = FALSE
    )
  })
  
  # =====================================================
  # SELECTORS
  # =====================================================
  
  output$SelectAnimal <- renderUI({
    
    req(processedData())
    req(input$colVar)
    
    validate(
      need(
        input$colVar %in% names(processedData()),
        "Invalid subject variable"
      )
    )
    
    ids <- levels(
      processedData()[[input$colVar]]
    )
    
    selectInput(
      "AnimalID",
      "Select subject",
      choices = ids
    )
  })
  
  output$SelectLS <- renderUI({
    
    req(processedData())
    req(input$latinSquareVar)
    
    validate(
      need(
        input$latinSquareVar %in% names(processedData()),
        "Invalid Latin square variable"
      )
    )
    
    ids <- levels(
      processedData()[[input$latinSquareVar]]
    )
    
    selectInput(
      "LSID",
      "Select Latin square",
      choices = ids
    )
  })
  
  # =====================================================
  # DESCRIPTIVE PLOTS
  # =====================================================
  
  output$Production_by_Animal <- renderPlot({
    
    req(processedData())
    
    data <- processedData()
    
    # =====================================================
    # NON-REPEATED
    # =====================================================
    
    if (!isTRUE(input$repeated)) {
      
      data_plot <- data.frame(
        
        Treatment =
          data[[input$treatVar]],
        
        Response =
          data[[input$measureVar]],
        
        Subject =
          data[[input$colVar]],
        
        LS =
          data[[input$latinSquareVar]]
      )
      
      # =====================================================
      # SUMMARY DATA
      # =====================================================
      
      summary_data <- data_plot %>%
        
        group_by(
          LS,
          Treatment
        ) %>%
        
        summarise(
          
          mean = mean(
            Response,
            na.rm = TRUE
          ),
          
          sd = sd(
            Response,
            na.rm = TRUE
          ),
          
          n = n(),
          
          se = sd / sqrt(n),
          
          lower = mean - se,
          
          upper = mean + se,
          
          .groups = "drop"
        )
      
      # =====================================================
      # PLOT
      # =====================================================
      
      ggplot(
        data_plot,
        aes(
          x = Treatment,
          y = Response,
          color = Treatment,
          shape = Subject
        )
      ) +
        
        # =====================================================
      # INDIVIDUAL OBSERVATIONS
      # =====================================================
      
      geom_jitter(
        width = 0.08,
        size = 4,
        alpha = 0.85
      ) +
        
        # =====================================================
      # SUBJECT LABELS
      # =====================================================
      
      geom_text(
        aes(
          label = Subject
        ),
        size = 3,
        vjust = -1,
        show.legend = FALSE
      ) +
        
        # =====================================================
      # MEANS
      # =====================================================
      
      geom_point(
        data = summary_data,
        aes(
          x = Treatment,
          y = mean
        ),
        inherit.aes = FALSE,
        size = 6,
        shape = 18,
        color = "black"
      ) +
        
        # =====================================================
      # ERROR BARS
      # =====================================================
      
      geom_errorbar(
        data = summary_data,
        aes(
          x = Treatment,
          ymin = lower,
          ymax = upper
        ),
        inherit.aes = FALSE,
        width = 0.15,
        linewidth = 1.2,
        color = "black"
      ) +
        
        # =====================================================
      # FACET BY LATIN SQUARE
      # =====================================================
      
      facet_wrap(
        ~LS
      ) +
        
        # =====================================================
      # STYLE
      # =====================================================
      
      labs(
        title = "Measurements by treatment and Latin square",
        y = input$measureVar,
        x = "Treatment"
      ) +
        
        theme_minimal(
          base_size = 15
        ) +
        
        theme(
          
          plot.title = element_text(
            face = "bold",
            hjust = 0.5
          ),
          
          axis.text = element_text(
            face = "bold"
          ),
          
          axis.title = element_text(
            face = "bold"
          ),
          
          strip.text = element_text(
            face = "bold",
            size = 14
          ),
          
          legend.position = "right"
        )
      
    } else {
      
      # =====================================================
      # REPEATED
      # =====================================================
      
      req(input$AnimalID)
      
      data <- data %>%
        
        filter(
          .data[[input$colVar]] ==
            input$AnimalID
        )
      
      ggplot(
        data,
        aes_string(
          x = input$daysVar,
          y = input$measureVar,
          group = input$treatVar,
          color = input$treatVar
        )
      ) +
        
        geom_line(
          linewidth = 1.2
        ) +
        
        geom_point(
          size = 3
        ) +
        
        ylim(input$yScaleProdAnimal)
    }
  })
  
  # =====================================================
  # LS VISUALIZATION
  # =====================================================
  
  output$Production_by_LS <- renderPlot({
    
    req(processedData())
    req(input$LSID)
    
    data <- processedData() %>%
      
      filter(
        .data[[input$latinSquareVar]] ==
          input$LSID
      )
    
    # =====================================================
    # NON-REPEATED LATIN SQUARE
    # =====================================================
    
    if (!isTRUE(input$repeated)) {
      
      ggplot(
        data,
        aes_string(
          x = input$colVar,
          y = input$rowVar
        )
      ) +
        
        # =====================================================
      # TILES
      # =====================================================
      
      geom_tile(
        fill = "grey95",
        color = "grey70",
        linewidth = 1.5
      ) +
        
        # =====================================================
      # TREATMENT LABELS
      # =====================================================
      
      geom_text(
        aes(
          label = .data[[input$treatVar]],
          color = .data[[input$treatVar]]
        ),
        size = 10,
        fontface = "bold",
        show.legend = FALSE
      ) +
        
        # =====================================================
      # RESPONSE VALUES
      # =====================================================
      
      geom_text(
        aes(
          label = round(
            .data[[input$measureVar]],
            1
          )
        ),
        nudge_y = -0.28,
        size = 6,
        color = "black",
        fontface = "bold"
      ) +
        
        # =====================================================
      # GRID LINES
      # =====================================================
      
      geom_hline(
        yintercept = seq(
          0.5,
          length(unique(data[[input$rowVar]])) + 0.5,
          by = 1
        ),
        color = "grey70",
        linewidth = 1
      ) +
        
        geom_vline(
          xintercept = seq(
            0.5,
            length(unique(data[[input$colVar]])) + 0.5,
            by = 1
          ),
          color = "grey70",
          linewidth = 1
        ) +
        
        # =====================================================
      # STYLE
      # =====================================================
      
      scale_y_discrete(
        limits = rev
      ) +
        
        coord_fixed() +
        
        labs(
          x = input$colVar,
          y = input$rowVar,
          title = paste(
            "Latin square",
            input$LSID
          )
        ) +
        
        theme_minimal(
          base_size = 16
        ) +
        
        theme(
          
          panel.grid = element_blank(),
          
          axis.text = element_text(
            face = "bold",
            size = 14
          ),
          
          axis.title = element_text(
            face = "bold",
            size = 15
          ),
          
          plot.title = element_text(
            face = "bold",
            hjust = 0.5,
            size = 18
          )
        )
      
    } else {
      
      # =====================================================
      # REPEATED MEASURES
      # =====================================================
      
      ggplot(
        data,
        aes_string(
          x = input$daysVar,
          y = input$measureVar,
          group = input$treatVar,
          color = input$treatVar
        )
      ) +
        
        geom_line(
          linewidth = 1.2
        ) +
        
        geom_point(
          size = 3
        ) +
        
        facet_grid(
          as.formula(
            paste(
              input$rowVar,
              "~",
              input$colVar
            )
          )
        ) +
        
        theme_minimal(
          base_size = 14
        ) +
        
        theme(
          
          strip.text = element_text(
            face = "bold"
          ),
          
          plot.title = element_text(
            face = "bold",
            hjust = 0.5
          )
        )
    }
  })
  # =====================================================
  # MODEL FORMULA
  # =====================================================
  
  formulaText <- reactive({
    
    req(input$fixedEffects)
    
    fixed_terms <- input$fixedEffects
    
    # =====================================================
    # REPEATED INTERACTION
    # =====================================================
    
    if (
      isTRUE(input$repeated) &&
      isTRUE(input$includeInteractions)
    ) {
      
      interaction_term <- paste0(
        input$treatVar,
        ":",
        input$daysVar
      )
      
      if (!(interaction_term %in% fixed_terms)) {
        
        fixed_terms <- c(
          fixed_terms,
          interaction_term
        )
      }
    }
    
    # =====================================================
    # NESTING FOR FIXED-EFFECTS MODELS
    # =====================================================
    
    has_random <- (
      !is.null(input$randomEffects) &&
        length(input$randomEffects) > 0
    )
    
    if (!has_random) {
      
      # nested rows
      
      if (isTRUE(input$nestedRows)) {
        
        fixed_terms <- c(
          fixed_terms,
          paste0(
            input$latinSquareVar,
            "/",
            input$rowVar
          )
        )
        
        fixed_terms <- setdiff(
          fixed_terms,
          input$rowVar
        )
      }
      
      # nested cols
      
      if (isTRUE(input$nestedCols)) {
        
        fixed_terms <- c(
          fixed_terms,
          paste0(
            input$latinSquareVar,
            "/",
            input$colVar
          )
        )
        
        fixed_terms <- setdiff(
          fixed_terms,
          input$colVar
        )
      }
    }
    
    # =====================================================
    # FIXED FORMULA
    # =====================================================
    
    fixed_formula <- paste(
      unique(fixed_terms),
      collapse = " + "
    )
    
    # =====================================================
    # RANDOM TERMS
    # =====================================================
    
    random_terms <- c()
    
    if (has_random) {
      
      for (v in input$randomEffects) {
        
        # nested rows
        
        if (
          v == input$rowVar &&
          isTRUE(input$nestedRows)
        ) {
          
          random_terms <- c(
            random_terms,
            paste0(
              "(1|",
              input$latinSquareVar,
              ":",
              input$rowVar,
              ")"
            )
          )
          
          # nested cols
          
        } else if (
          v == input$colVar &&
          isTRUE(input$nestedCols)
        ) {
          
          random_terms <- c(
            random_terms,
            paste0(
              "(1|",
              input$latinSquareVar,
              ":",
              input$colVar,
              ")"
            )
          )
          
        } else {
          
          random_terms <- c(
            random_terms,
            paste0("(1|", v, ")")
          )
        }
      }
    }
    
    # =====================================================
    # FINAL FORMULA
    # =====================================================
    
    formula_text <- paste(
      input$measureVar,
      "~",
      fixed_formula
    )
    
    if (length(random_terms) > 0) {
      
      formula_text <- paste(
        formula_text,
        "+",
        paste(random_terms, collapse = " + ")
      )
    }
    
    formula_text
  })
  
  # =====================================================
  # CHECK IF RANDOM EFFECTS EXIST
  # =====================================================
  
  hasRandomEffects <- reactive({
    
    !is.null(input$randomEffects) &&
      length(input$randomEffects) > 0
  })
  
  # =====================================================
  # MODEL TYPE
  # =====================================================
  
  modelType <- reactive({
    
    if (hasRandomEffects()) {
      
      "mixed"
      
    } else {
      
      "fixed"
    }
  })

  
  # =====================================================
  # MODEL FIT
  # =====================================================
  
  
  
  modelfit <- reactive({
    
    req(formulaText())
    
    formula <- as.formula(
      formulaText()
    )
    
    if (hasRandomEffects()) {
      
      lmerTest::lmer(
        formula,
        data = processedData(),
        REML = TRUE
      )
      
    } else {
      
      stats::aov(
        formula,
        data = processedData()
      )
    }
  })
  
  output$Formula <- renderPrint({
    
    formulaText()
  })
  
  # =====================================================
  # ICC
  # =====================================================
  
  output$ICC <- renderUI({
    
    req(modelType() == "mixed")
    
    vc <- VarCorr(
      modelfit()
    )
    
    vc_df <- as.data.frame(vc)
    
    residual_var <- vc_df$vcov[
      vc_df$grp == "Residual"
    ]
    
    random_var <- sum(
      vc_df$vcov[
        vc_df$grp != "Residual"
      ]
    )
    
    icc <- random_var /
      (random_var + residual_var)
    
    text <- HTML("ICC represents the proportion of total variability explained by the random 
        effects structure. Higher values indicate stronger similarity among observations 
        belonging to the same subject, animal, or experimental unit. <br><br>
                 Intraclass correlation coefficient (ICC): ", round(icc, 4))
    
    text
    
  })
  
  # =====================================================
  # MODEL INTERPRETATION
  # =====================================================
  
  output$ModelInterpretation <- renderUI({
    
    req(input$fixedEffects)
    
    fixed_txt <- paste(
      input$fixedEffects,
      collapse = ", "
    )
    
    random_txt <- paste(
      input$randomEffects,
      collapse = ", "
    )
    
    HTML(
      paste0(
        
        "<p><b>Fixed effects:</b> ",
        fixed_txt,
        "</p>",
        
        "<p>These variables are interpreted directly as systematic effects.</p>",
        
        "<p><b>Random effects:</b> ",
        random_txt,
        "</p>",
        
        "<p>These variables contribute variance components and correlation structures.</p>",
        
        "<p><b>Nested rows:</b> ",
        ifelse(input$nestedRows, "YES", "NO"),
        "</p>",
        
        "<p><b>Nested columns:</b> ",
        ifelse(input$nestedCols, "YES", "NO"),
        "</p>"
      )
    )
  })
  
  # =====================================================
  # RESIDUALS VS FITTED
  # =====================================================
  
  output$ResidualsFitted <- renderPlot({
    
    req(modelfit())
    
    model <- modelfit()
    
    plot(
      fitted(model),
      resid(model),
      pch = 19,
      col = "blue",
      xlab = "Fitted values",
      ylab = "Residuals"
    )
    
    abline(
      h = 0,
      lty = 2,
      lwd = 2
    )
  })
  
  # =====================================================
  # QQ PLOT
  # =====================================================
  
  output$QQPlot <- renderPlot({
    
    req(modelfit())
    
    model <- modelfit()
    
    qqnorm(
      resid(model),
      pch = 19,
      col = "blue"
    )
    
    qqline(
      resid(model),
      lwd = 2
    )
  })
  
  # =====================================================
  # MODEL WARNINGS
  # =====================================================
  
  output$ModelWarnings <- renderPrint({
    
    req(modelfit())
    
    model <- modelfit()
    
    cat("MODEL DIAGNOSTICS
")
    cat("=========================

")
    
    if (modelType() == "mixed") {
      
      if (lme4::isSingular(model)) {
        
        cat("WARNING: Singular fit detected.
")
        cat("The model may be overparameterized.

")
        
      } else {
        
        cat("No singularity detected.

")
      }
      
      vc <- VarCorr(model)
      
      small_var <- sapply(
        vc,
        function(x) attr(x, "stddev")
      )
      
      if (any(unlist(small_var) < 0.001)) {
        
        cat("Some variance components are close to zero.
")
        cat("Consider simplifying the random-effects structure.

")
      }
      
    } else {
      
      cat("Fixed-effects ANOVA model detected.
")
      cat("No random-effects diagnostics required.

")
    }
    
    cat("Check:
")
    cat("- Residual normality
")
    cat("- Homogeneity of variance
")
    cat("- Outliers
")
    
    if (isTRUE(input$repeated)) {
      cat("- Temporal correlation
")
    }
  })
  
  
  
  output$SummaryModel <- renderPrint({
    
    summary(modelfit())
  })
  
  output$AnovaModel <- renderPrint({
    
    anova(modelfit())
  })
  
  output$VarCompModel <- renderTable({
    
    if (modelType() == "fixed") {
      
      return(
        data.frame(
          Message = "No random effects in the model"
        )
      )
    }
    
    components <- VarCorr(
      modelfit()
    ) %>%
      as.data.frame()
    
    variance <- as.numeric(
      components$vcov
    )
    
    prop <- variance / sum(variance)
    
    data.frame(
      Component = components$grp,
      Variance = round(variance, 3),
      Proportion = round(prop, 3)
    )
  })
  
  # =====================================================
  # LS SELECTOR FOR PREDICTIONS
  # =====================================================
  
  output$SelectLSPredictions <- renderUI({
    
    req(processedData())
    
    ids <- levels(
      processedData()[[input$latinSquareVar]]
    )
    
    selectInput(
      "LSIDPredictions",
      "Select Latin square",
      choices = ids
    )
  })
  
  # =====================================================
  # OBSERVED VS PREDICTED
  # =====================================================
  
  output$ObservedPredictedPlot <- renderPlot({
    
    req(modelfit())
    req(processedData())
    req(input$LSIDPredictions)
    
    validate(
      need(
        isTRUE(input$repeated),
        "Observed vs predicted trajectories only available for repeated-measures designs"
      )
    )
    
    model <- modelfit()
    
    # =====================================================
    # PREDICTIONS
    # =====================================================
    
    data_fit <- processedData() %>%
      
      mutate(
        
        Predicted = if(modelType() == "mixed"){
          predict(
            model,
            re.form = NULL
          )
        } else {
          predict(model)
        },
        
        Observed = .data[[input$measureVar]]
      )
    
    # =====================================================
    # SELECT LATIN SQUARE
    # =====================================================
    
    d <- data_fit %>%
      
      filter(
        .data[[input$latinSquareVar]] ==
          input$LSIDPredictions
      )
    
    # =====================================================
    # OBSERVED VS PREDICTED
    # =====================================================
    
    ggplot(
      d,
      aes_string(
        x = input$daysVar,
        color = input$treatVar
      )
    ) +
      
      # =====================================================
    # OBSERVED VALUES
    # =====================================================
    
    geom_point(
      aes(
        y = Observed
      ),
      size = 3,
      alpha = 0.8
    ) +
      
      geom_line(
        aes_string(
          y = "Observed",
          group = input$subjectVar
        ),
        linewidth = 0.8,
        alpha = 0.5
      ) +
      
      # =====================================================
    # PREDICTED VALUES
    # =====================================================
    
    geom_line(
      aes_string(
        y = "Predicted",
        group = input$subjectVar
      ),
      linewidth = 1.5
    ) +
      
      geom_point(
        aes(
          y = Predicted
        ),
        shape = 18,
        size = 3
      ) +
      
      # =====================================================
    # FACETS
    # =====================================================
    
    facet_grid(
      as.formula(
        paste(
          input$rowVar,
          "~",
          input$colVar
        )
      )
    ) +
      
      # =====================================================
    # STYLE
    # =====================================================
    
    
    
    labs(
      title = paste(
        "Observed vs predicted trajectories - LS",
        input$LSIDPredictions
      ),
      x = input$daysVar,
      y = input$measureVar,
      color = "Treatment"
    )
  })
  
  # =====================================================
  # EFFECTS
  # =====================================================
  
  # =====================================================
  # ESTIMATED TREATMENT MEANS
  # =====================================================
  
  treatmentMeans <- reactive({
    
    emm <- emmeans(
      modelfit(),
      as.formula(
        paste(
          "~",
          input$treatVar
        )
      )
    )
    
    confint(emm) %>%
      as.data.frame()
  })
  
  # =====================================================
  # RAW VS ADJUSTED PLOT
  # =====================================================
  
  output$PlotRawAdjusted <- renderPlot({
    
    # =====================================================
    # RAW MEANS
    # =====================================================
    
    raw_tab <- processedData() %>%
      
      group_by(
        .data[[input$treatVar]]
      ) %>%
      
      summarise(
        
        RawMean = mean(
          .data[[input$measureVar]],
          na.rm = TRUE
        ),
        
        RawSE = sd(
          .data[[input$measureVar]],
          na.rm = TRUE
        ) / sqrt(n()),
        
        .groups = "drop"
      )
    
    # =====================================================
    # ADJUSTED MEANS
    # =====================================================
    
    adj_tab <- treatmentMeans() %>%
      
      dplyr::select(
        all_of(input$treatVar),
        emmean,
        SE
      )
    
    names(adj_tab) <- c(
      input$treatVar,
      "AdjustedMean",
      "AdjustedSE"
    )
    
    # =====================================================
    # MERGE
    # =====================================================
    
    tab <- left_join(
      raw_tab,
      adj_tab,
      by = input$treatVar
    )
    
    # =====================================================
    # LONG FORMAT
    # =====================================================
    
    plot_tab <- data.frame(
      
      Treatment = rep(
        tab[[input$treatVar]],
        2
      ),
      
      Type = rep(
        c(
          "Raw",
          "Adjusted"
        ),
        each = nrow(tab)
      ),
      
      Mean = c(
        tab$RawMean,
        tab$AdjustedMean
      ),
      
      SE = c(
        tab$RawSE,
        tab$AdjustedSE
      )
    )
    
    # =====================================================
    # PLOT
    # =====================================================
    
    ggplot(
      plot_tab,
      aes(
        x = Type,
        y = Mean,
        group = Treatment,
        color = Treatment
      )
    ) +
      
      geom_line(
        linewidth = 1.2,
        alpha = 0.7
      ) +
      
      geom_point(
        size = 4
      ) +
      
      geom_errorbar(
        aes(
          ymin = Mean - SE,
          ymax = Mean + SE
        ),
        width = 0.08
      ) +
      
      labs(
        title = "Raw vs adjusted treatment means",
        y = "Mean",
        x = ""
      )
  })
  
  # =====================================================
  # COMPACT LETTER DISPLAY
  # =====================================================
  
  treatmentLetters <- reactive({
    
    # =====================================================
    # EMMEANS
    # =====================================================
    
    emm <- emmeans(
      modelfit(),
      as.formula(
        paste(
          "~",
          input$treatVar
        )
      )
    )
    
    means_tab <- as.data.frame(
      confint(emm)
    )
    
    # =====================================================
    # P-VALUE MATRIX
    # =====================================================
    
    pw <- pwpm(
      emm,
      adjust = "tukey"
    )
    
    # convert to matrix
    
    pmat <- as.matrix(pw)
    
    # keep only numeric
    
    suppressWarnings(
      mode(pmat) <- "numeric"
    )
    
    # diagonal = 1
    
    diag(pmat) <- 1
    
    # =====================================================
    # LETTERS
    # =====================================================
    
    letters_obj <- multcompView::multcompLetters(
      pmat
    )
    
    means_tab$.group <- letters_obj$Letters[
      as.character(
        means_tab[[input$treatVar]]
      )
    ]
    
    means_tab
  })
  
  output$TableLetters <- renderDT({
    
    tab <- treatmentLetters()
    
    numeric_cols <- sapply(
      tab,
      is.numeric
    )
    
    tab[numeric_cols] <- round(
      tab[numeric_cols],
      4
    )
    
    DT::datatable(
      
      tab,
      
      rownames = FALSE,
      
      options = list(
        pageLength = 10,
        scrollX = TRUE
      )
    )
  })
  
  # =====================================================
  # MEANS OVER TIME
  # =====================================================
  
  meansOverTime <- reactive({
    
    req(input$repeated)
    
    emm <- emmeans(
      modelfit(),
      as.formula(
        paste(
          "~",
          input$treatVar,
          "|",
          input$daysVar
        )
      )
    )
    
    confint(emm) %>%
      as.data.frame()
  })
  
  output$PlotMeansOverTime <- renderPlot({
    
    tab <- meansOverTime()
    
    ggplot(
      tab,
      aes_string(
        x = input$daysVar,
        y = "emmean",
        color = input$treatVar,
        group = input$treatVar
      )
    ) +
      
      geom_line(
        linewidth = 1.2
      ) +
      
      geom_point(
        size = 3
      ) +
      
      geom_errorbar(
        aes(
          ymin = lower.CL,
          ymax = upper.CL
        ),
        width = 0.1
      ) +
      
      labs(
        y = "Estimated mean",
        x = input$daysVar
      )
  })
  
  output$TableMeansOverTime <- renderDT({
    
    tab <- meansOverTime()
    
    numeric_cols <- sapply(
      tab,
      is.numeric
    )
    
    tab[numeric_cols] <- round(
      tab[numeric_cols],
      4
    )
    
    DT::datatable(
      
      tab,
      
      rownames = FALSE,
      
      options = list(
        pageLength = 10,
        scrollX = TRUE
      )
    )
  })
  
  # =====================================================
  # RESIDUALS BY TREATMENT
  # =====================================================
  
  output$ResidualsByTreatment <- renderPlot({
    
    data_plot <- data.frame(
      
      Treatment =
        processedData()[[input$treatVar]],
      
      Residuals =
        resid(modelfit())
    )
    
    ggplot(
      data_plot,
      aes(
        x = Treatment,
        y = Residuals,
        fill = Treatment
      )
    ) +
      
      geom_boxplot() +
      
      geom_hline(
        yintercept = 0,
        lty = 2
      ) +
      
      labs(
        y = "Residuals",
        x = "Treatment"
      )
  })
  
  # =====================================================
  # TREATMENT MEANS PLOT
  # =====================================================
  
  output$PlotTreatmentMeans <- renderPlot({
    
    tab <- treatmentMeans()
    
    ggplot(
      tab,
      aes_string(
        x = input$treatVar,
        y = "emmean"
      )
    ) +
      
      geom_point(
        size = 5,
        color = "blue"
      ) +
      
      geom_errorbar(
        aes(
          ymin = lower.CL,
          ymax = upper.CL
        ),
        width = 0.15,
        linewidth = 1.2,
        color = "blue"
      ) +
      
      labs(
        x = "Treatment",
        y = "Estimated mean",
        title = "Estimated marginal means with 95% CI"
      )
  })
  
  # =====================================================
  # TREATMENT MEANS TABLE
  # =====================================================
  
  output$TableTreatmentMeans <- renderDT({
    
    tab <- treatmentMeans()
    
    numeric_cols <- sapply(
      tab,
      is.numeric
    )
    
    tab[numeric_cols] <- round(
      tab[numeric_cols],
      4
    )
    
    names(tab) <- gsub(
      "\\.",
      " ",
      names(tab)
    )
    
    DT::datatable(
      
      tab,
      
      rownames = FALSE,
      
      options = list(
        pageLength = 10,
        scrollX = TRUE
      )
    )
  })
  
  compareCI <- reactive({
    
    comparisons <- emmeans(
      modelfit(),
      as.formula(
        paste(
          "pairwise ~",
          input$treatVar
        )
      )
    ) %>%
      confint()
    
    ggplot(
      comparisons$contrasts,
      aes(
        contrast,
        estimate
      )
    ) +
      
      geom_errorbar(
        aes(
          ymin = lower.CL,
          ymax = upper.CL
        ),
        linewidth = 1,
        width = 0.1,
        color = "blue"
      ) +
      
      geom_point(
        size = 5,
        shape = 21,
        fill = "yellow"
      ) +
      
      geom_hline(
        yintercept = 0,
        lty = 2
      ) 
  })
  
  output$PlotCIComparisons <- renderPlot({
    
    compareCI()
  })
  
  
  
  # =====================================================
  # PAIRWISE COMPARISON TABLE
  # =====================================================
  
  output$TableCIComparisons <- renderDT({
    
    req(modelfit())
    
    comparisons <- emmeans(
      modelfit(),
      as.formula(
        paste(
          "pairwise ~",
          input$treatVar
        )
      )
    )
    
    tab <- comparisons$contrasts %>%
      
      confint() %>%
      
      as.data.frame()
    
    # =====================================================
    # ROUND NUMERIC COLUMNS
    # =====================================================
    
    numeric_cols <- sapply(
      tab,
      is.numeric
    )
    
    tab[numeric_cols] <- round(
      tab[numeric_cols],
      4
    )
    
    # =====================================================
    # OPTIONAL CLEAN COLUMN NAMES
    # =====================================================
    
    names(tab) <- gsub(
      "\\.",
      " ",
      names(tab)
    )
    
    DT::datatable(
      
      tab,
      
      rownames = FALSE,
      
      options = list(
        pageLength = 10,
        scrollX = TRUE
      )
    )
  })
  
  

  
  # =====================================================
  # RESIDUAL SD EXTRACTOR
  # =====================================================
  
  residualSD <- reactive({
    
    model <- modelfit()
    
    # =====================================================
    # MIXED MODEL
    # =====================================================
    
    if (modelType() == "mixed") {
      
      return(
        sigma(model)
      )
    }
    
    # =====================================================
    # FIXED ANOVA
    # =====================================================
    
    anova_tab <- summary(model)[[1]]
    
    mse <- anova_tab[
      nrow(anova_tab),
      "Mean Sq"
    ]
    
    sqrt(mse)
  })
    
  # =====================================================
  # STANDARD ERROR FOR TREATMENT COMPARISONS
  # =====================================================
  
  comparisonSE <- reactive({
    
    emm <- emmeans(
      modelfit(),
      as.formula(
        paste(
          "~",
          input$treatVar
        )
      )
    )
    
    pairs_emm <- pairs(emm)
    
    tab <- as.data.frame(
      summary(pairs_emm)
    )
    
    mean(tab$SE, na.rm = TRUE)
  })
  
  
  # =====================================================
  # POWER DESIGN SUMMARY
  # =====================================================
  
  output$PowerDesignSummary <- renderTable({
    
    req(processedData())
    
    data.frame(
      
      Component = c(
        "Observations",
        "Latin squares",
        "Rows",
        "Columns",
        "Treatments"
      ),
      
      Value = c(
        nrow(processedData()),
        
        length(unique(
          processedData()[[input$latinSquareVar]]
        )),
        
        length(unique(
          processedData()[[input$rowVar]]
        )),
        
        length(unique(
          processedData()[[input$colVar]]
        )),
        
        length(unique(
          processedData()[[input$treatVar]]
        ))
      )
    )
  })
  
  # =====================================================
  # POWER VARIANCE COMPONENTS
  # =====================================================
  
  output$PowerVariance <- renderTable({
    
    # =====================================================
    # FIXED MODEL
    # =====================================================
    
    if (modelType() == "fixed") {
      
      anova_tab <- summary(modelfit())[[1]]
      
      mse <- anova_tab[
        nrow(anova_tab),
        "Mean Sq"
      ]
      
      return(
        
        data.frame(
          
          Component = "Residual",
          
          Variance = round(mse, 4)
        )
      )
    }
    
    # =====================================================
    # MIXED MODEL
    # =====================================================
    
    vc <- VarCorr(
      modelfit()
    ) %>%
      as.data.frame()
    
    data.frame(
      Component = vc$grp,
      Variance = round(vc$vcov, 4)
    )
  })
  
  # =====================================================
  # DETECTABLE DIFFERENCE
  # =====================================================
  
  output$DetectableDifference <- renderPrint({
    
    req(modelfit())
    
    se_diff <- comparisonSE()
    
    alpha <- input$alphaPower
    power <- input$targetPower
    
    z_alpha <- qnorm(1 - alpha/2)
    z_beta <- qnorm(power)
    
    detectable_diff <- (
      z_alpha + z_beta
    ) * se_diff
    
    cat("Model type:", modelType(), "\n\n")
    
    cat(
      "Estimated SE for treatment comparisons:",
      round(se_diff, 4),
      "\n\n"
    )
    
    cat(
      "Approximate minimum detectable difference:\n\n"
    )
    
    cat(
      round(detectable_diff, 4)
    )
  })
  
  # =====================================================
  # POWER CURVE
  # =====================================================
  
  output$PowerCurve <- renderPlot({
    
    req(modelfit())
    
    se_diff <- comparisonSE()
    
    alpha <- input$alphaPower
    
    effects <- seq(
      0,
      5 * se_diff,
      length.out = 100
    )
    
    z_values <- effects / se_diff
    
    power_vals <- pnorm(
      z_values - qnorm(1 - alpha/2)
    )
    
    plot(
      effects,
      power_vals,
      type = "l",
      lwd = 3,
      col = "blue",
      ylim = c(0, 1),
      xlab = "Treatment difference",
      ylab = "Power",
      main = "Approximate power curve"
    )
    
    abline(
      h = input$targetPower,
      lty = 2,
      col = "red"
    )
  })
  
  # =====================================================
  # SIMULATION POWER
  # =====================================================
  
  output$SimulationPower <- renderPrint({
    
    input$RunPowerSimulation
    
    isolate({
      
      req(modelfit())
      
      if (!requireNamespace("simr", quietly = TRUE)) {
        
        cat(
          "Package 'simr' is not installed."
        )
        
        return()
      }
      
      library(simr)
      
      model <- modelfit()
      
      pwr <- powerSim(
        model,
        nsim = 50
      )
      
      print(pwr)
    })
  })
  
  
}

# =====================================================
# RUN APP
# =====================================================

shinyApp(ui, server)

