# indicators_calculate.r

## Source code --------------------------------------
source("data_attach.r")
source("functions_define.r")

# Prepare data ---------------------------
ref_organisms_benthic_unique <- ref_organisms_benthic %>%
    filter(!is.na(Organism)) %>%
    distinct(Organism, AGRRA_Bucket)
View(benthic_cover_presence)
benthic_cover_presence <- df_benthic_pim %>%
    left_join(ref_organisms_benthic_unique %>% select(Organism, Organism_Bucket = AGRRA_Bucket), by = "Organism") %>%
    left_join(ref_organisms_benthic_unique %>% select(Organism, Secondary_Bucket = AGRRA_Bucket), by = c("Secondary" = "Organism")) %>%
    mutate(
        Coral_Presence = Vectorize(calculate_type_presence)(Organism_Bucket, Secondary_Bucket, "Coral"),
        Algae_Presence = Vectorize(calculate_type_presence)(Organism_Bucket, Secondary_Bucket, "Algae_Macro_Fleshy"),
        Year = format(as.Date(Date), format = "%Y")
    )

# Calculate live coral cover ---------------------------
benthic_cover_presence_lcc <- benthic_cover_presence %>%
    group_by(Year, Site, Transect) %>%
    mutate(Coral_Cover_Tran = 100 * sum(Coral_Presence) / n()) %>%
    group_by(Year, Site) %>%
    mutate(Coral_Cover_Site = mean(Coral_Cover_Tran))
indicator_lcc <- benthic_cover_presence_lcc %>%
    group_by(Year) %>%
    summarize(
        `Min (Site)` = min(Coral_Cover_Site),
        `Av. (Site)` = mean(Coral_Cover_Site),
        `Median (Site)` = median(Coral_Cover_Site),
        `Max (Site)` = max(Coral_Cover_Site),
        `Min (Transect)` = min(Coral_Cover_Tran),
        `Av. (Transect)` = mean(Coral_Cover_Tran),
        `Median (Transect)` = median(Coral_Cover_Tran),
        `Max (Transect)` = max(Coral_Cover_Tran)
    ) %>%
    mutate(across(-Year, ~ round(.x, 2)))
indicator_lcc_sites <- benthic_cover_presence_lcc %>%
    group_by(Year, Site) %>%
    summarize(
        `Min (Transect)` = min(Coral_Cover_Tran),
        `Av. (Transect)` = mean(Coral_Cover_Tran),
        `Median (Transect)` = median(Coral_Cover_Tran),
        `Max (Transect)` = max(Coral_Cover_Tran)
    )

# Calculate macroalgae cover ---------------------------
benthic_cover_presence_fma <- benthic_cover_presence %>%
    group_by(Year, Site, Transect) %>%
    mutate(Algae_Cover_Tran = 100 * sum(Algae_Presence) / n()) %>%
    group_by(Year, Site) %>%
    mutate(Algae_Cover_Site = mean(Algae_Cover_Tran))
indicator_fma <- benthic_cover_presence_fma %>%
    group_by(Year) %>%
    summarize(
        `Min (Site)` = min(Algae_Cover_Site),
        `Av. (Site)` = mean(Algae_Cover_Site),
        `Median (Site)` = median(Algae_Cover_Site),
        `Max (Site)` = max(Algae_Cover_Site),
        `Min (Transect)` = min(Algae_Cover_Tran),
        `Av. (Transect)` = mean(Algae_Cover_Tran),
        `Median (Transect)` = median(Algae_Cover_Tran),
        `Max (Transect)` = max(Algae_Cover_Tran)
    ) %>%
    mutate(across(-Year, ~ round(.x, 2)))
indicator_fma_sites <- benthic_cover_presence_fma %>%
    group_by(Year, Site) %>%
    summarize(
        `Min (Transect)` = min(Algae_Cover_Tran),
        `Av. (Transect)` = mean(Algae_Cover_Tran),
        `Median (Transect)` = median(Algae_Cover_Tran),
        `Max (Transect)` = max(Algae_Cover_Tran)
    )
