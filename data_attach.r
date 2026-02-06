# data_attach.r

## Load packages --------------------------------------
library(rdryad)
library(tidyverse)

## Retrieve Turneffe AGRRA data from Dryad repository --------------------------------------
if (dir.exists("data_deposit") && length(list.files("data_deposit")) > 0) {
    message("Data files already present in data_deposit folder")
} else {
    message("Downloading data from Dryad...")
    downloaded_files <- dryad_download(dois = "10.5061/dryad.c866t1gcn")
    file.copy(unlist(downloaded_files), "data_deposit", overwrite = TRUE)
    message("Files copied to data_deposit/")
}
