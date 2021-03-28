+++
title = "Syntactic Tree Kernels"
date = "2017-09-04"
description = "The problem is deviously simple - given two input questions, tell whether the questions ask the same thing (i.e. seek to reveal the same previously unknown knowledge)."
categories = ["ML", "NLP", "kernels", "Kaggle"]
comments = true
+++

# Syntactic Tree Kernels

## Motivation

This post encapsulates the work I did with Dean Fulgoni for our final project in Big Data Analytics. Credit to Professor Chris Callison-Burch for steering me away from some topics that "could easily be Phd theses" and to Professor Zachary Ives for being an excellent teacher.

## The Problem We Tried to Solve

 The problem is deviously simple - given two input questions, tell whether the questions ask the same thing (i.e. seek to reveal the same previously unknown knowledge). Not to get off track, but this begs some thought on the nature of what a question is and whether a question is separable from its posed context. See the [Stanford Encyclopedia of Philosophy (SEP)][^1] for an excellent review of the philosophy of questions. I won't be discussing it in detail, but my view on this problem is colored by the philosophical understanding of questions. We can assume that questions on Quora are requesting information,  not testing the knowledge of the user base.

 > ... a question [is] an abstract thing for which an interrogative sentence is a piece of notation. (Belnap and Steel, 1976)

 The challenge was posed as a supervised learning question with a human labeled training set. A cursory glance at the training set showed that the human labeling was inconsistent, with varying standards to classify questions as semantically the same.

These were labeled as asking two different questions:

- Do we need smart cities or smart politicians?
- Do we need smart cities or smart laws?

We can see that the classification of this pair is debatable. Politicians are not laws. However, politicians are the only people with the power to make laws. Where is the line drawn for semantic similarity? How do we even approach situations where the the map between language and abstract meaning is complex?

$$
\begin{aligned}
    Politician &\ne Law \cr
    \\\\ Politician &\rightarrow Law \cr
\end{aligned}
$$

With an unclear standard for determining whether two questions had the same intent, we decided to approach the problem 'loosely'. Overfitting in any specific approach would kill our performance on the test set. We partitioned the feature set into **syntactic features** and **semantic features**. I'll touch on semantic features later, but I decided to focus on syntactic features because it was much lower hanging fruit. The question became how to quantify the syntactic similarity of two sentences.

$$ f: (sentence_1, sentence_2) \rightarrow s \in [0,1] $$

I'll save the complete literature review for a separate post. We chose to use Tree Kernels championed by Prof. Alessandro Moschitti of the University of Trento, Italy because of the elegance of the theoretical basis.

## Syntactic Tree Kernel Theory

As part of our search for unique features to encode syntactic and semantic similarity, we found that so called Tree Kernels had been shown to be highly effective in augmenting SVMs designed to solve problems in question classification, question answering, Semantic Role Labeling, and named entity recognition. The broad idea behind the theory is that syntactic features must be quantified to learn semantic structures. It isn't enough to say, compare lists of POS tags for two sentences because the structure of the sentences shape their meanings. We therefore design kernels that map from tree structures (e.g. constituency parse trees) to scores that measure the syntactic similarity of the two trees. Note that these scores are bounded for use in an SVM framework, but could easily be used as features in a deep learning framework.

### Kernel Definition

*The next few section are taken almost verbatim from Moschitti's ACL 2012 tutorial on State-of-the-art Kernels in Natural Language Processing. All credit goes to him and his colleagues.*

The point of the following math is that we can ensure our SVM kernel is valid only if the matrix of transformed points is positive semi-definite. You can review the literature for the proof.

A **kernel** is a function:

$$ k: (\overrightarrow{x},\overrightarrow{z}) \rightarrow \Phi(\overrightarrow{x}) \cdot \Phi(\overrightarrow{z}) ~~~~~~\forall \overrightarrow{x}, \overrightarrow{z} \in X$$


Mercer's Conditions for a valid kernel:

Let $X$ be a finite input space and let $K(x,z)$ be a symmetric function on $X$. Then $K(x,z)$ is a kernel function IFF matrix:

$$ k(x,z) = \Phi(x) \cdot \Phi(z)$$

is positive semi-definite (non-negative eigenvalues). That is, if the matrix is positive semi-definite we can find a $\Phi$ that implements the kernel function $k$.


## Tree Definition

