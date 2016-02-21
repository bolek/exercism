defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    String.graphemes(string)
      |> _encode("", nil)
  end

  @spec encode(String.t) :: String.t
  def decode(string) do
    Regex.scan(~r/\d+[A-Z]/u, string)
      |> List.flatten
      |> Enum.reduce("", _reduce_fn)
  end

  defp _encode([], result, nil), do: result
  defp _encode([char | tail], acc, nil), do: _encode(tail, acc, {char, 1})
  defp _encode([char | tail], acc, {char, n}), do: _encode(tail, acc, {char, n + 1})
  defp _encode([char | tail], acc, c), do: _encode(tail, acc <> _encode_token_counter(c), {char, 1})
  defp _encode([], acc, c), do: _encode([], acc <> _encode_token_counter(c), nil)

  defp _encode_token_counter({token, count}), do: "#{count}#{token}"

  defp _decode_token({0, _}, result), do: result
  defp _decode_token({n, token}, result), do: _decode_token({n - 1, token}, result <> token)

  defp _reduce_fn do
    fn(el, acc) ->
      {count, char} = String.split_at(el, -1)
      acc <> _decode_token({String.to_integer(count), char}, "")
    end
  end
end
