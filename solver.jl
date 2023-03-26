
function friedmann(da, a, p, t)
	Ω_m = p[1]
	Ω_k = p[2]
	Ω_de = p[3]
	w = p[4]

	@. da = a * sqrt(
		#Ω_r * a^-4 + 
		Ω_m / a^3 + 
		Ω_k / a^2 + 
		Ω_de / a^(-3.0 * (1.0 + w))
	)

	println(da)
end

function run()
	u = Universe[]

	push!(u, Universe(Ω_m=0.25, Ω_de=0.75, w=-0.8))
	push!(u, Universe(Ω_m=0.25, Ω_de=0.75, w=-1.0))
	push!(u, Universe(Ω_m=0.25, Ω_de=0.75, w=-1.2))
	#push!(u, Universe(Ω_m=1.25, Ω_k=-0.25))

	plot()

	for i in 1:length(u)
		a,t = evolve!(u[i], 0.5)
		plot!(
			t , a,
			label = 
			L"$ Ω_m=%$(u[i].Ω_m), Ω_k=%$(u[i].Ω_k), Ω_{de}=%$(u[i].Ω_de), w=%$(u[i].w) $", 
			ylims=(0.0, 3.0),
			xlims=(0.0,2.0)
		)
	end

	plot!()

#	index = argmin(abs.(a .- 1.0))
#	println(index)
#	println(a[index])
#	println(t[index] * t_H)
end

function run_2()
	u = Universe(Ω_m=1.25, Ω_k=-0.25)
	a,t = evolve!(u, 10.0)
	plot!(t,a)
end

function run_3()
	a0 = [0.01]
	tspan = (0.0, 2.0)

	p = [0.25, 0.0, 0.75, -1.0]

	prob = ODEProblem(friedmann, a0, tspan, p)
	sol = solve(prob, Tsit5())

	#a = sol.u
	#t = sol.t
	#plot(sol)
	#println(size(sol.t))

	#println("")
	#println(minimum(sol.u[1:end]))
	#println((sol.u[1:end] .- 1.0))

	adata = Float64[]
	for i in sol.u
		push!(adata, i[1])
	end

	println(argmin(abs.(adata .- 1)))
	println(adata[17])
	println(sol.t[17] * t_H)
end
