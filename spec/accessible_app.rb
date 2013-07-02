class AccessibleApp < TestApp
  get '/accessible' do
    '<form><label for="foo">Foo</label>' +
    '<input type="text" name="foo" id="foo"/></form>' +
    '<a href="/inaccessible">inaccessible</a>'
  end

  get '/inaccessible' do
    '<div role="zomg"></div>'
  end

  get '/excluded' do
    '<form><input type="text" name="foo" id="foo"/></form>'
  end

  get '/alert' do
    '<a href="#" onclick="alert(\'whoa!\')">Alert!</a>'
  end
end
