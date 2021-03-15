class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    if req.path.match(/cart/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    end

    if req.path.match(/cart/) && @@cart.empty?
      resp.write "Your cart is empty"
    else
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    end

    if req.path.match(/add/)
      item = req.params["q"]
      resp.write add_item(item)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def add_item(item)
    if @@items.include?(item) && req.path.match(/add/)
    @@cart << item
      return "added #{item}\n"
    else
      return "We don't have that item"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term) 
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
