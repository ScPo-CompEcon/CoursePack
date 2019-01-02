module test

using Roots,Interpolations,PyPlot,Optim
using CompEcon, NLsolve


alpha     = 0.65
beta      = 0.95
grid_max  = 2  # upper bound of capital grid
n         = 150  # number of grid points
N_iter    = 3000  # number of iterations
kgrid     = 1e-6:(grid_max-1e-6)/(n-1):grid_max  # equispaced grid
f(x) = x.^alpha  # defines the production function f(k)
tol = 1e-9

ab        = alpha * beta
c1        = (log(1 - ab) + log(ab) * ab / (1 - ab)) / (1 - beta)
c2        = alpha / (1 - ab)
v_star(k) = c1 .+ c2 .* log(k)  
k_star(k) = ab * k.^alpha   
c_star(k) = (1-ab) * k.^alpha   
ufun(x) = log(x)


# Bellman Operator
# inputs
# `grid`: grid of values of state variable
# `v0`: current guess of value function

# output
# `v1`: next guess of value function
# `pol`: corresponding policy function 

#takes a grid of state variables and computes the next iterate of the value function.
function bellman_operator(grid,v0)
    
    v1  = zeros(n)     # next guess
    pol = zeros(Int,n)     # policy function
    w   = zeros(n)   # temporary vector 

    # loop over current states
    # current capital
    for (i,k) in enumerate(grid)

        # loop over all possible kprime choices
        for (iprime,kprime) in enumerate(grid)
            if f(k) - kprime < 0   #check for negative consumption
                w[iprime] = -Inf
            else
                w[iprime] = ufun(f(k) - kprime) + beta * v0[iprime]
            end
        end
        # find maximal choice
        v1[i], pol[i] = findmax(w)     # stores Value und policy (index of optimal choice)
    end
    return (v1,pol)   # return both value and policy function
end



# VFI iterator
#
## input
# `n`: number of grid points
# output
# `v_next`: tuple with value and policy functions after `n` iterations.
function VFI()
    v_init = zeros(n)     # initial guess
    for iter in 1:N_iter
        v_next = bellman_operator(kgrid,v_init)  # returns a tuple: (v1,pol)
        # check convergence
        if maxabs(v_init.-v_next[1]) < tol
            verrors = maxabs(v_next[1].-v_star(kgrid))
            perrors = maxabs(kgrid[v_next[2]].-k_star(kgrid))
            println("discrete VFI:")
            println("Found solution after $iter iterations")
            println("maximal value function error = $verrors")
            println("maximal policy function error = $perrors")
            return v_next
        elseif iter==N_iter
            warn("No solution found after $iter iterations")
            return v_next
        end
        v_init = v_next[1]  # update guess 
    end
end

# plot
function plotVFI()
    v = VFI()
    figure("discrete VFI",figsize=(10,5))
    subplot(131)
    plot(kgrid,v[1],color="blue")
    plot(kgrid,v_star(kgrid),color="black")
    xlim(-0.1,grid_max)
    ylim(-50,-30)
    xlabel("k")
    ylabel("value")
    title("value function")

    subplot(132)
    plot(kgrid,kgrid[v[2]])
    plot(kgrid,k_star(kgrid),color="black")
    xlabel("k")
    title("policy function")

    subplot(133)
    plot(kgrid,kgrid[v[2]].-k_star(kgrid))
    title("policy function error")    
end

function bellman_operator2(grid,v0)
    
    v1  = zeros(n)     # next guess
    pol = zeros(n)     # consumption policy function

    Interp = interpolate((collect(grid),), v0, Gridded(Linear()) ) 

    # loop over current states
    # of current capital
    for (i,k) in enumerate(grid)

        objective(c) = - (log(c) + beta * Interp[f(k) - c])
        # find max of ojbective between [0,k^alpha]
        res = optimize(objective, 1e-6, f(k)) 
        pol[i] = f(k) - res.minimizer
        v1[i] = -res.minimum
    end
    return (v1,pol)   # return both value and policy function
end

function VFI2()
    v_init = zeros(n)     # initial guess
    for iter in 1:N_iter
        v_next = bellman_operator2(kgrid,v_init)  # returns a tuple: (v1,pol)
        # check convergence
        if maxabs(v_init.-v_next[1]) < tol
            verrors = maxabs(v_next[1].-v_star(kgrid))
            perrors = maxabs(v_next[2].-k_star(kgrid))
            println("continuous VFI:")
            println("Found solution after $iter iterations")
            println("maximal value function error = $verrors")
            println("maximal policy function error = $perrors")
            return v_next
        elseif iter==N_iter
            warn("No solution found after $iter iterations")
            return v_next
        end
        v_init = v_next[1]  # update guess 
    end
    return nothing
end

