using Plots
using LaTeXStrings
using ColorSchemes

includet("fate.jl")

function demo_1()
	u1 = Universe(
		Ω_m = 0.25, 
		Ω_de = 0.75,
		w = -1.2
	)
	u2 = Universe(
		Ω_m = 0.25, 
		Ω_de = 0.75,
		w = -1.0
	)
	u3 = Universe(
		Ω_m = 0.25, 
		Ω_de = 0.75,
		w = -0.8
	)

	s1a, s1t = evolve!(u1, 1.2)
	s2a, s2t = evolve!(u2, 1.2)
	s3a, s3t = evolve!(u3, 1.2)

	plot(
		xlabel = "t (×1e9 years)",
		ylabel = "a(t)",
		#fontfamily = "euler",
		#titlefont = Plots.font(12, "palatino"),
		#guidefont = Plots.font(10, "palatino"),
		#tickfont = Plots.font(8, "palatino"),
		#legendfont = Plots.font(8, "palatino"),
		guidefontsize = 14,
		tickfontsize = 10,
		legendfontsize = 10,
		framestyle = :box,
		widen = false,
		palette = :seaborn_colorblind6,
		size = (1920,1400),
		thickness_scaling = 2,
	)

	plot!(
		s1t, s1a, 
		#label = L"$ w=%$(u1.w) $",
		label = "w = -1.2",
		linewidth = 2,
	)
	plot!(
		s2t, s2a,
		label = "w = -1.0",
		linewidth = 2,
	)
	plot!(
		s3t, s3a,
		label = "w = -0.8",
		linewidth = 2,
	)

	lepasse = Shape(
		[(0.0, 0.0), (0.0, 1.0), (s1t[end], 1.0), (s1t[end], 0.0)]
	)
	plot!(
		lepasse, 
		fillcolor = plot_color(:turquoise, 0.2),
		label = "past",
	)

	lefutur = Shape(
		[(0.0, 1.0), (0.0, 1.30), (s1t[end], 1.30), (s1t[end], 1.0)]
	)
	plot!(
		lefutur, 
		fillcolor = plot_color(:turquoise, 0.1),
		label = "future",
	)

	t_H = 1.397e10

	ix = argmin(abs.(s1a .- 1.0))
	ix2 = argmin(abs.(s2a .- 1.0))
	ix3 = argmin(abs.(s3a .- 1.0))
	t1 = s1t[ix]
	t2 = s2t[ix2]
	t3 = s3t[ix3]
	#println(s2t[ix2]) 
	#println(s3t[ix3]) 

	plot!(
		[s1t[ix], s1t[ix]], 
		[s1a[ix], 0.0], 
		linestyle = :dot,
		linewidth = 2,
		label = "t = $(round(t1, digits=3))b yrs",
		color = :darkblue,
	)

	plot!(
		[s2t[ix2], s2t[ix2]], 
		[s2a[ix2], 0.0], 
		linestyle = :dot,
		linewidth = 2,
		color = :green,
		label = "t = $(round(t2, digits=3))b yrs",
	)

	plot!(
		[s3t[ix3], s3t[ix3]], 
		[s3a[ix3], 0.0], 
		linestyle = :dot,
		linewidth = 2,
		color = :darkorange,
		label = "t = $(round(t3, digits=3))b yrs",
	)



	savefig("fate2.png")
	plot!()
end


function demo_2()
	u = Universe[]

	push!(u, Universe(Ω_m=0.25, Ω_de=0.75, w=-0.8))
	push!(u, Universe(Ω_m=0.25, Ω_de=0.75, w=-1.0))
	push!(u, Universe(Ω_m=0.25, Ω_de=0.75, w=-1.2))
	#push!(u, Universe(Ω_m=1.25, Ω_k=-0.25))

	plot()

	for i in 1:length(u)
		a,t = evolve!(u[i], 1.6)
		plot!(
			t, a,
			label = 
			L"$ Ω_m=%$(u[i].Ω_m), Ω_k=%$(u[i].Ω_k), Ω_{de}=%$(u[i].Ω_de), w=%$(u[i].w) $"
		)
	end

	plot!()
end


function demo_3()
	u1 = Universe(
		Ω_m = 1.25, 
		Ω_k = -0.25
	)

	s1a, s1t = evolve!(u1, 3.0)

	plot(
		xlabel = "t (×1e9 years)",
		ylabel = "a(t)",
		#fontfamily = "euler",
		#titlefont = Plots.font(12, "palatino"),
		#guidefont = Plots.font(10, "palatino"),
		#tickfont = Plots.font(8, "palatino"),
		#legendfont = Plots.font(8, "palatino"),
		guidefontsize = 14,
		tickfontsize = 10,
		legendfontsize = 10,
		framestyle = :box,
		widen = false,
		palette = :seaborn_colorblind6,
		size = (1920,1400),
		thickness_scaling = 2,
	)

	plot!(
		s1t, s1a, 
		#label = L"$ w=%$(u1.w) $",
		label = "Ωm=1.25, Ωk=-0.2",
		linewidth = 2,
	)

#	plot!(
#		s2t, s2a,
#		label = "w = -1.0",
#		linewidth = 2,
#	)
#	plot!(
#		s3t, s3a,
#		label = "w = -0.8",
#		linewidth = 2,
#	)

	lepasse = Shape(
		[(0.0, 0.0), (0.0, 1.0), (s1t[end], 1.0), (s1t[end], 0.0)]
	)
	plot!(
		lepasse, 
		fillcolor = plot_color(:turquoise, 0.2),
		label = "past",
	)

	lefutur = Shape(
		[(0.0, 1.0), (0.0, 2.70), (s1t[end], 2.70), (s1t[end], 1.0)]
	)
	plot!(
		lefutur, 
		fillcolor = plot_color(:turquoise, 0.1),
		label = "future",
	)

	#t_H = 1.397e10

	ix = argmin(abs.(s1a .- 1.0))
	#ix2 = argmin(abs.(s2a .- 1.0))
	#ix3 = argmin(abs.(s3a .- 1.0))
	t1 = s1t[ix]
	#t2 = s2t[ix2]
	#t3 = s3t[ix3]
	#println(s2t[ix2]) 
	#println(s3t[ix3]) 

	plot!(
		[s1t[ix], s1t[ix]], 
		[s1a[ix], 0.0], 
		linestyle = :dot,
		linewidth = 2,
		label = "t = $(round(t1, digits=3))b yrs",
		color = :darkblue,
	)

#	plot!(
#		[s2t[ix2], s2t[ix2]], 
#		[s2a[ix2], 0.0], 
#		linestyle = :dot,
#		linewidth = 2,
#		color = :green,
#		label = "t = $(round(t2, digits=3))b yrs",
#	)
#
#	plot!(
#		[s3t[ix3], s3t[ix3]], 
#		[s3a[ix3], 0.0], 
#		linestyle = :dot,
#		linewidth = 2,
#		color = :darkorange,
#		label = "t = $(round(t3, digits=3))b yrs",
#	)
#


	savefig("fate3.png")
	plot!()
end
