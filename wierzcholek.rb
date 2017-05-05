load 'krawedz.rb'

class Wierzcholek
  def initialize(nazwa)
    @nazwa = nazwa
    @krawedzie = []
    @sasiedzi = []
  end

  def dodaj_krawedz(odleglosc, cel)
    @krawedzie.push(Krawedz.new(odleglosc, cel))
    @sasiedzi.push(cel)
  end

  def to_s
    @nazwa
  end

  attr_accessor :nazwa, :krawedzie, :sasiedzi
end