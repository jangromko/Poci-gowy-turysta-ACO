load 'graf.rb'
load 'mrowka.rb'
require 'parallel'
require 'benchmark'
require 'json'
load 'funkcje.rb'

plik = IO.read('rozklad.json')
rozklad = JSON.parse(plik)
graf = Graf.new
graf.utworz_z_jsona(rozklad)

najlepszy_koszt = 1.0/0
najlepsza_trasa = nil
kiedy_znaleziona = 0


mrowy = []

for j in 0..15
  for i in 0..20
    mrowy[i] = Mrowka.new(graf.wierzcholki['Warszawa'], 99)
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
  graf.odparuj(0.05)

  mrowy.each do |mrowa|
    mrowa.trasa.each do |krawedz|
      krawedz.dodaj_feromon(sigmoidalna_rozmiar(mrowa.trasa.size), 0.01)
      krawedz.dodaj_feromon(sigmoidalna_koszt(mrowa.koszt), 5)
      # puts krawedz.zapach
    end
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
