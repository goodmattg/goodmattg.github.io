+++
title = "Theory of Probability (Chapter 1)"
date = 2018-02-17
excerpt = "Reviewing a cleaning product is easy - you use the product and it does or does not work. Reviewing a textbook is harder - how do you quantify the benefit a book gives you, especially if you haven't read the book for its intended purpose, to convey a body knowledge."
categories = ["probability"]
comments = true
+++

<hr>

### Retrospect (03/27/21)

_I remember this time in my life clearly. It was a mental high point and a physical low point. Unsurprisingly, I only made it through two chapters. Theoretical probability is hard, and I found this material impossible to work through without peer feedback. Life is meant to be lived; I don't feel the pressure to take on masochistic intellectual challenges anymore._

## A _gedanken_ experiment

Do you gain some sort of magic insight if you work through an entire textbook, or is there no light at the end of the tunnel? Are you now master of this specific domain? Is there any feeling of accomplishment to be had? Better yet, I want to be able to review a textbook by actually saying what it did for me. Reviewing a cleaning product is easy - you use the product and it does or does not work. Reviewing a textbook is harder - how do you quantify the benefit a book gives you, especially if you haven't read the book for its intended purpose, to convey a body knowledge. 

My goal is to attempt every chapter, work selected problems, and write about the experience. This is going to be a public diary of my grappling with the material. I'm not a prodigy - so this will take a lot of effort to finish. I've selected _"The Theory of Probability"_ by Santosh S. Venkatesh. I took Professor Venkatesh's course "Engineering Probability" at Penn and did quite well. To be sure, Professor Venkatesh was one of the most engaging professors I had in college. Thank you to Oxford University Press for leaving the link to the solutions PDF in plain-text in the page source. 

The moment I opened "Theory" and saw the phrase "_gedanken_ experiment" I knew this was the book. In my limited experience, I've found that when academics write textbooks, they tend to deviate from their own speaking style and revert to bland academic writing. Add to the fact that most textbooks are viewed as vehicles to deliver formulae, and it's clear why textbooks aren't beach reading material. By contrast, Professor Venkatesh doesn't stray a beat from his physical teaching style. I can imagine him saying everything in this book word for word, because I've heard him say so many of these phrases word for word. If I could distill Venkatesh's style to its core, it is to ruminate on points of intellectual curiosity, not to linger on them, per se, but to give important points the cogent philosophical discussion they deserve. It's easy for academic text to go too far with these musings - but Venkatesh toes the line with grace.  

Lastly I just enjoy probability. I may go to graduate school to study the subject, and see no harm in deeply understanding the material. 


## Chapter 1.1-1.7 

- This books chapter's are one-indexed
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
- Example:

$$(a,b]^c = (0,1]~\backslash~s(a,b] = (0,a] \cup (b,1] \in R(\mathcal{J})$$

- This algebra is closed under finite sets of operations, yet is open under carefully chosen infinite sets of operations. The general point he works hard to convey is that the intuitive thoughts we have about probability are derived - or are intuitive only because we operate within carefully crafted $\sigma$-algebras. We have to fight to establish a notion of probability in continuous spaces. Without a scaffolding, like operating only on the Borel sets, we would reach the intractable problem that the probability of any point on the continuous real number line has probability zero. The obvious solution is to only deal with ranges of the continuous number line, which is what we do.\\ 


Probability space defined as tuple of sample space: $\Omega$, $\sigma$-algebra $\mathcal{F}$ containing all events, and probability measure $\mathcal{P}: \mathcal{F} \rightarrow \mathbb{R}$:

$$\textbf{Probability Space:}~~~~~~(\Omega, \mathcal{F}, \mathcal{P})$$ 

Venkatesh goes on a surprisingly funny tangent to show how it is that this probability space tuple is overdescribed. 

![Probability Space](/assets/posts/ProbabilityCh1/implicitSpace.jpg)
*Figure 1. Samples space is impliclitly defined by event family and probability measure*

My mind drifted to thinking how we develop intuition of probability spaces in everyday problem settings. In real life, we don't start out by knowing every possible thing that can happen, so we don't have $\mathcal{F}$ meaning we definitely don't have $\Omega$ nor $\mathcal{P}$. And when you think about it, we never actually have a complete notion of all the possibilities in anything but toy problems. The same way the Borel sets exclude all of the weird subsets on the number line that break our intuitive notion of probability, humans evolved to be very good at excluding events from our event families that have no chance of occurring. It gets at this highly complex question of how simple experiments dictate $(\Omega, \mathcal{F}, \mathcal{P})$ before we have the tuple itself. We basically end up hoisting the space up by its own bootstraps.

In a coin flip, $\Omega$ is $\{\mathcal{H}, \mathcal{T}\}$. But what if we didn't know what a coin was or how it worked? We would flip this mysterious coin for our first outcome $A_1$ and it would initial show $\mathcal{H}$. So $A_1 \in \omega$, the outcome space. So we have $\mathcal{H} \subseteq \mathcal{F} \subseteq \Omega$, $\mathcal{P}: \mathcal{F} \rightarrow \mathbb{R}$ is initially just $\mathcal{P}(\mathcal{H})=1$. Then we flip again, see $\mathcal{T}$, and suddenly this gets Bayesian. Suddenly we have an inner probability measure $P_{in}$ that's implicitly defined by the outer probability distribution $P_{out}$. That is, we might have actually encountered the entire sample space which would then be $\mathcal{H}, \mathcal{T}$, but we don't know anything about coins, so there could be more possible outcomes. Worse, we can easily see that the probability space on which $P_{out}$ is infinitely complex. A probability distribution over all the possible states that a sample space can take on isn't feasible. My knowledge is severely lacking here, but this feels like the idea of larger infinities at play where $\Omega_{in}$ is complexity $\aleph_1$ and $P_{out}$ is complexity $\aleph_2$. 

$$P_{out}(\Omega_{in}~|~\omega_{in})$$

$$P_{out}(\mathcal{F}_{in}~|~\omega_{in})$$

$$P_{out}(\mathcal{P_{in}}~|~\Omega_{in}, \mathcal{F}_{in})$$

The key advances in AI have been making machines that are excellent at operating within well defined probability spaces and event families. We'll have made the next leap when machines are able to revise their outer probability distributions. For example, that doesn't just mean an autonomous vehicle reacting to an obstacle it has never seen before, but reacting to a completely unfamiliar situation. Autonomous vehicles are programmed to slow down when people appear in front of the vehicle. If a jaguar suddenly enters the crosswalk, the car makes the deduction that a jaguar is person-like in that it moves, and slows down accordingly. The logic may be even less complex than that. But now the autonomous car is idling at a red light and an unusually angry strongman runs up and starts trying to tip the car. What to do now? This event has no probability because it wasn't derivable in the context of the programmed event family. A truly intelligent vehicle would revise its notion of the probability space for driving to include other beings actively trying to impede the driving action, and react accordingly.  