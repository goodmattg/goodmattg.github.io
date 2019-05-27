---
layout: post
title: "Relational Inductive Biases: a manifesto"
excerpt: DeepMind, Google Brain, MIT, and University of Edinburgh collaborators produce a manifesto on graph networks
categories: ["Deep Learning", "Graph Neural Networks (GN)"]
comments: true
---

The authors present a succinct and powerful manifesto of the importance of graph networks in artificial intelligence research. The paper is a move to synthesize the previously disjoint field of graph neural networks into a single framework: "Graph Networks (GN)".

FIGURE HERE

## Notes

- prioritize "combinatorial generalization", the ability to generate new inferences, predictions, and behaviors from know building blocks 
    - i.e. _putting the pieces together_
- combinatorial generalization is the goal, so we should bias towards learning on structured representations and computations
    - Generalizing on structured representations is easier than generalizing on unstructured representations
- The world is _compositional_, therefore our methods should be compositional
    - This does not mean we mean to trade off structure for flexibility. We consider the concepts jointly (i.e. nature _and_ nurture)
- Graph neural networks (GNs) exemplify this functional ambition by learning relations between "explicitly structured data"
    - learning $\rightarrow$ flexible
    - structured $\rightarrow$ composing known building blocks
- GN methods contain strong __relational inductive biases__
    1) Relational reasoning
        - _structure_ is composing a set of known building blocks
        - _structured representation_ describe this composition
        - structured representations consist of _entities_ connected by _relations_ according to _rules_
            - _entity_ is an element with attributes
            - _relation_ is a property between entities
            - _rule_ is a function that maps discrete pairs of entity-relations
        - _relational reasoning_ involves manipulating structured representations
    2) Inductive biases
        - An _inductive bias_ allows a learning algorithm to prioritize one solution over another, independent of the observed data.
            - E.g. prior in Bayesian statistics, regularization terms, algorithm architecture, composition of layers in NN, etc.
    3) __Relational Inductive Biases__
        - "Inductive biases which impose constraints on relationships and interactions among entities in a learning process"
- _Graph Networks_ (GN)
    - $G = (u, V, E)$
        - __u__: Global attribute
        - __V__ is the set of nodes w/ cardinality $N^v$ where each node $v_i$ has attributes
        - __E__ is the set of edges w/ cardinality $N^e$ where each edge $e_v$ has attributes. $E = \{(e_k,r_k,s_k)\}_{k=1:N^{e}}$
            - $e_k$ is the edge's attribute
            - $r_k$ is the index of the receiver node
            - $s_k$ is the index of the sender node
    - GN _block_ := $f: G \rightarrow G$
        - GN block algorithm
            1) Compute updated edge attributes: $e_k^{'} = \phi^e(e_k,v_{r_k},v_{s_k},u)$
            2) Aggregate edge attributes per node: $\bar{e}_i^{'} = \rho^{e \rightarrow v}(E_i^{'})$
            3) Compute updated node attributes: $v_i^{'} = \phi^v(\bar{e}_i^{'}, v_i, u)$
            4) Aggregate edge attributes globally: $\bar{e}^{'} = \rho^{e \rightarrow u}(E^{'})$
            5) Aggregate node attributes globally: $\bar{v}_i^{'} = \rho^{v \rightarrow u}(V^{'})$
            6) Compute updated global attribute: $u^{'} = \phi^u(\bar{e}^{'}, \bar{v}^{'}, u)$
        - TLDR
            - Update functions: $\phi$
                - SOA use NN as update function ($NN_e, NN_v, NN_u$)
                - Can include RNN as $\phi$, but this is not in literature yet
            - Aggregation functions: $\rho$
    - Relational inductive biases in GN
        - arbitrary relationships among entities. i.e. the GN architecture doesn't determine how entities interact.
        - GN are invariant to ordering on input (b/c input is graph, and graph represented as set)
        - update/aggregation functions are reused implying combinatorial generalization



> We suggest that a key path forward for modern AI is to commit to combinatorial generalization as a top priority. 


# Thoughts 

> When learning, we either fit new knowledge into our existing structured representations, or adjust the structure itself to better accommodate (and make use of) the new and the old. 

My initial reading of this yielded the natural extension that we should be applying reinforcement learning to structured representation. 

FIGURE SHOWING GN, DRN, ETC

@misc{battaglia2018relational,
    title={Relational inductive biases, deep learning, and graph networks},
    author={Peter W. Battaglia and Jessica B. Hamrick and Victor Bapst and Alvaro Sanchez-Gonzalez and Vinicius Zambaldi and Mateusz Malinowski and Andrea Tacchetti and David Raposo and Adam Santoro and Ryan Faulkner and Caglar Gulcehre and Francis Song and Andrew Ballard and Justin Gilmer and George Dahl and Ashish Vaswani and Kelsey Allen and Charles Nash and Victoria Langston and Chris Dyer and Nicolas Heess and Daan Wierstra and Pushmeet Kohli and Matt Botvinick and Oriol Vinyals and Yujia Li and Razvan Pascanu},
    year={2018},
    eprint={1806.01261},
    archivePrefix={arXiv},
    primaryClass={cs.LG}
}

