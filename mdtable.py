import sys, subprocess
from pathlib import Path

imgFile = sys.argv[1]
PATH = f"{Path(__file__).parent.resolve()}/{imgFile}"
tesseractCommand = f"tesseract {PATH} output --dpi 500 --psm 1"
clearEmptyNewLines = f"sed -i '/^[[:blank:]]*$/ d' output.txt; echo ' ' >> output.txt"
outputFilePath = f"{Path(__file__).parent.resolve()}/output.txt"


if(len(sys.argv) != 2):
    print(f"Invalid usage. Type 'python mdtable.py help' for usage.")
    sys.exit(0)

if(not("img" in imgFile)):
    print(f"Directory 'img' is not present in file path. Type 'python mdtable.py help' for usage.")
    sys.exit(0)

def help():
    pass

def proxima_linha_com_minusculo(arquivo):
    table = open("table.txt", "w")
    table.write("")
    with open(arquivo, 'r') as f:
        linhas = f.readlines()
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

def get_table_content(table_path):
    subprocess.run(tesseractCommand, shell = True, executable="/bin/bash")
    subprocess.run(clearEmptyNewLines, shell= True, executable="/bin/bash")
    proxima_linha_com_minusculo(outputFilePath)

# só buscar imagens dentro do diretorio img

# PATH = Path(f"{Path(__file__).parent.resolve()}/{sys.argv[1]}")



# table_img = sys.argv[1]
print(get_table_content(PATH))