We worked exclusively with **constituency parse trees**. Anywhere I write "tree", I am referring to a constituency parse tree. A constituency parse tree breaks down a sentence into phrases using a well-defined, **context-free**, phrase structure grammar. A context-free grammar is a set of rules that describes all possible strings in a formal language. Given any sentence, we have a formal way to define that sentence as made up of phrases, nouns, verbs, etc. Noam Chomsky was the first define context-free grammars in linguistics to describe the universal structure of natural language. We use the Penn-Treebank II formal grammar for this project. Here is a small sample of the Penn-Treebank II formal grammar:

- **RB**: Adverb
- **IN**: Preposition
- **PP**: Prepositional Phrase
- **VP**: Verb Phrase

Below is an example of a constituency parse tree for the sentence:

> I will never stop learning.

Notice that sentence tokens (the words) are always leaves of the tree and in their natural language order. That is, we should always be able to read the tree leaves from left to right and have our exact sentence.

![Constituency Parse Tree](/assets/posts/TreeKernel/ConstituencyTree.jpg)


### Tree Kernel Core Theory and Definitions

A tree kernel is a function: $f: (tree_1, tree_2) \rightarrow \mathbf{R}^+ $

A tree is defined recursively as a set of nodes, each of which has a value and a set of children, each of which are trees. A node is a "leaf" if it has no children. A node is "pre-terminal" if all of its child nodes are leaves. The "production" of a node is the subtree containing the node and its children. The production of two nodes are the same if the nodes have the same value and their children have the same value. Because we work are working with ordered trees, the children must have the same values in the same order to be part of the same production.

Key to the effectiveness of tree kernel features in solving problems is the choice of tree structure. Moschitti shows that different tree kernels are effective for different choices of syntax trees in solving different classes of problems. We used Stanford NLP to generate parse trees from the input sentences. A parse tree is an ordered tree that represents the syntax of a sentence according to some context-free grammar. There are two main classes of parse trees: constituency and dependency. A dependency parse trees is the tree structure generated by the dependencies of a sentence. While dependencies can be highly useful in generating features, as described in Section 4.1, Moschitti found that constituency parse trees were most effective in solving classification related problems. A constituency parse tree breaks down the tokens of sentence into their constituent grammars.

### Syntactic Tree Kernel or "Collins-Duffy" (STK)

For our tree kernel features we only implemented the Collins-Duffy tree kernel. The general idea of the Collins-Duffy Tree Kernel is that we want to compare the number of common subtrees between two input trees. The naive approach in exponential time is to enumerate all possible subtrees of the two input trees and then perform the dot-product. Obviously generating every subtree of each sentence, and then taking the dot-product of all of the subtrees to find how many the two sentences have in common would be a computationally nightmarish $O(n^2)$. We can take advantage of the fact that generating subtrees is recursive, and that if two parent nodes do not match, the subtrees rooted at those two nodes do not match. Collins and Duffy propose the following derivation.

Define the tree kernel $K: f(T_1,T_2) \rightarrow \mathbf{R}^+$ where $T_1$ and $T_2$ are well-formed trees. The dot-product approach above is written:

$$K(T_1,T_2) = h(T_1) \cdot h(T_2)$$

Where $h$ is a function that produces all of the subtrees of a tree. Again, the dot-product between $h(T_1)$ and $h(T_2)$ will count all of the subtrees $T_1$ and $T_2$ have in common. They define the indicator function $I_i(n)$ to be 1 if the subtree $i$ is rooted at node $n$ and 0 otherwise. Therefore, we can rewrite the dot-product above.

$$
\begin{aligned}
h(T_1) \cdot h(T_2) &= \sum_i h_i(T_1)h_i(T_2)
    \\\\ & = \sum_{n_1 \in N_1}\sum_{n_2 \in N_2} \sum_i I_i(n_1) I_i(n_2)
    \\\\ & = \sum_{n_1 \in N_1}\sum_{n_2 \in N_2} C(n_1, n_2)
\end{aligned}
$$

Where $C(n_1,n_2)$ is defined as $\sum_i I_i(n_1)I_i(n_2)$. We note that $C(n_1, n_2)$ can be computed recursively in polynomial time:

$C(n_1,n_2) = 0$ if the productions at $n_1$ and $n_2$ are different.

$C(n_1,n_2) = \lambda$ if the productions at $n_1$ and $n_2$ are the same and $n_1$ and $n_2$ are pre-terminal.

