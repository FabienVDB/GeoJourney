# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Clear sites"
Site.destroy_all # if Rails.env.development?
puts "Clear itineraries"
Itinerary.destroy_all #  if Rails.env.development?
puts "Clear areas"
Area.destroy_all # if Rails.env.development?
puts "Clear themes"
Theme.destroy_all # if Rails.env.development?
puts "Clear complete"

Dir[File.join(Rails.root, 'db', 'seeds/*', '*.rb')].each do |seed|
  load seed
end

puts "Create themes"
geotraverse = Theme.create!(name: "Geotraverse",
                            description: "Cut accross an entire mountain range to comprehend its formation")
fluvial_landforms = Theme.create!(name: "Fluvial landforms", description: "Discover how rivers shape topography")
urban_geology = Theme.create!(name: "Urban geology",
                              description: "Explore the geology of built environment in your city")

puts "Create areas"
western_alps = Area.create!(name: "Western Alps")
pyrenees = Area.create!(name: "Pyrenees")
aquitaine_basin = Area.create!(name: "Aquitaine Basin")
paris_basin = Area.create!(name: "Paris Basin")
provence = Area.create!(name: "Provence")

puts "Create Western Switzerland Geotraverse itinerary !Real!"
western_switzerland = Itinerary.create!(name: "Western Switzerland Geotraverse",
                                        theme: geotraverse,
                                        area: western_alps,
                                        duration_in_days: 2,
                                        summary: "Dig through time in the heart of the Alps",
                                        content: "The Alps arose as a result of the collision of the African \
and Eurasian tectonic plates. The Alpine Tethys ocean, which separated these continents since 220 millions years ago, \
started to disappear under the African-Italian plate around 65 millions years ago, due to their convergence. \
The African-Italian plate consequently overthrusted the European margin, which was eventually pushed back up, being \
less dense than the oceanic crust")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654004483/GeoJourney/WesternAlpsGeotraverse/WesternAlpsGeotraverse_x7oxej.jpg')
western_switzerland.photo.attach(io: file, filename: 'WesternSwitzerlandGeotraverse.jpg', content_type: 'image/jpg')

