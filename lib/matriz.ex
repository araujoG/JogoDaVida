defmodule Matriz do
	@compile :nowarn_unused_vars
	@moduledoc """
	Documentation for `JogoDaVida`.
	"""

	@doc """
	Hello world.

	## Examples

		iex> JogoDaVida.hello()
		:world

	"""

	def inicializa(nome) do
		input = File.read!(nome)
		matriz = String.split(input, "\n")
		n = Enum.count(matriz)
		matrizFormatada = populaMatriz(matriz, [])
		printaMatriz(matrizFormatada)
		IO.inspect "vizinhos de #{0},#{0} => #{listaAdjacentes(matrizFormatada, 0,0)}"
		# IO.inspect "vizinhos de #{0},#{1} => #{listaAdjacentes(matrizFormatada, 0,1)}"
		# IO.inspect "vizinhos de #{1},#{1} => #{listaAdjacentes(matrizFormatada, 1,1)}"
		# IO.inspect listaAdjacentes(matrizFormatada, 0,1)
		# IO.inspect listaAdjacentes(matrizFormatada, 0,2)
		# IO.inspect listaAdjacentes(matrizFormatada, 1,0)
		# IO.inspect listaAdjacentes(matrizFormatada, 1,1)
		# IO.inspect listaAdjacentes(matrizFormatada, 1,2)
		# IO.inspect listaAdjacentes(matrizFormatada, 2,0)
		# IO.inspect listaAdjacentes(matrizFormatada, 2,1)
		# IO.inspect listaAdjacentes(matrizFormatada, 2,2)

		percorreMatriz(matrizFormatada, 0,0, n)

		# iteracaoPrincipal(matrizFormatada,n, 0, 3)


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
    listaAdjacentes(matriz, i, j, Enum.count(matriz))
  end
	def listaAdjacentes(matriz, i, j, n) do
		[] |> adicaoParcial(matriz, i-1, j-1, n)
		|> adicaoParcial(matriz, i-1, j, n)
		|> adicaoParcial(matriz, i-1, j+1, n)
		|> adicaoParcial(matriz, i, j-1, n)
		|> adicaoParcial(matriz, i, j+1, n)
		|> adicaoParcial(matriz, i+1, j-1, n)
		|> adicaoParcial(matriz, i+1, j, n)
		|> adicaoParcial(matriz, i+1, j+1, n)
	end

	def adicaoParcial(lista, matriz, i, j, n) do
		if(i>=0 && (i+1)<=n && j>=0 && (j+1)<=n) do
			List.insert_at(lista, -1, get(matriz, i , j))
		else
			lista
		end
	end

	def percorreMatriz(matriz, i, j, n) do
		{linhaAtual, _lixo} = List.pop_at(matriz, i)
		linhaAtual = List.update_at(linhaAtual, j, &(&1 = 0))
		matriz = List.update_at(matriz,i, &(&1 = linhaAtual)) # Não entendi????
		if ((j+1)<n) do percorreMatriz(matriz, i, j+1, n)
		else
			if ((i+1)<n) do percorreMatriz(matriz, i+1, 0, n)
			else
				IO.inspect matriz
			end
		end
	end

	def verificaIgualdadeMatriz(matriz,matrizNova, i, j, n) do #Pode só usar o ==
		if (get(matriz,i,j) != get(matrizNova,i,j)) do false
		else
			if ((j+1)<n) do verificaIgualdadeMatriz(matriz, matrizNova, i, j+1, n)
			else
				if ((i+1)<n) do verificaIgualdadeMatriz(matriz, matrizNova, i+1, 0, n)
				else
					true
				end
			end
		end
	end

	def iteracaoPrincipal(matriz, n, iteracoes, iteracoesPrevistas) do
		if(iteracoes >= iteracoesPrevistas) do
			IO.inspect ("O sistema Parou depois de #{iteracoes} iteracoes, com a matriz final:")
			IO.inspect (matriz)
		else
			matrizNova = percorreMatriz(matriz,0,0,n)
			if (matriz == matrizNova) do
				IO.inspect ("O sistema estabilizou depois de #{iteracoes} iteracoes, com a matriz final:")
				IO.inspect(matrizNova)
			else
				iteracaoPrincipal(matrizNova, n, iteracoes+1, iteracoesPrevistas)
			end
		end
	end
end

Matriz.inicializa("arquivo.txt")
