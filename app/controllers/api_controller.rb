# frozen_string_literal: true

require 'httparty'

# Controlador que muestra la data obtenida en https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson
class ApiController < ApplicationController
  def index
    response = HTTParty.get('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson')

    if response.success?
      json_data = JSON.parse(response.body)
      json_data_features = json_data['features']
      #EarthquakeModel.delete_all
      transformed_data = json_data_features.map do |data|
        transform_data(data)
        #EarthquakeModel.create!(transform_data(data))
      end

      render json: transformed_data
    else
      render json: { error: 'Error al obtener datos de terremotos' }, status: :internal_server_error
    end
  end

  private

  def transform_data(data)
    {
      'featureid' => data['id'],
      'propertiesmag' => data['properties']['mag'],
      'propertiesplace' => data['properties']['place'],
      'propertiestime' => data['properties']['time'],
      'propertiesurl' => data['properties']['url'],
      'propertiestsunami' => data['properties']['tsunami'] == 1,
      'propertiesmagType' => data['properties']['magType'],
      'propertiestitle' => data['properties']['title'],
      'geometrycoordinates0' => data['geometry']['coordinates'][0],
      'geometrycoordinates1' => data['geometry']['coordinates'][1]
    }
  end
end

