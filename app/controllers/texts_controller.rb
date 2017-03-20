class TextsController < ApplicationController
  def new
    @data = Unirest.get(
      "https://new-json-parser.herokuapp.com/texts.json",
      headers: { "Accept" => "application/json" }
    ).body
    @archive = []
    @data['texts'].each do |text|
      file = Hash.new
      file['title'] = text['title']
      file['id'] = text['id']
      @archive << file
    end
  end

  def create
    if params[:title].present? && params[:file].present?
      @text = Unirest.post(
        "https://new-json-parser.herokuapp.com/texts.json",
        headers: { "Accept" => "application/json" },
        parameters: {
          title: params[:title],
          file: params[:file].read
        }
      ).body
      redirect_to '/texts/show'
    else
      flash[:warning] = 'Both fields are required'
      redirect_to '/texts/new'
    end
  end

  def show
    @data = Unirest.get(
      "https://new-json-parser.herokuapp.com/texts.json",
      headers: { "Accept" => "application/json" }
    ).body
    if params[:select].present?
      @id = params[:select]
    else
      @id = @data['texts'].last['id']
    end
    @text = Unirest.get(
      "https://new-json-parser.herokuapp.com/texts/#{@id}.json",
      headers: { "Accept" => "application/json" }
    ).body
    render json: @text
  end
end
