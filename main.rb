load 'graf.rb'
load 'mrowka.rb'
require 'parallel'
require 'benchmark'
require 'json'
load 'funkcje.rb'
=begin
plik = IO.readlines('/home/jg/Pulpit/projekt_testy_0/E.txt')
n, m, s, ts, czas = plik[0].split.map(&:to_i)

graf = Graf.new

for i in 1..n
  graf.dodaj_wierzcholek(Wierzcholek.new(i.to_s))
end

for i in 1..m-1
  dane = plik[i].split.map(&:to_i)
  p, k, l = dane[0..2]
  krawedz = graf.wierzcholki[p.to_s].dodaj_krawedz(graf.wierzcholki[k.to_s])
  j=3
  while j <= (2*l+2)
    krawedz.dodaj_polaczenie(Polaczenie.new(dane[j+1], dane[j], dodaj_do_czasu(dane[j], dane[j+1]), p.to_s, k.to_s, 'Latający Holender', graf.wierzcholki[k.to_s]))
    j += 2
  end
end

=end
#=begin
plik = IO.read('rozklad.json')
rozklad = JSON.parse(plik)
graf = Graf.new
graf.utworz_z_jsona(rozklad)
#=end


najlepszy_koszt = 1.0/0
najlepsza_trasa = nil
najlepsza_trasa_ogolna = nil
kiedy_znaleziona = 0


mrowy = []


for j in 0..20
  for i in 0..40
    # mrowy[i] = Mrowka.new(graf.wierzcholki['1'], 100, graf)
    mrowy[i] = Mrowka.new(graf.wierzcholki['Warszawa'], 99, graf)
  end


  mrowy.each do |mrowa|
    mrowa.wykonaj_pelna_trase
  end


  suma = 0
  mrowy.each do |mrowa|
    #puts mrowa.koszt
    # puts mrowa.trasa.size
    # puts mrowa.trasa
    #puts '–––––––––––––––––––––'
    if mrowa.koszt < najlepszy_koszt
      najlepszy_koszt = mrowa.koszt
      najlepsza_trasa = mrowa.trasa
      najlepsza_trasa_ogolna = mrowa.trasa_ogolna
      kiedy_znaleziona = j
    end

    suma += mrowa.koszt
  end

  puts '–––––––––––––––––––'
  puts j
  print 'ŚREDNIA: '
  puts suma/mrowy.size
  print 'NAJLEPSZY: '
  puts najlepszy_koszt
  puts '–––––––––––––––––––'



#=begin
  graf.odparuj(0.25)

  mrowy.each do |mrowa|
    mrowa.trasa_ogolna.each do |krawedz|
      krawedz.dodaj_feromon(sigmoidalna_rozmiar(mrowa.trasa.size), 0.01)
      krawedz.dodaj_feromon(sigmoidalna_koszt(mrowa.koszt), 15)
    end
  end

  najlepsza_trasa_ogolna.each do |krawedz|
    # krawedz.dodaj_feromon(sigmoidalna_rozmiar(mrowa.trasa.size), 0.01)
    # krawedz.dodaj_feromon(sigmoidalna_koszt(najlepszy_koszt), 15)
  end

#=end
end

=begin
mrowy.each do |mrowa|
  puts mrowa.koszt
  puts mrowa.trasa.size
  puts '–––––––––––––––––––––'
end
=end

puts najlepsza_trasa
puts najlepszy_koszt
puts najlepsza_trasa.size
puts kiedy_znaleziona

=begin
for i in 0..mrowy.size - 1
  File.open('/home/jg/Pulpit/Wyniki/' + i.to_s, "w") do |plik_wyj|
    plik_wyj.puts mrowy[i].koszt
    plik_wyj.puts mrowy[i].trasa
  end
end
=end

File.open('/home/jg/Pulpit/stan_grafu', "w") do |plik_wyj|
  graf.wierzcholki.each_key do |miasto|
    plik_wyj.puts miasto
    graf.wierzcholki[miasto].krawedzie.each_key do |krawedz|
      plik_wyj.puts graf.wierzcholki[miasto].krawedzie[krawedz]
    end

    plik_wyj.puts '–––––––––––––––––––––'
  end
end
