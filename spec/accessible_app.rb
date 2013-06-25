class AccessibleApp < TestApp
  get '/accessible' do
    '<form><label for="foo">Foo</label><input type="text" name="foo" id="foo"/></form>'
  end

  get '/inaccessible' do
    '<form><input type="text" name="foo" id="foo"/></form>'
  end
end
