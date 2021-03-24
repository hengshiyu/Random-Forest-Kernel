# Random Forest Kernel: Nonparametric Predition of Kernel Causal Effects
Hengshi Yu


## Introduction

Causal effects:

1. Counterfactual/potential outcome assumptions ```math Y^{a}```:
	- Outcome invariant to the treatment assignment (exchangeability). 
	- Equal to the observed outcome $Y$ under that treatment (consistency). 
	- Could be observed in population (positivity). 

2. Marginal causal effect $\mathbb{E}(Y^{a = 1}) - \mathbb{E}(Y^{a = 1})$ via inference on $\mathbb{E}(Y\mid A = 1) - \mathbb{E}(Y\mid A = 0)$


Motivation:

1. Treatment on continuous scale, like dose of medicine. 
2. Treatment is a combination, rather than a simple variable
3. Causal effect depends on the treatment values. 

How to estimate the marginal causal effects in longitudinal data under specific continuous treatment value $(A_1 = a_1, \ldots, A_K = a_K)$, when the causal effect depends on the treatment value?


<img align="center" src="imgs/Q-learning.png" width="600">

## Markov decision process and Q learning
Based on the Markov decision process, we have:  
<img align="center" src="imgs/MDP.png" width="600">

The Q learning for DTR typically assumes a deterministic policy. We extend the deterministic DTR/policy to be a stochastic policy and we then have

<img align="center" src="imgs/StoQ-Learning.png" width="600">


## Stochastic Q Learning for DTR


<img align="center" src="imgs/StoQLearningAlgo.png" width="600">

## Run experiments
```
Rscript run.R
```

## Some Results
We have the average lengths of confidence intervals.

<img align="center" src="imgs/averageCI.png" width="800">