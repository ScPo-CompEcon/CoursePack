module nfxptest

    using Base.Test,nfxp

    @testset "simulated data" begin
        N = 50
        T = 150
        mod = nfxp.Param()
        sd = nfxp.simdata(N,T,mod)

        @test length(sd[:id]) == N*T

        @test extrema(sd[:id]) == (1,N)
        @test extrema(sd[:t]) == (1,T)
        @test extrema(sd[:d]) == (0,1)

        # whenever replace, next period mileage must be the same as dx1
        @test all(sd[:x1][find(sd[:d])] .== sd[:dx1][find(sd[:d])])

        # mileage can never exceed p.n
        @test all(sd[:x] .<= mod.n)

        # P is a proper transition matrix
        @test all(sum(mod.P,2).==1.0)
    end


    @testset "check likelihood gradient" begin
        p = nfxp.Param()
        d = nfxp.simdata(1000,100,p)
        g = zeros(p.n_params)
        f = nfxp.likelihood!(p.theta,g,d,p)
        println(g)
    end

end