defmodule Phone do

  defmacrop is_letter(c) do
    quote do: unquote(c) in 97..122 or unquote(c) in 65..90
  end

  defmacrop is_digit(c) do
    quote do: unquote(c) in 48..57
  end
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
      |> String.to_char_list
      |> _number('')
      |> to_string
  end

  defp _number(raw, clean, n \\ 0)
  defp _number([], [h|t], 11) when h == ?1, do: t
  defp _number(_, _, n) when n > 10, do: '0000000000'
  defp _number([], _, n) when n != 10, do: '0000000000'
  defp _number([], clean, n), do: clean

  defp _number([h|t], clean, n) when is_digit(h), do: _number(t, clean ++ [h], n + 1)
  defp _number([h|t], clean, n) when is_letter(h), do: _number(t, clean, n + 1)
  defp _number([h|t], clean, n) when not is_digit(h), do: _number(t, clean, n)

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw), do: number(raw) |> _area_code

  defp _area_code(clean_number), do: String.slice(clean_number, 0, 3)

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    clean_number = number(raw)
    area = _area_code(clean_number)
    {exch, subs} = (String.slice(clean_number, 3, 7) |> String.split_at(3))
    "(#{area}) #{exch}-#{subs}"
  end
end
