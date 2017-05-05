require 'parallel'
require 'set'

class Mrowka

  def initialize(start, rozmiar_grafu)
    @start = start
    @trasa = []
    @odwiedzone = Set.new [start]
    @obecny_wierzcholek = start
    @rozmiar_grafu = rozmiar_grafu
    @status = 0
    @koszt = 0
  end


  def idz_dalej
    kandydaci = {}
    suma_atrakcyjnosci = 0
    if @odwiedzone.size < @rozmiar_grafu
      @obecny_wierzcholek.krawedzie.each do |krawedz|
        atrakcyjnosc = krawedz.zapach/3.0
        if @odwiedzone.include?(krawedz.cel)
          atrakcyjnosc /= 3.0
        end
        atrakcyjnosc += 1.0/krawedz.odleglosc
        suma_atrakcyjnosci += atrakcyjnosc
        kandydaci[krawedz] = atrakcyjnosc
      end


      r = Random.new
      wybor = r.rand(0.0..suma_atrakcyjnosci)
      suma_pom = 0

=begin
      puts @obecny_wierzcholek

      kandydaci.each_key do |k|
        puts k
      end

      puts '–––––––––––––––––––––––––'

=end

      kandydaci.each_key do |kandydat|
        suma_pom += kandydaci[kandydat]
        if suma_pom >= wybor
          @obecny_wierzcholek = kandydat.cel
          @odwiedzone.add(kandydat.cel)
          @trasa.push(kandydat)
          @koszt += kandydat.odleglosc
          #puts @obecny_wierzcholek.nazwa
          break
        end
      end

    elsif @odwiedzone.size >= @rozmiar_grafu and @obecny_wierzcholek == @start
      @status = 1

    else

      @obecny_wierzcholek.krawedzie.each do |krawedz|
        atrakcyjnosc = krawedz.zapach/3.0
        if krawedz.cel == @start
          atrakcyjnosc *= 4.0
        end
        atrakcyjnosc += 1.0/krawedz.odleglosc
        suma_atrakcyjnosci += atrakcyjnosc
        kandydaci[krawedz] = atrakcyjnosc
      end


      r = Random.new
      wybor = r.rand(0.0..suma_atrakcyjnosci)
      suma_pom = 0

=begin
      puts @obecny_wierzcholek

      kandydaci.each_key do |k|
        puts k
      end

      puts '–––––––––––––––––––––––––'

=end

      kandydaci.each_key do |kandydat|
        suma_pom += kandydaci[kandydat]
        if suma_pom >= wybor
          @obecny_wierzcholek = kandydat.cel
          @trasa.push(kandydat)
          @koszt += kandydat.odleglosc
          break
        end
      end

    end


  end


  def wykonaj_pelna_trase
    until @status == 1
      idz_dalej
    end
  end


  attr_reader :obecny_wierzcholek, :trasa, :odwiedzone, :koszt
end