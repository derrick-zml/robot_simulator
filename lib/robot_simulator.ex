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

  def simulate(robot, instructions) do
    instructions
    |> String.graphemes
    |> Enum.reduce(robot, fn instruction, robot -> move(robot, instruction) end)
  end

  defp move(%{position: {x, y}, direction: :north} = robot, "A"), do: %{robot | position: { x, y + 1 }}
  defp move(%{position: {x, y}, direction: :south} = robot, "A"), do: %{robot | position: { x, y - 1 }}
  defp move(%{position: {x, y}, direction: :east } = robot, "A"), do: %{robot | position: { x + 1, y }}
  defp move(%{position: {x, y}, direction: :west } = robot, "A"), do: %{robot | position: { x - 1, y }}

  defp move(%{direction: :north} = robot, "L"), do: %{robot | direction: :west }
  defp move(%{direction: :south} = robot, "L"), do: %{robot | direction: :east }
  defp move(%{direction: :east } = robot, "L"), do: %{robot | direction: :north}
  defp move(%{direction: :west } = robot, "L"), do: %{robot | direction: :south}

  defp move(%{direction: :north} = robot, "R"), do: %{robot | direction: :east }
  defp move(%{direction: :south} = robot, "R"), do: %{robot | direction: :west }
  defp move(%{direction: :east } = robot, "R"), do: %{robot | direction: :south}
  defp move(%{direction: :west } = robot, "R"), do: %{robot | direction: :north}

  defp move(_, _), do: {:error, "invalid instruction"}
end
