# fate.
# "did anyone hear that matter is decaying?"

const global dt::Float64 = 0.001	# time step

const global a₀::Float64 = 0.01
const global H₀::Float64 = 70.0

mutable struct Universe{T<:Float64}
	a::T	# scale factor
	t::T	# time
	Ω_r::T	# radiation density
	Ω_m::T	# matter density
	Ω_k::T	# curvature density
	Ω_de::T # dark energy density
	w::T	# equation of state parameter
end

function Universe(;a=a₀, t=0.0, Ω_r=0.0, Ω_m=0.0, 
	Ω_k=0.0, Ω_de=0.0, w=0.0)

	return Universe(
		a, 
		t,
		Ω_r, 
		Ω_m, 
		Ω_k, 
		Ω_de, 
		w
	)
end

function dadt(u::Universe)
	#return u.a * H₀ * sqrt(
	return u.a * sqrt(
		u.Ω_r * u.a^-4 + 
		u.Ω_m * u.a^-3 + 
		u.Ω_k * u.a^-2 + 
		u.Ω_de * u.a^(-3(1+u.w))
	)
end

function euler_step!(u::Universe)
	u.a += dadt(u) * dt
end

function rk2_step!(u::Universe)
	u.a += dadt(u) * 0.5 * dt
	u.a += dadt(u) * 0.5 * dt
end

function evolve!(universe::Universe, tt::Float64=2.0)
	numSteps = Int(floor(tt/dt))
	println(numSteps)

	adata = Float64[]
	tdata = Float64[]

	for t = 1:numSteps
		push!(adata, universe.a)
		push!(tdata, universe.t)

		rk2_step!(universe)
		universe.t += dt
	end

	scale_multiplier = 13.969 # accounts for hubble time and billions
	tdata .*= scale_multiplier
	#tdata .*= (t_H / 1e9)

	return adata, tdata
end

