import pandas as pd
import os

source_dir = os.path.join(os.getcwd(), "input")
dest_dir = os.path.join(os.getcwd(), "output")

os.makedirs(dest_dir, exist_ok=True)

for file in os.listdir(source_dir):
    if file.endswith(".xlsx"):
        file_path = os.path.join(source_dir, file)
        df = pd.read_excel(file_path, engine="openpyxl")
        output_path = os.path.join(dest_dir, file.replace(".xlsx", ".csv"))
        df.to_csv(output_path, index=False)
        print(f"Converted: {file} -> {output_path}")
