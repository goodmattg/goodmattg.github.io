---
layout: page
title: Projects
permalink: /projects/
---

## Identifying Semantically Identical Question Pairs From Quora

**Paper**: [PDF][3]

Our project is in the domain of natural language processing and natural language understanding. The broad problem we address is how to judge the semantic intent of language irrespective of its syntactic structure, specifically on indi- vidual sentences. What constitutes the meaning of a sen- tence is subjective and never fully tangible. Regardless, it is clear that sentences convey intent, such that a human could tell if two sentences are semantically identical, and even the degree to which this is true. How this is done by the mind is difficult to understand in itself, which makes modeling such a process quite challenging... [Read more][3]

## Graph-based Model Election Forecasting

**Paper**: [PDF][1]

**Presentation**: [PDF][2]

The goal of this research is to provide a graph-based model for predicting elections based on limited data.
We aim to model the counties as nodes in a graph and to design the edges between these counties based
on available election and census data. We set counties as nodes because national elections are physically
organized on the county level; each county is responsible for maintaining voting locations and sending votes
to counting facilities. First, we consider the relationship between voting patterns from previous Presidential
elections and predicted election results. Second, we consider the relationship between voting patterns from
previous Senatorial elections and predicted election results. Senate election results are powerful because they
are useful to improve our model at the state level. Senate elections are both infrequent and polarizing which
results in higher turnout than elections for the House of Representatives. Overall this yields a better model
of how counties in the same state influence each other. Counties are related to one another by historical
voting patterns. Two physically adjacent counties will almost certainly have the same historical voting pattern
meaning they are strongly correlated; an accurate poll of county X should predict how county Y will
vote. Using historical election data we can build a graph shift operator that relates the connections between
counties as some factor of ’connectedness’. We can also add other census data such as median income or
poverty index to further establish the connections that exist between counties.

The brief explanation is that counties voting patterns are predictable, and this is enough to predict elections. Having a highly accurate polling measure in a few counties is enough to predict election results in all counties with a decent accuracy. We are able to look at counties as a connected network because counties are not I.I.D random variables. Instead, counties share properties with each other that are turn out to be highly predictive of voting patterns: age distribution, race, median income, income distribution, etc. On a personal note, I was sad to see that county voting behavior was so predictable. Groupthink is clearly the norm.

[1]:{{ site.url }}/assets/downloads/finalGraphReport.pdf
[2]:{{ site.url }}/assets/downloads/finalGraphPresentation.pdf
[3]:{{ site.url }}/assets/downloads/FinalProjectPaper.pdf
