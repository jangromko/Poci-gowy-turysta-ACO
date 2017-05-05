load 'graf.rb'
load 'mrowka.rb'
require 'parallel'
require 'benchmark'
graf = Graf.new

w1 = Wierzcholek.new('Białystok')
w2 = Wierzcholek.new('Kraków')
w3 = Wierzcholek.new('Gdańsk')
w4 = Wierzcholek.new('Poznań')
w5 = Wierzcholek.new('Warszawa')


graf.dodaj_wierzcholek(w1)
graf.dodaj_wierzcholek(w2)
graf.dodaj_wierzcholek(w3)
graf.dodaj_wierzcholek(w4)
graf.dodaj_wierzcholek(w5)

#puts graf.wierzcholki

graf.wierzcholki['Białystok'].dodaj_krawedz(300, w2)
graf.wierzcholki['Kraków'].dodaj_krawedz(305, w1)
graf.wierzcholki['Białystok'].dodaj_krawedz(480, w3)
graf.wierzcholki['Gdańsk'].dodaj_krawedz(470, w1)
graf.wierzcholki['Kraków'].dodaj_krawedz(360, w3)
graf.wierzcholki['Gdańsk'].dodaj_krawedz(380, w2)
graf.wierzcholki['Poznań'].dodaj_krawedz(350, w3)
graf.wierzcholki['Kraków'].dodaj_krawedz(300, w4)
graf.wierzcholki['Warszawa'].dodaj_krawedz(200, w4)
graf.wierzcholki['Warszawa'].dodaj_krawedz(120, w1)
graf.wierzcholki['Warszawa'].dodaj_krawedz(210, w3)
graf.wierzcholki['Warszawa'].dodaj_krawedz(150, w2)
graf.wierzcholki['Kraków'].dodaj_krawedz(140, w5)
graf.wierzcholki['Gdańsk'].dodaj_krawedz(180, w5)
graf.wierzcholki['Białystok'].dodaj_krawedz(130, w5)

#puts graf.wierzcholki['Białystok'].trasy

#graf.wierzcholki.each do |wierzcholek|
#  wierzcholek.odparuj(0.2)
#end

#puts graf.wierzcholki['Białystok'].krawedzie

graf.odparuj(0.1)

#graf.wierzcholki.each_key { |wierzcholek| puts graf.wierzcholki[wierzcholek].krawedzie}

=begin
mrowa = Mrowka.new(w1, 4)

mrowa.wykonaj_pelna_trase

puts mrowa.trasa
=end

=begin
mrowy = []
for i in 0..500
  mrowy[i] = Mrowka.new(w3, 4)
end


puts Benchmark.measure {
  for j in 0..200
    Parallel.each(mrowy) do |mrowa|
      for i in 0..250
        mrowa.idz_dalej
      end
    end
  end
}

puts Benchmark.measure {
  for j in 0..200
    mrowy.each do |mrowa|
      for i in 0..250
        mrowa.idz_dalej
      end
    end
  end
}
=end

for x in 0..50
  mrowy = []
  for i in 0..500
    mrowy[i] = Mrowka.new(w1, 5)
  end

  mrowy.each do |mrowa|
    mrowa.wykonaj_pelna_trase
  end

  mrowy.each do |mrowa|
    mrowa.trasa.each do |krawedz|
      krawedz.dodaj_feromon(1.0/mrowa.koszt)
    end
  end

  graf.odparuj(0.05)
end


mrowy.each do |mrowa|
  puts mrowa.trasa
  puts mrowa.koszt
  puts '–––––––––––––––––––––––––––––'
end