$$C(n_1,n_2) = \lambda \prod_{j=1}^{nc(n_1)}(\sigma + C(ch(n_1,j),ch(n_2,j)))$$

Where $0 < \lambda \leq 1$ is a factor that down weights subtrees exponentially with their size, $nc(n_i)$ returns the number of children of node $i$, binary variable $\sigma \in {0,1}$ determines whether we use the ST or SST kernel, and $ch(n_i,j)$ selects the $j$th child of node $i$. The ST or subtree kernel is where $\sigma = 0$. For the ST kernel, the entire subtree must match to return a non-zero score. The SST or subset tree kernel is where $\sigma = 1$. For the SST kernel, non-zero scores can be achieved even if all of the subtrees of two nodes do not match.

The distinction between the ST and SST kernels in the previous section is that the SST kernel is more forgiving than the ST kernel. The SST kernel can still return high scores even if the exact sentences are not the same. Likewise, the ST kernel heavily penalizes minor differences between constituency trees. The factor $\lambda$ can be viewed as a penalty we utilize so that kernel does not over-inflate the importance of matches between larger subtrees. These parameters become less important when we normalize the kernel score using:

$$K_{norm}(T_1,T_2) = \frac{K(T_1,T_2)}{K(T_1,T_1)K(T_2,T_2)}



We generated features with the ST and SST tree kernels for each question pair using $\lambda \in \{1, 0.8, 0.5, 0.2, 0.1, 0.05, 0.2\}$ totaling 14 tree kernel features. Determining the optimal $\lambda$ for this task would be a good exploration on its own.


## Synactic Tree Kernels in Python

As far as I know, this is the first implementation of syntactic tree kernels in Python. This code may eventually move to its own maintained repository if it's needed. If you find any bugs please reach out to me. Dr. Moschitti's cited implementation is:

[SVM-Light][^2] written by Thorsten Joachims in C. His implementation is most-likely faster (no comparison benchmark yet). My implementation is however easier to grasp and is isolated from a complete SVM library.

### Building the Parse Tree

As described in the Pipeline section we used Stanford CoreNLP to generate our constituency parse trees. There aren't many libraries that are good for constituency parsing, and CoreNLP is by far the most stable and customizable. Oddly enough, Stanford CoreNLP will print a constituency parse tree for a given sentence with well-defined structure to console (i.e. pretty print), but provides no functionality to store the tree in a reasonable format (linked list, hashmap, etc. ). The code in this subsection is available on my [Github][^3] and is used to take the raw text output of Stanford CoreNLP and store in the schema below for tree kernel computation. We label each token with an Id and store the tokens for fast computation, but admittedly poor space complexity.

- curid:&emsp;&emsp;&emsp;&nbsp;*Integer*
- parid:&emsp;&emsp;&emsp;&nbsp;*Integer*
- posOrTok:&emsp;&nbsp;*String*
- indent:&emsp;&emsp;&ensp;&nbsp;*Integer*
- children:&emsp;&nbsp;&ensp;&nbsp;*[Integer]*
- childrenTok:&nbsp;&nbsp;*[String]*



### Computing Tree Kernels


