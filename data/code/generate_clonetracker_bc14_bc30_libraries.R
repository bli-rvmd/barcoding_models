## generate clonetracker barcode bc14 and bc30 libraries from json file downloaded from cellecta website

library(rjson)
tmp <- fromJSON(file = "../data/Cellecta-CONFIG-CloneTracker-XP-50M-Barcode-Library-LNGS-300.json")
bc14_lib <- do.call(rbind, lapply(2:length(tmp$TARGETS[[1]]$records), function(idx) data.frame(name = tmp$TARGETS[[1]]$records[[idx]][[1]], barcode = tmp$TARGETS[[1]]$records[[idx]][[2]])))
bc30_lib <- do.call(rbind, lapply(2:length(tmp$TARGETS[[2]]$records), function(idx) data.frame(name = tmp$TARGETS[[2]]$records[[idx]][[1]], barcode = tmp$TARGETS[[2]]$records[[idx]][[2]])))
write.csv(bc14_lib, "../data/barcode_library_bc14.csv", row.names = FALSE)
write.csv(bc30_lib, "../data/barcode_library_bc30.csv", row.names = FALSE)


## validate barcode libraries sent from WuXi

library(openxlsx)
library(dplyr)

# bc14
bc14_lib_wx <- as.data.frame(read.xlsx("../data/Cellecta-SEQ-CloneTracker-XP-5M-50M-Barcode-Libraries-480_x_BC14.xlsx", startRow = 11))[, 2:3]
colnames(bc14_lib_wx) <- c("name", "barcode")
all(bc14_lib_wx$barcode %in% bc14_lib$barcode)
# [1] TRUE
all(bc14_lib$barcode == bc14_lib_wx$barcode)
# [1] TRUE

# bc30
bc30_lib_wx <- as.data.frame(read.xlsx("../data/Cellecta-SEQ-CloneTracker-XP-5M-50M-Barcode-Libraries-100K_x_BC30.xlsx", startRow = 12))[, 2:3]
colnames(bc30_lib_wx) <- c("name", "barcode")
all(bc30_lib_wx$barcode %in% bc30_lib$barcode)
# [1] TRUE
all(bc30_lib$barcode == bc30_lib_wx$barcode)
# [1] TRUE
