# MultiPhaseAnalysisAndTaxonomy

A repository for analysis of operating regimes and setpoints of five-phase machines. We generalize the well-known classification for three-phase systems:

- MTPA (maximum torque per ampere): operation of the machine without any active constraint.
- FW (field weakening): operation region of the machine with active voltage constraint.

Due to the interplay of the third and fifth harmonics, we propose a richer taxonomy, where each of the region takes two indices, where the first one denotes the number of active constraints on current and the other one the number of active constraint on voltage.

![](https://github.com/AI-RICE/CurrentSetpoints5f/raw/main/docs/resources/Torque_speed_machine2.png)

![](https://github.com/AI-RICE/CurrentSetpoints5f/raw/main/docs/resources/Torque_speed_detail_machine2.png)

Details are provided in our [paper](). This repository provides a way to recreate the results from the paper.

## Using this repository

Run `main_regimes.m` and subsequently `main_boundary.m` to plot the operating regimes and the (smoothened) boundaries between them. The code should work for other machines, some are provided in the Initialization folder. The codes contain the following parameters:

- `IPM`: the parameters of the machines.
- `Vnonrot`: whether the zero-sequence component should be considered or fixed to zero.
- `calc_opt.n_T`: number of discretization points for the torque.
- `calc_opt.n_om`: number of discretization points for the rotations.

## Citation

If you like this work, please cite our paper:

```

```