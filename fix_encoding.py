import os

def fix_mojibake(filename):
    if not os.path.exists(filename):
        return
    with open(filename, 'r', encoding='utf-8') as f:
        content = f.read()
    
    try:
        fixed = content.encode('windows-1252').decode('utf-8')
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(fixed)
        print(f"Fixed {filename}")
    except Exception as e:
        print(f"Error fixing {filename}: {e}")

files = [
    r"c:\Users\shisu\Documents\mc consultoría\index.html",
    r"c:\Users\shisu\Documents\mc consultoría\css\styles.css",
    r"c:\Users\shisu\Documents\mc consultoría\js\main.js"
]

for file in files:
    fix_mojibake(file)
