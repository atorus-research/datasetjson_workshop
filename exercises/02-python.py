# R/Pharma 2025 Workshop: dsjconvert in Python
# Exercises for hands-on practice with the dsjconvert Python package

# EXERCISE INSTRUCTIONS:
# 1. Load the required packages need to complete the exercises
# 2. Find the main() function and work through each exercise in order
# 3. Replace TODO comments with actual Python code
# 4. Use the examples is the slides to help you, or
# 5. Check the examples in the dsjconvert README.md (https://github.com/swhume/dataset-json)
# 6. Run your code to make sure it works
# 7. Check your answers against exercises/answers/02-python-answer.py
# 8. Ask for help if you get stuck!

from pathlib import Path
from dsjconvert import XPTConverter, MetadataExtractor
from dsjconvert import DatasetJSONToXPTConverter


def check_data_dir_exists() -> None:
    directory_path = Path("data")
    if not directory_path.is_dir():
        raise FileNotFoundError(f"The directory '{directory_path}' does not exist or is not a directory.")


def main():
    check_data_dir_exists()

    # =============================================================================
    # SOLUTION to Dataset-JSON conversion exercises using Python and dsjconvert
    # =============================================================================

    # Exercise 1: convert cm.xpt to CM.ndjson using the define.xml metadata
    data_path = Path(__file__).parent.joinpath("data")
    xpt_file = Path(data_path).joinpath("cm.xpt")
    define_file = Path(data_path).joinpath("define.xml")
    # TODO use a function to convert cm.xpt to CM.ndjson using the define.xml metadata

    # Exercise 2: convert vs.xpt to VS.ndjson without using the define.xml metadata
    xpt_file = Path(data_path).joinpath("vs.xpt")
    # TODO use a function to convert vs.xpt to VS.ndjson without using the define.xml metadata

    # Exercise 3: convert dm.xpt to dm.json using the define.xml metadata
    xpt_file = Path(data_path).joinpath("dm.xpt")
    # TODO use a function to convert dm.xpt to dm.json using the define.xml metadata

    # Exercise 4: convert MH.ndjson to mh.xpt using the define.xml metadata
    dsj_file = Path(data_path).joinpath("MH.ndjson")
    # TODO use a function to convert MH.ndjson to mh.xpt


if __name__ == '__main__':
    main()
# Placeholder for python

