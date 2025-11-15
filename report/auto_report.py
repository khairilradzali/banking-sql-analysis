#pip install tabulate
import pandas as pd
from pathlib import Path

REPORT_DIR = Path(".")
OUTPUT_MD = REPORT_DIR / "analysis.md"

def df_to_markdown(df):
    """Convert DataFrame to a Markdown table."""
    try:
        return df.to_markdown(index=False)
    except:
        return df.head().to_markdown(index=False)

def main():
    REPORT_DIR.mkdir(exist_ok=True)

    csv_files = sorted(REPORT_DIR.glob("*.csv"))
    if not csv_files:
        print("❌ No CSV files found in report/")
        return

    md_sections = ["# Automated Banking SQL Analysis\n"]

    for csv_path in csv_files:
        name = csv_path.stem.replace("_", " ").title()
        df = pd.read_csv(csv_path)

        md_sections.append(f"## {name}\n")
        md_sections.append(df_to_markdown(df) + "\n")

    OUTPUT_MD.write_text("\n".join(md_sections), encoding='utf-8')
    print(f"✅ analysis.md generated at: {OUTPUT_MD}")

if __name__ == "__main__":
    main()
