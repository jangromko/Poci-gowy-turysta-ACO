def sigmoidalna_koszt(x)
  1-1/(1+Math.exp((-x+40000)*0.0005))

  #1000/x
end

def sigmoidalna_rozmiar(x)
  1-1/(1+Math.exp((-x+110)*0.5))
end

def atrakcyjnosc_czekanie(x)
  1-1/(1+Math.exp((-x+30)*0.06))+1/(x+0.1)

  #1/(x+0.1)
end

def atrakcyjnosc_czas_podrozy(x)
  1-1/(1+Math.exp((-x)*0.005))

  1/(x+0.1)
end

def nieodwiedzeni_atrakcyjnosc(x)
=begin
  if x == 0
    0.001
  elsif x == 1
    0.03
  elsif x > 1 and x < 10
    Math.log(x)/10
  else
    Math.exp((x-100)*0.03)+0.16
  end
=end

  if x >= 1
    1
  else
    0.7
  end
end

def dodaj_do_czasu(obecny_czas, dodane)
  (obecny_czas + dodane)%1440
end

def wylicz_czas_polaczenia(obecny_czas, odjazd, czas_trwania)
  if odjazd >= obecny_czas
    wynik = odjazd - obecny_czas
  else
    wynik = 1440 - obecny_czas + odjazd
  end


  wynik+czas_trwania
end