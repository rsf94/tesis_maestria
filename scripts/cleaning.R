packages <- c(
  "haven", 
  "survey",
  'fastDummies',
  'RColorBrewer',
  'tidyverse',
  'naniar',
  'data.table',
  'ggplot2'
)

installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}
lapply(packages, 
       library, 
       character.only = TRUE)


# Defino filepaths
path_data = "C:/Users/rsf94/Google Drive/MAESTRÍA ITAM/TESIS/data_raw"
pa



# Cargo Encuesta Nacional de Consumo de Drogas, Alcohol y Tabaco; ENCODAT Hogar 2016-2017

encodat_hogar <- read.csv(file.path(path_data, "ENCODAT_Hogar_2016-2017", "ponde_Hogar_ENA_2016_pp.csv"))
encodat_ind <- read.csv(file.path(path_data, "ENCODAT_Hogar_2016-2017", "Ponde_Integrantes_ENA_2016_pp.csv"))

encodat <- read.csv(file.path(path_data, "ENCODAT_Hogar_2016-2017", "ENCODAT 2016_2017.csv"))

View(miss_var_summary(encodat))

# nas

delete_na_variables <- function(x) {
  sum(is.na(x)) < length(x) * 0.6
}

encodat2 <- encodat[, vapply(encodat, delete_na_variables, logical(1)), drop = F]




# Análisis exploratorio
encodat2 <- encodat %>%
          select(al19) %>%
          filter(al19 %in% 1:9)

encodat2$al19 <- as.factor(encodat2$al19)

summary(encodat2$al19)

plot(encodat2$al19)

View(miss_var_summary(encodat2))

