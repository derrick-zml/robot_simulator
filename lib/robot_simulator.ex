defmodule RobotSimulator do

  def create(direction \\ :north, position \\ {0, 0}) do
    %{position: position, direction: direction}
  end

  def position(%{position: position} = _robot) do
    position
  end

  def direction(%{direction: direction} = _robot) do
    direction
  end
end
