
#############################
## Limpiar ambiente
#############################
rm(list = ls())

#############################
## Librerias
#############################

x <- c('rpart','rattle','DT','adabag','randomForest','haven','tidyverse')
lapply(x, require, character.only = TRUE)

#############################
## Datos
#############################

encuesta_mrp18 <- read_dta("V:/DAT/BADEHOG/BADEHOG_EXT/CRI_2018N1.dta",
                           encoding = "LATIN1")

encuesta_mrp19 <- read_dta("V:/DAT/BADEHOG/BADEHOG_EXT/CRI_2019N1.dta",
                           encoding = "LATIN1")
encuesta_mrp22 <- read_dta("V:/DAT/BADEHOG/BADEHOG_EXT/CRI_2022N1.dta",
                           encoding = "LATIN1")

#############################
## Limpieza 2018
#############################
encuesta_mrp18 <- encuesta_mrp18 %>% transmute(
  dam = str_pad(
    string = dam_ee,
    width = 2,
    pad = "0"
  ),
  area = case_when(area_ee == 1 ~ "1", TRUE ~ "0"),
  ingreso = ingcorte,
  lp,
  li,
  sexo = as_factor(sexo, levels = "values"),
  
  anoest = case_when(
    is.na(anoest) | edad < 7  ~ "98"   ,     #No aplica
    anoest == 99 ~ "99",    #NS/NR
    anoest == 0  ~ "1",     # Sin educacion
    anoest %in% c(1:6) ~ "2",     # 1 - 6
    anoest %in% c(7:12) ~ "3",     # 7 - 12
    anoest > 12 ~ "4",     # mas de 12
    TRUE ~ "Error"
  ),
  
  edad = case_when(edad < 15 ~ "1",
                   edad < 30 ~ "2",
                   edad < 45 ~ "3",
                   edad < 65 ~ "4",
                   TRUE ~ "5"),
  
  # discapacidad = discapacidad_ee,
  fep = `_fep`
) %>% 
  mutate(pobreza = ifelse(ingreso <= lp, 1, 0))



#############################
## Limpieza 2019
#############################

encuesta_mrp19 <- encuesta_mrp19 %>% transmute(
  dam = str_pad(
    string = dam_ee,
    width = 2,
    pad = "0"
  ),
  area = case_when(area_ee == 1 ~ "1", TRUE ~ "0"),
  ingreso = ingcorte,
  lp,
  li,
  sexo = as_factor(sexo, levels = "values"),
  
  anoest = case_when(
    is.na(anoest) | edad < 7  ~ "98"   ,     #No aplica
    anoest == 99 ~ "99",    #NS/NR
    anoest == 0  ~ "1",     # Sin educacion
    anoest %in% c(1:6) ~ "2",     # 1 - 6
    anoest %in% c(7:12) ~ "3",     # 7 - 12
    anoest > 12 ~ "4",     # mas de 12
    TRUE ~ "Error"
  ),
  
  edad = case_when(edad < 15 ~ "1",
                   edad < 30 ~ "2",
                   edad < 45 ~ "3",
                   edad < 65 ~ "4",
                   TRUE ~ "5"),
  
  # discapacidad = discapacidad_ee,
  fep = `_fep`
) %>% 
  mutate(pobreza = ifelse(ingreso <= lp, 1, 0))


#############################
## Limpieza 2022
#############################

encuesta_mrp22 <- encuesta_mrp22 %>% transmute(
  dam = str_pad(
    string = dam_ee,
    width = 2,
    pad = "0"
  ),
  area = case_when(area_ee == 1 ~ "1", TRUE ~ "0"),
  ingreso = ingcorte,
  lp,
  li,
  sexo = as_factor(sexo, levels = "values"),
  
  anoest = case_when(
    is.na(anoest) | edad < 7  ~ "98"   ,     #No aplica
    anoest == 99 ~ "99",    #NS/NR
    anoest == 0  ~ "1",     # Sin educacion
    anoest %in% c(1:6) ~ "2",     # 1 - 6
    anoest %in% c(7:12) ~ "3",     # 7 - 12
    anoest > 12 ~ "4",     # mas de 12
    TRUE ~ "Error"
  ),
  
  edad = case_when(edad < 15 ~ "1",
                   edad < 30 ~ "2",
                   edad < 45 ~ "3",
                   edad < 65 ~ "4",
                   TRUE ~ "5"),
  
  # discapacidad = discapacidad_ee,
  fep = `_fep`
) %>% 
  mutate(pobreza = ifelse(ingreso <= lp, 1, 0))
saveRDS(encuesta_mrp18, file = "pobreza/datos/encuesta_mrp18.rds")
saveRDS(encuesta_mrp19, file = "pobreza/datos/encuesta_mrp19.rds")
saveRDS(encuesta_mrp22, file = "pobreza/datos/encuesta_mrp22.rds")
