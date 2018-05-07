#regex R
library(stringr)
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