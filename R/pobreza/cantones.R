# ------------------------------------
# autor: Marco Espinoza
# CEPAL - División de Estadística
# fecha: Mayo 2024
# ------------------------------------


# Limpieza de datos -------------------------------------------------------

rm(list = ls())


# Nueva codificación ------------------------------------------------------

# Debemos codificar los cantones en base a los distritos
san_jose <- c("10101","10102","10103","10104","10105","10106","10107",
              "10108","10109","10110","10111")
escazu <- c("10201","10202","10203")
desamparados <- c("10301","10302","10303","10304","10305","10306","10307",
                  "10308","10309","10310","10311","10312","10313")
puriscal <- c("10401","10402","10403","10404","10405","10406",
              "10407","10408",
              "10409")
tarrazu <- c("10501","10502","10503")
aserri <- c("10601","10602","10603","10604","10605","10606","10607")
mora <- c("10701","10702","10703","10704","10705","10706","10707")
goicoechea <- c("10801","10802","10803","10804","10805","10806","10807")
santa_ana <- c("10901","10902","10903","10904","10905","10906")
alajuelita <- c("11001","11002","11003","11004","11005")
coronado <- c("11101","11102","11103","11104","11105")
acosta <- c("11201","11202","11203","11204","11205")
tibas <- c("11301","11302","11303","11304","11305")
moravia <- c("11401","11402","11403")
montes_de_oca <- c("11501","11502","11503","11504")
turrubares <- c("11601","11602","11603","11604","11605")
dota <- c("11701", "11702", "11703")
curridabat <- c("11801", "11802", "11803", "11804")
perez_zeledon <- c("11901", "11902", "11903", "11904", "11905", "11906", "11907", "11908", "11909", "11910", "11911", "11912")
leon_cortes <- c("12001", "12002", "12003", "12004", "12005", "12006")
alajuela <- c("20101", "20102", "20103", "20104", "20105", "20106", "20107", "20108", "20109", "20110", "20111", "20112", "20113", "20114")
san_ramon <- c("20201", "20202", "20203", "20204", "20205", "20206", "20207", "20208", "20209", "20210", "20211", "20212", "20213", "20214")
grecia <- c("20301", "20302", "20303", "20304", "20305", "20306", "20307", "20308")
san_mateo <- c("20401", "20402", "20403", "20404")
atenas <- c("20501", "20502", "20503", "20504", "20505", "20506", "20507", "20508")
naranjo <- c("20601", "20602", "20603", "20604", "20605", "20606", "20607", "20608")
palmares <- c("20701", "20702", "20703", "20704", "20705", "20706", "20707")
poas <- c("20801", "20802", "20803", "20804", "20805")
orotina <- c("20901", "20902", "20903", "20904", "20905")
san_carlos <- c("21001", "21002", "21003", "21004", "21005", "21006", "21007", "21008", "21009", "21010", "21011", "21012", "21013")
zarcero <- c("21101", "21102", "21103", "21104", "21105", "21106", "21107")
sarchi <- c("21201", "21202", "21203", "21204", "21205")
upala <- c("21301", "21302", "21303", "21304", "21305", "21306", "21307", "21308")
los_chiles <- c("21401", "21402", "21403", "21404")
guatuso <- c("21501", "21502", "21503", "21504")
rio_cuarto <- c("21601", "21602", "21603")
cartago <- c("30101", "30102", "30103", "30104", "30105", "30106", "30107", "30108", "30109", "30110", "30111")
paraiso <- c("30201", "30202", "30203", "30204", "30205", "30206")
la_union <- c("30301", "30302", "30303", "30304", "30305", "30306", "30307", "30308")
jimenez <- c("30401", "30402", "30403", "30404")
turrialba <- c("30501", "30502", "30503", "30504", "30505", "30506", "30507", "30508", "30509", "30510", "30511", "30512")
alvarado <- c("30601", "30602", "30603")
oreamuno <- c("30701", "30702", "30703", "30704", "30705")
el_guarco <- c("30801", "30802", "30803", "30804")
heredia <- c("40101", "40102", "40103", "40104", "40105")
barva <- c("40201", "40202", "40203", "40204", "40205", "40206")
santo_domingo <- c("40301", "40302", "40303", "40304", "40305", "40306", "40307", "40308")
santa_barbara <- c("40401", "40402", "40403", "40404", "40405", "40406")
san_rafael <- c("40501", "40502", "40503", "40504", "40505")
san_isidro <- c("40601", "40602", "40603", "40604")
belen <- c("40701", "40702", "40703")
flores <- c("40801", "40802", "40803")
san_pablo <- c("40901", "40902")
sarapiqui <- c("41001", "41002", "41003", "41004", "41005")
liberia <- c("50101", "50102", "50103", "50104", "50105")
nicoya <- c("50201", "50202", "50203", "50204", "50205", "50206", "50207")
santa_cruz <- c("50301", "50302", "50303", "50304", "50305", "50306", "50307", "50308", "50309")
bagaces <- c("50401", "50402", "50403", "50404")
carrillo <- c("50501", "50502", "50503", "50504")
canas <- c("50601", "50602", "50603", "50604", "50605")
abangares <- c("50701", "50702", "50703", "50704")
tilaran <- c("50801", "50802", "50803", "50804", "50805", "50806", "50807", "50808")
nandayure <- c("50901", "50902", "50903", "50904", "50905", "50906")
la_cruz <- c("51001", "51002", "51003", "51004")
hojancha <- c("51101", "51102", "51103", "51104", "51105")
puntarenas <- c("60101", "60102", "60103", "60104", "60105", "60106", "60107", "60108", "60109", "60110", "60111", "60112", "60113", "60114", "60115", "60116")
esparza <- c("60201", "60202", "60203", "60204", "60205", "60206")
buenos_aires <- c("60301", "60302", "60303", "60304", "60305", "60306", "60307", "60308", "60309")
montes_de_oro <- c("60401", "60402", "60403")
osa <- c("60501", "60502", "60503", "60504", "60505", "60506")
quepos <- c("60601", "60602", "60603")
golfito <- c("60701", "60702", "60703", "60704")
coto_brus <- c("60801", "60802", "60803", "60804", "60805", "60806")
parrita <- "60901"
corredores <- c("61001", "61002", "61003", "61004")
garabito <- c("61101", "61102", "61103")
monteverde <- "60109"
puerto_jimenez <- "60702"
limon <- c("70101", "70102", "70103", "70104")
pococi <- c("70201", "70202", "70203", "70204", "70205", "70206", "70207")
siquirres <- c("70301", "70302", "70303", "70304", "70305", "70306", "70307")
talamanca <- c("70401", "70402", "70403", "70404")
matina <- c("70501", "70502", "70503")
guacimo <- c("70601", "70602", "70603", "70604", "70605")


