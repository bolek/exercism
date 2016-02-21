defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2), do: _hd(strand1, strand2)

  defp _hd(strand1, strand2, distance \\ 0)
  defp _hd([], [], distance), do: distance
  defp _hd([], _, _), do: nil
  defp _hd(_, [], _), do: nil
  defp _hd([h|t1], [h|t2], distance), do: _hd(t1, t2, distance)
  defp _hd([_|t1], [_|t2], distance), do: _hd(t1, t2, distance + 1)
end
