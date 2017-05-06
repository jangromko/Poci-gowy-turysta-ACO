load 'krawedz.rb'
require 'set'

class Wierzcholek
  def initialize(nazwa)
    @nazwa = nazwa
    @krawedzie = []
    @sasiedzi = Set.new
  end

  def dodaj_krawedz(czas, odjazd, przyjazd, stacja_poczatkowa, miasto_docelowe, stacja_docelowa, pociag, zapach=0.2)
    @krawedzie.push(Krawedz.new(czas, odjazd, przyjazd, stacja_poczatkowa, miasto_docelowe, stacja_docelowa, pociag, zapach))
    @sasiedzi.add(miasto_docelowe)
  end

  def to_s
    @nazwa
  end

  attr_accessor :nazwa, :krawedzie, :sasiedzi
end