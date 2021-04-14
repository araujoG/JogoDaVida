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
		n = listSize(matriz,0)
		matrizFormatada = populaMatriz(matriz, [])
		IO.inspect matrizFormatada
		IO.inspect get(matrizFormatada, 0, 0, n)
		IO.inspect get(matrizFormatada, 1, 1, n)
		IO.inspect get(matrizFormatada, 2, 2, n)

	end

	def listSize([], n) do
		n
	end

	def listSize([_head|body], n) do
		listSize(body, n+1)
	end

	def findAt([head|body],0) do
		head
	end

	def findAt([head|body], i) do
		findAt(body, i-1)
	end

	def populaMatriz([], matriz) do
		matriz
	end

	def populaMatriz([head|tail], matriz) do
		populaMatriz(tail, matriz ++ String.split(head, " "))
	end

	def get(matriz, i,j, n) do
		index = i*n + j
		IO.inspect matriz
		IO.inspect index
		findAt(matriz, index)
	end
end

Matriz.inicializa("arquivo.txt")
