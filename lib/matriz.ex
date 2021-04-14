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
	def teste do
		:binary.bin_to_list "Ø"
	end

	def inicializa(nome) do
		input = File.read!(nome)
		matriz = String.split(input, "\r\n")
		n = Enum.count(matriz)
		IO.inspect n
		matrizFormatada = populaMatriz(matriz, [])
		IO.inspect matrizFormatada
		IO.inspect get(matrizFormatada, 0, 0)
		IO.inspect get(matrizFormatada, 1, 1)
		IO.inspect get(matrizFormatada, 2, 2)

		printaMatriz(matrizFormatada)

		IO.inspect listaAdjacentes(matrizFormatada, 0,0)
		IO.inspect listaAdjacentes(matrizFormatada, 0,1)
		IO.inspect listaAdjacentes(matrizFormatada, 0,2)
		IO.inspect listaAdjacentes(matrizFormatada, 1,0)
		IO.inspect listaAdjacentes(matrizFormatada, 1,1)
		IO.inspect listaAdjacentes(matrizFormatada, 1,2)
		IO.inspect listaAdjacentes(matrizFormatada, 2,0)
		IO.inspect listaAdjacentes(matrizFormatada, 2,1)
		IO.inspect listaAdjacentes(matrizFormatada, 2,2)


	end


	def populaMatriz([], matriz) do
		matriz
	end

	def populaMatriz([head|tail], matriz) do
		populaMatriz(tail, List.insert_at(matriz, -1, String.split(head, " ")))
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
		n = Enum.count(matriz)
		IO.inspect "vizinhos de #{i},#{j}"
		retorno = []
		retorno = adicaoParcial(matriz, i-1, j-1, retorno, n)
		retorno = adicaoParcial(matriz, i-1, j, retorno, n)
		retorno = adicaoParcial(matriz, i-1, j+1, retorno, n)
		retorno = adicaoParcial(matriz, i, j-1, retorno, n)
		retorno = adicaoParcial(matriz, i, j+1, retorno, n)
		retorno = adicaoParcial(matriz, i+1, j-1, retorno, n)
		retorno = adicaoParcial(matriz, i+1, j, retorno, n)
		retorno = adicaoParcial(matriz, i+1, j+1, retorno, n)
		retorno
	end

	def adicaoParcial(matriz, i, j, lista, n) do
		if(i>=0 && (i+1)<=n && j>=0 && (j+1)<=n) do
			List.insert_at(lista, -1, get(matriz, i , j))
		else
			lista
		end
	end
end

Matriz.inicializa("arquivo.txt")
