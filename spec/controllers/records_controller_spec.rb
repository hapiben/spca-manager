require "spec_helper"

describe RecordsController do

  before(:each) do
    controller.stub(:authenticate_user!) { true }
  end
  
  let(:parser) { mock(:parser).as_null_object }
  let(:previewer) { mock(:previewer) }
  let(:harvester) { mock(:harvester).as_null_object }

  describe "GET index" do
    before { Parser.stub(:find) { parser } }

    it "finds the parser" do
      Parser.should_receive(:find).with("1234") { parser }
      post :index, parser_id: "1234", parser: {}
    end

    it "initializes a previewer object" do
      Previewer.should_receive(:new).with(parser, "Data", "10") { previewer }
      post :index, parser_id: "1234", parser: {content: "Data"}, index: 10
      assigns(:previewer).should eq previewer
    end
  end

  describe "POST harvest" do
    before do 
      Parser.stub(:find) { parser }
      Harvester.stub(:new) { harvester }
    end

    it "initializes a harvester object" do
      Harvester.should_receive(:new).with(parser, "10") { harvester }
      post :harvest, parser_id: "1234", parser: {content: "Data"}, limit: 10
      assigns(:harvester).should eq harvester
    end

    it "starts the harvest" do
      harvester.should_receive(:start)
      post :harvest, parser_id: "1234", parser: {content: "Data"}, limit: 10
    end
  end
end