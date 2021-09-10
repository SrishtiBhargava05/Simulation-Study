#“I confirm that the following report and associated code is my own
#work, except where clearly indicated.”
#Simulation function 
Simulation_function <- function(Mu,Sigma,m=c(6,6)){
  #Purpose - To simulate data under different scenerios 
  #Input - InData - the data that has the response vector to be resampled 
  # m - number of observations in each sample 
  NewSample_1 <- data.frame(Sample = abs(rnorm(m[1],mean = Mu[1], sd = Sigma[1])), 
                            #We generate only postive numbers as ratios cannot be negative
                            Group = as.factor("Group 1"))
  NewSample_2 <- data.frame(Sample = abs(rnorm(m[2],mean = Mu[2], sd = Sigma[2])),
                            Group = as.factor("Group 2"))
  simulated_data <- rbind(NewSample_1,NewSample_2)
  return(simulated_data)
}

#Function for calculating power or size of the tests
Simulation_Tests<- function(InData,n = 999,alpha = 0.05){
  #Purpose : To resample the data and generate new p-values 
  #         and use them to find the power or size of test statistic
  #Input - InData - simulated data to be sampled
  # n - number of samples to be genrated
  # m - number of observations in each sample
  #alpha - Significance level of the test
  #Output - simulated p-values 
  #beta - power/size of the test
  Orignal_Parametric <- t.test(InData$Sample~InData$Group)
  Orignal_Nonparametric <- wilcox.test(InData$Sample~InData$Group)
  #Calculating the length of the input data 
  num <- as.vector(by(InData$Sample, InData$Group,length))
  means <- as.vector(by(InData$Sample, InData$Group, mean))
  SD   <- as.vector(by(InData$Sample, InData$Group, sd))
  #creating an empty storage vector
  pvalues <- data.frame(Parametric = numeric(n), Non_Parametric = numeric(n))
  for (i in 1:n) {
    #Simulating new data on the basis of the properties of the old one
    SimData <- Simulation_function(m = num, Mu = means, Sigma = SD)
    #rerunning the test
    teststatistic <- t.test(SimData$Sample~SimData$Group)
    teststatistic_np <- wilcox.test(SimData$Sample~SimData$Group)
    #extracting the p-values
    pvalues[i,1] <- teststatistic$p.value
    pvalues[i,2] <- teststatistic_np$p.value
  }
  #Calculating the number of p-values that rejected H0
  SignificantValues_p <- which(pvalues$Parametric <= alpha)
  count_H0_p <- length(SignificantValues_p)
  SignificantValues_np<- which(pvalues$Non_Parametric <= alpha)
  countH0_np <- length(SignificantValues_np)
  #Calculating the power of the test
  Prob_p<- countH0_np/n
  Prob_np<- count_H0_p/n
  Prob <- data.frame(Prob_p,Prob_np)
  return(list(Orignal_Parametric,Orignal_Nonparametric,Prob))
}


