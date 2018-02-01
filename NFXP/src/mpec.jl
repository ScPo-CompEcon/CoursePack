

module mpec

    using Ipopt
    using JuMP
    using DataFrames
    using DataFramesMeta


    """
        build_trans(p::Vector{Float64},n::Int)

    Build transition matrix for each of `n` states where each element `p[j]` of `p` is the probability of moving `j-1` states up in the grid defined by `1:n`.
    """ 
    function build_trans(p::Vector{Float64},n::Int)
        P = spzeros(n,n)
        p = vcat(p,(1-sum(p)))
        N = length(p)
        for i=0:(N-1)
            P =   P + sparse(1:(n-i),(1+i):n,ones(n-i)*p[i+1],n,n)
            P[n-i,n] = 1-sum(p[1:i])
        end
        return P
    end

    type Param
        n :: Int  # num of grid points
        gmax :: Int # upper boudn of mileage grid

        # structural params
        pr :: Vector{Float64}  # transition probs
        RC :: Float64         # replacement cost
        c :: Float64  # cost parameter
        beta :: Float64 # discount factor

        # computation objects
        grid :: LinSpace{Float64}
        P :: SparseMatrixCSC{Float64,Int64}
        # EV0 :: Vector{Float64}   # old value function   
        # EV1 :: Vector{Float64}   # new
        pk :: Vector{Float64}  # probability of keeping engine
        cost :: Vector{Float64}   #operating cost

        """
            create default param type
        """
        function Param()
            this = new()
            this.n = 175
            this.gmax = 450
            this.grid = 0.0:(this.n-1)

            this.pr = [0.0937; 0.4475; 0.4459; 0.0127]
            this.RC = 11.7257
            this.c = 2.45569
            this.beta = 0.9999
            this.P = build_trans(this.pr,this.n)
            this.cost = 0.001*this.c*collect(this.grid)
            # this.EV0 = zeros(this.n)
            # this.EV1 = zeros(this.n)
            this.pk = zeros(this.n)
            return this
        end
    end


    function read_busses(p::Param,num_types=4)
        # load data
        d = readtable(joinpath(dirname(@__FILE__),"buses.csv"),header=false)
        # setup data
        rename!(d,[:x1,:x2,:x5,:x7,:x9],[:id,:bus_type,:d1,:x,:dx1])

        # subset to bus type 
        d = @where(d,:bus_type .<= num_types)

        # discretize odometer data
        d[:x] = ceil(Int,p.n/(p.gmax*1000) * d[:x])
        d[:dx1] = d[:x] .- vcat(0,d[:x][1:(end-1)])
        d[:dx1] = d[:dx1].*(1-d[:d1]) .+d[:d1].*d[:x]  # replace first diff of x by x if replaced

        # get replacement dummy
        d[:d] = vcat(d[:d1][2:end],0)

        # remove obs with missing lagged mileage
        # this is the first row for each obs
        remove = d[:id] .- vcat(0,d[:id][1:(end-1)])
        d = d[remove.==0,:]

        d = @select(d,:id,:bus_type,:d,:x,:dx1)

        return d
    end

end