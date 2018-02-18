---
layout: post
title: The Theory of Probability Project
---

I'm not sure that I learned much in college. To put it bluntly, I don't feel as if I had to put in very much work to do decently well in college courses. It's not hard to see why.

- Grade inflation at Ivy League schools is well documented
- It wasn't that hard to do average in the college courses I took. Most of the tests I remember taking had several questions that did not require mastery of the material - but sufficed to memorize the application of a few formulae. 

My fellow students and I were masters at getting the A-. You would drill hard on the subset of the material you knew would show up, and pray for partial credit on the questions that required intuition. This implies that true intuition for material comes from mastery of said material. 

## The Idea: a _gedanken_ experiment

The idea behind the project is to see what happens when you work through an entire textbook. Did you gain some sort of magic insight, or is there no light at the end of the tunnel? Are you know master of this specific domain? Is there any feeling of accomplishment to be had? Better yet, I want to be able to review a textbook by actually saying what it did for me. Reviewing a cleaning product is easy - you use the product and it does or does not work. Reviewing a textbook is harder - how do you quantify the benefit a book gives you, especially if you haven't read the book for it's intended purpose, to convey a body knowledge. 

My goal is to read every chapter, work every problem, and write about the experience. This is going to be a public diary of my struggling with the material. I'm no genius - so this will take a lot of effort to finish. I've selected _"The Theory of Probability"_ by Santosh S. Venkatesh. Why is this book different from all other books? Well for one, I am selfish. I took Professor Venkatesh's course "Engineering Probability" at Penn and did quite well. To be sure, Professor Venkatesh was one of the most engaging professors I had in college. 

The moment I opened "Theory" and saw the phrase "_gedanken_ experiment" I knew this was the book. In my limited experience, I've found that when academics write textbooks, they have a tend to deviate from their own speaking style and revert to bland academic writing. Add to the fact that most textbooks are viewed as vehicles to deliver formulae, and it's clear why textbooks aren't beach reading material.In stark contrast, Professor Venkatesh doesn't stray a beat from his physical teaching style. I can imagine him saying everything in this book word for word, because I've heard him say so many of these phrases word for word. If I could distill Venkatesh's style to its core, it is to ruminate on points of intellectual curiosity, not to linger on them, per say, but to give important points the cogent philosophical discussion they deserve. It's easy for academic text to go too far with these musings - but Venkatesh toes the line with grace.  

Lastly, I simply enjoy probability. I may go to graduate school to study the subject, and see no harm in deeply understanding the material. 


## Chapter 1.1-1.7 

- This books chapter's are one-indexed...
- Going through the elements of Kolmogorov representation of probability
    - $A=B$ iff $A \subseteq B$ and $B \subseteq A$
    - Intersection: $A \cap B$
    - Union: $A \cup B$
    - Complement: $\Omega~\backslash~A$ = $A^c$
    - $\Omega$ is _certainty_
    - $\emptyset$ is _impossible_
- For finite sets, the family of all events in the probability space, $\mathcal{F}$, is closed. 
    - $A \in \mathcal{F} \rightarrow A^c \in \mathcal{F}$
    - $A \cup A^c = \Omega \in \mathcal{F}$
    - $(A \cup A^c)^c = \emptyset \in \mathcal{F}$
- Systems of sets closed under unions and complements are also called "fields" - author says that have more in common with algebreic systems.
- Closure under finite unions does not guarantee closure under countably infinite unions.

$$(a,b]^c = (0,1]~\backslash~(a,b] = (0,a] \cup (b,1] \in R(\mathcal{J})$$