class Krawedz
  def initialize(czas, odjazd, przyjazd, stacja_poczatkowa, miasto_docelowe, stacja_docelowa, pociag, zapach=0.2)
    @czas = czas
    @odjazd = odjazd
    @przyjazd = przyjazd
    @miasto_docelowe = miasto_docelowe
    @stacja_poczatkowa = stacja_poczatkowa
    @stacja_docelowa = stacja_docelowa
    @pociag = pociag
    @zapach = zapach
  end

  def to_s
    'stacja początkowa: ' + @stacja_poczatkowa + ', miasto docelowe: ' + @miasto_docelowe.to_s + ', stacja docelowa: ' + @stacja_docelowa + ', odjazd: ' + @odjazd.to_s + ', przyjazd: ' + @przyjazd.to_s + ', czas: ' + @czas.to_s + ', pociąg: ' + @pociag + ', zapach: ' + @zapach.to_s
  end

  def odparuj(wspolczynnik)
    @zapach = @zapach * (1 - wspolczynnik)
  end

  def dodaj_feromon(ilosc, wspolczynnik=1)
    @zapach += ilosc*wspolczynnik
  end

  attr_reader :czas, :miasto_docelowe, :zapach, :odjazd, :przyjazd, :stacja_docelowa, :stacja_poczatkowa, :pociag
end