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
Site.destroy_all if Rails.env.development?
puts "Clear itineraries"
Itinerary.destroy_all if Rails.env.development?
puts "Clear areas"
Area.destroy_all if Rails.env.development?
puts "Clear themes"
Theme.destroy_all if Rails.env.development?
puts "Clear done"

puts "Create themes"
geotraverse = Theme.create!(name: "Geotraverse",
                            description: "Cut accross an entire mountain range to comprehend its formation")
Theme.create!(name: "Fluvial landforms", description: "Discover how rivers shape topography")
Theme.create!(name: "Urban geology", description: "Explore the geology of built environment in your city")

puts "Create areas"
western_alps = Area.create!(name: "Western Alps")
central_pyenees = Area.create!(name: "Central Pyrenees")

puts "Create Western Alps Geotraverse itinerary"
geotraverse_western_alps = Itinerary.create!(name: "Western Alps Geotraverse",
                                             theme: geotraverse,
                                             area: western_alps,
                                             summary: "Cut through the core of the Alps to understand its formation",
                                             content: "The Alps arose as a result of the collision of the African \
and Eurasian tectonic plates, in which the Alpine Tethys ocean, \
which was formerly in between these continents, disappeared.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654004483/GeoJourney/WesternAlpsGeotraverse/WesternAlpsGeotraverse_x7oxej.jpg')
geotraverse_western_alps.photo.attach(io: file, filename: 'WesternAlpsGeotraverse.jpg', content_type: 'image/jpg')
puts "Western Alps Geotraverse itinerary done"

puts "Create plagne site"
plagne = Site.create!(itinerary: geotraverse_western_alps,
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
puts "Plagne site Done"

puts "Create mont pélerin site"
mont_pelerin = Site.create!(itinerary: geotraverse_western_alps,
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
puts "Mont Pèlerin site Done"

puts "Create morcles site"
morcles = Site.create!(itinerary: geotraverse_western_alps,
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
puts "Morcles site done"

puts "Create zermatt site"
zermatt = Site.create!(itinerary: geotraverse_western_alps,
                       stage: 4,
                       name: "Zermatt thrusts",
                       summary: "Colliding continents: Europe meets Africa",
                       location: "Mürini 3920 Zermatt, Switzerland",
                       latitude: 46.0256056,
                       longitude: 7.7562238,
                       duration_in_minutes: 360,
                       content: "The European rocks of the Monte Rosa nappe were buried at least 45 kilometers \
beneath the oceanic floor and the African rocks some 55 millions years ago. Susbsequent uplift \
raised the overlying oceanic rocks and African crust stacked above them. The rocks at \
the Rothorn peak belong to the oceanic nappe, whereas the iconic Matterhorn summit \
belongs to the thrusting African plate.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654003307/GeoJourney/WesternAlpsGeotraverse/Zermatt/Zermatt-Matterhorn_mzzzfi.jpg')
zermatt.photo.attach(io: file, filename: 'Zermatt.jpg', content_type: 'image/jpg')
puts "Zermatt site done"

puts "Create Oloron Jaca Geotraverse itinerary"
oloron_jaca = Itinerary.create!(name: "Oloron-Jaca Geotraverse",
                                theme: geotraverse,
                                area: central_pyenees,
                                summary: "Cut through the heart of the Pyrenees to understand its formation",
                                content: "The Pyrenees' present configuration is due to the collision between \
the microcontinent Iberia and the European Plate. The two continents were approaching each other since \
100 million years ago and were consequently colliding from 55 to 25 million years ago.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654028906/GeoJourney/OloronJacaPyreneesGeotraverse/oloronJacaGeotraverse_hjbwpl.jpg')
oloron_jaca.photo.attach(io: file, filename: 'OloronJacaGeotraverse.jpg', content_type: 'image/jpg')
puts "Oloron Jaca Geotraverse itinerary done"

puts "Create Courrèges site"
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
puts "Courrèges site Done"

puts "Create Accous site"
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
puts "Accous site Done"

puts "Create Castillo de Acher site"
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
puts "Castillo de Acher site Done"

puts "Create Candanchu site"
candanchu = Site.create!(itinerary: oloron_jaca,
                         stage: 4,
                         name: "candanchu",
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
puts "Candanchu site Done"

puts "Create Puente de Torrijos site"
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
puts "Puente de Torrijos site Done"

puts "Create Murillo de Gallego site"
murillo_de_gallego = Site.create!(itinerary: oloron_jaca,
                                  stage: 6,
                                  name: "Murillo de Gallego",
                                  summary: "Turbulent seabed",
                                  location: "Via Ferrata Varela Portillo, 22808 Murillo de Gállego, Spain",
                                  latitude: 42.362603,
                                  longitude: -0.758743,
                                  duration_in_minutes: 60,
                                  content: "Since 40 millions years ago, the Pyrenees are continously eroding away. \
Coarse material was transported away and deposited in the Ebro foreland, forming conglomerates made up of large \
pebbles. Futher erosion stripped the finest sediments and scuplted huge columns and pinnacles of coarse sediments.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654030923/GeoJourney/OloronJacaPyreneesGeotraverse/MurilloDeGallego/murillodeGallegoConglomerates_mobeln.jpg')
murillo_de_gallego.photo.attach(io: file, filename: 'Murillo de Gallego', content_type: 'image/jpg')
puts "Murillo de Gallego site Done"

puts "Seed complete"
