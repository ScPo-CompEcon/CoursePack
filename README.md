# ScPo-CompEcon CoursePack

This repo contains all relevant course material. 

## How to use

Clone this somewhere on your computer (don't install as a julia package). You can do this easily in Github Desktop as in the first homework. Choose a suitable location on your computer.

```bash
git clone https://github.com/ScPo-CompEcon/CoursePack /whereto/on/your/computer
```


## How to build this 

You should only worry about this section if you want to rebuild the site yourself.

#### Requirements

```bash
#python
#latex
#ruby
pip install jupyter
pip install pandoc
```

#### Building

in the root of this repo do

```bash
rake # builds all
rake html # builds only html
rake offline # builds offline slides
```

## Easy Usage from Julia

This repository is also setup as a Julia package repository. To have users easily
open up the Jupyter notebooks, they can use the commands from within Julia:

```julia
Pkg.add("IJulia") # use once to install IJulia
using IJulia
notebook(dir="/whereto/on/your/computer/Notebooks")  # that's the dir from above!
```

This will open up the Jupyter notebook at the location of your notebooks

