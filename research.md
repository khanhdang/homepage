---
layout: page-toc
title:  Research
---
<!-- # Research topics -->
<!-- # Current  research -->

## Neuromorphic Computing
<!-- : [>> more detail](./research_topics/neuromorphic) -->


We develop hardware for neuromorphic computing that mimics the behavior of biological brains. Here, the main target is to port the silicon brains into ASIC/FPGA and train them with bio-plausible learning approaches. The hardware platform is based on Leaky-Integrate-and-Fire neuron with online STDP learning and possible off-line ANN-SNN conversion.

{::nomarkdown}
<img src="../images/research_topics/neuromorphic/thumb.svg" class="icenter" width=100%>
{:/}

The hardware is based on CMOS technology with 3D-ICs using Through-Silicon-Vias. Neurons are grouped into clusters that connected via a 3D Network-on-Chip. Inter-layer wires are Through-Silicon-Vias.

Selected publications:

1.  **Khanh N. Dang**, Nguyen Anh Vu Doan, Abderazek Ben Abdallah *"MigSpike: A Migration Based Algorithm and Architecture for Scalable Robust Neuromorphic Systems"*,  **IEEE Transactions on Emerging Topics in Computing (TETC)**, IEEE, <button type="button" class="btn-sm btn-success">accepted</button>
1. Abderazek Ben Abdallah, **Khanh N. Dang**, *"Towards Robust Cognitive 3D Brain-inspired Cross-paradigm System"*, **Frontiers in Neuroscience**, Frontiers, Volume 15, pp. 795, 2021. \[[DOI: 10.3389/fnins.2021.690208](https://doi.org/10.3389/fnins.2021.690208)\]/\[[PDF](./share/pubs/FNINS-2021.pdf)\].
1. Ogbodo Mark Ikechukwu, **Khanh N. Dang** and Abderazek Ben. Abdallah, *"Energy-efficient Spike-based Scalable Architecture for Next-generation Cognitive AI Computing Systems"* Springer Lecture  Note in Computer Science (LNCS), **International Symposium on Ubiquitous Networking 2021 (UNET21)**, May 19 – May 22, 2021, Marakesh, Morocco. <a role="button" href="/2021/05/22/Best_Paper_Award_Unet.html" class="btn btn-outline-success btn-sm">Best Student Paper Award</a>
1. Mark Ogbodo, **Khanh N. Dang**,  Abderazek Ben Abdallah,  *"On the Design of a  Fault-tolerant Scalable Three Dimensional NoC-based  Digital Neuromorphic System with On-chip Learning"*, **IEEE Access**, IEEE, Volume 9, pp 64331 - 64345, 2021. \[[DOI](https://doi.org/10.1109/ACCESS.2021.3071089)\]/\[[PDF](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=9395458)\].
1. Duy-Anh Nguyen, Xuan-Tu Tran, **Khanh N. Dang**, and Francesca Iacopi,  *"A lightweight Max-Pooling method and architecture for Deep Spiking Convolutional Neural Networks"*,  **2020 IEEE Asia Pacific Conference on Circuits and Systems (APCCAS)**, Dec. 8-10, 2020.
1. Mark Ogbodo, The Vu, **Khanh N. Dang** and Abderazek Abdallah, *"Light-weight Spiking Neuron Processing Core for Large-scale 3D-NoC based Spiking Neural Network Processing Systems"*, **2020 IEEE International Conference on Big Data and Smart Computing (BigComp)**, Feb. 19-22, 2020.

Patent:

1. A. Ben Abdallah, Huakun Huang, **Khanh N. Dang**, Jiangning Song, *"ＡＩプロセッサ (AI Processor)"*, 特願2020-194733, Japan patent, (patent filed)

---

## AI for Computer-Aided Design
<!-- : [>> more detail](./research_topics/mlcad) -->

In this project, we  develop an AI framework for designing and maintaince multi/many-core system.  One of our research approach is to convert the constraints in the design phases (i.e., area, power, reliability, thermal) into a multiple-objective optimization. Here, we solve the problems using Genetic Algorithm (GA). 

{::nomarkdown}
<img src="../images/research_topics/mlcad/thumb.svg" class="icenter" width=100%>
{:/}





Selected publications:

1. Abderazek Ben Abdallah, **Khanh N. Dang**, *"Towards Robust Cognitive 3D Brain-inspired Cross-paradigm System"*, **Frontiers in Neuroscience**, Frontiers, Volume 15, pp. 795, 2021. \[[DOI: 10.3389/fnins.2021.690208](https://doi.org/10.3389/fnins.2021.690208)\]/\[[PDF](./share/pubs/FNINS-2021.pdf)\].
1. **Khanh N. Dang**, Akram Ben Ahmed, Fakhrul Zaman Rokhani, Abderazek Ben Abdallah, and Xuan-Tu Tran, *"A thermal distribution, lifetime reliability prediction and spare TSV insertion platform for stacking 3D NoCs"*, **2020 International Conference On Advanced Technologies For Communications (ATC)**, Nov. 8-10, 2020.



<!-- --- -->
<!-- # Previous topics -->
---

## Thermal-aware 3D-ICs
<!-- : [>> more detail](./research_topics/thermal3DICs) -->

As thermal dissipation is one of the most critical challenges for stacking 3D-ICs and the Mean Time to Failure (MTTF) decreases exponentially with the operating temperature as in Black’s mode. In this research, we target to develop algorithms and architectures to solve the lifetime reliability of 3D-ICs with awareness of thermal impact.

{::nomarkdown}
<img src="../images/research_topics/thermal3DICs/Normalized_Black_model.PNG" class="icenter" width=40% >
{:/}
Normalized thermal acceleration for lifetime reliability of CMOS and Copper with the Black's model. The fault rates are normalized to 343.15K (70°C).
In  in 80°C, the fault rates are 2x and 3x of 70°C for CMOS and Copper, respectively.

{::nomarkdown}
<img src="../images/research_topics/thermal3DICs/HotCluster.png" class="icenter" width=80% >
{:/}
The HotCluster platform to predict the fault rate and to place spare modules. Details in [here](https://doi.org/10.1109/TCAD.2021.3069370).



Selected publications:

1. **Khanh N. Dang**, Akram Ben Ahmed, Abderazek Ben Abdallah, Xuan-Tu Tran, *"HotCluster: A thermal-aware defect recovery method for Through-Silicon-Vias Towards Reliable 3-D ICs systems"*, **IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems**, **(in press)**. \[[DOI](https://doi.org/10.1109/TCAD.2021.3069370)\]/\[[PDF](../share/TCAD-2021.pdf)\].
1. **Khanh N. Dang**, Akram Ben Ahmed, Abderazek Ben Abdallah, Xuan-Tu Tran, *"A thermal-aware on-line fault tolerance method for TSV lifetime reliability in 3D-NoC systems"*, **IEEE Access**, IEEE, Volume 8, pp 166642-166657, 2020. \[[DOI](https://doi.org/10.1109/ACCESS.2020.3022904 )\]/\[[PDF](../share/09189765.pdf)\].
1. **Khanh N. Dang**, Akram Ben Ahmed, Ben Abdallah Abderrazak and Xuan-Tu Tran, *"TSV-OCT: A Scalable Online Multiple-TSV Defects Localization for Real-Time 3-D-IC Systems"*, **IEEE Transactions on Very Large Scale Integration Systems (TVLSI)**, IEEE, Volume 28, Issue 3, pp 672 - 685, 2020. \[[DOI](https://doi.org/10.1109/TVLSI.2019.2948878)\]/\[[PDF](../share/TVLSI-2019.pdf)\].
1. **Khanh N. Dang**, Michael Meyer, Akram Ben Ahmed, Abderazek Ben Abdallah, and Xuan-Tu Tran, *"A non-blocking non-degrading multi-defect link test method for 3D-Networks-on-Chip"*, **IEEE Access**, IEEE, Volume 8, pp 59571 - 59589, 2020. \[[DOI](https://doi.org/10.1109/ACCESS.2020.2982836)\]/\[[PDF](../share/ACCESS-2020.pdf)\].


Patents:

1. A. Ben Abdallah, **Khanh N. Dang**, Masayuki Hisada, *"Distance-aware Extended Parity Product Coding for multiple faults detection for on-chip links"*,特願2020-171553, Japan patent, (patent filed)
1. A. Ben Abdallah, **Khanh N. Dang**, *"A three-dimensional system on chip in which a TSV group including a plurality of TSVs provided to connect between layers"*, 特願2020-094220, Japan patent, (patent filed)

---

## Old research topics

For old research topics, please visit this [link](old-research).