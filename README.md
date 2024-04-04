# mdtable
Quick script to format text into a markdown table.

# Usage

```bash
./mdtable.sh [file] [column_count]
```

## Example

### File.txt

```txt
Title 1
Content a
Content b
Content c
Content d
Title 2
Content e
Content f
Content g
Content h
```

### Command

```bash
> ./mdtable.sh file.txt 2
```

### Table output

| Title 1 | Title 2 |
|:---:|:---:|
| Content a | Content e |
| Content b | Content f |
| Content c | Content g |
| Content d | Content h |
