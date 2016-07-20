require 'rails_helper'

RSpec.describe "articles/show", type: :view do
  before(:each) do
    @article = assign(:article, Article.create!(
      :title => "MyTitle",
      :body => "MyText"
    ))
    @comment = Comment.new
    @comments = [ Comment.create(body:"text"),
		 Comment.create(body:"text")
    ]
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
