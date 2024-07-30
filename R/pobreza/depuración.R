rm(list = ls())

discapacidad  <- read_dta("pobreza/datos/cri21n1.dta",  encoding = "UTF-8") %>% 
  transmute(  discapacidad_ee = case_when(a8a %in% c(0, 9) |
                                            a8b %in% c(0, 9) ~ "0", TRUE ~ "1"))

encuesta <- read_dta("pobreza/datos/CRI_2021N1.dta", encoding = "UTF-8")
statelevel_predictors_df <- readRDS("pobreza/datos/statelevel_predictors_df.rds")

encuesta$discapacidad_ee <- discapacidad$discapacidad_ee


# pruebas de tazas --------------------------------------------------------

encuesta |>
  group_by(dam_ee) |>
  summarise(
    precario = sum(nbi_piso_ee),
    total = length(nbi_piso_ee),
    propPrecario = precario/total
  )

encuesta |>
  group_by(dam_ee) |>
  summarise(
    agua = sum(nbi_agua_ee),
    total = length(nbi_agua_ee),
    propAgua = agua/total
  )

encuesta |>
  filter(!condact3 %in% c("-1","3")) |>
  mutate(condact = 
           recode(as.factor(condact3), 
                  "1" = "0",
                  "2" = "1")) |>
  group_by(dam_ee) |>
  summarise(
    desocupacion = sum(as.numeric(as.character(condact))),
    total = length(as.numeric(condact)),
    tasaDes = desocupacion/total
  )

encuesta |>
  group_by(dam_ee) |>
  summarise(
    elect = sum(nbi_elect_ee),
    total = length(nbi_elect_ee),
    propElect = elect/total
  )

# Código Andrés -----------------------------------------------------------
encuesta1 <- encuesta %>% 
  filter(!condact3 %in% c("-1","3")) %>% 
  transmute(
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
  # edad = edad,
  edad = case_when(edad < 15 ~ "1",
                   edad < 30 ~ "2",
                   edad < 45 ~ "3",
                   edad < 65 ~ "4",
                   TRUE ~ "5"),
  pobreza = ifelse(ingreso <= lp, 1, 0),
  discapacidad = discapacidad_ee,
  fep = `_fep`
) |>
  filter(anoest != "98")


byAgrega <-
  grep(
    pattern =  "^(n|ingreso|lp|li|fep)",
    x = names(encuesta1),
    invert = TRUE,
    value = TRUE
  )

encuesta_mrp <-
  encuesta1 %>%
  group_by_at(all_of(byAgrega)) %>%
  summarise(n = n(),
            ingreso = mean(ingreso),
            .groups = "drop") 


encuesta1 <- full_join(encuesta1, statelevel_predictors_df,
                          by = "dam")






