+++
date = 2018-09-09
title = "Software Sharing in Medical Research"
description = "I was reading Mohammed AlQuraishi's [post][1] \"AlphaFold @ CASP13: What just happened?\" recently about DeepMind's advance in protein folding. His point about research siloing holding the whole field back resonated with me in light of my current work identifying malignant tumors in ultrasound images."
categories = ["thoughts"]
comments = true
+++

# Software Sharing in Medical Research

I was reading Mohammed AlQuraishi's post[^1] "AlphaFold @ CASP13: What just happened?" recently about DeepMind's advance in protein folding. His point about research siloing holding the whole field back resonated with me in light of my current work identifying malignant tumors in ultrasound images. To put it bluntly, it isn't helpful that I can quickly find ten good papers claiming state-of-the-art performance on tumor segmentation if I can't quickly download and verify the model performance on a non-toy dataset. In my view, a toy dataset is a dataset that doesn't reflect the enumerable subtleties of real-world data. I.e. a dataset filtered to remove weird edge-cases, complex low probability situations, and messy inputs. As an aside, modern tumor ultrasound datasets are laughably perfect. They are all ~100 samples of perfectly cropped tumors with contiguous inner regions and no artefacts that would reflect rare conditions a radiologist would be trained to identify.

> As I discussed earlier, it is clear that between the Xu and Zhang groups enough was known to develop a system that would have perhaps rivaled AlphaFold. But because of the siloed nature of the field, it only gets a “gradient update” once every two years. Academic groups are thus forced to independently rediscover the wheel over and over. In DeepMind’s case, even though the team was small in comparison to the total headcount wof academic groups, they were presumably able to share information on a very regular basis, and this surely contributed to their success.

I can relate. There is a recent paper from a major medical research center that claims best-in-class performance on the tumor segmentation problem. A cursory reading yields that the best-in-class performance is probably legitimate and would extend well to my current work. The code is not publicly available and the research team immediately rejected my request to collaborate. In all fairness, I don't know why they are hesitant to collaborate; there could be IP concerns related to grant providers, or it could be a plain desire to maintain competitive advantage. My place is not to ask why, but this does put my work in a tough position.

I am building a complex system consisting of multiple sub-components for my current work. These components include but are not limited to: frame OCR, frame scale normalization, tumor segmentation, tumor diagnosis, etc. For the final product to exceed expectations, every component needs to operate with extremely high performance. So while I know there's a universe of segmentation algorithms out there, one of which probably _does_ have amazing performance invariant to the heterogeneity of lesion interior, I can't slot in any of these systems without re-implementing them myself, and I can't rigorously determine which system to slot in because that would require verification on our real-world dataset. So I'm suddenly forced to make decisions about time to payoff, ease of implementation, and verifiability of a crude implementation. I ended up going with a brute-force style approach simply because it's the only thing that I could both quickly implement myself and verify correctness. 

You would think by now that these building blocks would be readily available within the research community, but they aren't. It's a self-enforced barrier to entry that we should work hard to tear down. It is also worth noting that DeepMind[^2] is looking into the mammography problem as well.

[^1]: https://moalquraishi.wordpress.com/2018/12/09/alphafold-casp13-what-just-happened/

[^2]: https://deepmind.com/blog/applying-machine-learning-mammography/