## Welcome to the NEON codeFest!!




### The challenge

Species extinctions are increasing, and other species are invading new areas, such that the number of species that occupy any given area is changing over time. Understanding this change is a fundamental goal of ecology. Your challenge, should you chose to accept it, is to forecast the number of small mammal species across a set of long-term monitoring sites across the United States of America. How you generate your predictions is entirely up to you and your group. 



For the sake of this exercise, students will train their predictive models on the time period from 2014 - 2019 and then predict species richness in 2020 and 2021. Only a subset of sites were sampled in these years, such that care must be taken when formatting the predictions submitted (i.e., fill in the `richness` column of the `predictionTemplate.csv` file in the GitHub repo). 




**We will kick off this codeFest by checking out the `exampleForecast.Rmd` file, where we will walk through the data structure, learning some fun programming skills along the way.**










### The data

> The National Earth Observatory Network (NEON) is a continental-scale observation facility operated by Battelle and designed to collect long-term open access ecological data to better understand how U.S. ecosystems are changing.  -- https://www.neonscience.org/about



NEON data are derived from sampling a set of distributed sites across the United States. By systematically sampling these sites over time, it is possible to observe spatial and temporal changes in species population dynamics (e.g., change in the number of individuals of a species over time) and biodiversity measures (e.g., the number of species in a site). This is valuable information, as ecological communities may change over time as a result of habitat destruction, climate change, or the introduction of a predator or competitor species. Understanding how populations and communities respond to these changes is a central goal of ecology. Predictive approaches aimed at estimating what biodiversity will look like in the future are essential to protecting species from extinction and to understand what we might expect a given site to look like in the future. 





### NEON small mammal sampling

Small mammals are sampled in NEON sites with Sherman traps, where species are identified, marked with a tag and released. Several 10 x 10 trap grids (i.e. plots) are used per site to sample mammals. Each plot contains then 100 traps that are separated by 10 m from each other. Small mammals sampling usually occur during three consecutive nights based on lunar calendar, with sampling occurring within 10 days before or after the new moon. Here, we have reduced the data down to the season timescale, and estimated species richness as the number of unique species found in that given site (column `siteID` in the neonData file) in that given year (column `year` in the neonData file) and in that given season (column `season` in the neonData file). 













### Scoring and evaluation

Teams will predict the number of small mammal species at each site, following the prediction template file (`predictionTemplate.csv`). Forecasts will be assessed using root-mean squared error, which measures the squared difference between the projected species richness and the true value. 


![rmse](https://media.geeksforgeeks.org/wp-content/uploads/20200622171741/RMSE1.jpg)














### The prizes

There will be a prize for the team with the best predictive model. There will also be a wildcard prize for 'most inventive approach', which will be left up the disretion of a set of three judges. 










### The code of conduct

We use the Contributor Covenant as a code of conduct (`codeOfConduct.md` file in this repo). Violations of this code will result in immediate action. 






--- 

Feel free to fork this repo and use it as a template to develop a similar codeFest. Please see the `contributing.md` file for suggesting changes to this repo. 

We acknowledge funding from Louisiana State University College of Science and Department of Biological Sciences that made this event possible. 


