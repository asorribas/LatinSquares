library(shiny)
library(shinydashboard)
library(tidyverse)
library(readxl)
library(DT)
library(collapsibleTree)
library(lme4)
library(lmerTest)
library(emmeans)
library(stringr)
library(simr)
library(multcomp)
library(multcompView)


theme_set(
  theme_linedraw() +
    theme(
      legend.text = element_text(size = 14),
      legend.title = element_text(size = 22),
      axis.text.x = element_text(size = 18),
      axis.text.y = element_text(size = 14),
      axis.title.x = element_text(size = 18),
      axis.title.y = element_text(size = 18, angle=90),
      strip.text = element_text(size = 18),
      plot.title = element_text(size = 18,margin = margin(b = 20))
    )
)