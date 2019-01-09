class WelcomeController < ApplicationController
  def test

    response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?zip=28403&units=imperial&APPID=#{ENV['ow_api_key']}")   
    
    @results = {}
    @results['location'] = response['name']
    @results['temperature'] = response['main']['temp']

    print @results['temperature']
  end

  def index

    # # Creates an array of states that our user can choose from on our index page
    # @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK 
		#  TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY 
		#  NJ CT RI MA VT NH ME DC).sort!

    # # removes spaces from the 2-word city names and replaces the space with an underscore 
    #   if params[:city] != nil
    #       params[:city].gsub!(" ", "_")


    #checks that the state and city params are not empty before calling the API
    if params[:city] != "" && params[:city] != nil

      results = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?q=#{params[:city]}&units=imperial&APPID=#{ENV['ow_api_key']}")
    
      #Checks to see if the response contains an array (ambigous response for an invalid city/state combination) or a hash(valid response)
      if results.key?("name") 
        @location = results['name']
        @temperature = results['main']['temp']
        # @temp_c = results['current_observation']['temp_c']
        # @weather_icon = results['current_observation']['icon_url']
        # @weather_words = results['current_observation']['weather']
        # @forecast_link = results['current_observation']['forecast_url']
        # @real_feel_f = results['current_observation']['feelslike_f']
        # @real_feel_c = results['current_observation']['feelslike_c']
      else
        @error = "City does not exist." 
      end				   
    end

  end
end
