import sys, subprocess
from pathlib import Path

MDTABLE = []

imgFile = sys.argv[1]
columnCount = int(sys.argv[2])

PATH = f"{Path(__file__).parent.resolve()}/{imgFile}"
outputFilePath = f"{Path(__file__).parent.resolve()}/output.txt"
tableFilePath = f"{Path(__file__).parent.resolve()}/tableContent.txt"
mdtableFilePath = f"{Path(__file__).parent.resolve()}/mdtable.md"

tesseractCommand = f"tesseract {PATH} output --dpi 500 --psm 1"
clearEmptyNewLinesCommand = f"sed -i '/^[[:blank:]]*$/ d' output.txt; echo ' ' >> output.txt"

if(len(sys.argv) != 3):
    print(f"Invalid usage. Type 'python mdtable.py help' for usage.")
    sys.exit(0)

if(not("img" in imgFile)):
    print(f"Directory 'img' is not present in file path. Type 'python mdtable.py help' for usage.")
    sys.exit(0)

def help():
    pass

def array_chunks(array, n):
    start = 0
    end = int(len(array) / n)
    print(end)
    for i in range(n):
        MDTABLE.append(array[start:end])
        start = end
        end += end

def output_to_table(arquivo):
    table = open(tableFilePath, "w")
    table.write("")
    
    with open(arquivo, "r") as output:
        linhas = output.readlines()
        print(len(linhas))
        for i in range(len(linhas) - 1):  # Itera sobre todas as linhas, exceto a última
            line = linhas[i].rstrip()
            if linhas[i + 1].strip() and linhas[i + 1][0].islower():
                line += f" {linhas[i+1]}"
                table.write(line)
            elif linhas[i][0].islower():
                pass
            else:
                table.write(f"{line}\n")
        table.close()

def format_table(arquivo):

    with open(arquivo, "r") as table:
        tableLinhas = table.readlines()
        array_chunks(tableLinhas, columnCount)
        for col in MDTABLE:
            for i in range(len(col)+1):
                if(i != 1):
                    col[i] = f"| {col[i].rstrip()} "
                else:
                    col.insert(1, f"|:---:")   
    
    with open(mdtableFilePath, "w") as mdtable:
        mdtable.write("")
        for i in range(len(MDTABLE[0])):
            for col in MDTABLE:
                mdtable.write(f"{col[i]}")
            mdtable.write("|\n")

def get_table_content(table_path):
    subprocess.run(tesseractCommand, shell = True, executable="/bin/bash")
    subprocess.run(clearEmptyNewLinesCommand, shell= True, executable="/bin/bash")
    output_to_table(outputFilePath)
    format_table(tableFilePath)

get_table_content(PATH)