# A Hybrid Probabilistic Model for Latent Momentum and Match Outcome Prediction

**Author:** Fashad Ahmed Siddique  
**Institution:** University of Bologna, Master's Degree in Artificial Intelligence  
**Course:** Fundamentals of Artificial Intelligence and Knowledge Representation - Module 3  
**Email:** fashad.ahmedsiddique@studio.unibo.it

---

## Abstract

This project presents a hybrid probabilistic modeling approach that combines Hidden Markov Models (HMMs) for inferring latent team momentum variables with Bayesian Networks (BNs) for predicting football match outcomes. The work compares three distinct Bayesian Network architectures: a Naive Bayes baseline, an expert-defined directed acyclic graph (DAG) encoding domain knowledge, and a data-driven structure learned via Hill Climb Search. Experimental evaluation on a dataset comprising over 230,000 matches from the European Soccer Database (2000–2025) demonstrates that simpler structures (Naive Bayes and Expert DAG) achieve superior predictive performance compared to complex learned structures, suggesting that structure learning can lead to overfitting in stochastic domains. The integration of HMM-derived momentum features provides interpretable temporal dynamics that enhance the static probabilistic models.

---

## Introduction

### Research Context

Football match outcome prediction presents a challenging problem in probabilistic modeling due to the inherent stochasticity and high variability of results. The complexity arises from numerous interacting factors including team form, player availability, tactical variations, and random in-game events. Bayesian Networks provide a principled framework for modeling these uncertainties by encoding conditional dependencies between variables, while Hidden Markov Models offer a mechanism for capturing temporal dynamics through latent state inference.

### Research Objectives

This work addresses two primary research questions:

1. **Structure Learning Comparison**: Does knowledge-driven (expert-defined) structure learning produce superior predictive models compared to data-driven (automated) structure learning in the context of football match prediction?

2. **Temporal Feature Integration**: What is the value of latent momentum features inferred via HMMs in improving prediction accuracy compared to static features alone?

### Contributions

- Development of a hybrid HMM-BN framework for integrating temporal dynamics into static probabilistic models
- Comparative analysis of three Bayesian Network architectures with different structural assumptions
- Empirical evaluation demonstrating the superiority of simpler structures over complex learned ones in noisy domains
- Integration of interpretable momentum features derived from HMM state inference

---

## Methodology

### Dataset

The experimental evaluation utilizes the **Club Football Match Data (2000–2025)** dataset, comprising over 230,000 matches from European football leagues. The dataset includes the following essential attributes:

- `HomeTeam`: Name of the home team
- `AwayTeam`: Name of the away team
- `FTHG`: Full-time home goals
- `FTAG`: Full-time away goals
- `FTR`: Full-time result (H=Home win, D=Draw, A=Away win)
- `Date`: Match date (for temporal ordering)

