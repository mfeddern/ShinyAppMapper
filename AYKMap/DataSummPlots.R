data <- read.csv(file = 'DataSumm_EscHarAge.csv')

data_YukonUS <- data %>% filter(Region =='Yukon (US)')
data_long_YukonUS <- gather(data_YukonUS, key= "DataType",value="Escapement", Escapement..weir., Escapement..tower., Escapement..sonar., Age, Aerial.Survey)
YukonUS.plot<- ggplot(data = data_long_YukonUS, aes(x = Year,  y=DataType, size = Escapement, col=DataType)) + geom_point(alpha=0.7)+
facet_wrap(~Location)+
scale_size(range = c(2, 2), limits = c(0.5, 1.5))
YukonUS.plot



data_YukonCA <- data %>% filter(Region =='Yukon (CA)')
data_long_YukonCA <- gather(data_YukonCA, key= "DataType",value="Escapement", Escapement..weir., Escapement..tower., Escapement..sonar., Age, Aerial.Survey)
YukonCA.plot<- ggplot(data = data_long_YukonCA, aes(x = Year,  y=DataType, size = Escapement, col=DataType)) + geom_point(alpha=0.7)+
  facet_wrap(~Location)+
  scale_size(range = c(2, 2), limits = c(0.5, 1.5))
YukonCA.plot

data_Kuskokwim <- data %>% filter(Region =='Kuskokwim')
data_long_Kuskokwim <- gather(data_Kuskokwim, key= "DataType",value="Escapement", Escapement..weir., Escapement..tower., Escapement..sonar., Age, Aerial.Survey)
Kuskokwim.plot<- ggplot(data = data_long_Kuskokwim, aes(x = Year,  y=DataType, size = Escapement, col=DataType)) + geom_point(alpha=0.7)+
  facet_wrap(~Location)+
  scale_size(range = c(2, 2), limits = c(0.5, 1.5))
Kuskokwim.plot

data_NortonSound <- data %>% filter(Region =='Norton Sound')
data_long_NortonSound <- gather(data_NortonSound, key= "DataType",value="Escapement", Escapement..weir., Escapement..tower., Escapement..sonar., Age, Aerial.Survey)
NortonSound.plot<- ggplot(data = data_long_NortonSound, aes(x = Year,  y=DataType, size = Escapement, col=DataType)) + geom_point(alpha=0.7)+
  facet_wrap(~Location)+
  scale_size(range = c(2, 2), limits = c(0.5, 1.5))
NortonSound.plot
