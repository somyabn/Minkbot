require 'net/http'
require 'pry'

class BiometricFaceAuthentication

	def request_post(method,username)
	    uri= URI("http://localhost:4567//api/profile/#{method}/minkbot/123/#{username}")
	    http = Net::HTTP.new(uri.host, uri.port)
	    request = Net::HTTP::Post.new(uri.request_uri)
	    response = http.request(request)
	    if response.body != nil
	     JSON.parse(response.body)
	    end

	end

	def request_put(useroldname,usernewname)
	    uri= URI("http://localhost:4567//api/profile/edit/minkbot/123/#{useroldname}/#{usernewname}")
	    http = Net::HTTP.new(uri.host, uri.port)
	    request = Net::HTTP::Put.new(uri.path)
	    response = http.request(request)
	    if response.body != nil
	     JSON.parse(response.body)
	    end
	end

	def request_delete(username)
	    uri= URI("http://localhost:4567//api/profile/delete/minkbot/123/#{username}")
	    http = Net::HTTP.new(uri.host, uri.port)
	    request = Net::HTTP::Delete.new(uri.request_uri)
	    response = http.request(request)
	end

    def register(username)
	  request_post("registration","#{username}")
	end

	def authorise(username)
		request_post("authorise","#{username}")
    end

    def edit(useroldname,usernewname)
		request_put("#{useroldname}","#{usernewname}")
    end

    def delete(username)
    	request_delete("#{username}")
    end
end

