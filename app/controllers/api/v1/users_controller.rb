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

    def set_markers
      # print params["markers"][0]["lat"]
      # print current_user.id
      # print current_user.markers.count
      if current_user && params[:id].to_i == current_user.id
        params["markers"].each do |marker|
          # print "wow"
          # print marker["lat"]
          m = Marker.create(lat: marker["lat"], long: marker["lng"])
          m.user = current_user
        end
        my_markers = current_user.markers
        render json: my_markers
      else
        render json: { error: 'Not authorised!' }
      end
    end

    def delete_marker
      event = params[:ev]
      userEventToDestroy = UserEvent.find_by(event_id: event["id"], user_id: current_user["id"])
      print userEventToDestroy
      UserEvent.destroy(userEventToDestroy["id"])

      if current_user && params[:id].to_i == current_user.id
        render json: current_user.markers
      else
        render json: { error: 'Not authorized!' }
      end
    end

end
