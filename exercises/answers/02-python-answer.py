# R/Pharma 2025 Workshop: dsjconvert in Python
# Solution to the exercises for hands-on practice with the dsjconvert Python package
# =============================================================================
# This is the solution to the Python dsjconvert exercises.
# =============================================================================
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
from os import getcwd


def convert_xpt_dataset(dsj_format: str, data_path: Path, xpt_file: Path, define_file: Path = None):
    if define_file:
        extractor = MetadataExtractor(define_file)
        converter = XPTConverter(
            metadata_extractor=extractor,
            output_format=dsj_format,
            skip_validation=True
        )
    else:
        converter = XPTConverter(
            output_format=dsj_format,
            skip_validation=True
        )
    converter.convert_dataset(xpt_file, data_path)


def convert_dsj_dataset(dsj_format: str, data_path: Path, dsj_file: Path):
    converter = DatasetJSONToXPTConverter(input_format=dsj_format, skip_validation=True)
    converter.convert_dataset(dsj_file, data_path)


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
    data_path = Path(getcwd()).joinpath("data")
    xpt_file = Path(data_path).joinpath("cm.xpt")
    define_file = Path(data_path).joinpath("define.xml")
    # TODO use a function to convert cm.xpt to CM.ndjson using the define.xml metadata
    convert_xpt_dataset('ndjson', data_path, xpt_file, define_file)

    # Exercise 2: convert vs.xpt to VS.ndjson without using the define.xml metadata
    xpt_file = Path(data_path).joinpath("vs.xpt")
    # TODO use a function to convert vs.xpt to VS.ndjson without using the define.xml metadata
    convert_xpt_dataset('ndjson', data_path, xpt_file)

    # Exercise 3: convert dm.xpt to dm.json using the define.xml metadata
    xpt_file = Path(data_path).joinpath("dm.xpt")
    # TODO use a function to convert dm.xpt to dm.json using the define.xml metadata
    convert_xpt_dataset('json', data_path, xpt_file, define_file)

    # Exercise 4: convert MH.ndjson to mh.xpt using the define.xml metadata
    dsj_file = Path(data_path).joinpath("MH.ndjson")
    # TODO use a function to convert MH.ndjson to mh.xpt
    convert_dsj_dataset("ndjson", data_path, dsj_file)


if __name__ == '__main__':
    main()
# Placeholder for answers
