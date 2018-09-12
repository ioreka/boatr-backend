class Api::V1::MarkersController < ApplicationController

  def get_markers
    if current_user && params[:id].to_i == current_user.id
      myMarkers = current_user.markers
      render json: myMarkers
    else
      render json: { error: 'Not authorised!' }
    end
  end

  def add_marker
    if current_user && params[:id].to_i == current_user.id
        m = Marker.find_or_create_by(lat: params["marker"]["lat"], lng: params["marker"]["lng"])
        m.user = current_user
        m.save
      render json: m
    else
      render json: { error: 'Not authorised!' }
    end
  end

  def update_marker
    marker = Marker.find(params[:marker_id])
    marker.update(marker_params)
    render json: marker
  end

  def delete_marker
    markerToDestroy = Marker.find(params[:marker_id])
    markerToDestroy.destroy
    myMarkers = current_user.markers
    render json: myMarkers
  end

private
  def marker_params
    params.require(:marker).permit(:lat, :lng, :comment, :photoURL)
  end

end
