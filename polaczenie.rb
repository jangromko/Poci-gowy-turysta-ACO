class Polaczenie
  def initialize(czas, odjazd, przyjazd, stacja_poczatkowa, stacja_docelowa, pociag, miasto_docelowe)
    @czas = czas
    @odjazd = odjazd
    @przyjazd = przyjazd
    @stacja_poczatkowa = stacja_poczatkowa
    @stacja_docelowa = stacja_docelowa
    @pociag = pociag
    @miasto_docelowe = miasto_docelowe
  end

  def to_s
    'miasto docelowe: ' + @miasto_docelowe.nazwa + ', czas: ' + @czas.to_s + ', odjazd: ' + @odjazd.to_s + ', przyjazd: ' + @przyjazd.to_s + ', stacja początkowa: ' + @stacja_poczatkowa + ', stacja docelowa: ' + @stacja_docelowa + ', pociąg: ' + @pociag
  end


  attr_reader :czas, :odjazd, :przyjazd, :stacja_poczatkowa, :stacja_docelowa, :pociag, :miasto_docelowe
end