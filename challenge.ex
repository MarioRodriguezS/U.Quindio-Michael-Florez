defmodule Challenge do

  @moduledoc """
  This module solves the first challenge.
  """

  @doc """
  Calculate how much water the structure can store when it rains.

  ## Parameters
    - structure: Array that represents  the elevation of the structure.

  ## Examples
      iex> Challenge.run([0,1,0,2,1,0,1,3,2,1,2,1])
      6

      iex> Challenge.run([2,0,0,0,5,0,1,0,4,0,1])
      18
  """

  @spec run(structure :: list()) :: integer()
  def run([head | tail]) do
    left_height = find_left_height(head, [head | tail])
    {_, right_height} = find_right_height(head, tail)
    get_water([head | tail], left_height, right_height)
  end

  @spec find_left_height(prev_height :: integer(), structure :: list()) :: list()
  defp find_left_height(_, []), do: []

  defp find_left_height(prev_height, [head | tail]) when prev_height > head do
    [prev_height | find_left_height(prev_height, tail)]
  end

  defp find_left_height(_, [head | tail]) do
    [head | find_left_height(head, tail)]
  end

  @spec find_right_height(prev_height :: integer(), structure :: list()) :: tuple()
  defp find_right_height(prev_height, []), do: {prev_height, [prev_height]}

  defp find_right_height(prev_height, [head | tail]) do
    {max_height, list} = find_right_height(head, tail)

    max(max_height, prev_height)
    |> (&({&1, [&1 | list]})).()
  end

  @spec get_water(structure :: list(), left_height :: list(), right_height :: list()) :: integer()
  defp get_water([], [], []), do: 0

  defp get_water([height | structure], [max_left_height | left_height], [max_right_height | right_height]) do
    min(max_left_height, max_right_height) - height + get_water(structure, left_height, right_height)
  end
end
