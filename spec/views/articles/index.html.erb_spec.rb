require 'rails_helper'

RSpec.describe "articles/index", type: :view do
  before(:each) do
    articles = [
      Article.create!(
        :title => "MyTitle",
        :body => "MyText"
      ),
      Article.create!(
        :title => "MyTitle",
        :body => "MyText"
      )
    ]
    articledict = articles.map{ |a| {article_record: a, comments: [] }}
    
    assign(:articlesdict, articledict )
  end

  it "renders a list of articles" do
    render
    assert_select ".atitle", :text => "MyTitle".to_s, :count => 2
    assert_select ".abody", :text => "MyText".to_s, :count => 2
  end
end
