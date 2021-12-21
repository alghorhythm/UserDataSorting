
{  
  library(dplyr)
  library(tidyr)
  library(tidyverse)
  library(data.table)
 
  
  # Prompt user for filename
pendo.file <- readline(prompt = "Pendo file name here: ")
  
  # Read file
  pendo_data <- read.csv(pendo.file)
  
  # Rename Column names
  colnames(pendo_data)[2] <- "firstName"
  colnames(pendo_data)[6] <- "Time.on.Site.minutes"
  colnames(pendo_data)[9] <- "Create.Initiative"
  colnames(pendo_data)[10] <- "Launch.Initiative"
  colnames(pendo_data)[11] <- "Open.Initiative"
  colnames(pendo_data)[12] <- "Run.Allocation"
  colnames(pendo_data)[13] <- "Open.Allocation"
  colnames(pendo_data)[14] <- "Submit.to.Mediaocean"
  colnames(pendo_data)[15] <- "Start.Audience"
  colnames(pendo_data)[16] <- "Create.Audience"
  colnames(pendo_data)[17] <- "Open.Audience"
  colnames(pendo_data)[18] <- "Start.Viewership"
  colnames(pendo_data)[19] <- "Create.Segment"
  colnames(pendo_data)[20] <- "Open.Segment"
  colnames(pendo_data)[21] <- "Start.Plan"
  colnames(pendo_data)[22] <- "Run.Plan"
  colnames(pendo_data)[23] <- "Run.Linear.Buy"
  colnames(pendo_data)[24] <- "Run.Aggregate.Buy"
  colnames(pendo_data)[25] <- "Open.Plan"
  colnames(pendo_data)[26] <- "Open.Plan.2"
  colnames(pendo_data)[27] <- "TIME.Measure"
  colnames(pendo_data)[28] <- "DAYS.Measure"
  colnames(pendo_data)[29] <- "TIME.Plan"
  colnames(pendo_data)[30] <- "DAYS.plan"
  colnames(pendo_data)[31] <- "TIME.Audiences"
  colnames(pendo_data)[32] <- "DAYS.Audiences"
  colnames(pendo_data)[33] <- "TIME.Allocation"
  colnames(pendo_data)[34] <- "DAYS.Allocation"
  
  new_col_pendo <- pendo_data %>%
    mutate(
      #Abandoned Initiatives Column Creation LOGIC
      Abandoned.InitFAKE = Create.Initiative - Launch.Initiative,
      #ExploredPlans
      Explored.Plans = Open.Plan + Open.Plan.2,
      #AVG time on plat
      Average.Time.On.Platform = mean(Time.on.Site.minutes),
      #AVG days active
      Average.Days.Active = mean(Days.Active),
      #Sum, total initiatives created
      Total.Initiatives.Created = sum(Create.Initiative),
      #Sum, total initiatives Launched
      Total.Initiatives.Launched = sum(Launch.Initiative),
      #Sum, open initiative
      Total.Initiatives.Explored = sum(Open.Initiative),
      #Sum, Allocations Run
      Total.Allocations.Run = sum(Run.Allocation),
      #Sum, Allocations Explored
      Total.Allocations.Explored = sum(Open.Allocation),
      #Sum, Total MediaOcean allocations
      Total.Allocations.SubmittedTo.Mediaocean = sum(Submit.to.Mediaocean),
      #Sum, Total Audiences started
      Total.Audiences.Started = sum(Start.Audience),
      #Audience Created
      Total.Audiences.Created = sum(Create.Audience),
      #Audiences Explored
      Total.Audiences.Explored = sum(Open.Audience),
      #Segments started
      Total.Segments.Started = sum(Start.Viewership),
      #Segments Created
      Total.Segments.Created = sum(Create.Segment),
      #Segments explored
      Total.Segments.Explored = sum(Open.Segment),
      #Plans started
      Total.Plans.Started = sum(Start.Plan),
      #Plans run
      Total.Plans.Run = sum(Run.Plan),
      #Linear buys run
      Total.Linear.Buys.Run = sum(Run.Linear.Buy),
      #Aggregate Buys run
      Total.Aggregate.buys.Run = sum(Run.Aggregate.Buy),

    )
  
  new_col_pendo <- new_col_pendo %>%
    mutate(
      
      #Tot. Explored Plans
      Total.Explored.Plans = sum(Explored.Plans)
      
    )
  
  #Create real abandoned initiatives column since negatives must be zero
  Abandoned.Initiatives <- new_col_pendo %>%
    select(Abandoned.InitFAKE)
  
  #Conditional making all negatives zero 
  Abandoned.Initiatives[Abandoned.Initiatives < 0] <- 0
  
  #Bind new abandoned initiatives column to OG DF
  new_col_pendo <- cbind(new_col_pendo, Abandoned.Initiatives)
  
  #Delete INITFAKE
  new_col_pendo <- select(new_col_pendo, -35)
  
  #Rename INITfake
  new_col_pendo <- rename(new_col_pendo, Abandoned.Initiatives = Abandoned.InitFAKE)
  
  new_col_pendo <- new_col_pendo %>%
    mutate(
      
      Total.Abandoned.Initiatives = sum(Abandoned.Initiatives)
      
    )
  

  #RELOCATE EVERYTHING
  new_col_pendo <- relocate(new_col_pendo, "Abandoned.Initiatives", .after = Launch.Initiative)
  new_col_pendo <- relocate(new_col_pendo, "Explored.Plans", .after = Open.Plan.2)
  new_col_pendo <- relocate(new_col_pendo, "Average.Time.On.Platform", .after = Time.on.Site.minutes)
  new_col_pendo <- relocate(new_col_pendo, "Average.Days.Active", .after = Days.Active)
  new_col_pendo <- relocate(new_col_pendo, "Total.Initiatives.Created", .after = Create.Initiative)
  new_col_pendo <- relocate(new_col_pendo, "Total.Initiatives.Launched", .after = Launch.Initiative)
  new_col_pendo <- relocate(new_col_pendo, "Total.Abandoned.Initiatives", .after = Abandoned.Initiatives)
  new_col_pendo <- relocate(new_col_pendo, "Total.Initiatives.Explored", .after = Open.Initiative)
  new_col_pendo <- relocate(new_col_pendo, "Total.Allocations.Run", .after = Run.Allocation)
  new_col_pendo <- relocate(new_col_pendo, "Total.Allocations.Explored", .after = Open.Allocation)
  new_col_pendo <- relocate(new_col_pendo, "Total.Allocations.SubmittedTo.Mediaocean", .after = Submit.to.Mediaocean)
  new_col_pendo <- relocate(new_col_pendo, "Total.Audiences.Started", .after = Start.Audience)
  new_col_pendo <- relocate(new_col_pendo, "Total.Audiences.Created", .after = Create.Audience)
  new_col_pendo <- relocate(new_col_pendo, "Total.Audiences.Explored", .after = Open.Audience)
  new_col_pendo <- relocate(new_col_pendo, "Total.Segments.Started", .after = Start.Viewership)
  new_col_pendo <- relocate(new_col_pendo, "Total.Segments.Created", .after = Create.Segment)
  new_col_pendo <- relocate(new_col_pendo, "Total.Segments.Explored", .after = Open.Segment)
  new_col_pendo <- relocate(new_col_pendo, "Total.Plans.Started", .after = Start.Plan)
  new_col_pendo <- relocate(new_col_pendo, "Total.Plans.Run", .after = Run.Plan)
  new_col_pendo <- relocate(new_col_pendo, "Total.Linear.Buys.Run", .after = Run.Linear.Buy)
  new_col_pendo <- relocate(new_col_pendo, "Total.Aggregate.buys.Run", .after = Run.Aggregate.Buy)
  new_col_pendo <- relocate(new_col_pendo, "Total.Explored.Plans", .after = Explored.Plans)
  
  
  
  aband_grtr_zero <- new_col_pendo %>%
    filter(Abandoned.Initiatives > 0)
  
  aban_avg_list <- aband_grtr_zero %>%
    select(Abandoned.Initiatives)
  
  
  aban_avg_list <- aban_avg_list %>%
    mutate(
      
      Average.Abandoned.Initiatives = mean(Abandoned.Initiatives)
      
    )
   
  
  aban_avg_list <- select(aban_avg_list, -1)
  aban_avg_list <- aban_avg_list[1, ]
  
  
  new_col_pendo <- new_col_pendo %>%
    mutate(
      
      Average.Abandoned.Initiatives = aban_avg_list
    )
  
  new_col_pendo <- relocate(new_col_pendo, "Average.Abandoned.Initiatives", .after = Total.Abandoned.Initiatives)
  
  
  #############################################################
  
  
  avg_time_meas <- new_col_pendo %>%
    filter(TIME.Measure > 0)
  
  avg_time_list <- avg_time_meas %>%
    select(TIME.Measure)
  
  
  avg_time_list <- avg_time_list %>%
    mutate(
      
      Average.Time.On.Measure = mean(TIME.Measure)
      
    )
  
  
  avg_time_list <- select(avg_time_list, -1)
  avg_time_list <- avg_time_list[1, ]
  
  
  new_col_pendo <- new_col_pendo %>%
    mutate(
      
      Average.Time.On.Measure = avg_time_list
    )
  
  new_col_pendo <- relocate(new_col_pendo, "Average.Time.On.Measure", .after = TIME.Measure)
  
  #################################################################################################
  
  avg_days_meas <- new_col_pendo %>%
    filter(DAYS.Measure > 0)
  
  avg_days_list <- avg_days_meas %>%
    select(DAYS.Measure)
  
  
  avg_days_list <- avg_days_list %>%
    mutate(
      
      Average.Days.On.Measure = mean(DAYS.Measure)
      
    )
  
  
  avg_days_list <- select(avg_days_list, -1)
  avg_days_list <- avg_days_list[1, ]
  
  
  new_col_pendo <- new_col_pendo %>%
    mutate(
      
      Average.Days.On.Measure = avg_days_list
    )
  
  new_col_pendo <- relocate(new_col_pendo, "Average.Days.On.Measure", .after = DAYS.Measure)
  
  
  ############################################################################################
  
  avg_time_plan <- new_col_pendo %>%
    filter(TIME.Plan > 0)
  
  avg_timeplan_list <- avg_time_plan %>%
    select(TIME.Plan)
  
  
  avg_timeplan_list <- avg_timeplan_list %>%
    mutate(
      
      Average.Time.On.Plan = mean(TIME.Plan)
      
    )
  
  
  avg_timeplan_list <- select(avg_timeplan_list, -1)
  avg_timeplan_list <- avg_timeplan_list[1, ]
  
  
  new_col_pendo <- new_col_pendo %>%
    mutate(
      
      Average.Time.On.Plan = avg_timeplan_list
    )
  
  new_col_pendo <- relocate(new_col_pendo, "Average.Time.On.Plan", .after = TIME.Plan)
  
  
##############################################################################################
  
  avg_days_plan <- new_col_pendo %>%
    filter(DAYS.plan > 0)
  
  avg_daysplan_list <- avg_days_plan %>%
    select(DAYS.plan)
  
  
  avg_daysplan_list <- avg_daysplan_list %>%
    mutate(
      
      Average.Days.On.Plan = mean(DAYS.plan)
      
    )
  
  
  avg_daysplan_list <- select(avg_daysplan_list, -1)
  avg_daysplan_list <- avg_daysplan_list[1, ]
  
  
  new_col_pendo <- new_col_pendo %>%
    mutate(
      
      Average.Days.On.Plan = avg_daysplan_list
    )
  
  new_col_pendo <- relocate(new_col_pendo, "Average.Days.On.Plan", .after = DAYS.plan)
  
  
  ######################################################################################################
  
  avg_time_aud <- new_col_pendo %>%
    filter(TIME.Audiences > 0)
  
  avg_timeaud_list <- avg_time_aud %>%
    select(TIME.Audiences)
  
  
  avg_timeaud_list <- avg_timeaud_list %>%
    mutate(
      
      Average.Time.On.Audience = mean(TIME.Audiences)
      
    )
  
  
  avg_timeaud_list <- select(avg_timeaud_list, -1)
  avg_timeaud_list <- avg_timeaud_list[1, ]
  
  
  new_col_pendo <- new_col_pendo %>%
    mutate(
      
      Average.Time.On.Audience = avg_timeaud_list
    )
  
  new_col_pendo <- relocate(new_col_pendo, "Average.Time.On.Audience", .after = TIME.Audiences)
  
  ################################################################################################################
  
  avg_days_aud <- new_col_pendo %>%
    filter(DAYS.Audiences > 0)
  
  avg_daysaud_list <- avg_days_aud %>%
    select(DAYS.Audiences)
  
  
  avg_daysaud_list <- avg_daysaud_list %>%
    mutate(
      
      Average.Days.On.Audience = mean(DAYS.Audiences)
      
    )
  
  
  avg_daysaud_list <- select(avg_daysaud_list, -1)
  avg_daysaud_list <- avg_daysaud_list[1, ]
  
  
  new_col_pendo <- new_col_pendo %>%
    mutate(
      
      Average.Days.On.Audience = avg_daysaud_list
    )
  
  new_col_pendo <- relocate(new_col_pendo, "Average.Days.On.Audience", .after = DAYS.Audiences)
  
  ###################################################################################################################
  
  
  avg_time_alloc <- new_col_pendo %>%
    filter(TIME.Allocation > 0)
  
  avg_timealloc_list <- avg_time_alloc %>%
    select(TIME.Allocation)
  
  
  avg_timealloc_list <- avg_timealloc_list %>%
    mutate(
      
      Average.Time.On.Allocation = mean(TIME.Allocation)
      
    )
  
  
  avg_timealloc_list <- select(avg_timealloc_list, -1)
  avg_timealloc_list <- avg_timealloc_list[1, ]
  
  
  new_col_pendo <- new_col_pendo %>%
    mutate(
      
      Average.Time.On.Allocation = avg_timealloc_list
    )
  
  new_col_pendo <- relocate(new_col_pendo, "Average.Time.On.Allocation", .after = TIME.Allocation)
  
  ##################################################################################################################
  
  avg_days_alloc <- new_col_pendo %>%
    filter(DAYS.Allocation > 0)
  
  avg_daysalloc_list <- avg_days_alloc %>%
    select(DAYS.Allocation)
  
  
  avg_daysalloc_list <- avg_daysalloc_list %>%
    mutate(
      
      Average.Days.On.Allocation = mean(DAYS.Allocation)
      
    )
  
  
  avg_daysalloc_list <- select(avg_daysalloc_list, -1)
  avg_daysalloc_list <- avg_daysalloc_list[1, ]
  
  
  new_col_pendo <- new_col_pendo %>%
    mutate(
      
      Average.Days.On.Allocation = avg_daysalloc_list
    )
  
  new_col_pendo <- relocate(new_col_pendo, "Average.Days.On.Allocation", .after = DAYS.Allocation)
  
  Measure_Raw_Active <- pendo_data %>% 
    filter(Create.Initiative > 0 | Launch.Initiative > 0 | Open.Initiative > 0)
  
  Plan_Raw_Active <- pendo_data %>%
    filter(Start.Plan > 0 | Run.Plan > 0 | Run.Linear.Buy > 0 | Run.Aggregate.Buy > 0 | Open.Plan > 0 | Open.Plan.2 > 0)
  
  Allocate_Raw_Active <- pendo_data %>%
    filter(Run.Allocation > 0 | Open.Allocation > 0 | Submit.to.Mediaocean > 0)
  
  Audience_Raw_Active <- pendo_data %>%
    filter(Start.Audience > 0 | Create.Audience > 0 |  Open.Audience > 0 | Start.Viewership > 0 | Create.Segment > 0 | Open.Segment > 0)
  
  
write.csv(new_col_pendo, 'XXXXXX_MonthlyReport.csv')
write.csv(Measure_Raw_Active, 'XXXXXX_MeasureRawToActive.csv')
write.csv(Plan_Raw_Active, 'XXXXXX_PlanRawToActive.csv')
write.csv(Allocate_Raw_Active, 'XXXXXX_AllocateRawToActive.csv')
write.csv(Audience_Raw_Active, 'XXXXXX_AudienceRawToActive.csv')

  
  }
