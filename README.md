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

```bash
❯ python3 data-quality-evaluation.py

2024-02-26 22:53:51,424 - INFO - ------ Users Dataset ------
2024-02-26 22:53:51,425 - INFO - Missing values in users dataset:
_id              0
active           0
createdDate      0
lastLogin       62
role             0
signUpSource    48
state           56
dtype: int64
2024-02-26 22:53:51,427 - INFO - Duplicate IDs in users dataset: 283


2024-02-26 22:53:51,450 - INFO - ------ Receipts Dataset ------
2024-02-26 22:53:51,450 - INFO - Missing values in receipts dataset:
_id                          0
bonusPointsEarned          575
bonusPointsEarnedReason    575
createDate                   0
dateScanned                  0
finishedDate               551
modifyDate                   0
pointsAwardedDate          582
pointsEarned               510
purchaseDate               448
purchasedItemCount         484
rewardsReceiptItemList     440
rewardsReceiptStatus         0
totalSpent                 435
userId                       0
dtype: int64
2024-02-26 22:53:51,452 - INFO - Duplicate IDs in receipts dataset: 0
2024-02-26 22:53:51,453 - INFO - Inconsistent date formats in receipts dataset: 671


2024-02-26 22:53:51,456 - INFO - ------ Brands Dataset ------
2024-02-26 22:53:51,457 - INFO - Missing values in brands dataset:
_id               0
barcode           0
category        155
categoryCode    650
cpg               0
name              0
topBrand        612
brandCode       234
dtype: int64
2024-02-26 22:53:51,458 - INFO - Duplicate IDs in brands dataset: 0
```