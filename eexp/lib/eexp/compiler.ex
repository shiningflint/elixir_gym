defmodule Eexp.Compiler do
  def tokenize(contents) when is_binary(contents) do
    tokenize( String.to_charlist(contents) )
  end

  def tokenize(contents) when is_list(contents) do
    tokenizes(contents)
  end

  defp tokenizes('<%#' ++ t) do
    IO.inspect("this is a comment: #{ t }")
  end
end
