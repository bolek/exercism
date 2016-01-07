defmodule ListOps do
  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_|t]), do: 1 + count(t)

  @spec reverse(list) :: list
  def reverse(l), do: _reverse(l)

  defp _reverse(l, acc \\ [])
  defp _reverse([], acc), do: acc
  defp _reverse([h|t], acc), do: _reverse(t, [h | acc])

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([h|t], f), do: [f.(h) | map(t, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _),    do: []
  def filter([h|t], f)  do
    case f.(h) do
      true  -> [h | filter(t, f)]
      false -> filter(t, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, f), do: acc
  def reduce([h|t], acc, f), do: reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append([], []), do: []
  def append([], [h|t]), do: [h | append([], t)]
  def append([h|t], other), do: [h | append(t, other)]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat(lists) do
    append = &[&1|&2]
    reduce(lists, [], &reduce(&1, &2, append)) |> reverse
  end
end
