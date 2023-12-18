# ---
#
# clear the environment and import dependencies
#
# ---

rm(list = ls())
library(devtools)

# ---
# 
# remove functions
#
# ---

pkgName = "theon"

removeTheon <- function() {
  required <- requireNamespace(pkgName, quietly = TRUE)
  print(paste(pkgName, required, sep = ": "))
  if (required) {
    remove.packages(pkgName)
  }
}

forceRemoveTheon <- function() {
  tryCatch({
    devtools::unload(pkgName)
  }, error = function(e) {
    writeLines(paste0("COULD NOT UNLOAD PACKAGE: ", pkgName))
  })
  tryCatch({
    removeTheon()
  }, error = function(e) {
    writeLines(paste0("COULD NOT REMOVE PACKAGE: ", pkgName))
  })
}

# ---
#
# run this to remove the theon package
#
# ---

forceRemoveTheon()

# ---
#
# this should give an error
#
# ---

tryCatch({
    library(theon)
    stop("Library did not unload as expected.")
  }, error = function(e) {
    writeLines("Library did not load (this is expected).")
  }
)

# ---
#
# this should load theon
#
# ---

library(remotes)
remotes::install_github("greshje/theon", ref="main", upgrade = TRUE, INSTALL_opts = "--no-multiarch")

# ---
#
# this should now work
# 
# ---

library(theon)

ls("package:theon")

theon::hello()
theon::thankyou()

libUtil <- theon::getNewOhdsiLibUtil()
libUtil$test()



