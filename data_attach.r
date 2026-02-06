# data_attach.r

## Source code --------------------------------------
source("packages_attach.r")

## Retrieve Turneffe AGRRA data from Dryad repository --------------------------------------
if (dir.exists("data_deposit") && length(list.files("data_deposit")) > 0) {
    message("Data files already present in data_deposit folder")
} else {
    message("Downloading data from Dryad...")
    downloaded_files <- dryad_download(dois = "10.5061/dryad.c866t1gcn")
    file.copy(unlist(downloaded_files), "data_deposit", overwrite = TRUE)
    message("Files copied to data_deposit/")
}

## Attach data --------------------------------------
na_strings <- c("NA", "", "MISSING", "UNKNOWN")
df_benthic_inverts <- read.csv("data_deposit/Master_Benthic_Inverts_2010-2025.csv", na.strings = na_strings)
df_benthic_pim <- read.csv("data_deposit/Master_Benthic_PIM_2010-2025.csv", na.strings = na_strings)
df_benthic_recruits <- read.csv("data_deposit/Master_Benthic_Recruit_2023-2025.csv", na.strings = na_strings)
df_coral <- read.csv("data_deposit/Master_Coral_Community_2010-2025.csv", na.strings = na_strings)
df_fish <- read.csv("data_deposit/Master_Fish_Survey_2010-2025.csv", na.strings = na_strings)
ref_collectors <- read.csv("data_deposit/Ref_Collectors_Turneffe.csv", na.strings = na_strings)
ref_diseases <- read.csv("data_deposit/Ref_Diseases_Coral.csv", na.strings = na_strings)
ref_fish_sizes <- read.csv("data_deposit/Ref_Fish_Sizes.csv", na.strings = na_strings)
ref_fish_species <- read.csv("data_deposit/Ref_Fish_Species.csv", na.strings = na_strings)
ref_organisms_benthic <- read.csv("data_deposit/Ref_Organisms_Benthic.csv", na.strings = na_strings)
ref_sites <- read.csv("data_deposit/Ref_Sites_Turneffe.csv", na.strings = na_strings)
ref_substrates <- read.csv("data_deposit/Ref_Substrates_Benthic.csv", na.strings = na_strings)
