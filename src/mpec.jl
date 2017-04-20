


module jump

    using JuMP 
    using Distributions
    srand(12345)
    normal = Normal(0,0.01)
    
    function run()

        # create a model
        m = Model()

        # define constants (N, price, etc)
        N = 100
        price = collect(linspace(0.05,0.95,N))
        beta0 = 0.1
        demand0 = (1.0-price) / (2*beta0)
        demand = demand0 - rand(normal,N)

        #define JuMP variables
        @variable(m,eps[1:N])
        @variable(m,0 <= beta <= 1)

        # define constraints and objective
        @objective(m,Min,sum(eps)^2)
        @constraint(m,constr[i=1:N], 1.0 - 2*beta*(demand[i]-eps[i])-price[i] == 0)

        # solve
        status = solve(m)
        Dict(:obj=>getobjectivevalue(m),:beta=>getvalue(beta),:eps=>getvalue(eps))
    end
end


module nlopt

    using Distributions
    using NLopt
    srand(12345)
    normal = Normal(0,0.01)
    N = 100
    price = collect(linspace(0.05,0.95,N))
    beta0 = 0.1
    demand0 = (1.0-price) / (2*beta0)
    demand = demand0 - rand(normal,N)

    # objective function
    function obj(x,g)
        # x = [e_1,...,e_N,beta] i.e. (N+1,1)
        
        # gradient = [grad w.r.t e_1,
        #            ...,grad w.r.t e_N,
        #                grad w.r.t beta] i.e. (N+1,1)
        if length(g)>0
           g[:] = vcat(2.0*x[1:(end-1)],0.0)
        end
        # value of objective
        r = sum(x[1:(end-1)])^2
        return r
    end

    # 
    function constr(r::Vector,x::Vector,g::Matrix,n,q,p)
        if length(g) > 0
            # g has to be n by m for nlopt
            g[:,:] = cat(1,diagm(2*x[end]*ones(n)),-2*(q'.-x[1:(end-1)]'))
        end
        # value of contraints
        r[:] = 1.0 - 2*x[end].*(q.-x[1:(end-1)]) .- p
    end
    constr_clos(r::Vector,x::Vector,g::Matrix) = constr(r::Vector,x::Vector,g::Matrix,N,demand,price)

    function run()
        opt = Opt(:LD_SLSQP,N+1)
        lower_bounds!(opt,[[-Inf for i in 1:N]...,0.0])
        upper_bounds!(opt,[[Inf for i in 1:N]...,1.0])
        min_objective!(opt,obj)
        equality_constraint!(opt,constr_clos,[1e-10 for i in 1:N])
        xtol_rel!(opt,1e-4)
        ftol_rel!(opt,1e-6)

        res = optimize(opt, vcat(rand(normal,N),0.9))
        println("beta0 = $beta0")
        println("beta  = $(res[2][end])")
        r = zeros(N)
        g =zeros(N+1,N)
        constr(r,res[2],g,N,demand,price);
        println("maximal error of constraint at solution = $(maxabs(r))")
        return res
    end

end # module