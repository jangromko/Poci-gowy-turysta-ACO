def sigmoidalna_koszt(x)
  1-1/(1+Math.exp((-x+52000)*0.0006))
end

def sigmoidalna_rozmiar(x)
  1-1/(1+Math.exp((-x+190)*0.5))
end

def dodaj_do_czasu(obecny_czas, dodane)
  (obecny_czas + dodane)%1440
end