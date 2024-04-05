# mdtable
Quick script to format text into a markdown table.

# Usage

```bash
./mdtable.sh [file] [column_count]
```

# Arguments

```txt
[file]
```

Txt file with data to transform.


```txt
[column_count]
```
Integer that defines the amount of columns the table will have.

## Example

### File.txt

```txt
Title 1
Content A
Content B
Content C
Content D
Title 2
Content E
Content F
Content G
Content H
Title 3
Content I
Content J
Content K
Content L
```

### Command

```bash
> ./mdtable.sh file.txt 3
```

### Table output

| Title 1 | Title 2 | Title 3 |
| :---: | :---: | :---: |
| Content A | Content E | Content I |
| Content B | Content F | Content J |
| Content C | Content G | Content K |
| Content D | Content H | Content L |
