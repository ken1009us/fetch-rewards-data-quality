import json
import logging
import pandas as pd


logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s"
)


def load_data(file_path: str) -> pd.DataFrame:
    """
    Load data from a JSON file into a DataFrame.

    Args:
        file_path (str): The path to the JSON file to be loaded.

    Returns:
        pd.DataFrame: A DataFrame containing the data loaded from the JSON file.
    """
    try:
        with open(file_path, "r", encoding="utf-8") as file:
            data = json.load(file)
        return pd.DataFrame(data["data"])
    except Exception as e:
        logging.error(f"Failed to load data from {file_path}: {e}")
        return pd.DataFrame()


def check_missing_values(df: pd.DataFrame, dataset_name: str) -> None:
    """
    Check for missing values in the dataset and log the findings.

    Args:
        df (pd.DataFrame): The DataFrame to be checked.
        dataset_name (str): The name of the dataset (for logging purposes).
    """
    missing_values = df.isnull().sum()
    logging.info(f"Missing values in {dataset_name} dataset:\n{missing_values}")


def check_duplicate_ids(df: pd.DataFrame, id_column: str, dataset_name: str) -> None:
    """
    Check for duplicate IDs in the dataset and log the findings.

    Args:
        df (pd.DataFrame): The DataFrame to be checked.
        id_column (str): The name of the column containing the IDs.
        dataset_name (str): The name of the dataset (for logging purposes).
    """
    duplicate_ids = df[id_column].duplicated().sum()
    logging.info(f"Duplicate IDs in {dataset_name} dataset: {duplicate_ids}")


def check_date_consistency(
    df: pd.DataFrame, date_column: str, dataset_name: str
) -> None:
    """
    Check for consistency in date formats within a dataset and log the findings.

    Args:
        df (pd.DataFrame): The DataFrame to be checked.
        date_column (str): The name of the column containing the date values.
        dataset_name (str): The name of the dataset (for logging purposes).
    """
    original_count = df[date_column].notnull().sum()
    df[date_column] = pd.to_datetime(df[date_column], errors="coerce")
    after_conversion_count = df[date_column].notnull().sum()
    inconsistency_count = original_count - after_conversion_count
    logging.info(
        f"Inconsistent date formats in {dataset_name} dataset: {inconsistency_count}"
    )


def data_quality_evaluation() -> None:
    """
    Evaluate the data quality of users, receipts, and brands datasets
    by checking for missing values, duplicate IDs, and date consistency.
    """
    datasets = {
        "users": ("data/users.json", "userId"),
        "receipts": ("data/receipts.json", "receiptId"),
        "brands": ("data/brands.json", "brandId"),
    }

    for dataset_name, (file_path, id_column) in datasets.items():
        df = load_data(file_path)
        if df.empty:
            continue
        print("")
        logging.info(f"------ {dataset_name.capitalize()} Dataset ------")

        # Completeness: Check for missing values
        check_missing_values(df, dataset_name)

        # Uniqueness: Check for duplicate IDs
        df[id_column] = df["_id"].apply(lambda x: x["$oid"] if pd.notnull(x) else None)
        check_duplicate_ids(df, id_column, dataset_name)

        # Additional check for date consistency in receipts dataset
        if dataset_name == "receipts":
            check_date_consistency(df, "purchaseDate", dataset_name)

        print("")


if __name__ == "__main__":
    data_quality_evaluation()
