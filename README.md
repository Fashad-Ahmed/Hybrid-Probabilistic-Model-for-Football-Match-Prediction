# Hybrid Probabilistic Model for Football Match Prediction

## Project Overview

This project implements an end-to-end data science pipeline that combines **Hidden Markov Models (HMM)** and **Bayesian Networks (BN)** to predict football match outcomes. The approach uses HMM to infer latent "team momentum" variables from historical match data, which are then incorporated as features in static Bayesian Networks for match prediction.

### Key Features

- **HMM-based Momentum Inference**: Trains a Multinomial HMM for each team to model momentum as a latent variable
- **Multiple BN Structures**: Compares three different Bayesian Network architectures:
  - Naive Bayes (baseline)
  - Expert-defined DAG (causal structure)
  - Data-driven Learned DAG
- **Inference Comparison**: Evaluates exact inference (Variable Elimination) vs. approximate inference (Gibbs Sampling)
- **Comprehensive Evaluation**: Time-based train/test split with multiple metrics (Accuracy, Log-Loss, Confusion Matrix, Calibration Curves)
- **Automated Report Generation**: Produces a LaTeX report summarizing all findings

## Data Source

This project uses the **Club Football Match Data (2000 - 2025)** dataset from Kaggle.

**Dataset Link**: [Kaggle - Club Football Match Data](https://www.kaggle.com/datasets/your-username/club-football-match-data)

The dataset should contain a `Matches.csv` file with the following required columns:
- `HomeTeam`: Name of the home team
- `AwayTeam`: Name of the away team
- `FTHG`: Full-time home goals
- `FTAG`: Full-time away goals
- `FTR`: Full-time result (H=Home win, D=Draw, A=Away win)
- `Date`: Match date (optional but recommended)

## How to Run

### Prerequisites

1. **Python 3.10+** installed on your system (or use Google Colab - no installation needed!)
2. **JupyterLab** installed (will be installed automatically if not present, or use Google Colab)
3. **Graphviz system binaries** (for local Jupyter only):
   - macOS: `brew install graphviz`
   - Linux: `sudo apt-get install graphviz`
   - Windows: Download from [Graphviz website](https://graphviz.org/download/)
   - **Note**: In Google Colab, this is handled automatically

### Step-by-Step Instructions

#### Option A: Running in Google Colab (Recommended for Easy Setup)

1. **Upload the notebook to Google Colab**:
   - Go to [Google Colab](https://colab.research.google.com/)
   - Click "File" → "Upload notebook"
   - Upload `notebook.ipynb`

2. **Upload the dataset**:
   - In Colab, click the folder icon on the left sidebar
   - Click "Upload" and select `Matches.csv`
   - Or use the Kaggle API (see Option B below)

3. **Run all cells**: The notebook will automatically install all dependencies and system packages

#### Option B: Running in Local Jupyter

1. **Install Dependencies** (choose one method):
   
   **Option A: Using requirements.txt** (recommended for virtual environments):
   ```bash
   pip install -r requirements.txt
   ```
   
   **Option B: Install via notebook** (dependencies will be installed automatically in the first cell):
   - Skip this step and proceed to step 2
   
   **Option C: Manual installation** (if you prefer):
   ```bash
   pip install jupyterlab
   ```

2. **Start JupyterLab**:
   ```bash
   jupyter lab
   ```

3. **Install Graphviz** (if not already installed):
   - macOS: `brew install graphviz`
   - Linux: `sudo apt-get install graphviz`
   - Windows: Download installer from [Graphviz website](https://graphviz.org/download/)

4. **Download the Dataset**:
   - Option A: Using Kaggle CLI (if you have credentials set up):
     ```bash
     kaggle datasets download -d your-username/club-football-match-data
     unzip club-football-match-data.zip
     ```
   - Option B: Manual download:
     - Visit the Kaggle dataset page
     - Download the dataset
     - Extract `Matches.csv` to the project directory

5. **Open the Notebook**:
   - In JupyterLab, navigate to `notebook.ipynb`
   - Open the notebook

6. **Run the Pipeline**:
   - Execute cells sequentially from top to bottom
   - The first cell will install all required dependencies
   - Subsequent cells will execute the complete pipeline:
     - Data loading and preprocessing
     - HMM momentum inference
     - Bayesian Network construction and comparison
     - Inference experiments
     - Model evaluation
     - Report generation

### Expected Outputs

After running the complete notebook, you should see:

- **Visualizations**: 
  - Momentum distributions
  - Bayesian Network structure graphs
  - Confusion matrices
  - Calibration curves
  - Inference convergence plots

- **Metrics Table**: Comparison of all models (Accuracy, Log-Loss)

- **Generated Files**:
  - `report.tex`: LaTeX source file with project summary
  - `report.pdf`: Compiled PDF report (if pdflatex is installed)

## Project Structure

```
mod3-miniproject/
├── notebook.ipynb          # Main notebook with complete pipeline
├── README.md               # This file
├── requirements.txt        # Python dependencies
├── data/Matches.csv             # Dataset (to be downloaded)
├── report.tex              # Generated LaTeX report
└── report.pdf              # Generated PDF report (optional)
```

## Technical Details

### Methodology

1. **Data Preprocessing**:
   - Cleans match data and handles missing values
   - Computes Elo ratings for all teams
   - Creates additional features (goal difference, total goals)

2. **HMM Momentum Modeling**:
   - Trains a Multinomial HMM with 5 hidden states for each team
   - Uses observation sequences from recent match results
   - Infers momentum states using the Viterbi algorithm

3. **Bayesian Network Construction**:
   - Discretizes all features (Elo ratings, momentum)
   - Builds three BN structures:
     - **Naive Bayes**: All features independent given result
     - **Expert DAG**: Causal structure (Elo → Momentum → Result)
     - **Learned DAG**: Structure learned via Hill Climb Search

4. **Inference & Evaluation**:
   - Compares exact (Variable Elimination) vs. approximate (Gibbs Sampling) inference
   - Performs time-based train/test split
   - Evaluates all models with multiple metrics

### Dependencies

All dependencies are automatically installed in the first cell of the notebook:

- `pandas`, `numpy`: Data manipulation
- `matplotlib`, `seaborn`: Visualization
- `scikit-learn`: Machine learning utilities
- `pgmpy`: Probabilistic graphical models
- `hmmlearn`: Hidden Markov Models
- `networkx`: Graph visualization
- `graphviz`, `python-graphviz`: Graph rendering
- `tabulate`: Table formatting
- `kaggle`: Dataset download (optional)


## License

This project is for educational purposes as part of a Fundamentals of Artificial Intelligence and Knowledge Representation module 3 at <a href="https://www.unibo.it/it">Unibo</a>.

