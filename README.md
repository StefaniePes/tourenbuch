# Guidebook
These are template files for my personal pdf guidebook

*Usage examples for the interested are yet to come*

## Elevation profile
The profile is created with `gnuplot` from extracted distance and heigth data
from a `.gpx` track.

### Extract plotting data
With the [gpxplot.py](meta/gpxplot.py) tool, the neccessary plotting data can be
extracted from a `.gpx` track.

```
python meta/gpxplot.py skitouren/NAME/NAME.gpx > skitouren/NAME/hoehe.dat
```

The resulting `.dat` file contains distance and elevation data, which can now be
plotted with the [gnuplot template file](skitouren/hoehenprofil.plt).

After running `gnuplot` a LaTeX file is created for the later include in the
header segment.
