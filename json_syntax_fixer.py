import re


def fix_json_syntax_and_encapsulate(json_string):
    """
    Fixes the common JSON syntax issue where adjacent JSON objects in the file
    are not comma-separated and encapsulates the JSON objects within a {"data": [...]} structure.
    """
    # Fix missing commas between JSON objects
    fixed_json = re.sub(r'}\s*{', '}, {', json_string)
    # Encapsulate within a "data" array
    encapsulated_json = f'{{"data": [{fixed_json}]}}'
    return encapsulated_json


def read_and_fix_file(file_path):
    """
    Reads the JSON file, fixes its syntax, encapsulates data within a "data" key,
    and writes the fixed content back to the file.
    """
    with open(file_path, "r", encoding="utf-8") as f:
        original_content = f.read()

    final_content = fix_json_syntax_and_encapsulate(original_content)

    with open(file_path, "w", encoding="utf-8") as f:
        f.write(final_content)


if __name__ == "__main__":
    file = input("Enter the full path of the JSON file: ")
    read_and_fix_file(file)
