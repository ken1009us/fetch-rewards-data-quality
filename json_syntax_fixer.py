import re


def fix_json(json_string):
    fixed_json = re.sub(r'}\s*{', '}, {', json_string)
    return fixed_json


def read_file(file_path):
    with open(f'data/{file_path}.json', 'r', encoding="utf-8") as f:
        original_content = f.read()

    fixed_content = fix_json(original_content)
    with open(f'data/{file_path}.json', 'w', encoding="utf-8") as f:
        f.write(fixed_content)


if __name__ == "__main__":
    file = input("Enter the JSON file name: ")
    read_file(file)
