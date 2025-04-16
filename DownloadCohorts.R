################################################################################
# INSTRUCTIONS: This script assumes you have cohorts you would like to use in an
# ATLAS instance. Please note you will need to update the baseUrl to match
# the settings for your enviroment. You will also want to change the 
# CohortGenerator::saveCohortDefinitionSet() function call arguments to identify
# a folder to store your cohorts. This code will store the cohorts in 
# "inst/sampleStudy" as part of the template for reference. You should store
# your settings in the root of the "inst" folder and consider removing the 
# "inst/sampleStudy" resources when you are ready to release your study.
# 
# See the Download cohorts section
# of the UsingThisTemplate.md for more details.
# ##############################################################################

library(dplyr)
baseUrl <- "https://atlas-demo.ohdsi.org/WebAPI"
# Use this if your WebAPI instance has security enables
# ROhdsiWebApi::authorizeWebApi(
#   baseUrl = baseUrl,
#   authMethod = "windows"
# )
cohortDefinitionSet <- ROhdsiWebApi::exportCohortDefinitionSet(
  baseUrl = baseUrl,
  cohortIds = c(
    1792011, # [PP25 FEP2] FEPwRisperidone
    1792119, # [PP25 FEP2] FEPwHaloperidol
    1792125, # [PP25 FEP2] FEPwAripiprazole
    1792127, # [PP25 FEP2] FEPwBrexpiprazole
    1792129, # [PP25 FEP2] FEPwOlanzapine
    1792130, # [PP25 FEP2] FEPwQuetiapine
    1792131, # [PP25 FEP2] FEPwZiprazidone
    1792141, # [PP25 FEP2] FEPwLurasidone
    1792143, # [PP25 FEP2] FEPwPaliperidone
    1792012  # [PP25 FEP2] Rehospitalization
  ),
  generateStats = TRUE
)

# Rename cohorts
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792011,]$cohortName <- "risperidone"
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792119,]$cohortName <- "haloperidol"
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792125,]$cohortName <- "aripiprazole"
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792127,]$cohortName <- "brexpiprazole"
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792129,]$cohortName <- "olanzapine"
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792130,]$cohortName <- "quetiapine"
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792131,]$cohortName <- "ziprazidone"
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792141,]$cohortName <- "lurazidone"
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792143,]$cohortName <- "paliperidone"
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792012,]$cohortName <- "rehospitalization"

# Re-number cohorts
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792011,]$cohortId <- 1
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792119,]$cohortId <- 2
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792125,]$cohortId <- 3
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792127,]$cohortId <- 4
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792129,]$cohortId <- 5
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792130,]$cohortId <- 6
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792131,]$cohortId <- 7
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792141,]$cohortId <- 8
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792143,]$cohortId <- 9
cohortDefinitionSet[cohortDefinitionSet$cohortId == 1792012,]$cohortId <- 10

# Save the cohort definition set
# NOTE: Update settingsFileName, jsonFolder and sqlFolder
# for your study.
CohortGenerator::saveCohortDefinitionSet(
  cohortDefinitionSet = cohortDefinitionSet,
  settingsFileName = "inst/Cohorts.csv",
  jsonFolder = "inst/cohorts",
  sqlFolder = "inst/sql/sql_server",
)

# Download and save the negative control outcomes
# TODO: create a negative controls concept set
#negativeControlOutcomeCohortSet <- ROhdsiWebApi::getConceptSetDefinition(
#  conceptSetId = 1885090,
#  baseUrl = baseUrl
#) %>%
#  ROhdsiWebApi::resolveConceptSet(
#    baseUrl = baseUrl
#  ) %>%
#  ROhdsiWebApi::getConcepts(
#    baseUrl = baseUrl
#  ) %>%
#  rename(outcomeConceptId = "conceptId",
#         cohortName = "conceptName") %>%
#  mutate(cohortId = row_number() + 100) %>%
#  select(cohortId, cohortName, outcomeConceptId)

# NOTE: Update file location for your study.
#CohortGenerator::writeCsv(
#  x = negativeControlOutcomeCohortSet,
#  file = "inst/sampleStudy/negativeControlOutcomes.csv",
#  warnOnFileNameCaseMismatch = F
#)