puts "  Create plagne site !Real!"
plagne = Site.create!(itinerary: western_switzerland,
                      stage: 1,
                      name: "Dinoplagne",
                      summary: "Dinosaur footprints",
                      location: "sur la Croix, 01130 Plagne, France",
                      latitude: 46.1893585,
                      longitude: 5.7155843,
                      duration_in_minutes: 180,
                      content: "Many dinosaur footprints embedded in a limestone of late Jurassic age \
(152 millions years ago). The site features a 150m-long track left by Odysseus, \
a 30m-long Diplodocus. A new species has been recognized and named after the plagne village: \
Brontopodus plagnensis. At that time, the site was located on the southern margin \
of the European continent. The environment was a beach shore under a warm tropical climate, \
just like the present-day Bahamas islands.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654003184/GeoJourney/WesternAlpsGeotraverse/Dinoplagne/Dinoplagne_vomc1j.jpg')
plagne.photo.attach(io: file, filename: 'Dinoplagne.jpg', content_type: 'image/jpg')
puts "  Plagne site complete"

puts "  Create mont pélerin site !Real!"
mont_pelerin = Site.create!(itinerary: western_switzerland,
                            stage: 2,
                            name: "Mont Pélerin conglomerates",
                            summary: "Alpine foreland basin",
                            location: "Mont Pèlerin, 1801 Chardonne, Switzerland",
                            latitude: 46.4975638,
                            longitude: 6.8188236,
                            duration_in_minutes: 30,
                            content: "Some 25 millions years ago, the Alpine range was rapidly growing. \
The coarse eroded material started to accumulate at the foot of the range, \
transported by an early Rhone river. This 1000m-thick accumulation took the shape \
of a section of a shallow cone, called an alluvian fan. These deposits were in turn \
thrusted on top of more distal sediments that make up the Swiss PLateau.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654003500/GeoJourney/WesternAlpsGeotraverse/MontPelerin/MontPelerin_zpvn6k.jpg')
mont_pelerin.photo.attach(io: file, filename: 'MontPelerin.jpg', content_type: 'image/jpg')
puts "  Mont Pèlerin site complete"

puts "  Create morcles site !Real!"
morcles = Site.create!(itinerary: western_switzerland,
                       stage: 3,
                       name: "Morcles nappe",
                       summary: "Spectacular folds in the calcareous Alps",
                       location: "Route des Carroz 1, 1890 Mex, Switzerland",
                       latitude: 46.184887,
                       longitude: 7.001007,
                       duration_in_minutes: 240,
                       content: "the Morcles nappe consists of Jurassic and Cretaceous limestones \
deposited on the European margin. The nappe itself is a huge north-west-verging recumbent fold, \
spanning a 200 km²-area. It contains numerous smaller folds which can be observed \
on every mountain flanks in the area. The Dent de morcles mountain is part of the overturned \
limb of the nappe, thus the older rocks lie at the top. The layers show intensive \
tectonic thinning, having experienced signicant plastic deformation due to the lower position \
in the nappe stack.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654003255/GeoJourney/WesternAlpsGeotraverse/Morcles/Dent-de-Morcles_etuo5t.jpg')
morcles.photo.attach(io: file, filename: 'Morcles.jpg', content_type: 'image/jpg')
puts "  Morcles site complete"

puts "  Create zermatt site !Real!"
zermatt = Site.create!(itinerary: western_switzerland,
                       stage: 4,
                       name: "Zermatt thrusts",
                       summary: "Colliding continents: Europe meets Africa",
                       location: "Bahnhofstrasse 1, 3929 Täsch, Switzerland",
                       latitude: 46.06825142238093,
                       longitude: 7.776304828342801,
                       duration_in_minutes: 360,
                       content: "The European rocks of the Monte Rosa nappe were buried at least 45 kilometers \
beneath the oceanic floor and the African rocks some 55 millions years ago. Susbsequent uplift \
raised the overlying oceanic rocks and African crust stacked above them. The rocks at \
the Rothorn peak belong to the oceanic nappe, whereas the iconic Matterhorn summit \
belongs to the thrusting African plate.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654003307/GeoJourney/WesternAlpsGeotraverse/Zermatt/Zermatt-Matterhorn_mzzzfi.jpg')
zermatt.photo.attach(io: file, filename: 'Zermatt.jpg', content_type: 'image/jpg')
puts "  Zermatt site complete"

puts "Western Switzerland Geotraverse itinerary complete"

puts "Create Oloron Jaca Geotraverse itinerary !Real!"
oloron_jaca = Itinerary.create!(name: "Oloron-Jaca Geotraverse",
                                theme: geotraverse,
                                area: pyrenees,
                                duration_in_days: 3,
                                summary: "How the Pyrenees were formed ? Dive deep to understand",
                                content: "The Pyrenees' present configuration is due to the collision between \
the microcontinent Iberia and the European Plate. The two continents were approaching each other since \
100 million years ago and were consequently colliding from 55 to 25 million years ago.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654028906/GeoJourney/OloronJacaPyreneesGeotraverse/oloronJacaGeotraverse_hjbwpl.jpg')
oloron_jaca.photo.attach(io: file, filename: 'OloronJacaGeotraverse.jpg', content_type: 'image/jpg')

puts "  Create Courrèges site !Real!"
courreges = Site.create!(itinerary: oloron_jaca,
                         stage: 1,
                         name: "Courrèges",
                         summary: "Lava encounters deep water",
                         location: "Géolval RGTP Courrèges, Avenue d'Ossau, 64680 Ogeu-les-Bains, France",
                         latitude: 43.161992,
                         longitude: -0.521164,
                         duration_in_minutes: 30,
                         content: "Pillow lavas are lavas that contain characteristic pillow-shaped structures that \
are attributed to the underwater extrusion of rapidly cooling lava. These lavas infiltrated extensional \
faults and spread over the sea floor about 110 millions years ago when the Bay of Biscay was opening.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654028388/GeoJourney/OloronJacaPyreneesGeotraverse/Courreges/CourregesPillowLavas_fnmcky.jpg')
courreges.photo.attach(io: file, filename: 'Courrege.jpg', content_type: 'image/jpg')
puts "  Courrèges site complete"

puts "  Create Accous site !Real!"
accous = Site.create!(itinerary: oloron_jaca,
                      stage: 2,
                      name: "Accous",
                      summary: "Europe smashes Spain",
                      location: "1615 Route Départementale 834, 64490 Accous, France",
                      latitude: 42.970492,
                      longitude: -0.609913,
                      duration_in_minutes: 60,
                      content: "The site is located right at the geological boundary between the European and \
the Iberian plates. Upon collision some 40 millions years ago, the European margin overthrusted the spanish margin \
at the The Northern Pyrenean Fault.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654029913/GeoJourney/OloronJacaPyreneesGeotraverse/Accous/AccousCollision_lckma9.jpg')
accous.photo.attach(io: file, filename: 'Accous.jpg', content_type: 'image/jpg')
puts "  Accous site complete"

puts "  Create Castillo de Acher site !Real!"
castillo_de_acher = Site.create!(itinerary: oloron_jaca,
                                 stage: 3,
                                 name: "Castillo de Acher",
                                 summary: "Ancient red desert",
                                 location: "Anglus, 64490 Urdos, France",
                                 latitude: 42.809381,
                                 longitude: -0.555496,
                                 duration_in_minutes: 240,
                                 content: "260 millions years ago, during Permian times, the climate of the Pangean \
                                 supercontinent was very arid. Over time, sand grains from the desert consolidated \
                                 into beautiful red standstoned, due to the oxidation of iron minerals.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654029590/GeoJourney/OloronJacaPyreneesGeotraverse/castilloDeAcher/CastillodeAcherPermianSandstone_s82eag.jpg')
castillo_de_acher.photo.attach(io: file, filename: 'CastilloDeAcher.jpg', content_type: 'image/jpg')
puts "  Castillo de Acher site complete"

puts "  Create Candanchú site !Real!"
candanchu = Site.create!(itinerary: oloron_jaca,
                         stage: 4,
                         name: "Candanchú",
                         summary: "The heart of the Pyrenees",
                         location: "N-330-b, 22889 Candanchú, Spain",
                         latitude: 42.789858,
                         longitude: -0.526142,
                         duration_in_minutes: 40,
                         content: "This site is made up of rocks that were formed during an previous collision that \
occured 300 million years ago: the Hercynian orogeny. Remnants of this collision can be found in the Massif central \
and Brittany, in France, as well as the Appalachian, in the US.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654030821/GeoJourney/OloronJacaPyreneesGeotraverse/Candanchu/candanchuAxialZone_jdgpo9.jpg')
candanchu.photo.attach(io: file, filename: 'Candanchu.jpg', content_type: 'image/jpg')
puts "  Candanchú site complete"

puts "  Create Puente de Torrijos site !Real!"
puente_de_torrijos = Site.create!(itinerary: oloron_jaca,
                                  stage: 5,
                                  name: "Puente de Torrijos",
                                  summary: "Turbulent seabed",
                                  location: "unnamed road, 22710 Jaca, Spain",
                                  latitude: 42.609706,
                                  longitude: -0.544252,
                                  duration_in_minutes: 30,
                                  content: "45 millions years ago, the Iberian and the European plates came closer \
together. The ancient sea that separated them underwent frequent earthquakes. During these earthquakes, loads of \
coarse sediments were rushing down the continental slopes and deposited at the bottom. During quiet times, only fine \
sediments deposited, thereby creating distinctive repeating layer sequences, known as Flysch.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654030883/GeoJourney/OloronJacaPyreneesGeotraverse/CanteraDeTorrijos/canteraDeTorrijosFlysch_iyuxgi.jpg')
puente_de_torrijos.photo.attach(io: file, filename: 'PuenteDeTorrijos.jpg', content_type: 'image/jpg')
puts "  Puente de Torrijos site complete"

puts "  Create Murillo de Gállego site !Real!"
murillo_de_gallego = Site.create!(itinerary: oloron_jaca,
                                  stage: 6,
                                  name: "Murillo de Gállego",
                                  summary: "The Pyrenean foreland basin",
                                  location: "Via Ferrata Varela Portillo, 22808 Murillo de Gállego, Spain",
                                  latitude: 42.362603,
                                  longitude: -0.758743,
                                  duration_in_minutes: 60,
                                  content: "Since 40 millions years ago, the Pyrenees are continously eroding away. \
Coarse material was transported away and deposited in the Ebro foreland, forming conglomerates made up of large \
pebbles. Futher erosion stripped the finest sediments and scuplted huge columns and pinnacles of coarse sediments.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654030923/GeoJourney/OloronJacaPyreneesGeotraverse/MurilloDeGallego/murillodeGallegoConglomerates_mobeln.jpg')
murillo_de_gallego.photo.attach(io: file, filename: 'Murillo de Gallego', content_type: 'image/jpg')
puts "  Murillo de Gállego site complete"

puts "Oloron Jaca Geotraverse itinerary complete"

puts "Create Basque Country Geotraverse itinerary !Fake!"
basque_country = Itinerary.create!(name: "Basque Country Geotraverse",
                                   theme: geotraverse,
                                   area: pyrenees,
                                   duration_in_days: 2,
                                   summary: "The geology of the Pyrenees in the Basque Country",
                                   content: "")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654329863/GeoJourney/BasqueCountryGeotraverse/1314661-Pays_basque_zk6tso.jpg')
basque_country.photo.attach(io: file, filename: 'BasqueCountryGeotraverse.jpg', content_type: 'image/jpg')

puts "  Create Basque Country Site 1 !Fake!"
Site.create!(itinerary: basque_country,
             stage: 1,
             name: "La Rhune",
             latitude: 43.3332143936,
             longitude: -1.62313479477,
             duration_in_minutes: 120)
puts "  Basque Country Fake Site 1 complete"

puts "  Create Basque Country Site 2 !Fake!"
Site.create!(itinerary: basque_country,
             stage: 2,
             name: "Lohia Bay",
             latitude: 43.3802222,
             longitude: -1.74415833,
             duration_in_minutes: 60)
puts "  Basque Country Fake Site 2 complete"

puts "  Create Basque Country Site 3 !Fake!"
Site.create!(itinerary: basque_country,
             stage: 3,
             name: "Zumaia",
             latitude: 43.3011167,
             longitude: -2.259767,
             duration_in_minutes: 120)
puts "  Basque Country Fake Site 3 complete"

puts "  Create Basque Country Site 4 !Fake!"
Site.create!(itinerary: basque_country,
             stage: 4,
             name: "Sopelana",
             latitude: 43.3949333,
             longitude: -2.9883583,
             duration_in_minutes: 120)
puts "  Basque Country Fake Site 4 complete"

puts "Basque Country Geotraverse itinerary complete"

puts "Create Lannemezan Barbastro itinerary !Fake!"
lannemezan_barbastro = Itinerary.create!(name: "Lannemezan-Barbastro Geotraverse",
                                         theme: geotraverse,
                                         area: pyrenees,
                                         duration_in_days: 3,
                                         summary: "Cut through the central Pyrenees",
                                         content: "")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654331472/GeoJourney/LannemezanBarbastroGeotraverse/LannemezanBarbastroGeotraverse_ffdwc9.jpg')
lannemezan_barbastro.photo.attach(io: file, filename: 'LannemezanBarbastroGeotraverse.jpg', content_type: 'image/jpg')

puts "  Create Lannemezan Barbastro Site 1 !Fake!"
Site.create!(itinerary: lannemezan_barbastro,
             stage: 1,
             latitude: 43.033168488642836,
             longitude: 0.3314781183175135,
             duration_in_minutes: 180)
puts "  Lannemezan Barbastro Site 1 complete"

puts "  Create Lannemezan Barbastro Site 2 !Fake!"
Site.create!(itinerary: lannemezan_barbastro,
             stage: 2,
             latitude: 42.79035752055275,
             longitude: 0.18117076027188853,
             duration_in_minutes: 240)
puts "  Lannemezan Barbastro Site 2 complete"

puts "  Create Lannemezan Barbastro Site 3 !Fake!"
Site.create!(itinerary: lannemezan_barbastro,
             stage: 3,
             latitude: 42.680110648719364,
             longitude: 0.0811419069306548,
             duration_in_minutes: 300)
puts "  Lannemezan Barbastro Site 3 complete"

puts "  Create Lannemezan Barbastro Site 4 !Fake!"
Site.create!(itinerary: lannemezan_barbastro,
             stage: 4,
             latitude: 42.41826289539259,
             longitude: 0.13794212284895982,
             duration_in_minutes: 60)
puts "  Lannemezan Barbastro Site 4 complete"

puts "  Create Lannemezan Barbastro Site 5 !Fake!"
Site.create!(itinerary: lannemezan_barbastro,
             stage: 5,
             latitude: 42.03708755885027,
             longitude: 0.1261639141458871,
             duration_in_minutes: 120)
puts "  Lannemezan Barbastro Site 5 complete"
puts "Lannemezan Barbastro itinerary complete"

puts "Create Foix Berga itinerary !Fake!"
foix_berga = Itinerary.create!(name: "Foix-Berga Geotraverse",
                               theme: geotraverse,
                               area: pyrenees,
                               duration_in_days: 3,
                               summary: "Cut through the Eastern Pyrenees")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654339930/GeoJourney/FoixBergaGeotraverse/FoixBergaGeotraverse_obdbwb.jpg')
foix_berga.photo.attach(io: file, filename: 'FoixBergaGeotraverse.jpg', content_type: 'image/jpg')

puts "  Create Foix Berga Site 1 !Fake!"
Site.create!(itinerary: foix_berga,
             stage: 1,
             latitude: 42.967578283639284,
             longitude: 1.6052723719270208,
             duration_in_minutes: 30)
puts "  Foix Berga Site 1 complete"

puts "  Create Foix Berga Site 2 !Fake!"
Site.create!(itinerary: foix_berga,
             stage: 2,
             latitude: 43.01059227685118,
             longitude: 1.5909125085952114,
             duration_in_minutes: 120)
puts "  Foix Berga Site 2 complete"

puts "  Create Foix Berga Site 3 !Fake!"
Site.create!(itinerary: foix_berga,
             stage: 3,
             latitude: 42.79771334284952,
             longitude: 1.8057612071107112,
             duration_in_minutes: 45)
puts "  Foix Berga Site 3 complete"

puts "  Create Foix Berga Site 4 !Fake!"
Site.create!(itinerary: foix_berga,
             stage: 4,
             latitude: 42.53629771819626,
             longitude: 1.737134089951452,
             duration_in_minutes: 60)
puts "  Foix Berga Site 4 complete"

puts "  Create Foix Berga Site 5 !Fake!"
Site.create!(itinerary: foix_berga,
             stage: 5,
             latitude: 42.18500549113791,
             longitude: 1.8150683572509971,
             duration_in_minutes: 120)
puts "  Foix Berga Site 5 complete"

puts "  Create Foix Berga Site 6 !Fake!"
Site.create!(itinerary: foix_berga,
             stage: 6,
             latitude: 42.12716636825142,
             longitude: 1.8807946906687039,
             duration_in_minutes: 30)
puts "  Foix Berga Site 6 complete"

puts "Foix Berga itinerary complete"

puts "Create Lyon Torino itinerary !Fake!"
lyon_torino = Itinerary.create!(name: "Lyon-Torino Geotraverse",
                                theme: geotraverse,
                                area: western_alps,
                                duration_in_days: 4,
                                summary: "Cut through the Alps via Grenoble and the Romanche Valley")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654345370/GeoJourney/LyonTorinoGeotraverse/LyonTorinoGeotraverse_zmnznq.jpg')
lyon_torino.photo.attach(io: file, filename: 'FoixBergaGeotraverse.jpg', content_type: 'image/jpg')

puts "  Create Lyon Torino Site 1 !Fake!"
Site.create!(itinerary: lyon_torino,
             stage: 1,
             latitude: 45.6731,
             longitude: 4.8555,
             duration_in_minutes: 30)
puts "  Lyon Torino Site 1 complete"

puts "  Create Lyon Torino Site 2 !Fake!"
Site.create!(itinerary: lyon_torino,
             stage: 2,
             latitude: 45.33154104,
             longitude: 5.66346210,
             duration_in_minutes: 240)
puts "  Lyon Torino Site 2 complete"

puts "  Create Lyon Torino Site 3 !Fake!"
Site.create!(itinerary: lyon_torino,
             stage: 3,
             latitude: 45.306253258000,
             longitude: 5.84301990112,
             duration_in_minutes: 60)
puts "  Lyon Torino Site 3 complete"

puts "  Create Lyon Torino Site 4 !Fake!"
Site.create!(itinerary: lyon_torino,
             stage: 4,
             latitude: 45.0637771533895,
             longitude: 6.038919016769432,
             duration_in_minutes: 30)
puts "  Lyon Torino Site 4 complete"

puts "  Create Lyon Torino Site 5 !Fake!"
Site.create!(itinerary: lyon_torino,
             stage: 5,
             latitude: 45.06470775155292,
             longitude: 6.411755928233464,
             duration_in_minutes: 30)
puts "  Lyon Torino Site 5 complete"

puts "  Create Lyon Torino Site 6 !Fake!"
Site.create!(itinerary: lyon_torino,
             stage: 6,
             latitude: 44.93197176870072,
             longitude: 6.726883301483135,
             duration_in_minutes: 360)
puts "  Lyon Torino Site 6 complete"

puts "  Create Lyon Torino Site 7 !Fake!"
Site.create!(itinerary: lyon_torino,
             stage: 7,
             latitude: 44.97312351685449,
             longitude: 7.373782875266774,
             duration_in_minutes: 60)
puts "  Lyon Torino Site 7 complete"

puts "Lyon Torino itinerary complete"

puts "Create Bordeaux urban itinerary !Real!"
bordeaux = Itinerary.create!(name: "Bordeaux Urban Geology",
                             theme: urban_geology,
                             area: aquitaine_basin,
                             duration_in_days: 1,
                             summary: "Visit Bordeaux in a way you'd never imagined",
                             content: "The city of Bordeaux is located within the Aquitaine sedimentary basin. A deep \
fault beneath the Garonne river triggered the uplift of the eastern bank.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654351693/GeoJourney/BordeauxUrbanGeology/BordeauxUrbanGeology_xahrm9.jpg')
bordeaux.photo.attach(io: file, filename: 'Bordeaux.jpg', content_type: 'image/jpg')

puts "  Create Place Du Parlement site !Real!"
place_du_parlement = Site.create!(itinerary: bordeaux,
                                  stage: 1,
                                  name: "Place du Parlement",
                                  summary: "Jurassic animals in the fountain",
                                  location: "9 Pl. du Parlement, 33000 Bordeaux, France",
                                  latitude: 44.84088699876,
                                  longitude: -0.5721234381830,
                                  duration_in_minutes: 15,
                                  content: "The rocks used to buid the fountain are of Late Jurassic age \
(145 millions years ago). The limestones come from a quarry in the Charente department. They bear numerous fossils \
of sea urchins, belemnites (similar to cuttle fish) and amonites.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654351996/GeoJourney/BordeauxUrbanGeology/PlaceDuParlement/PlaceDuParlement_vnaph6.jpg')
place_du_parlement.photo.attach(io: file, filename: 'PlaceDuParlement.jpg', content_type: 'image/jpg')
puts "  Place Du Parlement site complete"

puts "  Create Monument aux Girondins site !Real!"
monument_aux_girondins = Site.create!(itinerary: bordeaux,
                                      stage: 2,
                                      name: "Monument aux Girondins",
                                      summary: "Hot rock turns to lava",
                                      location: "2792 Place des Quinconces, 33000 Bordeaux, France",
                                      latitude: 44.84635907205055,
                                      longitude: -0.5707971423628408,
                                      duration_in_minutes: 10,
                                      content: "The red paving stones of the terrace are made up of migmatites. These \
rocks were subjected to sufficiently high temperature (> 650°C) to partially melt. They undergo strong deformation as \
the melt fraction tries to make its way upward.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654356663/GeoJourney/BordeauxUrbanGeology/MonumentAuxGirondins/MonumentAuxGirondins_qorun6.jpg')
monument_aux_girondins.photo.attach(io: file, filename: 'MonumentAuxGirondins.jpg', content_type: 'image/jpg')
puts "  Monument aux Girondins site complete"

puts "  Create Le Wagon site !Real!"
le_wagon = Site.create!(itinerary: bordeaux,
                        stage: 3,
                        name: "Le Wagon",
                        summary: "Seafish for dinner at Le Wagon Bordeaux !",
                        location: "107 Cr Balguerie Stuttenberg, 33300 Bordeaux, France",
                        latitude: 44.86013811803033,
                        longitude: -0.5636628867626898,
                        duration_in_minutes: 10,
                        content: "The Le Wagon building is made up of a yellowish limestone of Eocene age (32 millions \
years ago). It contains large pieces of starfish fossils, as well as oysters and coral remnants. Cross-bedding \
indicates that strong tidal currrents prevailed in this former coastal environment.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654357373/GeoJourney/BordeauxUrbanGeology/LeWagon/LeWagonBordeauxInside_iadszq.jpg')
le_wagon.photo.attach(io: file, filename: 'Le Wagon.jpg', content_type: 'image/jpg')
puts "  Le Wagon site complete"

puts "Bordeaux urban itinerary complete"

puts "Create Paris urban itinerary !Fake!"
paris = Itinerary.create!(name: "Paris Urban Geology",
                          theme: urban_geology,
                          area: paris_basin,
                          duration_in_days: 1,
                          summary: "Visit Paris in a way you'd never imagined")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654360497/GeoJourney/ParisUrbanGeology/Paris_cjsl0b.jpg')
paris.photo.attach(io: file, filename: 'Paris.jpg', content_type: 'image/jpg')

puts "  Create Paris Site 1 !Fake!"
Site.create!(itinerary: paris,
             stage: 1,
             latitude: 48.83741998178254,
             longitude: 2.339818067995274,
             duration_in_minutes: 60)
puts "  Paris Site 1 complete"

puts "  Create Paris Site 2 !Fake!"
Site.create!(itinerary: paris,
             stage: 2,
             latitude: 48.85111780154556,
             longitude: 2.343841381484701,
             duration_in_minutes: 10)
puts "  Paris Site 2 complete"

puts "  Create Paris Site 3 !Fake!"
Site.create!(itinerary: paris,
             stage: 3,
             latitude: 48.886108856015426,
             longitude: 2.3430464568184415,
             duration_in_minutes: 45)
puts "  Paris Site 3 complete"

puts "Paris urban itinerary complete"

puts "Create Marseille urban itinerary !Fake!"
marseille = Itinerary.create!(name: "Marseille Urban Geology",
                              theme: urban_geology,
                              area: provence,
                              duration_in_days: 1,
                              summary: "Visit Marseille in a way you'd never imagined")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654365447/GeoJourney/MarseilleUrbanGeology/Marseille_euq2ex.jpg')
marseille.photo.attach(io: file, filename: 'Marseille.jpg', content_type: 'image/jpg')

puts "  Create Marseille Site 1 !Fake!"
Site.create!(itinerary: marseille,
             stage: 1,
             latitude: 43.29516080047442,
             longitude: 5.374905819826319,
             duration_in_minutes: 10)
puts "  Marseille Site 1 complete"

puts "  Create Marseille Site 2 !Fake!"
Site.create!(itinerary: marseille,
             stage: 2,
             latitude: 43.28496168401156,
             longitude: 5.373183841899546,
             duration_in_minutes: 30)
puts "  Marseille Site 2 complete"

puts "  Create Marseille Site 3 !Fake!"
Site.create!(itinerary: marseille,
             stage: 3,
             latitude: 43.232017525749015,
             longitude: 5.356296654364284,
             duration_in_minutes: 180)
puts "  Marseille Site 3 complete"

puts "Marseille urban itinerary complete"

puts "Create Garonne terraces itinerary !Fake!"
garonne_terraces = Itinerary.create!(name: "Garonne terraces",
                                     theme: fluvial_landforms,
                                     area: aquitaine_basin,
                                     duration_in_days: 2,
                                     summary: "Follow the flow along the Garonne river")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654363491/GeoJourney/GaronneTerraces/ToulouseTerraces_xsu04f.jpg')
garonne_terraces.photo.attach(io: file, filename: 'GaronneTerraces.jpg', content_type: 'image/jpg')

puts "  Create Garonne terraces Site 1 !Fake!"
Site.create!(itinerary: garonne_terraces,
             stage: 1,
             latitude: 43.70135566472758,
             longitude: 1.3688871947025039,
             duration_in_minutes: 20)
puts "  Garonne terraces Site 1 complete"

puts "  Create Garonne terraces Site 2 !Fake!"
Site.create!(itinerary: garonne_terraces,
             stage: 2,
             latitude: 43.792738726411066,
             longitude: 1.275926444795906,
             duration_in_minutes: 30)
puts "  Garonne terraces Site 2 complete"

puts "  Create Garonne terraces Site 3 !Fake!"
Site.create!(itinerary: garonne_terraces,
             stage: 3,
             latitude: 43.98629092973455,
             longitude: 1.140707544362609,
             duration_in_minutes: 45)
puts "  Garonne terraces Site 3 complete"

puts "Garonne terraces itinerary complete"

puts "Seed complete"