**Dataset Source:** [Kaggle - Club Football Match Data (2000-2025)](https://www.kaggle.com/datasets/adamgbor/club-football-match-data-2000-2025)

### Modeling Pipeline

The methodology consists of four principal stages:

#### 1. Data Preprocessing and Feature Engineering

- **Data Cleaning**: Removal of incomplete records and validation of match results
- **Elo Rating Computation**: Calculation of team strength ratings using the Elo rating system with home advantage adjustment (+100 Elo points)
- **Feature Discretization**: Quantile-based binning of continuous variables (Elo ratings, momentum states) into five discrete categories to ensure balanced distributions

#### 2. Hidden Markov Model for Momentum Inference

- **Model Specification**: Training of a 5-state Categorical HMM for each team using sequences of match results (Win/Draw/Loss)
- **State Inference**: Application of the Viterbi algorithm to infer the most likely momentum state sequence for each team
- **Interpretability Analysis**: Examination of state-conditioned distributions reveals interpretable performance regimes (e.g., sustained high form, low form periods)

#### 3. Bayesian Network Construction

Three distinct BN architectures are constructed and compared:

- **Naive Bayes (Baseline)**: Assumes conditional independence of all features given the match outcome, providing a low-variance baseline
- **Expert DAG (Knowledge-Driven)**: Encodes domain knowledge through causal links (Elo → Momentum → Result)
- **Learned DAG (Data-Driven)**: Structure learned via Hill Climb Search with Bayesian Information Criterion (BIC) maximization

All models employ Maximum Likelihood Estimation for parameter learning.

#### 4. Inference and Evaluation

- **Inference Methods**: Comparison of exact inference (Variable Elimination) with approximate inference (Gibbs Sampling)
- **Evaluation Protocol**: Temporal train/test split (80/20) to prevent data leakage and preserve chronological structure
- **Performance Metrics**: Accuracy, log loss, confusion matrices, calibration curves

### Experimental Results

The Naive Bayes model achieved the best log loss (1.0139) with 49.07% accuracy, tying with the Expert model and outperforming the Learned structure (48.60%). A notable finding is the "Draw Blindspot" phenomenon, where all models consistently favor home or away wins over draws, likely due to the posterior probability structure in three-class distributions. Comparison of exact and approximate inference methods demonstrated convergence of Gibbs Sampling at N=500 samples.

---

## Project Structure

```
mod3-miniproject/
├── notebook.ipynb              # Main Jupyter notebook implementing the complete pipeline
├── README.md                   # This document
├── requirements.txt            # Python package dependencies
├── aaai.bst                    # Bibliography style file
│
├── data/                       # Dataset directory
│   ├── Matches.csv            # Primary match data (to be downloaded)
│   └── EloRatings.csv         # Computed Elo ratings (generated)
│
├── images/                     # Generated visualizations
│   ├── bn_structures.png      # Bayesian Network architecture diagrams
│   ├── confusion_matrix.png   # Model confusion matrices
│   ├── calibration_curve.png  # Probability calibration curves
│   └── hmm_matrix.png         # HMM transition matrices
│
├── report/                     # LaTeX report source files
│   ├── main.tex              # Main LaTeX document
│   ├── faikrmod3.bib         # Bibliography database
│   ├── faikrmod3.sty         # Custom LaTeX style file
│   ├── aaai.bst              # Bibliography style
│   └── final_report.pdf      # Compiled PDF report
│
└── scripts/                    # Utility scripts
    └── compile_report.sh      # LaTeX compilation script
```

---

## Installation and Setup

### Prerequisites

- **Python 3.10+** (Python 3.13 recommended)
- **JupyterLab 4.0+** (for interactive execution)
- **LaTeX Distribution** (for report compilation; TeX Live or MiKTeX)
- **Graphviz** (for graph visualization; system-level installation required)

### System Dependencies

**Graphviz Installation:**

- **macOS**: `brew install graphviz`
- **Linux (Debian/Ubuntu)**: `sudo apt-get install graphviz`
- **Windows**: Download installer from [Graphviz website](https://graphviz.org/download/)

### Python Environment Setup

#### Option 1: Virtual Environment (Recommended)

```bash
# Create virtual environment
python3 -m venv venv

# Activate virtual environment
# On macOS/Linux:
source venv/bin/activate
# On Windows:
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

#### Option 2: Direct Installation

   ```bash
   pip install -r requirements.txt
   ```
   
### Required Python Packages

The project requires the following packages (specified in `requirements.txt`):

- **Data Manipulation**: `pandas>=1.5.0`, `numpy>=1.23.0`
- **Visualization**: `matplotlib>=3.6.0`, `seaborn>=0.12.0`
- **Machine Learning**: `scikit-learn>=1.2.0`
- **Probabilistic Models**: `pgmpy>=0.1.19`, `hmmlearn>=0.2.7`
- **Graph Visualization**: `networkx>=3.0`, `graphviz>=0.20.1`
- **Notebook Environment**: `jupyterlab>=4.0.0`
- **Utilities**: `tabulate>=0.9.0`
- **Data Download** (optional): `kaggle>=1.5.13`

---

## Usage

### Data Preparation

1. **Download the Dataset**:
   - Visit the [Kaggle dataset page](https://www.kaggle.com/datasets/adamgbor/club-football-match-data-2000-2025)
   - Download `Matches.csv`
   - Place the file in the `data/` directory

2. **Alternative: Kaggle API** (if credentials are configured):
   ```bash
   kaggle datasets download -d adamgbor/club-football-match-data-2000-2025
   unzip club-football-match-data-2000-2025.zip -d data/
   ```

### Execution

#### Interactive Execution (Jupyter Notebook)

1. **Launch JupyterLab**:
   ```bash
   jupyter lab
   ```

2. **Open the Notebook**:
   - Navigate to `notebook.ipynb` in the JupyterLab interface
   - Execute cells sequentially from top to bottom

3. **Expected Workflow**:
   - Cell execution will automatically install dependencies if needed
     - Data loading and preprocessing
   - HMM momentum inference for all teams
   - Bayesian Network construction and parameter learning
   - Inference experiments (exact vs. approximate)
   - Model evaluation and visualization generation
   - LaTeX report generation (if LaTeX is installed)

#### Report Compilation

To compile the LaTeX report:

```bash
# Using the provided script
bash scripts/compile_report.sh

# Or manually
cd report/
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

The compiled PDF will be available as `report/final_report.pdf`.

### Expected Outputs

Upon successful execution, the following artifacts are generated:

- **Visualizations** (in `images/` directory):
  - Bayesian Network structure diagrams
  - Confusion matrices for each model
  - Calibration curves
  - HMM transition matrices
  - Momentum state distributions

- **Performance Metrics**:
  - Comparative table of model accuracies and log losses
  - Inference convergence analysis
  - Baseline comparison results

- **Report** (in `report/` directory):
  - LaTeX source files
  - Compiled PDF report (`final_report.pdf`)

---

## Technical Implementation Details

### Key Algorithms

- **Viterbi Algorithm**: Used for HMM state sequence inference
- **Variable Elimination**: Exact inference method for Bayesian Networks
- **Gibbs Sampling**: Markov Chain Monte Carlo method for approximate inference
- **Hill Climb Search**: Greedy structure learning algorithm with BIC scoring
- **Maximum Likelihood Estimation**: Parameter learning for all probabilistic models

### Design Decisions

- **5-State HMM**: Chosen to balance model complexity with interpretability
- **Quantile-Based Discretization**: Ensures balanced class distributions for discrete BN models
- **Temporal Train/Test Split**: Preserves chronological ordering and prevents data leakage
- **Home Advantage Adjustment**: +100 Elo points based on established football analytics literature

---

## Results Summary

The experimental evaluation yields the following key findings:

1. **Structure Complexity Trade-off**: Simpler structures (Naive Bayes, Expert DAG) outperform complex learned structures, suggesting overfitting in data-driven structure learning for stochastic domains.

2. **Momentum Feature Value**: HMM-derived momentum features provide interpretable temporal dynamics that enhance static probabilistic models.

3. **Inference Method Comparison**: Exact inference (Variable Elimination) and approximate inference (Gibbs Sampling) produce consistent results, with Gibbs Sampling converging at 500 samples.

4. **Draw Prediction Challenge**: All models exhibit difficulty predicting draws ("Draw Blindspot"), a phenomenon consistent with the posterior probability structure in three-class classification.

---

## References

The project builds upon established work in probabilistic graphical models, Hidden Markov Models, and sports analytics. Key references are included in the LaTeX report bibliography (`report/faikrmod3.bib`).

---

## License and Academic Use

This project is developed for educational purposes as part of the **Fundamentals of Artificial Intelligence and Knowledge Representation** course (Module 3) at the [University of Bologna](https://www.unibo.it/it).

**Academic Integrity**: This codebase is intended for learning and research purposes.


