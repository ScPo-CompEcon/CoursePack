
# [ScPo-CompEcon](https://github.com/ScPo-CompEcon/Syllabus) CoursePack

## Content

This website contains the course material for the [computational economics course at Sciences Po](https://github.com/ScPo-CompEcon/Syllabus).

I recommend you clone this somewhere on your computer (don't install as a julia package). You can do this easily in Github Desktop as in the first homework. Choose a suitable location on your computer. Alternatively, in your terminal, do this:

```bash
git clone https://github.com/ScPo-CompEcon/CoursePack /whereto/on/your/computer
```

This way you have all the materials locally and can use the site even if offline.

## Course Materials

You can look at the material in a variety of formats. All content is given as `IJulia` notebooks, which you can edit on your computer, and from those notebooks I create `html` rendered versions, `pdf`s and html slides. The link below point to the actual website, so in case you are offline, just go to `/whereto/on/your/computer` and open files from that location. For example, to open the IJulia notebooks, do in julia

```julia
Pkg.add("IJulia") # use once to install IJulia
using IJulia
notebook(dir="/whereto/on/your/computer/Notebooks")  # that's the dir from above!
```
This will open up the Jupyter notebook at the location of your notebooks



### Html Rendered Notebooks

[Basic Introduction to Julia](https://ScPo-CompEcon.github.io/CoursePack/Html/BasicIntroduction)  
[Basic Introduction to Computing](https://ScPo-CompEcon.github.io/CoursePack/Html/BasicComputing)  
[Numerical Integration](https://ScPo-CompEcon.github.io/CoursePack/Html/integration)  
[Plots.jl](https://ScPo-CompEcon.github.io/CoursePack/Html/PlotsJL)  
[Function Approximation](https://ScPo-CompEcon.github.io/CoursePack/Html/funcapprox)  

### Slides

[Basic Introduction to Julia](https://ScPo-CompEcon.github.io/CoursePack/Slides/BasicIntroduction)  
[Basic Introduction to Computing](https://ScPo-CompEcon.github.io/CoursePack/Slides/BasicComputing)  
[Plots.jl](https://ScPo-CompEcon.github.io/CoursePack/Slides/PlotsJL)  
[Numerical Integration](https://ScPo-CompEcon.github.io/CoursePack/Slides/integration)  
[Function Approximation](https://ScPo-CompEcon.github.io/CoursePack/Slides/funcapprox)  

### Pdf

[Basic Introduction to Julia](https://ScPo-CompEcon.github.io/CoursePack/Pdfs/BasicIntroduction.pdf)  
[Basic Introduction to Computing](https://ScPo-CompEcon.github.io/CoursePack/Pdfs/BasicComputing.pdf)  
[Plots.jl](https://ScPo-CompEcon.github.io/CoursePack/Pdfs/PlotsJL.pdf)    
[Numerical Integration](https://ScPo-CompEcon.github.io/CoursePack/Pdfs/integration.pdf)    
[Function Approximation](https://ScPo-CompEcon.github.io/CoursePack/Pdfs/funcapprox.pdf)  

## Required Packages

Please have all of those installed. This list will be updated!

- [Plots.jl](https://github.com/JuliaPlots/Plots.jl)
- [PyPlot.jl](https://github.com/JuliaPy/PyPlot.jl)
- [PlotlyJS.jl](http://spencerlyon.com/PlotlyJS.jl/)
- [ScPoExample.jl](https://github.com/ScPo-CompEcon/ScPoExample.jl)
- [Gallium.jl](https://github.com/Keno/Gallium.jl)
- [Logging.jl](https://github.com/kmsquire/Logging.jl)
* [DataFrames.jl](https://dataframesjl.readthedocs.io)
* [DataFramesMeta.jl](https://github.com/JuliaStats/DataFramesMeta.jl)
* [Queries.jl](https://github.com/davidanthoff/Query.jl)
- [ForwardDiff.jl](https://github.com/JuliaDiff/ForwardDiff.jl)
- [FastGaussQuadrature.jl](https://github.com/ajt60gaibb/FastGaussQuadrature.jl)
- [Sobol.jl](https://github.com/stevengj/Sobol.jl)



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
rake slides # builds slides
rake offline # builds offline slides; mathjax doesn't work properly offline.
```




