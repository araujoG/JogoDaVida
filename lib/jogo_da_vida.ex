defmodule JogoDaVida do
	@moduledoc """
	Documentation for `JogoDaVida`.
	"""

	@doc """
	Hello world.
	"""
  def main do
    nomeDoArquivo = "arquivo1.txt"
    iteracoes = 11
    Matriz.inicializa(nomeDoArquivo, iteracoes)
  end

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
		# IO.puts("Vizinhos: #{vizinhos}")
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
		# IO.puts("Vizinhos: #{vizinhos}")
		if(vizinhos |> continuaZumbi?) do
			"Zumbi"
		else
			"Morto"
		end
	end
	def mudancaDeEstado("Morto", vizinhos) do
		# IO.puts("Vizinhos: #{vizinhos}")
		if(vizinhos |> continuaMorto?) do
			"Morto"
		else
			"Vivo"
		end
	end
	def mudancaDeEstado(lixo, _vizinhos) do
		lixo
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
    	    continuaMorto?(tail, [])
    	end

    end
    def continuaMorto?([], ["Vivo","Vivo","Vivo"]) do
		# Reprodução
        false
    end
    def continuaMorto?([], _descartavel) do
        true
    end
    def continuaMorto?(vizinhos, vivos) do
    	[ head | tail ] = vizinhos
    	if(head == "Vivo")  do
    		continuaMorto?(tail, ["Vivo" | vivos])
    	else
    	    continuaMorto?( tail,vivos)
    	end
    end

	# Continua Vivo
  def continuaVivo?([]) do
		# Nenhum vivo por perto
		false
	end
	def continuaVivo?(vizinhos) do
		# Subpopulação
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
# JogoDaVida.statusTeste()

