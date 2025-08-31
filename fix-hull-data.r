# @catmoez: For local authority lists and election results (currently covering England and Wales local elections from
# 2021 to May 2025), see my Github folder UK Local Authority Districts

library(readr)
library(dplyr)
library(tidyr)

election_results <- read_csv("uk_local_auths_list_20212025.csv")

lvls <- sort(unique(c(election_results$TopParty, election_results$NextParty)))

# using names from OGP
election_results <- election_results %>%
    mutate(
        District = case_when(
            District == "Stratford-upon-Avon" ~ "Stratford-on-Avon",
            District == "Herefordshire" ~ "Herefordshire, County of",
            TRUE ~ District
        )
    )

# https://en.wikipedia.org/wiki/Hull_City_Council_elections
election_results_2 <- tibble::tibble(
    ElecYear = 2024:2021,
    District = rep("Kingston upon Hull, City of", 4),
    County = District,
    Area = "England",
    TopParty = c(rep("Liberal Democrats", 3), "Labour"),
    TopPartyPct = c(31 / (31+26), 32 / (32+25), 29 / (29+27), 30 / (26+30 + 1)),
    NextParty = c(rep("Labour", 3), "Liberal Democrat"),
    NextPartyPct = c(26 / (31+26), 25 / (32+25), 27 / (29+27), 26 / (26+30 + 1)),
    Notes = NA
)

election_results <- bind_rows(election_results, election_results_2)

write_csv(election_results, "uk_local_auths_list_20212025_fix.csv", na = "")
