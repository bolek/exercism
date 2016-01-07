defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence), do: _count(sentence)

  # private methods
  defp _count(sentence) do
    sentence
      |> _split_into_words
      |> _normalize_words_case
      |> _aggregate_words
  end

  defp _split_into_words(sentence) do
    Regex.scan(~r/\w+-\w+|\d+|\pL+/u, sentence)
      |> List.flatten
  end

  defp _normalize_words_case(words), do: Enum.map(words, &(String.downcase(&1)))

  defp _aggregate_words(words) do
    reduce_fun = fn(word, counter) -> Dict.update(counter, word, 1, &(&1 + 1)) end
    Enum.reduce(words, %{}, reduce_fun)
  end
end
