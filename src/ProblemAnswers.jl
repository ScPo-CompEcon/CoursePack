# problem 1a
N = 10
A = zeros(N,N)
for i in 1:N, j in 1:N
    abs(i-j)<=1 ? A[i,j]+=1 : nothing
    i==j ? A[i,j]-=3 : nothing
end
A

# problem 1b
sum(sum(1/j for j in 1:i) for i in 1:25)

#### Prepare Data

X = rand(1000, 3)               # feature matrix
a0 = rand(3)                    # ground truths
y = X * a0 + 0.1 * randn(1000);  # generate response

X2 = hcat(ones(1000),X)
lreg = X2\y

# problem 3
using DataFrames
data = DataFrame(X)
data[:y] = y
lm1 = fit(LinearModel, @formula(y ~ x1 + x2 + x3), data)
@test coef(lm1) ≈ lreg atol=1e-16


# problem 4
r = 2.9:.00005:4; numAttract = 150
steady = ones(length(r),1)*.25
for i=1:400 ## Get to steady state
  steady .= r.*steady.*(1-steady)
end
x = zeros(length(steady),numAttract)
x[:,1] = steady
@inbounds for i=2:numAttract ## Grab values at the attractor
  x[:,i] = r.*x[:,i-1].*(1-x[:,i-1])
end
using Plots
plot(collect(r),x,seriestype=:scatter,markersize=.002,legend=false)


macro ~(y,ex)
  new_ex = Meta.quot(ex)
  quote
    inner_ex = $(esc(new_ex))
    data_name = Symbol(string(inner_ex.args[end])[1])
    eval_ex = Expr(:(=),:data,data_name)
    eval(Main,eval_ex)
    new_X = Matrix{Float64}(size(data,1),length(inner_ex.args)-1)
    cur_spot = 0
    for i in 2:length(inner_ex.args)
      if inner_ex.args[i] == 1
        new_X[:,i-1] = ones(size(data,1))
      else
        col = parse(Int,string(string(inner_ex.args[i])[2]))
        new_X[:,i-1] = data[:,col]
      end
    end
    $(esc(y)),new_X
  end
end

y = rand(10)
X = rand(10,4)
y~1+X1+X2+X4

function solve_least_squares(y,X)
  X\y
end
solve_least_squares(tup::Tuple) = solve_least_squares(tup...)
solve_least_squares(y~1+X1+X2+X4)

function myquantile(d::UnivariateDistribution, q::Number)
    θ = mean(d)
    tol = Inf
    while tol > 1e-5
        θold = θ
        θ = θ - (cdf(d, θ) - q) / pdf(d, θ)
        tol = abs(θold - θ)
    end
    θ
end

for dist in [Gamma(5, 1), Normal(0, 1), Beta(2, 4)]
    @show myquantile(dist, .75)
    @show quantile(dist, .75)
    println()
end

using LightGraphs, Distributions
function mkTree(maxdepth::Int = 10, p::Float64 = 0.8, g::SimpleGraph = Graph(1), currhead::Int = 1)
    if (maxdepth <= 1) g
    else
       b = Binomial(2, p)
       nEdges = max(1, rand(b))
        for leaves in 1:nEdges
            add_vertex!(g)
            newnode = nv(g)
            add_edge!(g, currhead, newnode)
            mkTree(maxdepth-1, p, g, newnode)
        end
    end
    g
end

using Roots
f(x) = 10 - x + e*sin(x)
fzero(f,BigFloat(2.0))

f! = function (x,dx)
  dx[1] = x[1]   + x[2]   + x[3]^2 -12
  dx[2] = x[1]^2 - x[2]   + x[3]   - 2
  dx[3] = 2x[1]  - x[2]^2 + x[3]   - 1
end
using NLsolve
res = nlsolve(f!,[1.0;1.0;1.0])
res.zero
res = nlsolve(f!,[1.0;1.0;1.0],autodiff=true)
res.zero
