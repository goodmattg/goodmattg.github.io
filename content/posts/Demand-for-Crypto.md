+++
title = "Demand for Cryptocurrency is Demand for Alpha"
date = 2021-05-09
description = "I don't get crypto, but I kind of get crypto"
categories = ["Crypto", "Bitcoin", "Ether", "FX"]
comments = true
+++

<hr>

## The Demand: smart people who want lucrative jobs correlated with "smartness"

I _still_ don't get crypto, but I kind of get one of the needs for crypto. If you run in my "_elite_" [^1] post-grad circle you'll notice that a lot of people talk  about finance. Every quantitatively oriented software engineer I meet will introduce themselves and be like "I'm John. In my free time I like hiking, hanging out with friends, and I do some quantitative trading __just for fun__." Just for fun?! Is quantitative trading fun? I mean, it's lucrative if you have good strategies and the right infrastructure, but is it actually so "fun" that we would do it in our unpaid free time? What I'm getting at is lots of people in the academic _elite_ that know quant trading is a way to (1) be smart (2) make gobs of money where (3) the amount of money you make is correlated with how smart you are. And if you consider the kinds of people who make it to _elite_ institutions, this is the dream job. Most of us learn young that how much you earn isn't tied to how smart you are, but this is tough pill for people who _won_ at "being smart". You spend a lifetime jumping through academic hoops, winning the race, and you get to the end where statistically, it hardly matters [^2]. But then, there's this one magical niche field, quantitative trading, where the two strongly correlate, so naturally the demand to enter the field is high. I studied electrical engineering, but after looking at the EE job market as a rational economic actor, I realized joining the field would be silly. If you love EE and would die doing it in your free time, sure go work in EE. But if you're me and only really liked EE, you do what it takes to switch towards a field with higher compensation. Why the low EE salaries? I'm not an economist, but rising income inequality, international labor markets, and skilled worker visas (H-1B) successfully commoditized the EE profession. So in the end, EE and other hard science / engineering careers pay well, but not nearly the money software engineering and quant finance pay.

# The Supply: exceptional organizations that don't need many people

But from the quantitative finance side [^3], the demand for new talent is far lower than supply. What is this statement based on? Anecdotal evidence, so call foul if I'm off. But just eyeballing my peer group, it looks like Jane Street / etc. take a handful of new graduates a year maximum. Assume a small multiple above new grads for experienced hires. Any of these places employ at maximum ~2000 people, and it's pretty clear these small exceptional organizations minimize their headcount so everyone gets paid more. Nothing surprising here. And so, we kind of see that quant finance shops always need new talent, because people flame out or retire, but not nearly as much talent as _elite_ institutions produce. From personal conversations, it feels like >50% of computer science, statistics, math, and physics Ph.Ds. have considered quant finance. 

# The Mismatch

There's a mismatch here. Lot's of highly intelligent, credentialed people that could probably do these jobs, not many jobs because the firms are massively scalable. Citadel Securities reports they account for 26% of all US equities volume with ~1400 employees [^4]. The larger quant hedge funds have less than 1k employees, and Renaissance famously employs like what, 300 people? Quant finance is just software and finance IP - these firms don't produce tangible goods and stay lean to maximize profitability. And worse, more market participants means more efficient markets - i.e. less alpha. Again, un-cited, but this why IP is so closely guarded at these firms. Strategies disappear as soon as other market participants can execute the same strategy. It's reductive, but I just think of all these guys as alpha miners. Finite amount of gold on Earth, finite amount of alpha in the markets. Unless we could just create more markets....

# Cryptocurrencies = Infinite "Amateur Golden Windows"

So here you go: I think below the surface, some of the demand for crypto is just masked demand for new markets. We need crypto because we need more markets. We need more markets because there are a lot of smart people who want to correlate their earnings with their intelligence. Alpha decreases monotonically in existing markets, so the solution is new markets. Cryptocurrencies present an _elegant_ way to create new FX instruments.

__Q__: What's a challenge with FX trading from the growth perspective?<br/>
__A__: Currencies are 1:1 with nation-states, and the world isn't getting any new nation-states. 
<br/><br/>
__Q__: But why can't we make money trading traditional FX?<br/>
__A__: You _can_ make money, but there's a difference between betting on directions/movements (gambling) and systematic trading. FX is the largest and most liquid market in the world. With so many market participants and massive liquidity, you can bet it's pretty goddamn difficult to find alpha, let alone arbitrages.
<br/><br/>
__Q__: So what makes crypto different?<br/>
__A__: From one perspective, nothing. Every new cryptocurrency just creates _N_ new currency pairs with _N_ existing currencies. But because the cryptos have different flavors / features / auto-generated copy, you get weird cross currency dynamics. __Figuring out weird market dynamics with algorithms is mining alpha__.
<br/><br/>
__Q__: Couldn't we create markets with other asset classes?<br/>
__A__: Of course, but isn't it easier to go with something where you just click a button and a new instrument springs into existence globally?
<br/><br/>
__Q__: So how is this a solution for people who don't already work professionally in _traditional_ quantitative finance?<br/>
__A__: There's a __golden window of time__ before trading volume draws in professionals where amateurs can rediscover existing strategies and apply them new instruments. You can bet that as $t \rightarrow \infty$, the big HFT shops will deploy the same cross-exchange latency arbitrage strategies they use now, but those strategies either can't be guaranteed to work or aren't worth the cost to deploy until:
1. Instrument trading volumes are large
2. Market data infrastructure is stable
3. There is enough market data to backtest new strategies

To hammer it home, cryptocurrencies are in one way valuable because they provide an __infinite number of golden windows__ for amateurs to exploit before volumes draw in bigger players. By the time bigger players enter the market, some kid can hit a button and create a new market on an existing blockchain, or a group of engineers can write a new blockchain. Rinse and repeat. Your smart friends can trade crypto and conceivably make money that isn't just random gambling. Larger quant finance institutions support this because they get to deploy large-scale / high-volume strategies and take the alpha if any cryptocurrencies become widely successful (e.g. Bitcoin, Ether). Are cryptocurrencies "good"? Unlikely. Are cryptocurrencies valuable? They are if people value them. 

[^1]: I mean this in the most self-deprecating way possible, it's just faster than writing "Ivy League + all the elite technical schools, elite state schools, honors programs at state schools, anyone who worked hard at any educational institution, and brilliant people who took alternative paths".

[^2]: ...relative to other college educated persons. The earnings gap by education level is well demonstrated in economics literature.

[^3]: To save some time I'm going to lump all quantitative finance into a bucket, but yes, the field has many sub-disciplines: HFT, prop trading shops, quant hedge funds, quant groups at bulge brackets, etc. 

[^4]: https://www.citadelsecurities.com/products/equities-and-options/