defmodule Matriz do
	def inicializa(nome, iteracoes) do
		input = File.read!(nome)
		input = String.replace(input, "\r", "")
		matriz = String.split(input, "\n")

		matrizFormatada = populaMatriz(matriz, [])
    m = Enum.count(matrizFormatada) #Número de linhas
		n = Enum.count(List.first(matrizFormatada)) #Número de colunas
    IO.puts "M = #{m}  ||  N = #{n}"
    IO.inspect("Sistema inicializado, iteracao 0, matriz atual:")
    printaMatriz(matrizFormatada)
    #IO.inspect formaLinha([],matrizFormatada, 0, 2)
    #IO.inspect formaLinha([],matrizFormatada, 1, 2)
    #IO.inspect formaLinha([],matrizFormatada, 2, 2)
		# IO.inspect "vizinhos de #{0},#{0} => #{listaAdjacentes(matrizFormatada, 0,0)}"
		# IO.inspect "vizinhos de #{0},#{1} => #{listaAdjacentes(matrizFormatada, 0,1)}"
		# IO.inspect "vizinhos de #{1},#{1} => #{listaAdjacentes(matrizFormatada, 1,1)}"
		#IO.inspect listaAdjacentes(matrizFormatada, 0,1)
		# IO.inspect listaAdjacentes(matrizFormatada, 0,2)
		# IO.inspect listaAdjacentes(matrizFormatada, 1,0)
		# IO.inspect listaAdjacentes(matrizFormatada, 1,1)
		# IO.inspect listaAdjacentes(matrizFormatada, 1,2)
		# IO.inspect listaAdjacentes(matrizFormatada, 2,0)
		# IO.inspect listaAdjacentes(matrizFormatada, 2,1)
		# IO.inspect listaAdjacentes(matrizFormatada, 2,2)

		#IO.inspect percorreMatriz([],matrizFormatada, 0,0, n)

		iteracaoPrincipal(matrizFormatada, m, n, 1, iteracoes)
	end

  def populaMatriz([head|tail]) do
		populaMatriz(tail,List.insert_at([], -1, String.split(head, " ")))
	end

  def populaMatriz([], matriz) do
		matriz
	end

	def populaMatriz([head|tail], matriz) do
		populaMatriz(tail,List.insert_at(matriz, -1, String.split(head, " ")))
	end

	def get(matriz, i,j) do
		{ret, _lixo} = List.pop_at(matriz, i)
		{ret, _lixo} = List.pop_at(ret, j)
		ret
	end

	def printaMatriz([]) do
	end

	def printaMatriz([head|body]) do
		IO.inspect head
		printaMatriz(body)
	end

  def listaAdjacentes(matriz, i, j) do
    listaAdjacentes(matriz, i, j, Enum.count(matriz), Enum.count(List.first(matriz)))
  end
	def listaAdjacentes(matriz, i, j, m, n) do
		[] |> adicaoParcial(matriz, i-1, j-1, m, n)
		|> adicaoParcial(matriz, i-1, j, m, n)
		|> adicaoParcial(matriz, i-1, j+1, m, n)
		|> adicaoParcial(matriz, i, j-1, m, n)
		|> adicaoParcial(matriz, i, j+1, m, n)
		|> adicaoParcial(matriz, i+1, j-1, m, n)
		|> adicaoParcial(matriz, i+1, j, m, n)
		|> adicaoParcial(matriz, i+1, j+1, m, n)
	end

	def adicaoParcial(lista, matriz, i, j, m, n) do
		if(i>=0 && (i+1)<=m && j>=0 && (j+1)<=n) do
			List.insert_at(lista, -1, get(matriz, i , j))
		else
			lista
		end
	end

  def formaLinha(novaLinha, matriz, i, j) when j == 0 do
    # IO.puts ">>i=#{i} j=#{j}"
    elemento = get(matriz,i,j)
    [Celula.mudancaDeEstado(elemento, listaAdjacentes(matriz,i,j)) | novaLinha]
  end

  def formaLinha(novaLinha, matriz, i, j) do
    # IO.puts ">>i=#{i} j=#{j}"
		elemento = get(matriz,i,j)
    [Celula.mudancaDeEstado(elemento, listaAdjacentes(matriz,i,j)) | novaLinha] |>
    formaLinha(matriz, i, j-1)
  end

	def percorreMatriz(matrizNova,matriz, i, _j, m, n) do
    # IO.puts "i=#{i} j=#{j} n=#{n}"
		linhaAtualizada = formaLinha([], matriz, i, n-1)
		matrizNova = List.insert_at(matrizNova, -1, linhaAtualizada)
		if ((i+1)<m) do percorreMatriz(matrizNova, matriz, i+1, 0, m, n)
			else
				matrizNova
			end
	end

	def verificaIgualdadeMatriz(matriz,matrizNova, i, j, m, n) do #Pode só usar o ==
		if (get(matriz,i,j) != get(matrizNova,i,j)) do false
		else
			if ((j+1)<n) do verificaIgualdadeMatriz(matriz, matrizNova, i, j+1, m, n)
			else
				if ((i+1)<m) do verificaIgualdadeMatriz(matriz, matrizNova, i+1, 0, m, n)
				else
					true
				end
			end
		end
	end

	def iteracaoPrincipal(matriz, m, n, iteracoes, iteracoesPrevistas) do
	 	if(iteracoes > iteracoesPrevistas) do
	 		IO.inspect ("O sistema Parou depois de #{iteracoes-1} iteracoes, com a matriz final:")
	 		printaMatriz(matriz)
	 	else
	 		matrizNova = percorreMatriz([], matriz, 0, 0, m, n)
	 		if verificaIgualdadeMatriz(matriz, matrizNova, 0, 0, m, n) do
	 			IO.inspect ("O sistema estabilizou depois de #{iteracoes-1} iteracoes, com a matriz final:")
	 			printaMatriz(matrizNova)
	 		else
				IO.inspect("Sistema ainda em execucao, iteracao #{iteracoes}, matriz atual:")
				printaMatriz(matrizNova)
	 			iteracaoPrincipal(matrizNova, m, n, iteracoes+1, iteracoesPrevistas)
	 		end
	 	end
	 end
end

JogoDaVida.main
