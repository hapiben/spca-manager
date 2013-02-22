class RecordsController < ApplicationController
  
  before_filter :find_parser

  def index
    @previewer = Previewer.new(@parser, params[:parser][:content], params[:index], params[:environment])
    render layout: false
  end

  def find_parser
    @parser = Parser.find(params[:parser_id])
  end
end