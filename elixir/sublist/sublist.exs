defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  def compare(a, b) do
    case list_size(a) - list_size(b) do
      diff when diff <= 0 -> _compare(a, b, a, b, [], :sublist)
      diff when diff > 0 -> _compare(b, a, b, a, [], :superlist)
    end
  end

  # _compare(A, B, A_remaining, B_remaining, mapped, map_type)
  @spec _compare(list, list, list, list, list, atom) :: atom

  # return :equal if both lists equal
  defp _compare(a, a, _, _, _, _),            do: :equal

  # return map_type if found all from A
  defp _compare(_, _, [], _, _, f),           do: f

  # unequal if A_remaining and B_remaining have only one different element
  defp _compare(_, _, [_|[]], [_|[]], [], _), do: :unequal

  # mapped head - slice heads, add to mapped and proceed
  defp _compare(a, b, [h|t1], [h|t2], r, f),  do: _compare(a, b, t1, t2, [h|r], f)

  # heads different, remove head from B_remaining and proceed
  defp _compare(a, b, _, [_|ty], [], f),      do: _compare(a, b, a, ty, [], f)

  # nothing left in B_remaining, definitely not able to find A subset in empty list
  defp _compare(_, _, _, [], _, _),           do: :unequal

  # heads not matching and mapped not empty, rollback
  defp _compare(a, b, _, y, [_|ht], f),       do: _compare(a, b, a, append(reverse(ht),y), [], f)


  # helper list functions

  defp list_size([]), do: 0
  defp list_size([_|t]), do: 1 + list_size(t)

  defp append([], []), do: []
  defp append([], [h|t]), do: [h | append([], t)]
  defp append([h|t], other), do: [h | append(t, other)]

  defp reverse(l), do: _reverse(l)
  defp _reverse(l, acc \\ [])
  defp _reverse([], acc), do: acc
  defp _reverse([h|t], acc), do: _reverse(t, [h | acc])
end
