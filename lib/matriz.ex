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


end

Matriz.inicializa("arquivo.txt")
