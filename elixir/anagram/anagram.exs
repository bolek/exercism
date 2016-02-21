defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates
      |> filter_candidates_with_same_length_as_base(base)
      |> filter_out_base_words(base)
      |> filter_same_normalized(base)
  end

  defp filter_candidates_with_same_length_as_base(candidates, base) do
    base_length = String.length base
    Enum.filter(candidates, &(base_length ==  String.length(&1)))
  end

  defp filter_out_base_words(candidates, base) do
    base_downcase = String.downcase base
    Enum.filter(candidates, &(base_downcase) != String.downcase(&1))
  end

  defp filter_same_normalized(candidates, base) do
    normalized_base = normalize base
    Enum.filter(candidates, &(normalized_base == normalize(&1)))
  end

  defp normalize(word) do
    word |> String.downcase |> String.graphemes |> Enum.sort
  end
end
