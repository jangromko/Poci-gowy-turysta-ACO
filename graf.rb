load 'wierzcholek.rb'

class Graf
  def initialize
    @wierzcholki = {}
  end

  def dodaj_wierzcholek(wierzcholek)
    @wierzcholki[wierzcholek.nazwa] = wierzcholek
  end

  def odparuj(wspolczynnik=0.2)
    @wierzcholki.each_key do |wierzcholek|
      if wierzcholek != nil
        @wierzcholki[wierzcholek].krawedzie.each do |krawedz|
          krawedz.odparuj(wspolczynnik)
        end
      end
    end
  end

  attr_accessor :wierzcholki
end