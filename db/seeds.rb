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
Area.create!(name: "Central Pyrenees")

puts "Create Western Alps Geotraverse itinerary"
geotraverse_western_alps = Itinerary.create!(name: "Western Alps Geotraverse",
                                             theme: geotraverse,
                                             area: western_alps,
                                             summary: "Cut through the core of the Alps to understand its formation",
                                             content: "The Alps arose as a result of the collision of the African \
and Eurasian tectonic plates, in which the Alpine Tethys ocean, \
which was formerly in between these continents, disappeared.")
file = URI.open('https://res.cloudinary.com/dxlbokhad/image/upload/v1654004483/GeoJourney/WesternAlpsGeotraverse/WesternAlpsGeotraverse_x7oxej.jpg')
geotraverse_western_alps.photo.attach(io: file, filename: 'Dinoplagne.jpg', content_type: 'image/jpg')
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

puts "Seed complete"
