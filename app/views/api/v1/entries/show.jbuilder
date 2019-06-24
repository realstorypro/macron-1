# frozen_string_literal: true

json.partial! collection: @entry.points, partial: "score", as: :score
