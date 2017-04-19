### EXERCISE 1 - animals

# What is the heaviest carnivore?

carnivores = filter(mammals, order == 'Carnivora')
biggest_carnivore = arrange(carnivores, desc(adult_body_mass_g))
head(biggest_carnivore)

#Southern Elephant Seal. 

#####
# How many primates are in our dataset?
primates = filter(mammals, order =='Primates')
dim(primates)

### EXERCISE 2 - Data exploration. Try to use pipes!

# Which order has the most species? 

a = group_by(mammals, order)
b = summarize(a, num_species = length(species))
c = arrange(b, desc(num_species))

# or...
c = group_by(mammals, order) %>%
  summarize(num_species = length(species)) %>%
  arrange(desc(num_species))


# Which order has the widest range of body mass (max-min)?

a = group_by(mammals, order)
b = summarize(a, range_mass = max(adult_body_mass_g) - min(adult_body_mass_g))
c = arrange(b, desc(range_mass))

c = group_by(mammals, order) %>%
  summarize(range_mass = max(adult_body_mass_g) - min(adult_body_mass_g)) %>%
  arrange(desc(range_mass))

# Which species of carnivore has the largest body length to body mass ratio? (Hint: that's `adult_head_body_len_mm / adult_body_mass_g')`

a = filter(mammals, order == 'Carnivora')
b = mutate(a, lenToMass = adult_head_body_len_mm / adult_body_mass_g) 
c = arrange(b, desc(lenToMass))

c = filter(mammals, order == 'Carnivora') %>%
  mutate(lenToMass = adult_head_body_len_mm / adult_body_mass_g) %>%
  arrange(desc(lenToMass))

#weasel!


