defmodule Aoc4 do
  @moduledoc """
  Documentation for Aoc4.
  """

  def any_anagrams?(phrase) do
    phrase
    |> String.split(" ")
    |> produce_combinations
    |> Enum.any?(&(anagram?(&1)))
  end

  def produce_combinations(phrases) do
    for x <- phrases, y <- phrases -- [x], do: {x,y}
  end

  # Determine if the two words are anagrams of each other.
  # * No word is an anagram if it is not the same length
  # * One word is an anagram of another if each character of the first
  #   is present in teh second (this actually should be handled with
  #   removal from the comparison string, but it works on the input)
  def anagram?({x,y}) do
    if String.length(x) != String.length(y) do
      false
    else
      parts = String.split(x, "", trim: true)
      |> Enum.all?(&(String.contains?(y,&1)))
    end
  end

  # Count phrases from the input where no word is an anagram of
  # another word
  def count_non_anagrams(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.reject(&(any_anagrams?(&1)))
    |> Enum.count
  end

  # Count phrases from the input that are made entirely of unique words
  def count_valid(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.filter(&(valid?(&1)))
    |> Enum.count
  end

  def valid?(phrase) do
    words = String.split(phrase, " ")
    len = Enum.count(words)
    uniq = Enum.uniq(words)
    len == Enum.count(uniq)
  end
end
