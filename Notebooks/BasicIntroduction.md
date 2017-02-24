
## A Basic Introduction to  Julia

This Introduction is based on [Chris Rackauckas'](www.stochasticlifestyle.com) excellent [IntroToJulia/]([http://ucidatascienceinitiative.github.io/IntroToJulia/) from which I freely copy and paste here.

This quick introduction assumes that you have basic knowledge of some scripting language and provides an example of the Julia syntax. So before we explain anything, let's just treat it like a scripting language, take a head-first dive into Julia, and see what happens.

You'll notice that, given the right syntax, almost everything will "just work". There will be some peculiarities, and these we will be the facts which we will study in much more depth. Usually, these oddies/differences from other scripting languages are "the source of Julia's power".

### This Notebook

* The code in this notebook is live, i.e. it works.
* You can execute a cell by clicking inside it, and then clicking on the "play" button, or you just hit Ctrl+Enter.
* I encourage you to execute and play around with all code cells!

### Problems

Time to start using your noggin. Scattered in this document are problems for you to solve using Julia. Many of the details for solving these problems have been covered, some have not. You may need to use some external resources:

http://docs.julialang.org/en/release-0.5/manual/

https://gitter.im/JuliaLang/julia

Your main forum is [https://discourse.julialang.org](https://discourse.julialang.org)

Solve as many or as few problems as you can. Please work at your own pace, or with others if that's how you're comfortable!

## Documentation and "Hunting"

The main source of information is the [Julia Documentation](http://docs.julialang.org/en/latest/manual/). Julia also provides lots of built-in documentation and ways to find out what's going on. The number of tools for "hunting down what's going on / available" is too numerous to explain in full detail here, so instead this will just touch on what's important. For example, the `?` gets you to the documentation for a type, function, etc.


```julia
?copy

```

    search: copy copy! copysign deepcopy unsafe_copy! cospi complex Complex
    





```
copy(x)
```

Create a shallow copy of `x`: the outer structure is copied, but not all internal values. For example, copying an array produces a new array with identically-same elements as the original.




to see what *methods* are defined by a certain name, use `methods`. Let's see how the methods for the function `+`


```julia
methods(+)
```




163 methods for generic function <b>+</b>:<ul><li> +(x::<b>Bool</b>, z::<b>Complex{Bool}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/complex.jl#L136" target="_blank">complex.jl:136</a></li> <li> +(x::<b>Bool</b>, y::<b>Bool</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/bool.jl#L48" target="_blank">bool.jl:48</a></li> <li> +(x::<b>Bool</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/bool.jl#L45" target="_blank">bool.jl:45</a></li> <li> +<i>{T<:AbstractFloat}</i>(x::<b>Bool</b>, y::<b>T</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/bool.jl#L55" target="_blank">bool.jl:55</a></li> <li> +(x::<b>Bool</b>, z::<b>Complex</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/complex.jl#L143" target="_blank">complex.jl:143</a></li> <li> +(x::<b>Bool</b>, A::<b>AbstractArray{Bool,N<:Any}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/arraymath.jl#L91" target="_blank">arraymath.jl:91</a></li> <li> +(x::<b>Float32</b>, y::<b>Float32</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/float.jl#L239" target="_blank">float.jl:239</a></li> <li> +(x::<b>Float64</b>, y::<b>Float64</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/float.jl#L240" target="_blank">float.jl:240</a></li> <li> +(z::<b>Complex{Bool}</b>, x::<b>Bool</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/complex.jl#L137" target="_blank">complex.jl:137</a></li> <li> +(z::<b>Complex{Bool}</b>, x::<b>Real</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/complex.jl#L151" target="_blank">complex.jl:151</a></li> <li> +(a::<b>Float16</b>, b::<b>Float16</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/float16.jl#L136" target="_blank">float16.jl:136</a></li> <li> +(x::<b>Char</b>, y::<b>Integer</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/char.jl#L40" target="_blank">char.jl:40</a></li> <li> +(c::<b>BigInt</b>, x::<b>BigFloat</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/mpfr.jl#L240" target="_blank">mpfr.jl:240</a></li> <li> +(a::<b>BigInt</b>, b::<b>BigInt</b>, c::<b>BigInt</b>, d::<b>BigInt</b>, e::<b>BigInt</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/gmp.jl#L298" target="_blank">gmp.jl:298</a></li> <li> +(a::<b>BigInt</b>, b::<b>BigInt</b>, c::<b>BigInt</b>, d::<b>BigInt</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/gmp.jl#L291" target="_blank">gmp.jl:291</a></li> <li> +(a::<b>BigInt</b>, b::<b>BigInt</b>, c::<b>BigInt</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/gmp.jl#L285" target="_blank">gmp.jl:285</a></li> <li> +(x::<b>BigInt</b>, y::<b>BigInt</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/gmp.jl#L255" target="_blank">gmp.jl:255</a></li> <li> +(x::<b>BigInt</b>, c::<b>Union{UInt16,UInt32,UInt64,UInt8}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/gmp.jl#L310" target="_blank">gmp.jl:310</a></li> <li> +(x::<b>BigInt</b>, c::<b>Union{Int16,Int32,Int64,Int8}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/gmp.jl#L326" target="_blank">gmp.jl:326</a></li> <li> +(a::<b>BigFloat</b>, b::<b>BigFloat</b>, c::<b>BigFloat</b>, d::<b>BigFloat</b>, e::<b>BigFloat</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/mpfr.jl#L388" target="_blank">mpfr.jl:388</a></li> <li> +(a::<b>BigFloat</b>, b::<b>BigFloat</b>, c::<b>BigFloat</b>, d::<b>BigFloat</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/mpfr.jl#L381" target="_blank">mpfr.jl:381</a></li> <li> +(a::<b>BigFloat</b>, b::<b>BigFloat</b>, c::<b>BigFloat</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/mpfr.jl#L375" target="_blank">mpfr.jl:375</a></li> <li> +(x::<b>BigFloat</b>, c::<b>BigInt</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/mpfr.jl#L236" target="_blank">mpfr.jl:236</a></li> <li> +(x::<b>BigFloat</b>, y::<b>BigFloat</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/mpfr.jl#L205" target="_blank">mpfr.jl:205</a></li> <li> +(x::<b>BigFloat</b>, c::<b>Union{UInt16,UInt32,UInt64,UInt8}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/mpfr.jl#L212" target="_blank">mpfr.jl:212</a></li> <li> +(x::<b>BigFloat</b>, c::<b>Union{Int16,Int32,Int64,Int8}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/mpfr.jl#L220" target="_blank">mpfr.jl:220</a></li> <li> +(x::<b>BigFloat</b>, c::<b>Union{Float16,Float32,Float64}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/mpfr.jl#L228" target="_blank">mpfr.jl:228</a></li> <li> +<i>{T}</i>(B::<b>BitArray{2}</b>, J::<b>UniformScaling{T}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/uniformscaling.jl#L38" target="_blank">linalg/uniformscaling.jl:38</a></li> <li> +(a::<b>Base.Pkg.Resolve.VersionWeights.VWPreBuildItem</b>, b::<b>Base.Pkg.Resolve.VersionWeights.VWPreBuildItem</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/pkg/resolve/versionweight.jl#L85" target="_blank">pkg/resolve/versionweight.jl:85</a></li> <li> +(a::<b>Base.Pkg.Resolve.VersionWeights.VWPreBuild</b>, b::<b>Base.Pkg.Resolve.VersionWeights.VWPreBuild</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/pkg/resolve/versionweight.jl#L131" target="_blank">pkg/resolve/versionweight.jl:131</a></li> <li> +(a::<b>Base.Pkg.Resolve.VersionWeights.VersionWeight</b>, b::<b>Base.Pkg.Resolve.VersionWeights.VersionWeight</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/pkg/resolve/versionweight.jl#L185" target="_blank">pkg/resolve/versionweight.jl:185</a></li> <li> +(a::<b>Base.Pkg.Resolve.MaxSum.FieldValues.FieldValue</b>, b::<b>Base.Pkg.Resolve.MaxSum.FieldValues.FieldValue</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/pkg/resolve/fieldvalue.jl#L44" target="_blank">pkg/resolve/fieldvalue.jl:44</a></li> <li> +(x::<b>Base.Dates.CompoundPeriod</b>, y::<b>Base.Dates.CompoundPeriod</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L314" target="_blank">dates/periods.jl:314</a></li> <li> +(x::<b>Base.Dates.CompoundPeriod</b>, y::<b>Base.Dates.Period</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L312" target="_blank">dates/periods.jl:312</a></li> <li> +(x::<b>Base.Dates.CompoundPeriod</b>, y::<b>Base.Dates.TimeType</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L359" target="_blank">dates/periods.jl:359</a></li> <li> +(dt::<b>DateTime</b>, z::<b>Base.Dates.Month</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L37" target="_blank">dates/arithmetic.jl:37</a></li> <li> +(dt::<b>DateTime</b>, y::<b>Base.Dates.Year</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L13" target="_blank">dates/arithmetic.jl:13</a></li> <li> +(x::<b>DateTime</b>, y::<b>Base.Dates.Period</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L64" target="_blank">dates/arithmetic.jl:64</a></li> <li> +(x::<b>Date</b>, y::<b>Base.Dates.Day</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L62" target="_blank">dates/arithmetic.jl:62</a></li> <li> +(x::<b>Date</b>, y::<b>Base.Dates.Week</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L60" target="_blank">dates/arithmetic.jl:60</a></li> <li> +(dt::<b>Date</b>, z::<b>Base.Dates.Month</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L43" target="_blank">dates/arithmetic.jl:43</a></li> <li> +(dt::<b>Date</b>, y::<b>Base.Dates.Year</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L17" target="_blank">dates/arithmetic.jl:17</a></li> <li> +(y::<b>AbstractFloat</b>, x::<b>Bool</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/bool.jl#L57" target="_blank">bool.jl:57</a></li> <li> +<i>{T<:Union{Int128,Int16,Int32,Int64,Int8,UInt128,UInt16,UInt32,UInt64,UInt8}}</i>(x::<b>T</b>, y::<b>T</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/int.jl#L32" target="_blank">int.jl:32</a></li> <li> +(x::<b>Integer</b>, y::<b>Ptr</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/pointer.jl#L108" target="_blank">pointer.jl:108</a></li> <li> +(z::<b>Complex</b>, w::<b>Complex</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/complex.jl#L125" target="_blank">complex.jl:125</a></li> <li> +(z::<b>Complex</b>, x::<b>Bool</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/complex.jl#L144" target="_blank">complex.jl:144</a></li> <li> +(x::<b>Real</b>, z::<b>Complex{Bool}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/complex.jl#L150" target="_blank">complex.jl:150</a></li> <li> +(x::<b>Real</b>, z::<b>Complex</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/complex.jl#L162" target="_blank">complex.jl:162</a></li> <li> +(z::<b>Complex</b>, x::<b>Real</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/complex.jl#L163" target="_blank">complex.jl:163</a></li> <li> +(x::<b>Rational</b>, y::<b>Rational</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/rational.jl#L199" target="_blank">rational.jl:199</a></li> <li> +(x::<b>Integer</b>, y::<b>Char</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/char.jl#L41" target="_blank">char.jl:41</a></li> <li> +<i>{N}</i>(i::<b>Integer</b>, index::<b>CartesianIndex{N}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/multidimensional.jl#L58" target="_blank">multidimensional.jl:58</a></li> <li> +(c::<b>Union{UInt16,UInt32,UInt64,UInt8}</b>, x::<b>BigInt</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/gmp.jl#L314" target="_blank">gmp.jl:314</a></li> <li> +(c::<b>Union{Int16,Int32,Int64,Int8}</b>, x::<b>BigInt</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/gmp.jl#L327" target="_blank">gmp.jl:327</a></li> <li> +(c::<b>Union{UInt16,UInt32,UInt64,UInt8}</b>, x::<b>BigFloat</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/mpfr.jl#L216" target="_blank">mpfr.jl:216</a></li> <li> +(c::<b>Union{Int16,Int32,Int64,Int8}</b>, x::<b>BigFloat</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/mpfr.jl#L224" target="_blank">mpfr.jl:224</a></li> <li> +(c::<b>Union{Float16,Float32,Float64}</b>, x::<b>BigFloat</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/mpfr.jl#L232" target="_blank">mpfr.jl:232</a></li> <li> +(x::<b>Irrational</b>, y::<b>Irrational</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/irrationals.jl#L88" target="_blank">irrationals.jl:88</a></li> <li> +(x::<b>Number</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/operators.jl#L115" target="_blank">operators.jl:115</a></li> <li> +<i>{T<:Number}</i>(x::<b>T</b>, y::<b>T</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/promotion.jl#L255" target="_blank">promotion.jl:255</a></li> <li> +(x::<b>Number</b>, y::<b>Number</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/promotion.jl#L190" target="_blank">promotion.jl:190</a></li> <li> +(r1::<b>OrdinalRange</b>, r2::<b>OrdinalRange</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/operators.jl#L505" target="_blank">operators.jl:505</a></li> <li> +<i>{T<:AbstractFloat}</i>(r1::<b>FloatRange{T}</b>, r2::<b>FloatRange{T}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/operators.jl#L512" target="_blank">operators.jl:512</a></li> <li> +<i>{T<:AbstractFloat}</i>(r1::<b>LinSpace{T}</b>, r2::<b>LinSpace{T}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/operators.jl#L531" target="_blank">operators.jl:531</a></li> <li> +(r1::<b>Union{FloatRange,LinSpace,OrdinalRange}</b>, r2::<b>Union{FloatRange,LinSpace,OrdinalRange}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/operators.jl#L544" target="_blank">operators.jl:544</a></li> <li> +(x::<b>Ptr</b>, y::<b>Integer</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/pointer.jl#L106" target="_blank">pointer.jl:106</a></li> <li> +(A::<b>BitArray</b>, B::<b>BitArray</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/bitarray.jl#L1042" target="_blank">bitarray.jl:1042</a></li> <li> +(A::<b>Array{T<:Any,2}</b>, B::<b>Diagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L121" target="_blank">linalg/special.jl:121</a></li> <li> +(A::<b>Array{T<:Any,2}</b>, B::<b>Bidiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L121" target="_blank">linalg/special.jl:121</a></li> <li> +(A::<b>Array{T<:Any,2}</b>, B::<b>Tridiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L121" target="_blank">linalg/special.jl:121</a></li> <li> +(A::<b>Array{T<:Any,2}</b>, B::<b>SymTridiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L130" target="_blank">linalg/special.jl:130</a></li> <li> +(A::<b>Array{T<:Any,2}</b>, B::<b>Base.LinAlg.AbstractTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L158" target="_blank">linalg/special.jl:158</a></li> <li> +(A::<b>Array</b>, B::<b>SparseMatrixCSC</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/sparse/sparsematrix.jl#L1711" target="_blank">sparse/sparsematrix.jl:1711</a></li> <li> +<i>{P<:Union{Base.Dates.CompoundPeriod,Base.Dates.Period}}</i>(x::<b>Union{Base.ReshapedArray{P,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray{P,N<:Any},SubArray{P,N<:Any,A<:Union{Base.ReshapedArray{T<:Any,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray},I<:Tuple{Vararg{Union{Base.AbstractCartesianIndex,Colon,Int64,Range{Int64}},N<:Any}},L<:Any}}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L323" target="_blank">dates/periods.jl:323</a></li> <li> +(A::<b>AbstractArray{Bool,N<:Any}</b>, x::<b>Bool</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/arraymath.jl#L90" target="_blank">arraymath.jl:90</a></li> <li> +(A::<b>SymTridiagonal</b>, B::<b>SymTridiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/tridiag.jl#L96" target="_blank">linalg/tridiag.jl:96</a></li> <li> +(A::<b>Tridiagonal</b>, B::<b>Tridiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/tridiag.jl#L494" target="_blank">linalg/tridiag.jl:494</a></li> <li> +(A::<b>UpperTriangular</b>, B::<b>UpperTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/triangular.jl#L357" target="_blank">linalg/triangular.jl:357</a></li> <li> +(A::<b>LowerTriangular</b>, B::<b>LowerTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/triangular.jl#L358" target="_blank">linalg/triangular.jl:358</a></li> <li> +(A::<b>UpperTriangular</b>, B::<b>Base.LinAlg.UnitUpperTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/triangular.jl#L359" target="_blank">linalg/triangular.jl:359</a></li> <li> +(A::<b>LowerTriangular</b>, B::<b>Base.LinAlg.UnitLowerTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/triangular.jl#L360" target="_blank">linalg/triangular.jl:360</a></li> <li> +(A::<b>Base.LinAlg.UnitUpperTriangular</b>, B::<b>UpperTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/triangular.jl#L361" target="_blank">linalg/triangular.jl:361</a></li> <li> +(A::<b>Base.LinAlg.UnitLowerTriangular</b>, B::<b>LowerTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/triangular.jl#L362" target="_blank">linalg/triangular.jl:362</a></li> <li> +(A::<b>Base.LinAlg.UnitUpperTriangular</b>, B::<b>Base.LinAlg.UnitUpperTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/triangular.jl#L363" target="_blank">linalg/triangular.jl:363</a></li> <li> +(A::<b>Base.LinAlg.UnitLowerTriangular</b>, B::<b>Base.LinAlg.UnitLowerTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/triangular.jl#L364" target="_blank">linalg/triangular.jl:364</a></li> <li> +(A::<b>Base.LinAlg.AbstractTriangular</b>, B::<b>Base.LinAlg.AbstractTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/triangular.jl#L365" target="_blank">linalg/triangular.jl:365</a></li> <li> +(Da::<b>Diagonal</b>, Db::<b>Diagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/diagonal.jl#L110" target="_blank">linalg/diagonal.jl:110</a></li> <li> +(A::<b>Bidiagonal</b>, B::<b>Bidiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/bidiag.jl#L256" target="_blank">linalg/bidiag.jl:256</a></li> <li> +(UL::<b>UpperTriangular</b>, J::<b>UniformScaling</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/uniformscaling.jl#L55" target="_blank">linalg/uniformscaling.jl:55</a></li> <li> +(UL::<b>Base.LinAlg.UnitUpperTriangular</b>, J::<b>UniformScaling</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/uniformscaling.jl#L58" target="_blank">linalg/uniformscaling.jl:58</a></li> <li> +(UL::<b>LowerTriangular</b>, J::<b>UniformScaling</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/uniformscaling.jl#L55" target="_blank">linalg/uniformscaling.jl:55</a></li> <li> +(UL::<b>Base.LinAlg.UnitLowerTriangular</b>, J::<b>UniformScaling</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/uniformscaling.jl#L58" target="_blank">linalg/uniformscaling.jl:58</a></li> <li> +(A::<b>Diagonal</b>, B::<b>Bidiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L120" target="_blank">linalg/special.jl:120</a></li> <li> +(A::<b>Bidiagonal</b>, B::<b>Diagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L121" target="_blank">linalg/special.jl:121</a></li> <li> +(A::<b>Diagonal</b>, B::<b>Tridiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L120" target="_blank">linalg/special.jl:120</a></li> <li> +(A::<b>Tridiagonal</b>, B::<b>Diagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L121" target="_blank">linalg/special.jl:121</a></li> <li> +(A::<b>Diagonal</b>, B::<b>Array{T<:Any,2}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L120" target="_blank">linalg/special.jl:120</a></li> <li> +(A::<b>Bidiagonal</b>, B::<b>Tridiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L120" target="_blank">linalg/special.jl:120</a></li> <li> +(A::<b>Tridiagonal</b>, B::<b>Bidiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L121" target="_blank">linalg/special.jl:121</a></li> <li> +(A::<b>Bidiagonal</b>, B::<b>Array{T<:Any,2}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L120" target="_blank">linalg/special.jl:120</a></li> <li> +(A::<b>Tridiagonal</b>, B::<b>Array{T<:Any,2}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L120" target="_blank">linalg/special.jl:120</a></li> <li> +(A::<b>SymTridiagonal</b>, B::<b>Tridiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L129" target="_blank">linalg/special.jl:129</a></li> <li> +(A::<b>Tridiagonal</b>, B::<b>SymTridiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L130" target="_blank">linalg/special.jl:130</a></li> <li> +(A::<b>SymTridiagonal</b>, B::<b>Array{T<:Any,2}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L129" target="_blank">linalg/special.jl:129</a></li> <li> +(A::<b>Diagonal</b>, B::<b>SymTridiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L138" target="_blank">linalg/special.jl:138</a></li> <li> +(A::<b>SymTridiagonal</b>, B::<b>Diagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L139" target="_blank">linalg/special.jl:139</a></li> <li> +(A::<b>Bidiagonal</b>, B::<b>SymTridiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L138" target="_blank">linalg/special.jl:138</a></li> <li> +(A::<b>SymTridiagonal</b>, B::<b>Bidiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L139" target="_blank">linalg/special.jl:139</a></li> <li> +(A::<b>Diagonal</b>, B::<b>UpperTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L150" target="_blank">linalg/special.jl:150</a></li> <li> +(A::<b>UpperTriangular</b>, B::<b>Diagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L151" target="_blank">linalg/special.jl:151</a></li> <li> +(A::<b>Diagonal</b>, B::<b>Base.LinAlg.UnitUpperTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L150" target="_blank">linalg/special.jl:150</a></li> <li> +(A::<b>Base.LinAlg.UnitUpperTriangular</b>, B::<b>Diagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L151" target="_blank">linalg/special.jl:151</a></li> <li> +(A::<b>Diagonal</b>, B::<b>LowerTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L150" target="_blank">linalg/special.jl:150</a></li> <li> +(A::<b>LowerTriangular</b>, B::<b>Diagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L151" target="_blank">linalg/special.jl:151</a></li> <li> +(A::<b>Diagonal</b>, B::<b>Base.LinAlg.UnitLowerTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L150" target="_blank">linalg/special.jl:150</a></li> <li> +(A::<b>Base.LinAlg.UnitLowerTriangular</b>, B::<b>Diagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L151" target="_blank">linalg/special.jl:151</a></li> <li> +(A::<b>Base.LinAlg.AbstractTriangular</b>, B::<b>SymTridiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L157" target="_blank">linalg/special.jl:157</a></li> <li> +(A::<b>SymTridiagonal</b>, B::<b>Base.LinAlg.AbstractTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L158" target="_blank">linalg/special.jl:158</a></li> <li> +(A::<b>Base.LinAlg.AbstractTriangular</b>, B::<b>Tridiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L157" target="_blank">linalg/special.jl:157</a></li> <li> +(A::<b>Tridiagonal</b>, B::<b>Base.LinAlg.AbstractTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L158" target="_blank">linalg/special.jl:158</a></li> <li> +(A::<b>Base.LinAlg.AbstractTriangular</b>, B::<b>Bidiagonal</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L157" target="_blank">linalg/special.jl:157</a></li> <li> +(A::<b>Bidiagonal</b>, B::<b>Base.LinAlg.AbstractTriangular</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L158" target="_blank">linalg/special.jl:158</a></li> <li> +(A::<b>Base.LinAlg.AbstractTriangular</b>, B::<b>Array{T<:Any,2}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/special.jl#L157" target="_blank">linalg/special.jl:157</a></li> <li> +<i>{P<:Union{Base.Dates.CompoundPeriod,Base.Dates.Period}}</i>(Y::<b>Union{Base.ReshapedArray{P,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray{P,N<:Any},SubArray{P,N<:Any,A<:Union{Base.ReshapedArray{T<:Any,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray},I<:Tuple{Vararg{Union{Base.AbstractCartesianIndex,Colon,Int64,Range{Int64}},N<:Any}},L<:Any}}</b>, x::<b>Union{Base.Dates.CompoundPeriod,Base.Dates.Period}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L337" target="_blank">dates/periods.jl:337</a></li> <li> +<i>{P<:Union{Base.Dates.CompoundPeriod,Base.Dates.Period},Q<:Union{Base.Dates.CompoundPeriod,Base.Dates.Period}}</i>(X::<b>Union{Base.ReshapedArray{P,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray{P,N<:Any},SubArray{P,N<:Any,A<:Union{Base.ReshapedArray{T<:Any,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray},I<:Tuple{Vararg{Union{Base.AbstractCartesianIndex,Colon,Int64,Range{Int64}},N<:Any}},L<:Any}}</b>, Y::<b>Union{Base.ReshapedArray{Q,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray{Q,N<:Any},SubArray{Q,N<:Any,A<:Union{Base.ReshapedArray{T<:Any,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray},I<:Tuple{Vararg{Union{Base.AbstractCartesianIndex,Colon,Int64,Range{Int64}},N<:Any}},L<:Any}}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L338" target="_blank">dates/periods.jl:338</a></li> <li> +<i>{T<:Base.Dates.TimeType,P<:Union{Base.Dates.CompoundPeriod,Base.Dates.Period}}</i>(x::<b>Union{Base.ReshapedArray{P,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray{P,N<:Any},SubArray{P,N<:Any,A<:Union{Base.ReshapedArray{T<:Any,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray},I<:Tuple{Vararg{Union{Base.AbstractCartesianIndex,Colon,Int64,Range{Int64}},N<:Any}},L<:Any}}</b>, y::<b>T</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L83" target="_blank">dates/arithmetic.jl:83</a></li> <li> +<i>{T<:Base.Dates.TimeType}</i>(r::<b>Range{T}</b>, x::<b>Base.Dates.Period</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/ranges.jl#L39" target="_blank">dates/ranges.jl:39</a></li> <li> +<i>{Tv1,Ti1,Tv2,Ti2}</i>(A_1::<b>SparseMatrixCSC{Tv1,Ti1}</b>, A_2::<b>SparseMatrixCSC{Tv2,Ti2}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/sparse/sparsematrix.jl#L1697" target="_blank">sparse/sparsematrix.jl:1697</a></li> <li> +(A::<b>SparseMatrixCSC</b>, B::<b>Array</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/sparse/sparsematrix.jl#L1709" target="_blank">sparse/sparsematrix.jl:1709</a></li> <li> +(A::<b>SparseMatrixCSC</b>, J::<b>UniformScaling</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/sparse/sparsematrix.jl#L3811" target="_blank">sparse/sparsematrix.jl:3811</a></li> <li> +(x::<b>AbstractSparseArray{Tv<:Any,Ti<:Any,1}</b>, y::<b>AbstractSparseArray{Tv<:Any,Ti<:Any,1}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/sparse/sparsevector.jl#L1179" target="_blank">sparse/sparsevector.jl:1179</a></li> <li> +(x::<b>Union{Base.ReshapedArray{T<:Any,1,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray{T<:Any,1},SubArray{T<:Any,1,A<:Union{Base.ReshapedArray{T<:Any,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray},I<:Tuple{Vararg{Union{Base.AbstractCartesianIndex,Colon,Int64,Range{Int64}},N<:Any}},L<:Any}}</b>, y::<b>AbstractSparseArray{Tv<:Any,Ti<:Any,1}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/sparse/sparsevector.jl#L1180" target="_blank">sparse/sparsevector.jl:1180</a></li> <li> +(x::<b>AbstractSparseArray{Tv<:Any,Ti<:Any,1}</b>, y::<b>Union{Base.ReshapedArray{T<:Any,1,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray{T<:Any,1},SubArray{T<:Any,1,A<:Union{Base.ReshapedArray{T<:Any,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray},I<:Tuple{Vararg{Union{Base.AbstractCartesianIndex,Colon,Int64,Range{Int64}},N<:Any}},L<:Any}}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/sparse/sparsevector.jl#L1181" target="_blank">sparse/sparsevector.jl:1181</a></li> <li> +<i>{T<:Number}</i>(x::<b>AbstractArray{T,N<:Any}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/abstractarraymath.jl#L91" target="_blank">abstractarraymath.jl:91</a></li> <li> +<i>{R,S}</i>(A::<b>AbstractArray{R,N<:Any}</b>, B::<b>AbstractArray{S,N<:Any}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/arraymath.jl#L49" target="_blank">arraymath.jl:49</a></li> <li> +(A::<b>AbstractArray</b>, x::<b>Number</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/arraymath.jl#L94" target="_blank">arraymath.jl:94</a></li> <li> +(x::<b>Number</b>, A::<b>AbstractArray</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/arraymath.jl#L95" target="_blank">arraymath.jl:95</a></li> <li> +<i>{N}</i>(index1::<b>CartesianIndex{N}</b>, index2::<b>CartesianIndex{N}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/multidimensional.jl#L52" target="_blank">multidimensional.jl:52</a></li> <li> +<i>{N}</i>(index::<b>CartesianIndex{N}</b>, i::<b>Integer</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/multidimensional.jl#L57" target="_blank">multidimensional.jl:57</a></li> <li> +(J1::<b>UniformScaling</b>, J2::<b>UniformScaling</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/uniformscaling.jl#L37" target="_blank">linalg/uniformscaling.jl:37</a></li> <li> +(J::<b>UniformScaling</b>, B::<b>BitArray{2}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/uniformscaling.jl#L39" target="_blank">linalg/uniformscaling.jl:39</a></li> <li> +(J::<b>UniformScaling</b>, A::<b>AbstractArray{T<:Any,2}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/uniformscaling.jl#L40" target="_blank">linalg/uniformscaling.jl:40</a></li> <li> +(J::<b>UniformScaling</b>, x::<b>Number</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/uniformscaling.jl#L41" target="_blank">linalg/uniformscaling.jl:41</a></li> <li> +(x::<b>Number</b>, J::<b>UniformScaling</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/uniformscaling.jl#L42" target="_blank">linalg/uniformscaling.jl:42</a></li> <li> +<i>{TA,TJ}</i>(A::<b>AbstractArray{TA,2}</b>, J::<b>UniformScaling{TJ}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/linalg/uniformscaling.jl#L102" target="_blank">linalg/uniformscaling.jl:102</a></li> <li> +<i>{T}</i>(a::<b>Base.Pkg.Resolve.VersionWeights.HierarchicalValue{T}</b>, b::<b>Base.Pkg.Resolve.VersionWeights.HierarchicalValue{T}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/pkg/resolve/versionweight.jl#L23" target="_blank">pkg/resolve/versionweight.jl:23</a></li> <li> +<i>{P<:Base.Dates.Period}</i>(x::<b>P</b>, y::<b>P</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L70" target="_blank">dates/periods.jl:70</a></li> <li> +(x::<b>Base.Dates.Period</b>, y::<b>Base.Dates.Period</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L311" target="_blank">dates/periods.jl:311</a></li> <li> +(y::<b>Base.Dates.Period</b>, x::<b>Base.Dates.CompoundPeriod</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L313" target="_blank">dates/periods.jl:313</a></li> <li> +(y::<b>Base.Dates.Period</b>, x::<b>Base.Dates.TimeType</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L66" target="_blank">dates/arithmetic.jl:66</a></li> <li> +<i>{T<:Base.Dates.TimeType}</i>(x::<b>Base.Dates.Period</b>, r::<b>Range{T}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/ranges.jl#L40" target="_blank">dates/ranges.jl:40</a></li> <li> +(x::<b>Union{Base.Dates.CompoundPeriod,Base.Dates.Period}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L322" target="_blank">dates/periods.jl:322</a></li> <li> +<i>{P<:Union{Base.Dates.CompoundPeriod,Base.Dates.Period}}</i>(x::<b>Union{Base.Dates.CompoundPeriod,Base.Dates.Period}</b>, Y::<b>Union{Base.ReshapedArray{P,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray{P,N<:Any},SubArray{P,N<:Any,A<:Union{Base.ReshapedArray{T<:Any,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray},I<:Tuple{Vararg{Union{Base.AbstractCartesianIndex,Colon,Int64,Range{Int64}},N<:Any}},L<:Any}}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L336" target="_blank">dates/periods.jl:336</a></li> <li> +(x::<b>Base.Dates.TimeType</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L8" target="_blank">dates/arithmetic.jl:8</a></li> <li> +(a::<b>Base.Dates.TimeType</b>, b::<b>Base.Dates.Period</b>, c::<b>Base.Dates.Period</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L348" target="_blank">dates/periods.jl:348</a></li> <li> +(a::<b>Base.Dates.TimeType</b>, b::<b>Base.Dates.Period</b>, c::<b>Base.Dates.Period</b>, d::<b>Base.Dates.Period...</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L350" target="_blank">dates/periods.jl:350</a></li> <li> +(x::<b>Base.Dates.TimeType</b>, y::<b>Base.Dates.CompoundPeriod</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/periods.jl#L354" target="_blank">dates/periods.jl:354</a></li> <li> +(x::<b>Base.Dates.Instant</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L4" target="_blank">dates/arithmetic.jl:4</a></li> <li> +<i>{T<:Base.Dates.TimeType}</i>(x::<b>AbstractArray{T,N<:Any}</b>, y::<b>Union{Base.Dates.CompoundPeriod,Base.Dates.Period}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L76" target="_blank">dates/arithmetic.jl:76</a></li> <li> +<i>{T<:Base.Dates.TimeType}</i>(y::<b>Union{Base.Dates.CompoundPeriod,Base.Dates.Period}</b>, x::<b>AbstractArray{T,N<:Any}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L77" target="_blank">dates/arithmetic.jl:77</a></li> <li> +<i>{P<:Union{Base.Dates.CompoundPeriod,Base.Dates.Period}}</i>(y::<b>Base.Dates.TimeType</b>, x::<b>Union{Base.ReshapedArray{P,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray{P,N<:Any},SubArray{P,N<:Any,A<:Union{Base.ReshapedArray{T<:Any,N<:Any,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N<:Any}}},DenseArray},I<:Tuple{Vararg{Union{Base.AbstractCartesianIndex,Colon,Int64,Range{Int64}},N<:Any}},L<:Any}}</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/dates/arithmetic.jl#L84" target="_blank">dates/arithmetic.jl:84</a></li> <li> +(a, b, c, xs...) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/operators.jl#L138" target="_blank">operators.jl:138</a></li> </ul>




```julia
fieldnames(LinSpace)
```




    4-element Array{Symbol,1}:
     :start  
     :stop   
     :len    
     :divisor



and find out which method was used with the `@which` macro:


```julia
@which copy([1,2,3])
```




copy<i>{T<:Array{T,N}}</i>(a::<b>T</b>) at <a href="https://github.com/JuliaLang/julia/tree/3c9d75391c72d7c32eea75ff187ce77b2d5effc8/base/array.jl#L70" target="_blank">array.jl:70</a>



copy<i>{T<:Array{T,N}}</i>(a::<b>T</b>) at <a href="https://github.com/JuliaLang/julia/tree/9c76c3e89a8c384f324c2e0b84ad28ceef9ab69d/base/array.jl#L70" target="_blank">array.jl:70</a>



Notice that this gives you a link to the source code where the function is defined.

Lastly, we can find out what type a variable is with the `typeof` function:


```julia
a = [1.0;2;3]
typeof(a)
```




    Array{Float64,1}



We can also get a direct view of source code with


```julia
@edit copy([1,2,3])
```

    Unknown editor: no line number information passed.
    The method is defined at line 70.


### Array Syntax

The array syntax is similar to MATLAB's conventions.


```julia
a = Vector{Float64}(5) # Create a length 5 Vector (dimension 1 array) of Float64's

a = [1;2;3;4;5] # Create the column vector [1 2 3 4 5]

a = [1 2 3 4] # Create the row vector [1 2 3 4]

a[3] = 2 # Change the third element of a (using linear indexing) to 2

b = Matrix{Float64}(4,2) # Define a Matrix of Float64's of size (4,2)

c = Array{Float64}(4,5,6,7) # Define a (4,5,6,7) array of Float64's 

e = falses(4,4)

f = trues(5,2)

#checkout more at http://docs.julialang.org/en/stable/manual/arrays/

mat    = [1 2 3 4
          3 4 5 6
          4 4 4 6
          3 3 3 3] #Define the matrix inline 

mat[1,2] = 4 # Set element (1,2) (row 1, column 2) to 4

mat

```




    4×4 Array{Int64,2}:
     1  4  3  4
     3  4  5  6
     4  4  4  6
     3  3  3  3



Note that, in the console (called the REPL), you can use `;` to surpress the output. In a script this is done automatically. Note that the "value" of an array is its pointer to the memory location. **This means that arrays which are set equal affect the same values**:


```julia
a = [1;3;4]
b = a
b[1] = 10
a
```




    3-element Array{Int64,1}:
     10
      3
      4



To set an array equal to the values to another array, use copy


```julia
a = [1;4;5]
b = copy(a)
b[1] = 10
a
```




    3-element Array{Int64,1}:
     1
     4
     5



We can also make an array of a similar size and shape via the function `similar`, or make an array of zeros/ones with `zeros` or `ones` respectively:


```julia
c = similar(a)
d = zeros(a)
e = ones(a)
println(c); println(d); println(e)
```

    [4478721872,4409999584,4493003984]
    [0,0,0]
    [1,1,1]


#### Array Indexing

You can index arrays in 2 ways: linear index, and multidimensional index. In general, the linear index is faster.


```julia
z = rand(3,3,3)
z[1,3,2]  # multidimensional
z[4]  # linear index: julia stores columnwise
using Base.Test
@test z[1,3,2] == z[sub2ind(size(z),1,3,2)]
```




    Test Passed
      Expression: z[1,3,2] == z[sub2ind(size(z),1,3,2)]
       Evaluated: 0.11869688372427212 == 0.11869688372427212



Arrays can be of any type, specified by the type parameter. One interesting thing is that this means that arrays can be of arrays:


```julia
a = Vector{Vector{Float64}}(3)
a[1] = [1;2;3]
a[2] = [1;2]
a[3] = [3;4;5]
a
```




    3-element Array{Array{Float64,1},1}:
     [1.0,2.0,3.0]
     [1.0,2.0]    
     [3.0,4.0,5.0]



You can create empty arrays and push onto them:


```julia
x = Int[]
for i in 10:-2:0
    println("x is now equal to $x")
    push!(x,i)   # remember that ! for later.
end
x

y = zeros(Int,6)
vals = 10:-2:0
for i in 1:6
    y[i] = vals[i]
    println("y is = $y")
end
```

    x is now equal to Int64[]
    x is now equal to [10]
    x is now equal to [10,8]
    x is now equal to [10,8,6]
    x is now equal to [10,8,6,4]
    x is now equal to [10,8,6,4,2]
    y is = [10,0,0,0,0,0]
    y is = [10,8,0,0,0,0]
    y is = [10,8,6,0,0,0]
    y is = [10,8,6,4,0,0]
    y is = [10,8,6,4,2,0]
    y is = [10,8,6,4,2,0]


### Array Comprehensions

A very powerful way to generate arrays in julia are [comprehensions](http://docs.julialang.org/en/stable/manual/arrays/#comprehensions). Imagine you want to fill a (3,5,6) array with the values of a function `foo` that takes 3 arguments (one for each dimension):


```julia
foo(x,y,z) = sin(x)*0.5y^0.5 + z^2
d = [foo(i,j,k) for i in 1:3, j in linspace(0.01,0.1,5), k in [log(l) for l in 2:7]]
```




    3×5×6 Array{Float64,3}:
    [:, :, 1] =
     0.522527  0.556302  0.579124  0.597581  0.613501
     0.525918  0.562416  0.587078  0.607022  0.624226
     0.487509  0.493173  0.497001  0.500096  0.502766
    
    [:, :, 2] =
     1.24902  1.2828   1.30562  1.32408  1.34   
     1.25241  1.28891  1.31357  1.33352  1.35072
     1.214    1.21967  1.2235   1.22659  1.22926
    
    [:, :, 3] =
     1.96389  1.99766  2.02048  2.03894  2.05486
     1.96728  2.00378  2.02844  2.04838  2.06558
     1.92887  1.93453  1.93836  1.94146  1.94413
    
    [:, :, 4] =
     2.63236  2.66614  2.68896  2.70742  2.72334
     2.63576  2.67225  2.69691  2.71686  2.73406
     2.59735  2.60301  2.60684  2.60993  2.6126 
    
    [:, :, 5] =
     3.25248  3.28625  3.30907  3.32753  3.34345
     3.25587  3.29236  3.31703  3.33697  3.35417
     3.21746  3.22312  3.22695  3.23005  3.23272
    
    [:, :, 6] =
     3.82864  3.86242  3.88524  3.90369  3.91961
     3.83203  3.86853  3.89319  3.91314  3.93034
     3.79362  3.79929  3.80311  3.80621  3.80888



### Broadcasting

You can perform operations element-wise on an array with the `.` syntax. For example, do `A .+ B` to sum elements of A and B elementwise. Of course they need to be compatible dimensionwise.

Julia v0.5 is now able to broadcast any function over an array in an efficient manner:


```julia
fff(x) = x^(2/3)
@test fff.(d) == broadcast(fff,d)
```




    Test Passed
      Expression: fff.(d) == broadcast(fff,d)
       Evaluated: [0.648742 0.676406 … 0.709465 0.722011; 0.651546 0.681352 … 0.716918 0.7304; 0.619425 0.624213 … 0.630041 0.632282]
    
    [1.15979 1.18061 … 1.2058 1.21545; 1.16189 1.18436 … 1.21153 1.22192; 1.13801 1.14155 … 1.14586 1.14753]
    
    [1.56823 1.58616 … 1.60794 1.6163; 1.57004 1.5894 … 1.6129 1.62192; 1.54954 1.55257 … 1.55627 1.5577]
    
    [1.90647 1.92275 … 1.94254 1.95015; 1.90811 1.92568 … 1.94705 1.95527; 1.88953 1.89227 … 1.89563 1.89692]
    
    [2.19521 2.21038 … 2.22885 2.23596; 2.19674 2.21312 … 2.23307 2.24073; 2.17942 2.18198 … 2.18511 2.18631]
    
    [2.44735 2.46172 … 2.47923 2.48597; 2.4488 2.46432 … 2.48323 2.4905; 2.43241 2.43483 … 2.43778 2.43892] == [0.648742 0.676406 … 0.709465 0.722011; 0.651546 0.681352 … 0.716918 0.7304; 0.619425 0.624213 … 0.630041 0.632282]
    
    [1.15979 1.18061 … 1.2058 1.21545; 1.16189 1.18436 … 1.21153 1.22192; 1.13801 1.14155 … 1.14586 1.14753]
    
    [1.56823 1.58616 … 1.60794 1.6163; 1.57004 1.5894 … 1.6129 1.62192; 1.54954 1.55257 … 1.55627 1.5577]
    
    [1.90647 1.92275 … 1.94254 1.95015; 1.90811 1.92568 … 1.94705 1.95527; 1.88953 1.89227 … 1.89563 1.89692]
    
    [2.19521 2.21038 … 2.22885 2.23596; 2.19674 2.21312 … 2.23307 2.24073; 2.17942 2.18198 … 2.18511 2.18631]
    
    [2.44735 2.46172 … 2.47923 2.48597; 2.4488 2.46432 … 2.48323 2.4905; 2.43241 2.43483 … 2.43778 2.43892]



---------------------

#### Question 1

Can you explain the following behavior? Julia's community values consistancy of the rules, so all of the behavior is deducible from simple rules. (Hint: I have noted all of the rules involved here).


```julia
a
```




    3-element Array{Array{Float64,1},1}:
     [1.0,2.0,3.0]
     [1.0,2.0]    
     [3.0,4.0,5.0]




```julia
b = a
println("a=$a")
b[1] = [1;4;5]
a
```

    a=Array{Float64,1}[[1.0,2.0,3.0],[1.0,2.0],[3.0,4.0,5.0]]





    3-element Array{Array{Float64,1},1}:
     [1.0,4.0,5.0]
     [1.0,2.0]    
     [3.0,4.0,5.0]



----------------------------------------

To fix this, there is a recursive copy function: `deepcopy`


```julia
b = deepcopy(a)
b[1] = [1;2;3]
a
```




    3-element Array{Array{Float64,1},1}:
     [1.0,4.0,5.0]
     [1.0,2.0]    
     [3.0,4.0,5.0]



For high performance, Julia provides mutating functions. These functions change the input values that are passed in, instead of returning a new value. By convention, mutating functions tend to be defined with a `!` at the end and tend to mutate their first argument. An example of a mutating function in `scale!` which scales an array by a scalar (or array)


```julia
a = [1;6;8]
scale!(a,2) # a changes
```




    3-element Array{Int64,1}:
      2
     12
     16



The purpose of mutating functions is that they allow one to **reduce the number of memory allocations** which is crucial for achiving high performance.

## Control Flow

Control flow in Julia is pretty standard. You have your basic for and while loops, and your if statements. There's more in the documentation.


```julia
for i=1:5 #for i goes from 1 to 5
    println(i)
end

t = 0
while t<5
    println(t)
    t+=1 # t = t + 1
end

school = :ScPo

if school==:ScPo & (x == 0)
    println("your mascott is The Lion and the Fox")
else
    println("you are not from ScPo, I don't know what your mascott is")
end
```

    1
    2
    3
    4
    5
    0
    1
    2
    3
    4
    your mascott is The Lion and the Fox


One interesting feature about Julia control flow is that we can write multiple loops in one line:


```julia
for i=1:2,j=2:4
    println(i*j)
end
```

    2
    3
    4
    4
    6
    8


## Problems

You can try to solve those problems either in a julia REPL (your terminal), in Juno, or by adding new cells in this notebook.

#### Problem 1a

Use Julia's array and control flow syntax in order to define the NxN Strang matrix:

$$ \left[\begin{array}{ccccc}
-2 & 1\\
1 & -2 & 1\\
 & \ddots & \ddots & \ddots\\
 &  & \ddots & \ddots & 1\\
 &  &  & 1 & -2
\end{array}\right] $$

#### Problem 1b

Write an expression that computes

$$ y = \sum_{i=1}^{25} \sum_{j=1}^i j^{-1}  $$


#### Problem 2

```julia
#### Prepare Data

X = rand(1000, 3)               # feature matrix
a0 = rand(3)                    # ground truths
y = X * a0 + 0.1 * randn(1000);  # generate response
```

Given an Nx3 array of data (`randn(N,3)`) and a Nx1 array of outcomes, produce the data matrix `X` which appends a column of 1's to the data matrix, and solve for the 4x1 array `β` via `βX = b` using `qrfact` or `\`. (Note: This is linear regression)

#### Problem 3

Compare your results to that of using `llsq` from `MultivariateStats.jl` (note: you need to go find the documentation to find out how to use this!)


#### Problem 4

The logistic difference equation is defined by the recursion

$$ b_{n+1}=r*b_{n}(1-b_{n}) $$

where $b_{n}$ is the number of bunnies at time $n$. Starting with $b_{0}=.25$, by around $400$ iterations this will reach a steady state. This steady state (or steady periodic state) is dependent on $r$. Write a function which solves for the steady state(s) for each given $r$, and plot "every state" in the steady attractor for each $r$ (x-axis is $r$, $y$=value seen in the attractor) using Plots.jl. Take $r\in\left(2.9,4\right)$




## Function Syntax


```julia
f(x,y) = 2x+y # Create an inline function
```

    WARNING: Method definition f(Any, Any) in module Main at In[1]:1 overwritten at In[27]:1.





    f (generic function with 3 methods)




```julia
f(1,2) # Call the function
```




    7




```julia
function f(x)
  x+2  
end # Long form definition
```

    WARNING: Method definition f(Any) in module Main at In[3]:2 overwritten at In[29]:2.





    f (generic function with 3 methods)



By default, Julia functions return the last value computed within them.


```julia
f(2)
```




    4



A key feature of Julia is **multiple dispatch**. Notice here that there is "one function", `f`, with two methods. Methods are the actionable parts of a function. Here, there is one method defined as `(::Any,::Any)` and `(::Any)`, meaning that if you give `f` two values then it will call the first method, and if you give it one value then it will call the second method.

Multiple dispatch works on types. To define a dispatch on a type, use the `::Type` signifier:


```julia
f(x::Int,y::Int) = 3x+2y
```

    WARNING: Method definition f(Int64, Int64) in module Main at In[5]:1 overwritten at In[31]:1.





    f (generic function with 3 methods)



Julia will dispatch onto the strictest acceptible type signature.


```julia
f(2,3) # 3x+2y
```




    12




```julia
f(2.0,3) # 2x+y since 2.0 is not an Int
```




    7.0



Types in signatures can be parametric. For example, we can define a method for "two values are passed in, both Numbers and having the same type". Note that `<:` means "a subtype of".


```julia
f{T<:Number}(x::T,y::T) = 4x+10y
```




    f (generic function with 4 methods)




```julia
f(2,3) # 3x+2y since (::Int,::Int) is stricter
```




    12




```julia
f(2.0,3.0) # 4x+10y
```




    38.0



Note that type parameterizations can have as many types as possible, and do not need to declare a supertype. For example, we can say that there is an `x` which must be a Number, while `y` and `z` must match types:


```julia
f{T<:Number,T2}(x::T,y::T2,z::T2) = 5x + 5y + 5z
```




    f (generic function with 5 methods)



We will go into more depth on multiple dispatch later since this is the core design feature of Julia. The key feature is that Julia functions specialize on the types of their arguments. This means that `f` is a separately compiled function for each method (and for parametric types, each possible method). The first time it is called it will compile.

-------------------------

#### Question 2

Can you explain these timings?


```julia
f(x,y,z,w) = x+y+z+w
@time f(1,1,1,1)
@time f(1,1,1,1)
@time f(1,1,1,1)
@time f(1,1,1,1.0)
@time f(1,1,1,1.0)
```

      0.001418 seconds (385 allocations: 21.072 KB)
      0.000001 seconds (4 allocations: 160 bytes)
      0.000001 seconds (3 allocations: 144 bytes)
      0.002245 seconds (1.33 k allocations: 69.866 KB)
      0.000001 seconds (4 allocations: 160 bytes)





    4.0



4.0




-------------------------

Note that functions can also feature optional arguments:


```julia
function test_function(x,y;z=0) #z is a keyword argument
  if z==0
    return x+y,x*y #Return a tuple
  else
  return x*y*z,x+y+z #Return a different tuple
  #whitespace is optional
  end #End if statement
end #End function definition
```




    test_function (generic function with 1 method)



Here, if z is not specified, then it's 0.


```julia
x,y = test_function(1,2)
```




    (3,2)




```julia
x,y = test_function(1,2;z=3)
```




    (6,6)



Notice that we also featured multiple return values.


```julia
println(x); println(y)
```

    6
    6


The return type for multiple return values is a Tuple. The syntax for a tuple is `(x,y,z,...)` or inside of functions you can use the shorthand `x,y,z,...` as shown.

Note that functions in Julia are "first-class". This means that functions are just a type themselves. Therefore functions can make functions, you can store functions as variables, pass them as variables, etc. For example:


```julia
function function_playtime(x) #z is an optional argument
    y = 2+x
    function test()
        2y # y is defined in the previous scope, so it's available here
    end
    z = test() * test()
    return z,test
end #End function definition
z,test = function_playtime(2)
```




    (64,test)




```julia
test()
```




    8




```julia
8


```




    8



Notice that `test()` does not get passed in `y` but knows what `y` is. This is due to the function scoping rules: an inner function can know the variables defined in the same scope as the function. This rule is recursive, leading us to the conclusion that the top level scope is global. Yes, that means


```julia
a = 2
```




    2



defines a global variable. We will go into more detail on this.

Lastly we show the anonymous function syntax. This allows you to define a function inline.


```julia
g = (x,y) -> 2x+y
```




    (::#5) (generic function with 1 method)



Unlike named functions, `g` is simply a function in a variable and can be overwritten at any time:


```julia
g = (x) -> 2x
```




    (::#7) (generic function with 1 method)



An anonymous function cannot have more than 1 dispatch. However, as of v0.5, they are compiled and thus do not have any performance disadvantages from named functions. We will encounter anonymous functions later on when we will use numerical optimizers, for example.

## Type Declaration Syntax

A type is what in many other languages is an "object". If that is a foreign concept, thing of a type as a thing which has named components. A type is the idea for what the thing is, while an instantiation of the type is a specific one. For example, you can think of a car as having an make and a model. So that means a Toyota RAV4 is an instantiation of the car type.

In Julia, we would define the car type as follows:


```julia
type Car
    make
    model
end
```

We could then make the instance of a car as follows:


```julia
mycar = Car("Toyota","Rav4")
```




    Car("Toyota","Rav4")



Here I introduced the string syntax for Julia which uses "..." (like most other languages, I'm glaring at you MATLAB). I can grab the "fields" of my type using the `.` syntax:


```julia
mycar.make
```




    "Toyota"



To "enhance Julia's performance", one usually likes to make the **typing stricter**. For example, we can define a WorkshopParticipant (notice the convention for types is capital letters, CamelCase) as having a name and a field. The name will be a string and the field will be a Symbol type, (defined by :Symbol, which we will go into plenty more detail later).


```julia
type WorkshopParticipant
    name::String
    field::Symbol
end
tony = WorkshopParticipant("Tony",:physics)
```




    WorkshopParticipant("Tony",:physics)



As with functions, types can be set "parametrically". For example, we can have an StaffMember have a name and a field, but also an age. We can allow this age to be any Number type as follows:


```julia
type StaffMember{T<:Number}
    name::String
    field::Symbol
    age::T
end
ter = StaffMember("Terry",:football,17)
```




    StaffMember{Int64}("Terry",:football,17)



The rules for parametric typing is the same as for functions. Note that most of Julia's types, like Float64 and Int, are natively defined in Julia in this manner. This means that **there's no limit for user defined types**, only your imagination. Indeed, many of Julia's features first start out as a prototyping package before it's ever moved into Base (the Julia library that ships as the Base module in every installation).

Lastly, there exist abstract types. These types cannot be instantiated but are used to build the type hierarchy. You've already seen one abstract type, Number. We can define one for Person using the Abstract keyword


```julia
abstract Person
```

Then we can set types as a subtype of person


```julia
type Student <: Person
    name
    grade
end
```

You can define type heirarchies on abstract types. See the beautiful explanation at: http://docs.julialang.org/en/release-0.5/manual/types/#abstract-types


```julia
abstract AbstractStudent <: Person
```

Another "version" of type is `immutable`. When one uses `immutable`, the fields of the type cannot be changed. However, Julia will automatically stack allocate immutable types, whereas standard types are heap allocated. If this is unfamiliar terminology, then think of this as meaning that immutable types are able to be stored closer to the CPU and have less cost for memory access (this is a detail not present in many scripting languages). Many things like Julia's built-in Number types are defined as `immutable` in order to give good performance.


```julia
immutable Field
    name
    school
end
ds = Field(:DataScience,[:PhysicalScience;:ComputerScience])
```




    Field(:DataScience,Symbol[:PhysicalScience,:ComputerScience])



----
#### Question 3

Can you explain this interesting quirk? This Field is immutable, meaning that `ds.name` and `ds.school` cannot be changed:


```julia
ds.name = :ComputationalStatistics
```


    type Field is immutable

    


However, the following is allowed:


```julia
push!(ds.school,:BiologicalScience)
ds.school
```




    3-element Array{Symbol,1}:
     :PhysicalScience  
     :ComputerScience  
     :BiologicalScience



(Hint: recall that an array is not the values itself, but a pointer to the memory of the values)

-----------------------

One important detail in Julia is that everything is a type (and every piece of code is an Expression type, more on this later). Thus functions are also types, which we can access the fields of. Not only is everything compiled down to C, but all of the "C parts" are always accessible. For example, we can, if we so choose, get a function pointer:


```julia
foo(x) = 2x
first(methods(foo)).lambda_template.fptr
```




    Ptr{Void} @0x0000000000000000



------------------------------

## Problems

Try the new few problems in the Basic Problems

## Some Basic Types

Julia provides many basic types. Indeed, you will come to know Julia as a system of multiple dispatch on types, meaning that the interaction of types with functions is core to the design.

### Lazy Iterator Types

While MATLAB or Python has easy functions for building arrays, Julia tends to side-step the actual "array" part with specially made types. One such example are ranges. To define a range, use the `start:stepsize:end` syntax. For example:


```julia
a = 1:5
println(a)
b = 1:2:10
println(b)
```

    1:5
    1:2:9


We can use them like any array. For example:


```julia
println(a[2]); println(b[3])
```

    2
    5


But what is `b`?


```julia
println(typeof(b))
```

    StepRange{Int64,Int64}


`b` isn't an array, it's a StepRange. A StepRange has the ability to act like an array using its fields:


```julia
fieldnames(StepRange)
```




    3-element Array{Symbol,1}:
     :start
     :step 
     :stop 




```julia
3-element Array{Symbol,1}:
 :start
 :step 
 :stop 


```


    syntax: extra token "Array" after end of expression

    


Note that at any time we can get the array from these kinds of type via the `collect` function:


```julia
c = collect(a)
```




    5-element Array{Int64,1}:
     1
     2
     3
     4
     5



The reason why lazy iterator types are preferred is that they do not do the computations until it's absolutely necessary, and they take up much less space. We can check this with `@time`:


```julia
@time a = 1:100000
@time a = 1:100
@time b = collect(1:100000);
```

      0.000002 seconds (5 allocations: 192 bytes)
      0.000001 seconds (5 allocations: 192 bytes)
      0.000367 seconds (8 allocations: 781.547 KB)


Notice that the amount of time the range takes is much shorter. This is mostly because there is a lot less memory allocation needed: only a `StepRange` is built, and all that holds is the three numbers. However, `b` has to hold `100000` numbers, leading to the huge difference.

### Dictionaries 

Another common type is the Dictionary. It allows you to access (key,value) pairs in a named manner. For example:


```julia
d = Dict(:test=>2,"silly"=>:suit)
println(d[:test])
println(d["silly"])
```

    2
    suit


### Tuples

Tuples are immutable arrays. That means they can't be changed. However, they are super fast. They are made with the `(x,y,z,...)` syntax and are the standard return type of functions which return more than one object.


```julia
tup = (2.,3) # Don't have to match types
x,y = (3.0,"hi") # Can separate a tuple to multiple variables
```




    (3.0,"hi")



## Problems

Try problems 8-11 in the Basic Problems

## Metaprogramming

Metaprogramming is a huge feature of Julia. The key idea is that every statement in Julia is of the type `Expression`. Julia operators by building an Abstract Syntax Tree (AST) from the Expressions. You've already been exposed to this a little bit: a `Symbol` (like `:PhysicalSciences` is not a string because it is part of the AST, and thus is part of the parsing/expression structure. One interesting thing is that symbol comparisons are O(1) while string comparisons, like always, are O(n)) is part of this, and macros (the weird functions with an `@`) are functions on expressions.

Thus you can think of metaprogramming as "code which takes in code and outputs code". One basic example is the `@time` macro:


```julia
macro my_time(ex)
  return quote
    local t0 = time()
    local val = $ex
    local t1 = time()
    println("elapsed time: ", t1-t0, " seconds")
    val
  end
end
```




    @my_time (macro with 1 method)




```julia
@my_time (macro with 1 method)


```


    syntax: expected "(" in macro definition

    


This takes in an expression `ex`, gets the time before and after evaluation, and prints the elapsed time between (the real time macro also calculates the allocations as seen earlier). Note that `$ex` "interpolates" the expression into the macro. Going into detail on metaprogramming is a large step from standard scripting and will be a later session. 

Why macros? One reason is because it lets you define any syntax you want. Since it operates on the expressions themselves, as long as you know how to parse the expression into working code, you can "choose any syntax" to be your syntax. A case study will be shown later. Another reason is because these are done at "parse time" and those are only called once (before the function compilation).

## Steps for Julia Parsing and Execution

1. The AST after parsing <- Macros
2. The AST after lowering (@code_typed)
3. The AST after type inference and optimization <- Generated Functions (@code_lowered) 
4. The LLVM IR <- Functions (@code_llvm)
5. The assembly code (@code_native)
