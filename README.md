# Data Quality Evaluation Project

## Overview

This project of Fetch Rewards aims to assess and enhance the data quality of the datasets, ensuring they are accurate, complete, and reliable for making informed business decisions.

## Getting Started

### Prerequisites

- Python 3.11 or later
- Pandas library
- JSON library

## Installation

1. Ensure Python is installed on your system. If not, download and install it from python.org.

2. Install Pandas, if it's not already installed, using pip:

```bash
$ pip install pandas
```

3. Clone this repository to your local machine:

```bash
$ git clone git@github.com:ken1009us/fetch-rewards-data-quality.git
```

4. Navigate to the project directory:

```bash
$ cd data-quality-evaluation
```

## Usage

To run the data quality evaluation script, execute the following command in your terminal:

```bash
$ python3 data_quality_evaluation.py
```

This script will load the datasets, perform data quality checks, and log the findings. The evaluation covers completeness, uniqueness, and consistency of data entries.

### Data Quality Checks

#### Completeness

Checks for missing or null values in the datasets to ensure all records are complete.

#### Uniqueness

Identifies duplicate entries in the datasets to avoid redundancy and ensure the uniqueness of each record.

#### Consistency

Validates the formats of data entries, especially for dates and identifiers, to maintain consistency across the datasets.
