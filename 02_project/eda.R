library(tidyverse)
library(plotly)


# read in data
df <- readr::read_csv("./data/citibike-tripdata.csv")


# create a summary table
summary <- df %>%
  group_by(start_station_name) %>%
  summarise(
    total_rides = n(),
    avg_duration = as.integer(mean(tripduration)),
    avg_age = as.integer(mean(age))
  ) %>%
  arrange(-total_rides) %>%
  head(10)


# create a bar plot
ggplot(summary, aes(x= start_station_name, y = total_rides, 
                    fill = ifelse(total_rides > mean(total_rides), T, F)
                      )) + 
  geom_bar(stat="identity", show.legend=F) + 
  ggtitle("Total Rides by Station") + 
  theme(plot.title = element_text(hjust = 0.5)) + scale_fill_manual(values = c('#828282', '#2785bc'))
 # scale_x_discrete(labels=function(x){gsub(" ", "\n", summary$start_station_name)})

# create a scatter plot the ggplot way
ggplot(df, aes(x= age, y = distance)) + geom_point()

# create scatter plot with plotly
plot_ly(data = df,x=~age, y=~distance,
        type = "scatter",
        mode = "markers", 
        text= ~paste("Age:", age, "Distance:", round(distance, 2))
        )
