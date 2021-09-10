#“I confirm that the following report and associated code is my own
#work, except where clearly indicated.”
#Loading the libraries 
source("./SimulationTests.R")
library(tidyverse)
library(dslabs)
library(gridExtra)
library(grid)
#Data
admissions_raw <- data.frame(admissions)
str(admissions_raw)
admissions_new <- admissions_raw%>%
  mutate(gender = as.factor(gender), 
         major = as.factor(major),ratio = admitted/100)

#Exploratory Analysis
hist(admissions_new$ratio, xlab = 'Number of Admitted Students', 
     main = 'Histogram of Admitted Students', col = 'lightblue')
Grouped_admissions <- admissions_new%>%group_by(gender)%>%select(-major)
Grouped_admissions_summaries <- Grouped_admissions%>%
  summarise(Mean = mean(ratio), SD = sd(ratio), n = n())
Grouped_admissions_summaries

#Scenerio 1: Keeping the ratio of males and females in each subject the same
#We use the orignal mean and standard deviation from the orignal data to 
#simulate new data
#We first generate the same sample size to come up with a new scenerio 
#Setting seed to make the results replicable
set.seed(180008373)
new_data <- Simulation_function(Mu = Grouped_admissions_summaries$Mean, 
                                Sigma = Grouped_admissions_summaries$SD,
                                m = c(6,6))
new_data_summary <- new_data%>%group_by(Group)%>%
  summarise(Mean = mean(Sample), SD = sd(Sample), n = n(), 
            sum = sum(Sample),Median = median(Sam))
new_data_summary
#A mesurement error was found in the observations such that we know the true 
#mean of the two Genders is the same
Difference <- diff(new_data_summary$sum)
new_data_sim_1 <- new_data
#Arbitairily picking the observation to change
new_data_sim_1[6,1] <- new_data_sim_1[6,1] + Difference
new_data_sim_1
new_data_sim_1_summary <- new_data_sim_1%>%group_by(Group)%>%
  summarise(Mean = mean(Sample), SD = sd(Sample), n = n(), sum = sum(Sample))
new_data_sim_1_summary
#Calculating the size of these tests
set.seed(180008373)
Size_AlphaLevel_Table<-rbind(as.data.frame(Simulation_Tests(new_data_sim_1, 
                                                            alpha = 0.01)[3]),
                             as.data.frame(Simulation_Tests(new_data_sim_1, 
                                                            alpha = 0.05)[3]),
                             as.data.frame(Simulation_Tests(new_data_sim_1, 
                                                            alpha = 0.10)[3]))
Size_AlphaLevel_Table
ggplot(Size_AlphaLevel_Table)+geom_line(aes(Prob_p,Alpha,colour = 'blue')) + 
  geom_line(aes(Prob_np,Alpha, colour = 'red')) + labs(x = "Power") + 
  scale_color_discrete(name= "Type",labels = c("T-test","Mann Whitney U Test"))
+ggtitle("Figure 1: Size Plot Against Alpha Levels")

#Scenerio 2: Effect of incresaing the sample size
set.seed(180008373)
#Effectsize 0.03 
M1 <- c(0.38,0.41)
S<- c(0.22,0.28)
newdata_12<- Simulation_function(Mu = M1,Sigma = S, m = c(6,6))
newdata_100<- Simulation_function(Mu = M1,Sigma = S, m = c(50,50))
newdata_1000<- Simulation_function(Mu = M1,Sigma = S, m = c(500,500))

#Effectsize 0.05
newdata_12_1<- Simulation_function(Mu = c(0.38,0.43),Sigma =c(0.22,0.28),
                                   m = c(6,6))
newdata_100_1<- Simulation_function(Mu = c(0.38,0.43),Sigma =c(0.22,0.28), 
                                    m = c(50,50))
newdata_1000_1<- Simulation_function(Mu = c(0.38,0.43),Sigma =c(0.22,0.28), 
                                     m = c(500,500))
#Effectsize 0.08
set.seed(180008373)
newdata_12_2<- Simulation_function(Mu = c(0.38,0.46),Sigma =c(0.22,0.28), 
                                   m = c(6,6))
newdata_100_2<- Simulation_function(Mu = c(0.38,0.46),Sigma =c(0.22,0.28), 
                                    m = c(50,50))
newdata_1000_2<- Simulation_function(Mu = c(0.38,0.46),Sigma =c(0.22,0.28), 
                                     m = c(500,500))

#Runing the simulation test on each new data

Result_1 <- Simulation_Tests(newdata_12)
Result_2 <- Simulation_Tests(newdata_100)
Result_3 <- Simulation_Tests(newdata_1000)


Result_4 <- Simulation_Tests(newdata_12_1)
Result_5 <- Simulation_Tests(newdata_100_1)
Result_6 <- Simulation_Tests(newdata_1000_1)

Result_7 <- Simulation_Tests(newdata_12_2)
Result_8 <- Simulation_Tests(newdata_100_2)
Result_9 <- Simulation_Tests(newdata_1000_2)


Power_1 <- cbind(rbind(as.data.frame(Result_1[3]),
                  as.data.frame(Result_2[3]),
                  as.data.frame(Result_3[3])),SampleSize = c(12,100,1000))
Power_2 <- cbind(rbind(as.data.frame(Result_4[3]),
                       as.data.frame(Result_5[3]),
                       as.data.frame(Result_6[3])),SampleSize = c(12,100,1000))
Power_3 <-cbind(rbind(as.data.frame(Result_7[3]),
                      as.data.frame(Result_8[3]),
                      as.data.frame(Result_9[3])),SampleSize = c(12,100,1000)) 

effects_size <- data.frame(rbind(Power_1[,1], Power_2[,1], 
                                 Power_3[,1]), row.names = c("0.3","0.5", "0.8"))
colnames(effects_size) <- c(12,100,1000)

#Plotting the power
p1<-ggplot(Power_1)+geom_line(aes(Prob_p,SampleSize,col = 'blue')) + 
  geom_line(aes(Prob_np,SampleSize, col = 'red')) + labs(x = "Power") +
  scale_color_discrete(name = "Type",labels = c("Mann Whitney U Test","T-test"))+
  ggtitle("Figure 2: Power Plot Against Sample Size - Effect size 0.3 ")
p2 <-ggplot(Power_2)+geom_line(aes(Prob_p,SampleSize, col = 'blue')) + 
  geom_line(aes(Prob_np,SampleSize, col = 'red')) + labs(x = "Power") +
  scale_color_discrete(name = "Type",labels = c("Mann Whitney U Test","T-test"))+
  ggtitle("Figure 3: Power Plot Against Sample Size - Effect size 0.5")
p3 <- ggplot(Power_3)+geom_line(aes(Prob_p,SampleSize, col = 'blue')) + 
  geom_line(aes(Prob_np,SampleSize, col = 'red')) + labs(x = "Power") +
  scale_color_discrete(name = "Type",labels = c("Mann Whitney U Test","T-test"))+
  ggtitle("Figure 4: Power Plot Against Sample Size - Effect size 0.8")
