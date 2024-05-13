
# Librerias ---------------------------------------------------------------

x <- c('tidyverse','sf','httr2','ows4R','rmapshaper','janitor')
lapply(x, require, character.only = TRUE)


# conexión ----------------------------------------------------------------

# Link dado por el SNIT de Costa Rica 
url_wfs <- "https://geos.snitcr.go.cr/be/IGN_5_CO/wfs?"

# Aquí se crea la conexión
bwk_client <- WFSClient$new(
  url = url_wfs,
  serviceVersion = "2.0.0"
)

as_tibble(bwk_client$getFeatureTypes(pretty = TRUE))

# En esta parte del código se hace el GET request de la información
# En este caso nos interesa extraer la provincia y el cantón.
url <- url_parse(url_wfs)
url$query <- list(
  service = "wfs",
  request = "GetFeature",
  typename = "IGN_5_CO:limitecantonal_5k",
  srsName = "EPSG:4326"
)
request <- url_build(url)


# extración ---------------------------------------------------------------

regiones <- read_sf(request) |>
  select("CÓDIGO_CANTÓN", "PROVINCIA", "CANTÓN")
st_crs(regiones) <- st_crs(4326)

regiones_simplificadas <- ms_simplify(
  input = regiones,
  keep = 0.05,
  keep_shapes = FALSE
)


# simplificación de regiones ----------------------------------------------

# eliminar la isla del coco

# El siguiente código lo que produce es la simplificación de la regiones 
# y el mapa. Esto quiere decir que se reduce las dimensiones para poder 
# apreciar de mejor manera el mapa. Además de esto, también se reduce su 
# tamaño computacionalmente. Aquí estamos quitando la Isla del Coco. 


regiones_simplificadas <- ms_filter_islands(
  input = regiones_simplificadas,
  min_area = 24000000
)


# archivo para todos los cantones -----------------------------------------

write_sf(
  obj = regiones_simplificadas, dsn = "ingreso/output/cantones_cr.geojson")



# recodificación para el primer mapa --------------------------------------

cantones <- st_read("ingreso/output/cantones_cr.geojson", quiet = TRUE)
cantones <- janitor::clean_names(cantones)



cantones <- cantones |> 
  mutate(
    canton = case_match(
      canton,
      "Puerto Jiménez" ~ "Golfito",
      "Monteverde" ~ "Puntarenas",
      "Río Cuarto" ~ "Grecia",
      .default = canton
    ),
    codigo_canton = case_match(
      canton,
      "613" ~ "607",
      "612" ~ "601",
      "216" ~ "203",
      .default = canton
    )
  )

cantones <- cantones |> 
  summarise(
    geometry = st_union(geometry),
    .by = c(codigo_canton,provincia, canton)
  )


# Creación del archivo cantones ajustados ---------------------------------

write_sf(obj = cantones, 
         dsn = "ingreso/output/cantones_ajustado_cr.geojson")


# Regiones de planificación -----------------------------------------------

# para este caso debemos hacer un request distinto

url$query <- list(
  service = "wfs",
  request = "GetFeature",
  typename = "IGN_5_CO:limitedistrital_5k",
  srsName = "EPSG:4326"
)
request <- url_build(url)


# extracción --------------------------------------------------------------

regiones <- read_sf(request) |>
  select("CÓDIGO_DTA", "PROVINCIA", "CANTÓN", "DISTRITO", "REGIÓN")
st_crs(regiones) <- st_crs(4326)


# simplificación de regiones ----------------------------------------------

regiones_simplificadas <- ms_simplify(input = regiones,
                                      keep = 0.05,
                                      keep_shapes = FALSE)

# eliminar la isla del coco
regiones_simplificadas <- ms_filter_islands(input = regiones_simplificadas, min_area = 24000000)


# Creación del archivo distrital ------------------------------------------

write_sf(obj = regiones_simplificadas,
         dsn = "ingreso/output/distritos_cr.geojson")


# Unión MIDEPLAN ----------------------------------------------------------

distritos <- st_read("ingreso/output/distritos_cr.geojson", quiet = TRUE)

distritos <- janitor::clean_names(distritos)

res <- distritos |>
  summarise(geometry = st_union(geometry), .by = region)


# Creación archivo --------------------------------------------------------

write_sf(obj = res, dsn = "ingreso/output/regiones_cr.geojson")


# Distritos pre censo 2011 ------------------------------------------------

distritos <- st_read("ingreso/output/distritos_cr.geojson", quiet = TRUE)
distritos <- janitor::clean_names(distritos)


distritos <- distritos |> 
  mutate(
    distrito = case_match(
      distrito,
      "Canalete" ~ "Upala",
      "Matambú" ~ "La Cruz",
      "Gutiérrez Braun" ~ "Buenos Aires",
      .default = canton
    ),
    codigo_canton = case_match(
      canton,
      "613" ~ "607",
      "612" ~ "601",
      "216" ~ "203",
      .default = canton
    )
  )


distritos %>% filter(distrito %in% c("Canalete","Matambú"))

cantones <- cantones |> 
  summarise(
    geometry = st_union(geometry),
    .by = c(codigo_canton,provincia, canton)
  )








