require 'net/http'

class SemqClient

    def initialize(server, queue)
        @server = server
        @queue = queue
    end
    
    def pop(timeout_in_seconds = 0)
        startTime = Time.now
        result = getNextItem
        while result.nil? and (timeout_in_seconds == 0 or Time.now - startTime < timeout_in_seconds)
            result = getNextItem
        end
        return result
    end

    def push(message)
        url = constructQueueUrl
        http = Net::HTTP.new(url.host, url.port)
        http.post(url.path, message)
    end

    def clear
        url = constructQueueUrl
        req = Net::HTTP::Delete.new(url.path)
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
        }
        case res
        when Net::HTTPSuccess
            return true
        else
            return false
        end
    end

    def allQueuesOnServer
        url = URI.parse(@server + "/queues")
        req = Net::HTTP::Get.new(url.path)
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
        }
        case res
        when Net::HTTPSuccess
            return res.body
        else
            return nil
        end
    end

    private

    def constructQueueUrl
        URI.parse(@server + '/queue/' + @queue)
    end

    def getNextItem
        url = constructQueueUrl
        req = Net::HTTP::Get.new(url.path)
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
        }
        case res
        when Net::HTTPSuccess
            return res.body
        else
            return nil
        end
    end
    

end
