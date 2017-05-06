load 'graf.rb'
load 'mrowka.rb'
require 'parallel'
require 'benchmark'
require 'json'

plik = IO.read('rozklad.json')
rozklad = JSON.parse(plik)
graf = Graf.new
graf.utworz_z_jsona(rozklad)
