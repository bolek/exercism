if System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("example.exs")
else
  Code.load_file("dna.exs")
end

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule DNATest do
  use ExUnit.Case

  # @tag :pending
  test "transcribes guanine to cytosine" do
    assert DNA.to_rna('G') == 'C'
  end

  test "transcribes cytosine to guanine" do
    assert DNA.to_rna('C') == 'G'
  end

  test "transcribes thymidine to adenine" do
    assert DNA.to_rna('T') == 'A'
  end

  test "transcribes adenine to uracil" do
    assert DNA.to_rna('A') == 'U'
  end

  test "it transcribes all dna nucleotides to rna equivalents" do
    assert DNA.to_rna('ACGTGGTCTTAA') == 'UGCACCAGAAUU'
  end
end
