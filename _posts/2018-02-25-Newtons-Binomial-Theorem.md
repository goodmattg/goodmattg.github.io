---
layout: post
title: Proving Newton's Binomial Theorem
comments: true
---

## Proving Newton's Binomial Theorem

Prove Newton's Theorem for $t \in \mathbb{R}$ for $\|x\|<1$. If $t=n$ is any positive integer obtain the standard binomial formula $(a+b)^n=\sum_{k=0}^n\binom{n}{k}a^{n-k}b^k$. 

$$(1+x)^t=1+\binom{t}{1}x+\binom{t}{2}x^2+\binom{t}{3}x^3\cdots=\sum_{k=0}^{\infty}\binom{t}{k}x^k$$

My calculus is rusty, so my first and only instinct when I see an infinite series like this with incrementing exponents is to use Taylor's approximation theorem with remainder. 

$$f^{n+1}(x) = \underbrace{\sum_{k=0}^{n}f^{(k)}(0)\frac{x^k}{k!}}_\text{T(x)}~+~\underbrace{\frac{1}{n!}\int_0^xt^nf^{n+1}(x-t)~dt}_{R_n(x)}$$ 

Looking this over, we can tell this is probably a good approach. That initial term matches up almost perfectly to our proof objective. Let's find the $k_{th}$ derivative of the function.

$$ 
\begin{align} 
    f(x) & = (1+x)^t \\
    f^{(k)}(x) & = t(t-1)(t-2) \cdots (t-k+1)(1+x)^{t-k} \\
    & = t^{\underline{k}}(1+x)^{t-k} 
\end{align} 
$$

We have the approximation term $T(x)$: 

$$
\begin{align}
    T(x) & = \sum_{k=0}^{n}f^{(k)}(0)\frac{x^k}{k!} \\
    & = \sum_{k=0}^{n}t^{\underline{k}}(1+(0))^{t-k}\frac{x^k}{k!} \\
    & = \sum_{k=0}^{n}t^{\underline{k}}\frac{x^k}{k!} \\
    & = \sum_{k=0}^{n}\binom{t}{k}x^k
\end{align}
$$

This matches perfectly! Now we just have to show that the remainder term $R(x) \rightarrow 0$ for $\|x\|<1$. At this point I didn't know what to do - I don't yet have the experience in formal mathematical proofs to even understand the target approach for this style of problem. Referring to the internet, the solution is quite clear. We replace the $n+1_{th}$ derivative term with a positive function that is always greater than this derivative term. We then show that $R(x) \rightarrow 0$ integrating over the term with the positive function substituted in.

First define the positive function $M(x)$ over the interval $\|t\|<\|x\|$. We use the $M$ to represent maximum because it is cleaner than writing $MAX(x)$.  

$$
|f^{n+1}(t)| \leq max\{1,t^{n+1}\}(1+|x|)^{t-(n+1)} \leq M(x)^{n+1}
$$  

We therefore have:

$$
|R_n(x)| \leq \frac{M(x)^{n+1}}{n!}\int_0^xt^n~dt~=~\frac{M(x)^{n+1}x^{n+1}}{(n+1)!}
$$

The $(n+1)!$ term will grow exponentially fast as $n \rightarrow \infty$, so $R(x) \rightarrow 0$. As said earlier, we only needed to demonstrate that the remainder approached zero, so we are done. 

$$\blacksquare$$

## Aside

I looked at the solution for this one and I can't grasp why they specify this exact maximum bounding function. We're quickly abandon the function so it hardly matters, but it seems like we could bound closer. Why $max(1,t^{n+1})$? Why not just $t^{n+1}$ or even $t^{\underline{n+1}}$? I'm guessing this is a matter of convention; we can see that over the interval $\|t\|<\|x\|$, $\|t^{n+1}\| \leq 1$, so I'd venture the $max(1,t^{n+1})$ function is just to get rid of negatives in case $n+1$ is odd.  

