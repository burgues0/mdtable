# mdtable
Quick script to format text into a markdown table.

# Usage

./mdtable.sh \[file\] \[column_count\]

## Example

> file.txt

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

```bash
./mdtable.sh file.txt 2
```

> table output

| Title 1 | Title 2 |
|:---:|:---:|
| Content a | Content e |
| Content b | Content f |
| Content c | Content g |
| Content d | Content h |
