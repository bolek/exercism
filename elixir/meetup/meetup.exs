defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @weekday_to_number %{ monday: 1, tuesday: 2, wednesday: 3, thursday: 4,
    friday: 5, saturday: 6, sunday: 7}

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    _meetup(_first_weekday_in_month(year, month, weekday), schedule)
  end

  defp _meetup({year, month, day}, :first), do: {year, month, day}
  defp _meetup({year, month, day}, :second), do: {year, month, day + 7}
  defp _meetup({year, month, day}, :third), do: {year, month, day + 14}
  defp _meetup({year, month, day}, :fourth), do: {year, month, day + 21}
  defp _meetup({year, month, day}, :last) do
    day = _last_day(day, :calendar.last_day_of_the_month(year, month))
    {year, month, day}
  end
  defp _meetup({year, month, day}, :teenth),
    do: {year, month, _teenth_day(day)}

  defp _first_weekday_in_month(year, month, weekday) do
    weekday_number = @weekday_to_number[weekday]
    weekday_number_on_first = :calendar.day_of_the_week({year, month, 1})
    {year, month, 1 + rem(weekday_number  - (weekday_number_on_first - 7), 7)}
  end

  defp _teenth_day(day) when day > 12, do: day
  defp _teenth_day(day), do: _teenth_day(day + 7)

  defp _last_day(day, last_day_in_month)
    when day + 7 > last_day_in_month,
    do: day

  defp _last_day(day, last_day_in_month),
    do: _last_day(day + 7, last_day_in_month)
end
