load 'wierzcholek.rb'

class Graf
  def initialize
    @wierzcholki = {}
  end

  def dodaj_wierzcholek(wierzcholek)
    @wierzcholki[wierzcholek.nazwa] = wierzcholek
  end

  def utworz_z_jsona(rozklad)
    rozklad.each_key do |miasto|
      self.dodaj_wierzcholek(Wierzcholek.new(miasto))
    end

    rozklad.each_key do |miasto|
      w = @wierzcholki[miasto]

      rozklad[miasto].each_key do |stacja|
        rozklad[miasto][stacja].each do |polaczenie|
          polaczenie['stacje'].each do |cel|
            w.dodaj_krawedz(cel['czas'], polaczenie['odjazd'], cel['przyjazd'], stacja, @wierzcholki[cel['miastoDocelowe']], cel['stacjaDocelowa'], polaczenie['pociag'])
          end
        end
      end
    end
  end

  def wierzcholek_nazwa(nazwa)
    @wierzcholki[nazwa]
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