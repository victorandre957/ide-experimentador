# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# {
#     "skill": "navigation",
#     "parameter":{
#         "room":"PC Room 3",
#         "waypoints": [
#             {
#                 "x":-27.23,
#                 "y":18.0,
#                 "z":-1.57
#             },
#             {
#                 "x":-27.23,
#                 "y":16.0
#             },
#             {
#                 "x":-28.5,
#                 "y":16.0
#             },
#             {
#                 "x":-28.5,
#                 "y":18.0,
#                 "z":-1.57
#             }
#         ]
#     },
#     "label":"navto_room"
# },
LocalPlanStep.create(
    label: "navto_room",
    skill: "navigation",
    parameters: { room: "PC Room 3", waypoints: [ {x: 0.1, y: 0.6, z: -1.2 } ] }
)
