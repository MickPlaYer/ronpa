class SentencesController < ApplicationController
  def index
    @sentences = Sentence.last 50
    respond_to do |format|
      format.json { render :json => @sentences.to_json }
    end
  end
end
