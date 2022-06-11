defmodule Eexp do
  @moduledoc """
  Documentation for `Eexp`.
  """

  @doc """
  Evaluate String

  ## Examples

      iex> Eexp.eval_string("test")
      true

  """
  @spec eval_string(String.t()) :: Boolean
  def eval_string(source) when is_binary(source) do
    IO.inspect(source)
    true
  end

  def compile_string(source) when is_binary(source) do
    tokenize(source)
  end

  def tokenize(contents) do
    Eexp.Compiler.tokenize(contents)
  end
end
