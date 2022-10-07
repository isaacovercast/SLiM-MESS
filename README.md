# SLiM-MESS

## Simple example models ##

### helloworld.txt ###
Obvious.

### species.txt ###
Simple single-species two population model with migration.

# Multi-species community models #

## Simple as possible base model ##

### community_0.txt ###
Simple three species community model with fixed community size, hackish
WF abundance dynamics, and genetics per species. No migration.

Useful logging (abundance and heterozygosity per species per unit time):
```
time,N_p0,N_p1,N_p2,H_p0,H_p1,H_p2
1,1783,1187,2055,5.60135e-07,0.0,0.0
21,1945,975,2054,1.53969e-06,7.16128e-06,0.0

```
**NB:** Logging breaks if abundance goes to 0. SLiM subpopulations are cleaned
up and their references are removed.

## Allowing 0-abundance ##
The logging is useful for temporal trends, so how to allow for subpopulations
to go locally extinct? For the logging to work we either have to _know_ in advance
or limit the total species richness of the local community (annoying), or
we have to think about how to restructure the logging so the columns don't correspond
to 'subpopulation' outputs.

### community_01.txt ###
Lets say we can fix the max species richness in the local community to some high value.
The trick will then be to prevent 0 abundance species from getting cleaned up.
I can imagine how you'd do this by 'tagging' 0-abundance species as locally extinct,
but then fixing their abundance to 1 (artificially) to keep them from being cleaned up.

This feels hackish, so maybe I won't try it just yet.

### community_02.txt ###

## Modeling migration from the metacommunity ##
How to model the metacommunity and migration into the local subpopulations is
another big, untackled question.

### commmunity_meta.txt###

## in situ speciation ##

## Spatially explicit models ##



