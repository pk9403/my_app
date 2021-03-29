defmodule MyApp.FilterIn do
    @moduledoc """
        Header와 Token 사이의 내용만 남긴다.
    """

    require Logger

# abc(12)cd ->{"abc", "12)cd"}
    def getRight(str, head) do
        case String.split(str, head, parts: 2) do
            [content] -> {"", content}
            [remain, content] -> {remain, content}
        end
    end

    def getLeft(str,tail) do
        case String.split(str, tail, parts: 2) do
            [remain, _] -> remain
            [_content] -> ""
        end
    end

    def filterIn("",_head,_tail)do
        ""
    end

    # filterIn("abc(12)cd, "(", ")")
    # {content, remain} = {"abc(12, "cd"}
    def filterIn(str,head,tail) do
        {_, content} = getRight(str,head)
        remain = getLeft(content,tail)
        remain <> filterIn(remain,head,tail)
    end

    # "abc(12)cd" =>abccd
    def test do
        IO.puts filterIn("abc(12)"  , "(" , ")"     )             # 12
        IO.puts filterIn("(12)abc"  , "(" , ")"      )            # 12
        IO.puts filterIn("abc(12)abc(34)"  , "(" , ")" )          # 12
        IO.puts filterIn("abc()abc()abc"  , "(" , ")" )           #
        IO.puts filterIn("abc(abc)abc(12)abc"  , "(" , ")" )      # abc
        IO.puts filterIn("abc(abc(12)"  , "(" , ")" )             # abc(12
    end

end
