Fork by CMS27
# ScPo-CompEcon CoursePack

This repo contains all relevant course material. If you just want to look at the slides, please go to the website at [https://scpo-compecon.github.io/CoursePack/](https://scpo-compecon.github.io/CoursePack/)

## How to use this

You can build the CoursePack website an all material on your computer. You should only worry about this section if you want to rebuild the site yourself.

### Requirements

```bash
# you need
# 1. python
# 2. latex
# 3. ruby
pip install jupyter
pip install pandoc
```

### Building

1. Clone this to your computer

	```bash
	git clone https://github.com/ScPo-CompEcon/CoursePack /whereto/on/your/computer
	```

2. in the root of that repo then do

	```bash
	rake # builds all
	rake html # builds only html
	rake offline # builds offline slides
	```

## Looking at the material built on your computer

Use those commands from within Julia:

```julia
Pkg.add("IJulia") # use once to install IJulia
using IJulia
notebook(dir="/whereto/on/your/computer/Notebooks")  # that's the dir from above!
```

This will open up the Jupyter notebook at the location of your notebooks