function plotVFI2()
    v = VFI2()
    figure("discrete VFI - continuous control",figsize=(10,5))
    subplot(131)
    plot(kgrid,v[1],color="blue")
    plot(kgrid,v_star(kgrid),color="black")
    xlim(-0.1,grid_max)
    ylim(-50,-30)
    xlabel("k")
    ylabel("value")
    title("value function")

    subplot(132)
    plot(kgrid,v[2])
    plot(kgrid,k_star(kgrid),color="black")
    xlabel("k")
    title("policy function")

    subplot(133)
    plot(kgrid,v[2].-k_star(kgrid))
    xlabel("k")
    title("policy function error")
end


function policy_iter(grid,c0,u_prime,f_prime)
    
    c1  = zeros(length(grid))     # next guess
    pol_fun = interpolate((collect(grid),), c0, Gridded(Linear()) ) 
    
    # loop over current states
    # of current capital
    for (i,k) in enumerate(grid)
        objective(c) = u_prime(c) - beta * u_prime(pol_fun[f(k)-c]) * f_prime(f(k)-c)
        c1[i] = fzero(objective, 1e-10, f(k)-1e-10) 
    end
    return c1
end

uprime(x::Float64) = 1.0 / x
fprime(x::Float64) = alpha* x ^ (alpha-1) 
function fprime(x::Vector) 
    r = similar(x)
    for ix in eachindex(x)
        if x[ix] > 0
            r[ix] = alpha* x[ix]^(alpha-1)
        else
            r[ix] = 10000.0
        end
    end
    return r
end

function PFI()
    c_init = kgrid
    for iter in 1:N_iter
        c_next = policy_iter(kgrid,c_init,uprime,fprime)  
        # check convergence
        if maxabs(c_init.-c_next) < tol
            perrors = maxabs(c_next.-c_star(kgrid))
            println("PFI:")
            println("Found solution after $iter iterations")
            println("max policy function error = $perrors")
            return c_next
        elseif iter==N_iter
            warn("No solution found after $iter iterations")
            return c_next
        end
        c_init = c_next  # update guess 
    end
end
function plotPFI()
    v = PFI()
    figure("PFI")
    subplot(121)
    plot(kgrid,v)
    plot(kgrid,c_star(kgrid),color="black")
    xlabel("k")
    title("policy function")

    subplot(122)
    plot(kgrid,v.-c_star(kgrid))
    xlabel("k")
    title("policy function error")
end
#plotVFI()
#plotVFI2()
#plotPFI()

function proj2(n=25)

    a = 1e-6
    aa = 1e-2
    b = 1.0
    bb = 0.95
    basis = fundefn(:cheb,n,a,b)
    k = funnode(basis)[1]   # collocation points

    fs = f.(k)

    # system of equations: for each k, one line
    function ff(coef::Vector,result::Vector,b,coll_points,fs)
        # get cons function
        cons = funeval(coef,b,coll_points)[1]
        # println("coef= $coef")
        # println("cons = $cons")

        # put resulting residuals into result[:]
        # put into euler equation
        nextk = fs.-cons  
        for i in eachindex(nextk)
            if nextk[i] < 0 
                result[i] = -8000.0
            else
                result[i] = uprime(cons[i]) .- beta * uprime(nextk[i]) .* fprime(nextk[i])
            end
        end
        # println(result)
    end

    f_closure(x::Vector,r::Vector) = ff(x,r,basis,k,fs)

    res = nlsolve(f_closure,ones(n)*0.4)
    x = linspace(aa,bb,501)
    y = funeval(res.zero,basis,x)[1]
    plot(x,y)
    return res
end

function proj(n=25)

    alpha = 1.0
    eta   = 1.5
    a     = 0.1
    b     = 3.0
    basis = fundefn(:cheb,n,a,b)
    p     = funnode(basis)[1]   # collocation points

    c0 = ones(n)*0.3
    function resid!(c::Vector,result::Vector,p,basis,alpha,eta)
        # your turn!
        q = funeval(c,basis,p)[1]
        q2 = zeros(q)
        for i in eachindex(q2)
            if q[i] < 0
                q2[i] = -20.0
            else
                q2[i] = sqrt(q[i])
            end
        end
        result[:] = p.+ q .*((-1/eta)*p.^(eta+1)) .- alpha*q2 .- q.^2
    end
    f_closure(r::Vector,x::Vector) = resid!(x,r,p,basis,alpha,eta)
    res = nlsolve(f_closure,c0)
    println(res)

    # plot residual function
    x = collect(linspace(a,b,501))
    y = similar(x)
    resid!(res.zero,y,x,basis,alpha,eta);
    y = funeval(res.zero,basis,x)[1]
    pl = Any[]
    push!(pl,plot(x,y,title="residual function"))
    
    # plot supply functions at levels 1,10,20
    
    # plot demand function
    
    y = funeval(res.zero,basis,x)[1]
    p2 = plot(y,x,label="supply 1")
    plot!(10*y,x,label="supply 10")
    plot!(20*y,x,label="supply 20")
    d = x.^(-eta)
    plot!(d,x,label="Demand")

    push!(pl,p2)
    
    plot(pl...,layout=2)
end


end # module