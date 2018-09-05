class Api::V1::UsersController < ApplicationController

  def create
      user = User.create(username: params[:username], password: params[:password])
      if user.valid?
        render json: { token: issue_token({ id: user.id }) }
      else
        render json: { error: 'Cannot create user!' }
      end
    end

    def login
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        render json: { token: issue_token({ id: user.id }) }
      else
        render json: { error: 'Cannot find or authenticate user.' }
      end
    end

    def get_current_user
      if current_user
        render json: { username: current_user.username, id: current_user.id }
      else
        render json: { error: 'no user' }
      end
    end

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
      marker.update(lat: params["lat"], lng: params["lng"])
      marker.save
      render json: marker
    end

    def delete_marker
      markerToDestroy = Marker.find(params[:marker_id])
      print markerToDestroy
      markerToDestroy.destroy
      myMarkers = current_user.markers
      print myMarkers
      render json: myMarkers
    end

    def add_comment
      marker = Marker.find(params[:marker_id])
      print marker
      print params
      marker.update(comment: params["comment"])
      marker.save
      render json: marker
    end


end
