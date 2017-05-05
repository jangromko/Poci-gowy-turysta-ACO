class Krawedz
  def initialize(odleglosc, cel, zapach=0.2)
    @odleglosc = odleglosc
    @cel = cel
    @zapach = zapach
  end

  def to_s
    'cel: ' + @cel.to_s + ', czas: ' + @odleglosc.to_s + ', zapach: ' + @zapach.to_s
  end


  def odparuj(wspolczynnik)
    @zapach = @zapach * (1 - wspolczynnik)
  end

  def dodaj_feromon(ilosc, wspolczynnik=1)
    @zapach += ilosc*wspolczynnik
  end

  attr_accessor :odleglosc, :cel, :zapach
end