require 'parallel'
require 'set'

class Mrowka

  def initialize(start, rozmiar_grafu, graf)
    @start = start
    @trasa = []
    @trasa_ogolna = []
    @odwiedzone = Set.new [start]
    @obecny_wierzcholek = start
    @obecna_stacja = nil
    @rozmiar_grafu = rozmiar_grafu
    @status = 0
    @koszt = 0
    @graf = graf
    # @aktualny_czas = rand(0..1439)
    @aktualny_czas = 0
    @r = Random.new

    @wierzcholki = []
    @sasiedzi_do_odwiedzenia = {}
    graf.wierzcholki.each_key do |w|
      @wierzcholki.push(graf.wierzcholki[w])
      @sasiedzi_do_odwiedzenia[w] = graf.wierzcholki[w].sasiedzi.size
    end
  end


  def ile_czekania(obecny_czas, odjazd)
    if obecny_czas <= odjazd
      odjazd - obecny_czas
    else
      1440 - obecny_czas + odjazd
    end
  end


  def idz_dalej
    kandydaci = {}
    suma_atrakcyjnosci = 0
    if @odwiedzone.size < @rozmiar_grafu
      @obecny_wierzcholek.krawedzie.each_key do |krawedz|
        atrakcyjnosc = @obecny_wierzcholek.krawedzie[krawedz].zapach
        polaczenie = @obecny_wierzcholek.krawedzie[krawedz].najlepsze_polaczenie(@aktualny_czas)

        if polaczenie.stacja_poczatkowa == @obecna_stacja
          dodatek_na_przesiadke = 1
        elsif @odwiedzone.size == 1
          dodatek_na_przesiadke = 0
        else
          dodatek_na_przesiadke = 25
        end
        # atrakcyjnosc *= (10000.0/(ile_czekania(dodaj_do_czasu(@aktualny_czas, dodatek_na_przesiadke), krawedz.odjazd) + 0.001))**2
        # atrakcyjnosc *= 100.0/(polaczenie.czas + 0.01)
        atrakcyjnosc *= atrakcyjnosc_czas_podrozy(polaczenie.czas)
        atrakcyjnosc *= atrakcyjnosc_czekanie(ile_czekania(dodaj_do_czasu(@aktualny_czas, dodatek_na_przesiadke), polaczenie.odjazd))

        if @odwiedzone.include?(polaczenie.miasto_docelowe)
          atrakcyjnosc /= 10000000.0
        end

        # atrakcyjnosc *= nieodwiedzeni_atrakcyjnosc(@sasiedzi_do_odwiedzenia[polaczenie.miasto_docelowe.nazwa])

        if polaczenie.miasto_docelowe == @obecny_wierzcholek
          atrakcyjnosc /= 1000.0
        end

        suma_atrakcyjnosci += atrakcyjnosc
        kandydaci[polaczenie] = atrakcyjnosc
      end



      wybor = @r.rand(0.0..suma_atrakcyjnosci)
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
          if kandydat.stacja_poczatkowa == @obecna_stacja
            dodatek_na_przesiadke = 1
          elsif @odwiedzone.size == 1
            dodatek_na_przesiadke = 0
          else
            dodatek_na_przesiadke = 25
          end

          @trasa_ogolna.push(@graf.wierzcholki[@obecny_wierzcholek.nazwa].krawedzie[kandydat.miasto_docelowe.nazwa])
          @aktualny_czas = dodaj_do_czasu(@aktualny_czas, dodatek_na_przesiadke)
          @obecny_wierzcholek = kandydat.miasto_docelowe

          @wierzcholki.each do |w|
            if w.sasiedzi.include? @obecny_wierzcholek and !(@odwiedzone.include? @obecny_wierzcholek)
              @sasiedzi_do_odwiedzenia[w.nazwa] -= 1
            end
          end

          @obecna_stacja = kandydat.stacja_docelowa
          @trasa.push(kandydat)
          @koszt += kandydat.czas + ile_czekania(@aktualny_czas, kandydat.odjazd)
          @aktualny_czas = (@aktualny_czas + ile_czekania(@aktualny_czas, kandydat.odjazd) + kandydat.czas)%1440
          unless @odwiedzone.include? @obecny_wierzcholek
            @koszt += 30
            @aktualny_czas = (@aktualny_czas + 30)%1440
          end
          @odwiedzone.add(@obecny_wierzcholek)
          # puts @obecny_wierzcholek.nazwa
          break
        end
      end

    elsif @odwiedzone.size >= @rozmiar_grafu and @obecny_wierzcholek == @start
      @status = 1
    else

      @obecny_wierzcholek.krawedzie.each_key do |krawedz|
        atrakcyjnosc = @obecny_wierzcholek.krawedzie[krawedz].zapach
        if @obecny_wierzcholek.krawedzie[krawedz].miasto_docelowe == @start
          atrakcyjnosc *= 4.0
        end

        if @obecny_wierzcholek.krawedzie[krawedz].miasto_docelowe == @obecny_wierzcholek
          atrakcyjnosc /= 100.0
        end

        suma_atrakcyjnosci += atrakcyjnosc
        kandydaci[@obecny_wierzcholek.krawedzie[krawedz].najlepsze_polaczenie(@aktualny_czas)] = atrakcyjnosc
      end


      wybor = @r.rand(0.0..suma_atrakcyjnosci)
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
          if kandydat.stacja_docelowa == @obecna_stacja
            dodatek_na_przesiadke = 1
          elsif @odwiedzone.size == 1
            dodatek_na_przesiadke = 0
          else
            dodatek_na_przesiadke = 25
          end

          @trasa_ogolna.push(@graf.wierzcholki[@obecny_wierzcholek.nazwa].krawedzie[kandydat.miasto_docelowe.nazwa])
          @obecny_wierzcholek = kandydat.miasto_docelowe
          @obecna_stacja = kandydat.stacja_docelowa
          @trasa.push(kandydat)
          @koszt += kandydat.czas + ile_czekania(dodaj_do_czasu(@aktualny_czas, dodatek_na_przesiadke), kandydat.odjazd)
          @aktualny_czas = (@aktualny_czas + ile_czekania(@aktualny_czas, kandydat.odjazd) + kandydat.czas)%1440
          break
        end
      end
    end
  end


  def wykonaj_pelna_trase
    until @status == 1
      idz_dalej
      #puts @sasiedzi_do_odwiedzenia.to_s
    end
  end


  attr_reader :obecny_wierzcholek, :trasa, :odwiedzone, :koszt, :trasa_ogolna
end