defmodule JogoDaVida do
	@moduledoc """
	Documentation for `JogoDaVida`.
	"""

	@doc """
	Hello world.

	## Examples

		iex> JogoDaVida.hello()
		:world

	"""
	def statusTeste do
		status = "Vivo"
		IO.puts("#{status} => #{Celula.mudancaDeEstado(status, ["Vivo", "Vivo", "Vivo", "Morto"])}")
		IO.puts("#{status} => #{Celula.mudancaDeEstado(status, ["Vivo", "Vivo", "Vivo", "Vivo", "Morto"])}")
		IO.puts("#{status} => #{Celula.mudancaDeEstado(status, ["Morto", "Morto", "Vivo", "Morto"])}")
		IO.puts("#{status} => #{Celula.mudancaDeEstado(status, ["Morto", "Zumbi", "Vivo", "Morto"])}")
		status = "Morto"
		IO.puts("#{status} => #{Celula.mudancaDeEstado(status, ["Vivo", "Vivo", "Vivo", "Morto"])}")
		IO.puts("#{status} => #{Celula.mudancaDeEstado(status, ["Morto", "Morto", "Vivo", "Morto"])}")
		status = "Zumbi"
		IO.puts("#{status} => #{Celula.mudancaDeEstado(status, ["Morto", "Morto", "Vivo", "Morto"])}")
		IO.puts("#{status} => #{Celula.mudancaDeEstado(status, ["Morto", "Morto", "Zumbi", "Morto"])}")
	end
end

defmodule Celula do
	# Mudança de estado
	def mudancaDeEstado("Vivo", vizinhos) do
		IO.puts("Vizinhos: #{vizinhos}")
		if(vizinhos |> temZumbi?) do
			"Zumbi"
		else
			if(vizinhos |> continuaVivo?) do
				"Vivo"
			else
				"Morto"
			end
		end
	end
	def mudancaDeEstado("Zumbi", vizinhos) do
		IO.puts("Vizinhos: #{vizinhos}")
		if(vizinhos |> continuaZumbi?) do
			"Zumbi"
		else
			"Morto"
		end
	end
	def mudancaDeEstado("Morto", vizinhos) do
		IO.puts("Vizinhos: #{vizinhos}")
		if(vizinhos |> continuaMorto?) do
			"Morto"
		else
			"Vivo"
		end
	end

	# Continua zumbi?
	def continuaZumbi?([]) do
		false
	end
	def continuaZumbi?(vizinhos) do
		[ head | tail ] = vizinhos
		if(head == "Vivo") do
			true
		else
			continuaZumbi?(tail)
		end
	end

	# Tem zumbi?
	def temZumbi?([]) do
		false
	end
	def temZumbi?(vizinhos) do
		[ head | tail ] = vizinhos
		if(head == "Zumbi") do
			true
		else
			temZumbi?(tail)
		end
	end

	# Continua morto?
	def continuaMorto?([]) do
    	true
    end
    def continuaMorto?(vizinhos) do
    	[ head | tail ] = vizinhos
    	if(head == "Vivo") do
    		continuaMorto?( tail, ["Vivo"])
    	else
    	    continuaMorto?( tail, [])
    	end

    end
    def continuaMorto?(_descartavel, ["Vivo","Vivo","Vivo"]) do
		# Reprodução
        false
    end
    def continuaMorto?([], _descartavel) do
        true
    end
    def continuaMorto?(vizinhos, vivos) do
    	[ head | tail ] = vizinhos
    	if(head == "Vivo")  do
    		continuaMorto?( tail, ["Vivo" | vivos])
    	else
    	    continuaMorto?( tail,vivos)
    	end
    end

	# Continua Vivo
	def continuaVivo?(vizinhos) do
		# Primeira Iteração
		[ head | tail ] = vizinhos
		if(head == "Vivo") do
			continuaVivo?(tail, ["Vivo"])
		else
			continuaVivo?(tail)
		end
	end
	def continuaVivo?(_descartavel, ["Vivo", "Vivo","Vivo", "Vivo"]) do
		# Superpopulação
		false
	end
	def continuaVivo?([], ["Vivo"]) do
		# Subpopulação
		false
	end
	def continuaVivo?([], _descartavel) do
		# População Saudável
		true
	end
	def continuaVivo?(vizinhos, vivos) do
		[ head | tail ] = vizinhos
		if(head == "Vivo") do
			continuaVivo?(tail, ["Vivo" | vivos])
		else
			continuaVivo?(tail, vivos)
		end
	end
end
JogoDaVida.statusTeste()
