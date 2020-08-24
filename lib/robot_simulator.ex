defmodule RobotSimulator do
  @directions [:north, :south, :east, :west]

  def create(direction \\ :north, position \\ {0, 0}) do
    with :ok <- validate_direction(direction),
         :ok <- validate_position(position) do
      %{position: position, direction: direction}
    end
  end

  def position(%{position: position} = _robot) do
    position
  end

  def direction(%{direction: direction} = _robot) do
    direction
  end

  defp validate_position({x, y} = position) when is_integer(x) and is_integer(y), do: :ok
  defp validate_position(_), do: {:error, "invalid position"}

  defp validate_direction(direction) when direction in @directions, do: :ok
  defp validate_direction(_), do: {:error, "invalid direction"}
end
