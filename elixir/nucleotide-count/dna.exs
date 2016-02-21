defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  defmacrop invalid_nucleotide?(n) do
    quote do: not unquote(n) in unquote(@nucleotides)
  end

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer

  def count(_, nuc) when invalid_nucleotide?(nuc), do: raise ArgumentError
  def count(strand, nucleotide), do: histogram(strand)[nucleotide]

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: Map
  def histogram(strand), do: strand |> _histogram(_default_histogram)

  defp _histogram([], hist), do: hist
  defp _histogram([h|_], _) when invalid_nucleotide?(h), do: raise ArgumentError
  defp _histogram([h|t], hist), do: _histogram(t, %{hist | h => hist[h] + 1 })

  defp _default_histogram do
    Enum.reduce(@nucleotides, %{}, &(Dict.put_new(&2, &1, 0)))
  end
end
