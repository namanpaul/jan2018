#regex R
library(stringr)
library(dplyr)
#for string manipulation

#reading unstructured txt files
read_text <- readLines("for_regex.txt",
                       skipNul = TRUE)

#using grep to recognize beginning with the letter 'g' assuming we're interested only in those ones
lines_of_interest<- as.character(grep("^[g]", read_text, value = T))

#reading this data as a df
df <- read.table(textConnection(lines_of_interest),
                 stringsAsFactors = FALSE)

#renaming the vars of the df
df <- df %>% 
  rename(varname = V1,
         x = V2,
         y = V3,
         z = V4)

df

#this df can now be written to a csv and operated upon as required
write.csv(df, "processed_unstructured_txt_file.csv",
          row.names = FALSE)







##FOR multiple txt files: in process

#reading multiple files from a directory
library(readr)

#list_file contains the lines read out of the txt files
list_file_1 <- list.files(pattern = "*.txt") %>%
  lapply(readLines)

x <- bind_rows(list_file, .id = "vars")




file_list <- list.files(pattern="*.txt")                              

# read in each .txt file in file_list and rbind them into a data frame called data 
data <- do.call("rbind", lapply(file_list, 
                 function(x) 
                   read.table(paste(x, sep=''), 
                              header = TRUE, 
                              stringsAsFactors = FALSE)))

clean_data <- data %>%
  filter(str_detect(some, "^[g]"))

#vars can be renamed and written to a csv for further processing
df_clean <- clean_data %>% 
  rename(varname = some,
         x = warning,
         y = message,
         z = lines)

df_clean

#this df can now be written to a csv and operated upon as required
write.csv(df_clean, "multiple_txt_files_written_into_single.csv",
          row.names = FALSE)