# Lectura del censo -------------------------------------------------------


# Extraemos el censo y de una vez creamos una columna nueva llamada 
# canton, donde se crean los cantones en base a los distritos

censo_mrp <- censo_mrp <- readRDS("ingreso/datos/cens0.rds") %>%
  filter(anoest != "98") %>% 
  mutate(
    canton = 
      case_when(
        distrito %in% san_jose ~ 'San José',
        distrito %in% escazu ~ 'Escazú',
        distrito %in% desamparados ~ 'Desamparados',
        distrito %in% puriscal ~ 'Puriscal',
        distrito %in% tarrazu ~ 'Tarrazú',
        distrito %in% aserri ~ 'Aserrí',
        distrito %in% mora ~ 'Mora',
        distrito %in% goicoechea ~ 'Goicoechea',
        distrito %in% santa_ana ~ 'Santa Ana',
        distrito %in% alajuelita ~ 'Alajuelita',
        distrito %in% coronado ~ 'Vázquez de Coronado',
        distrito %in% acosta ~ 'Acosta',
        distrito %in% tibas ~ 'Tibás',
        distrito %in% moravia ~ 'Moravia',
        distrito %in% montes_de_oca ~ 'Montes de Oca',
        distrito %in% turrubares ~ 'Turrubares',
        distrito %in% dota ~ 'Dota',
        distrito %in% curridabat ~ 'Curridabat',
        distrito %in% perez_zeledon ~ 'Pérez Zeledón',
        distrito %in% leon_cortes ~ 'León Cortés Castro',
        distrito %in% alajuela ~ 'Alajuela',
        distrito %in% san_ramon ~ 'San Ramón',
        distrito %in% grecia ~ 'Grecia',
        distrito %in% san_mateo ~ 'San Mateo',
        distrito %in% atenas ~ 'Atenas',
        distrito %in% naranjo ~ 'Naranjo',
        distrito %in% palmares ~ 'Palmares',
        distrito %in% poas ~ 'Poás', 
        distrito %in% orotina ~ 'Orotina',
        distrito %in% san_carlos ~ 'San Carlos',
        distrito %in% zarcero ~ 'Zarcero',
        distrito %in% sarchi ~ 'Sarchí',
        distrito %in% upala ~ 'Upala',
        distrito %in% los_chiles ~ 'Los Chiles',
        distrito %in% guatuso ~ 'Guatuso',
        distrito %in% rio_cuarto ~ 'Río Cuarto',
        distrito %in% cartago ~ 'Cartago',
        distrito %in% paraiso ~ 'Paraíso',
        distrito %in% la_union ~ 'La Unión',
        distrito %in% jimenez ~ 'Jiménez',
        distrito %in% turrialba ~ 'Turrialba',
        distrito %in% alvarado ~ 'Alvarado',
        distrito %in% oreamuno ~ 'Oreamuno',
        distrito %in% el_guarco ~ 'El Guarco',
        distrito %in% heredia ~ 'Heredia',
        distrito %in% barva ~ 'Barva',
        distrito %in% santo_domingo ~ 'Santo Domingo',
        distrito %in% santa_barbara ~ 'Santa Bárbara',
        distrito %in% san_rafael ~ 'San Rafael',
        distrito %in% san_isidro ~ 'San Isidro',
        distrito %in% belen ~ 'Belén',
        distrito %in% flores ~ 'Flores',
        distrito %in% san_pablo ~ 'San Pablo',
        distrito %in% sarapiqui ~ 'Sarapiquí',
        distrito %in% liberia ~ 'Liberia',
        distrito %in% nicoya ~ 'Nicoya',
        distrito %in% santa_cruz ~ 'Santa Cruz',
        distrito %in% bagaces ~ 'Bagaces',
        distrito %in% carrillo ~ 'Carrillo',
        distrito %in% canas ~ 'Cañas',
        distrito %in% abangares ~ 'Abangares',
        distrito %in% tilaran ~ 'Tilarán',
        distrito %in% nandayure ~ 'Nandayure',
        distrito %in% la_cruz ~ 'La Cruz',
        distrito %in% hojancha ~ 'Hojancha',
        distrito %in% puntarenas ~ 'Puntarenas',
        distrito %in% esparza ~ 'Esparza',
        distrito %in% buenos_aires ~ 'Buenos Aires',
        distrito %in% montes_de_oro ~ 'Montes de Oro',
        distrito %in% osa ~ 'Osa',
        distrito %in% quepos ~ 'Quepos',
        distrito %in% golfito ~ 'Golfito',
        distrito %in% coto_brus ~ 'Coto Brus',
        distrito %in% parrita ~ 'Parrita',
        distrito %in% corredores ~ 'Corredores',
        distrito %in% garabito ~ 'Garabito',
        distrito %in% monteverde ~ 'Monteverde',
        distrito %in% puerto_jimenez ~ 'Puerto Jiménez',
        distrito %in% limon ~ 'Limón',
        distrito %in% pococi ~ 'Pococí',
        distrito %in% siquirres ~ 'Siquirres',
        distrito %in% talamanca ~ 'Talamanca',
        distrito %in% matina ~ 'Matina',
        distrito %in% guacimo ~ 'Guácimo'
        
      )
  )


