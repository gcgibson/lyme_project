


lyme=read.csv("/Users/gcgibson/Desktop/lyme/lymedata.csv",header = T)
lyme$X2011<- as.integer(lyme$X2011)
lyme$X2012<- as.integer(lyme$X2012)

ts<- ts(t(lyme[,2:11]))

ma_data <- array(unlist(lyme[which(lyme$State=="Massachusetts"),]))[2:11]

require(rbiips)
library(MCMCpack)
model_file = '/Users/gcgibson/Desktop/lyme/seasonal_pois.bug' # BUGS model filename
cat(readLines(model_file), sep = "\n")

par(bty='l')
light_blue = rgb(.7, .7, 1)
light_red = rgb(1, .7, .7)


t_max = length(ma_data)
n_burn = 500 # nb of burn-in/adaptation iterations
n_iter = 1000 # nb of iterations after burn-in
thin = 5 # thinning of MCMC outputs
n_part = 50 # nb of particles for the SMC

inits = list(-2)
G = matrix(c(cos(2*pi),sin(2*pi/4),-sin(2*pi/4),cos(2*pi/4)), nrow=2, byrow=TRUE)

#setting the mean value of the initial count to 1400
data = list(t_max=t_max, y = ma_data,  G = G, mean_sigma_init = c(0,0), cov_sigma_init=.0001*diag(2) ,mean_x_init=c(log(1400),log(1400)))
model = biips_model(model_file, data=data,sample_data = FALSE)

##fixing variance for now, will extend model to handle inference over variance later

n_part = 10000# Number of particles
variables = c('x') # Variables to be monitored
out_smc = biips_smc_samples(model, variables, n_part)

summ_pmmh = biips_summary(out_smc, probs=c(.025, .975))



p<- ggplot() 
p<- p+ geom_line(data = data.frame(x=seq(1,length(summ_pmmh$x$f$mean[1,])),y=exp(summ_pmmh$x$f$mean[1,])), aes(x = x, y = y), color = "red") +
  
  geom_line(data=data.frame(x=seq(1,length(ma_data)),y=ma_data), aes(x = x, y = y), color = "cornflowerblue") +
  geom_ribbon(data=data.frame(x=seq(1,length(ma_data)),y=ma_data),aes(x=x,ymin=summ_pmmh$x$f$quant$`0.025`[1,],ymax=summ_pmmh$x$f$quant$`0.975`[1,]),alpha=0.3)+
  xlab('data_date') +
  ylab('count')
print(p)


