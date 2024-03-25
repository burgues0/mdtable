# mdtable
CLI program that transforms tables in images into Markdown formatted tables

# Usage

- check if file has exec permissions

```bash
mdtable.py [args] <options>
```

## Possible usages

- pass image filepath as argument, return the table in clipboard
- pass image filepath + -f "name", return table in the file
- pass folder with images, return .txt with all image_names + table below the name
- limit image file to .png or .jpg
