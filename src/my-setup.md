# My Setup

I use julia mainly from a text editor, which lets me send lines of code to a terminal where julia is running. 

## Details

* OS: MacOS High Sierra (in general, always latest version)
* Editor: [sublime text 3](https://www.sublimetext.com)
	1. install [package control](https://packagecontrol.io/installation)
	1. install [send code plugin](https://github.com/randy3k/SendCode) via Package control, as explained.
* Terminal: standard mac terminal
	* you need xcode command line tools installed.

## How does it work

* cmd+enter sends the current line into the terminal
* select lines, cmd+enter sends that.

## workflow with modules

* create a text file with your editor, (say "develop.jl")
* write code and then just do include("develop.jl") in the terminal to run all of it
* it's preferrable to use your code within a `module` to avoid problems with already defined objects (like structs)

	```julia
	# in develop.jl
	module test
		import Base.sum

		struct myType
			a::Int
			b::Float64
		end

		sum(m::Mytype) = m.a + m.b

	end  # module

	# in terminal
	include("develop.jl")
	x = test.myType(1,1.1)
	sum(x)
	```