```python {linenos=table}


import numpy as np
import math
from nltk.corpus import wordnet as wn

'''
Helper Methods
'''
def _isLeaf_(tree, parentNode):
    return (len(tree[parentNode]['children']) == 0)

def _isPreterminal_(tree, parentNode):
    for idx in tree[parentNode]['children']:
        if not _isLeaf_(tree, idx):
            return False
    return True

'''
Implementation of the Colins-Duffy or Subset-Tree (SST) Kernel
'''

def _cdHelper_(tree1, tree2, node1, node2, store, lam, SST_ON):
    # No duplicate computations
    if store[node1, node2] >= 0:
        return

    # Leaves yield similarity score by definition
    if (_isLeaf_(tree1, node1) or _isLeaf_(tree2, node2)):
        store[node1, node2] = 0
        return

    # same parent node
    if tree1[node1]['posOrTok'] == tree2[node2]['posOrTok']:
        # same children tokens
        if tree1[node1]['childrenTok'] == tree2[node2]['childrenTok']:
            # Check if both nodes are pre-terminal
            if _isPreterminal_(tree1, node1) and _isPreterminal_(tree2, node2):
                store[node1, node2] = lam
                return
            # Not pre-terminal. Recurse among the children of both token trees.
            else:
                nChildren = len(tree1[node1]['children'])

                runningTotal = None
                for idx in range(nChildren):
                     # index ->  node_id
                    tmp_n1 = tree1[node1]['children'][idx]
                    tmp_n2 = tree2[node2]['children'][idx]
                    # Recursively run helper
                    _cdHelper_(tree1, tree2, tmp_n1, tmp_n2, store, lam, SST_ON)
                    # Set the initial value for the layer. Else multiplicative product.
                    if (runningTotal == None):
                        runningTotal = SST_ON + store[tmp_n1, tmp_n2]
                    else:
                        runningTotal *= (SST_ON + store[tmp_n1, tmp_n2])

                store[node1, node2] = lam * runningTotal
                return
        else:
            store[node1, node2] = 0
    else: # parent nodes are different
        store[node1, node2] = 0
        return


def _cdKernel_(tree1, tree2, lam, SST_ON):
    # Fill the initial state of the store
    store = np.empty((len(tree1), len(tree2)))
    store.fill(-1)
    # O(N^2) to compute the tree dot product
    for i in range(len(tree1)):
        for j in range(len(tree2)):
            _cdHelper_(tree1, tree2, i, j, store, lam, SST_ON)

    return store.sum()

'''
Returns a tuple w/ format: (raw, normalized)
If NORMALIZE_FLAG set to False, tuple[1] = -1
'''
def _CollinsDuffy_(tree1, tree2, lam, NORMALIZE_FLAG, SST_ON):
    raw_score = _cdKernel_(tree1, tree2, lam, SST_ON)
    if (NORMALIZE_FLAG):
        t1_score = _cdKernel_(tree1, tree1, lam, SST_ON)
        t2_score = _cdKernel_(tree2, tree2, lam, SST_ON)
        return (raw_score,(raw_score / math.sqrt(t1_score * t2_score)))
    else:
        return (raw_score,-1)


'''
Implementation of the Partial Tree Kernel (PTK) from:
"Efficient Convolution Kernels for Dependency and Constituent Syntactic Trees"
by Alessandro Moschitti
'''

'''
The delta function is stolen from the Collins-Duffy kernel
'''

def _deltaP_(tree1, tree2, seq1, seq2, store, lam, mu, p):

#     # Enumerate subsequences of length p+1 for each child set
    if p == 0:
        return 0
    else:
        # generate delta(a,b)
        _delta_(tree1, tree2, seq1[-1], seq2[-1], store, lam, mu)
        if store[seq1[-1], seq2[-1]] == 0:
            return 0
        else:
            runningTot = 0
            for i in range(p-1, len(seq1)-1):
                for r in range(p-1, len(seq2)-1):
                    scaleFactor = pow(lam, len(seq1[:-1])-i+len(seq2[:-1])-r)
                    dp = _deltaP_(tree1, tree2, seq1[:i], seq2[:r], store, lam, mu, p-1)
                    runningTot += (scaleFactor * dp)
            return runningTot

def _delta_(tree1, tree2, node1, node2, store, lam, mu):
#     print("Evaluating Delta: (%d,%d)" % (node1, node2))

    # No duplicate computations
    if store[node1, node2] >= 0:
        return

    # Leaves yield similarity score by definition
    if (_isLeaf_(tree1, node1) or _isLeaf_(tree2, node2)):
        store[node1, node2] = 0
        return

    # same parent node
    if tree1[node1]['posOrTok'] == tree2[node2]['posOrTok']:

        if _isPreterminal_(tree1, node1) and _isPreterminal_(tree2, node2):
            if tree1[node1]['childrenTok'] == tree2[node2]['childrenTok']:
                store[node1, node2] = lam
            else:
                store[node1, node2] = 0
            return

        else:
            # establishes p_max
            childmin = min(len(tree1[node1]['children']), len(tree2[node2]['children']))
            deltaTot = 0
            for p in range(1,childmin+1):
                # compute delta_p
                deltaTot += _deltaP_(tree1, tree2,
                                     tree1[node1]['children'],
                                     tree2[node2]['children'], store, lam, mu, p)

            store[node1, node2] = mu * (pow(lam,2) + deltaTot)
            return

    else:
        # parent nodes are different
        store[node1, node2] = 0
        return

def _ptKernel_(tree1, tree2, lam, mu):
    # Fill the initial state of the store
    store = np.empty((len(tree1), len(tree2)))
    store.fill(-1)

    # O(N^2) to compute the tree dot product
    for i in range(len(tree1)):
        for j in range(len(tree2)):
            _delta_(tree1, tree2, i, j, store, lam, mu)

    return store.sum()

'''
Returns a tuple w/ format: (raw, normalized)
If NORMALIZE_FLAG set to False, tuple[1] = -1
'''
def _MoschittiPT_(tree1, tree2, lam, mu, NORMALIZE_FLAG):
    raw_score = _ptKernel_(tree1, tree2, lam, mu)
    if (NORMALIZE_FLAG):
        t1_score = _ptKernel_(tree1, tree1, lam, mu)
        t2_score = _ptKernel_(tree2, tree2, lam, mu)
        return (raw_score,(raw_core / math.sqrt(t1_score * t2_score)))
    else:
        return (raw_score,-1)


```