# Predicción realizada ----------------------------------------------------

# Cargamos la predicción realizada en el archivo de XGBoost.Rmd
pred <- readRDS("ingreso/output/pred3.rds")
# se lo agregamos al data frame del censo
censo_mrp$pred_ingreso <- pred


# Creamos una base de datos resumen ---------------------------------------

# Creamos una base de datos resumen para el ingreso medio para cada uno 
# de los 81 cantones existentes en el censo 2011. 
ingreso_cantonal <- censo_mrp %>% 
  group_by(canton) %>% 
  summarise(
    ingreso_medio = mean(pred_ingreso)
  )

saveRDS(ingreso_cantonal, "ingreso/output/ingreso_cantonal.rds")

# BASE RESUMEN PARA LAS REGIONES DE PLANIFICACIÓN ECONÓMICA  --------------


# Creamos una columna nueva donde recodificamos el DAM y le llamamos
# código. Esto se hace debido a que para poder realizar el mapa
# se hace un left join con el shapefile, por lo tanto el nombre de la 
#columna en común debe ser igual a la del otro archivo. 
# para evitar recodings, se hace desde acá.
censo_mrp <- censo_mrp <- readRDS("ingreso/datos/cens0.rds") %>%
  filter(anoest != "98") %>% 
  mutate(
  region = recode(dam,
               "01" = "Central",
               "02" = "Chorotega",
               "03" = "Pacífico Central",
               "04" = "Brunca",
               "05" = "Huetar Caribe",
               "06" = "Huetar Norte"))
# volvemos a cargar la predicción y se la agregamos a la base del censo  
pred <- readRDS("ingreso/output/pred3.rds")
censo_mrp$pred_ingreso <- pred

# Creamos una base de datos resumen para las regiones de planificación
ingreso_region <- censo_mrp %>% 
  group_by(region) %>% 
  summarise(
    ingreso_medio = mean(pred_ingreso)
  )


saveRDS(ingreso_region, "ingreso/output/ingreso_region.rds")



# Creamos base para distrito ----------------------------------------------

censo_mrp <- censo_mrp <- readRDS("ingreso/datos/censo_mrp1.rds")
pred <- readRDS("ingreso/output/pred.rds")
censo_mrp$pred_ingreso <- pred

ingreso_distrito <- censo_mrp %>% group_by(distrito) %>% 
  summarise(media_ingreso = mean(pred))

saveRDS(ingreso_distrito, "ingreso/output/ingreso_distrital.rds")

setdiff(distritos$CÓDIGO_DTA,ingreso_distrito$distrito)

censo_mrp %>% filter(distrito == "21308")