## Towards Syntactic-Semantic Tree Kernels

Ignoring all of the theory and code in the previous sections would not be unreasonable. The major criticism of ST and PTK kernels is that they are syntactic, and syntax is not meaning. A simple example:

1. The girl went to the store to buy __eggs__ for the family.
2. The girl went to the store to buy __milk__ for the family.

The sentences generate the same constituency parse tree (minus) the differing terminal leaf, but have completely different meanings. Put plainly, the sentences above are grammatically the same except for the one word difference. However, the SST kernel we implemented above would give a very high similarity score for the **meaning** of the two sentences even though we know that they have different meanings. Bloehdorn and Moschitti propose a theoretically elegant modification to solve our problem. This new syntactic-semantic tree kernel (**SSTK**) is defined as:

$$ K_{SSTK} = comp(f_1, f_2) \prod_{t=1}^{nt_{(f1)}} SIM(f_1(t),f_2(t)) $$

where $comp(f_1, f_2)$ is $1$ if $f_1$ differs from $f_2$ only in the terminal nodes and 0 otherwise, $nt(f_i)$ is the number of terminal nodes and $f_i(t)$ is the t-th terminal symbol of $f_i$ numbered from left to right, and $SIM$ is a function returning $[0, 1]$ where $0$ is completely different, and $1$ means the words are identical in meaning.

Now in plain English. If the two tree fragments don't have the same non-terminal structure then we end the computation early. The SSTK is the same as PTK and SST in that it ignores tree fragments that are not **identical** in syntactic structure (grammar). Say the two tree fragments have the same non-terminal structure, but different terminal nodes (leaves). This means the two sentence structures have the same syntax but different words. So our indicator function $comp(f_1, f_2)$ returns 1, and we compute the multiplicative product by computing the similarity of each in-order pair of terminal leaves.

This is where it gets admittedly ridiculous. How exactly do we quantify the semantic similarity of two words. Doesn't this depend on the sentence context? This is where there is no good answer yet. There are computational kernels that give similarity metrics on word databases like WordNet, but we don't have significant evidence on which is best for different classes of problems. Our implementation used the raw score returned by WordNet, but that isn't very interesting.

## Lesson Learned, Hardly Earned

Research tools like StanfordCoreNLP are not performant. Most my time was spent building tooling, testing my implementations of paper algorithms, running batch jobs on AWS instances, debugging the batch processing jobs on AWS, and questioning my sanity for embarking on this rabbit hole.

## If We Only Had More Time

I would have worked on:

[1] Reworking this kernel as a feature generator in a deep learning approach. Consider that the behavior of this entire field is based around using these as a mathematically valid kernel in an SVM. Deep learning has showed greater promise in solving these types of problems because the neural network structure is more adaptable.

[2] Grammars: A Google Trends search shows >85% Quora’s user base can be divided as living on the Indian subcontinent and the United States, yet English is almost exclusively the only language used to ask/answer questions. This matters because we should not expect perfect English grammar from people whose first language isn’t English. Any effective model should detect common misuses of English grammar specific to users from the Indian subcontinent and subsequently "loosen". Note that this is different from detecting common colloquial expressions or slang that native English speakers use.

[3] More work on incorporating different word similarity databases into the SSTK kernel. This could be anything from Wordnet, to scraped data from forums, to the paraphrase database (PPDB) at UPenn.

[4] Using different metrics for WordNet semantic similarities like Resnik, Wu & Palmer, or Lin.

### Links

[^1]: https://plato.stanford.edu/entries/questions/.
[^2]: http://svmlight.joachims.org/
[^3]: https://github.com/goodmattg/quora_kaggle/blob/master/TreeBuild.py

