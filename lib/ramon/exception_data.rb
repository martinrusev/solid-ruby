module Ramon
    class ExceptionData 

        def initialize(exception, name=nil)
            @exception = exception
            @name = name
        end

        def to_hash
            hash = {}
            # We need the url before the main exception info
            hash['data'] = additional_data

            hash.merge!({  
                'exception_class' => @exception.class.to_s,
                'message' => @exception.message,
                'backtrace' => @exception.backtrace, 
                'url' => hash['data']['request']['url']
            })

            hash['data'].merge!(ApplicationEnvironment.to_hash(framework))
            hash['data'].merge!(context_stuff)
            hash['data'].merge!(extra_stuff)
            self.class.sanitize_hash(hash)
        end

        def extra_stuff
            if @name
                {'name' => @name}
            else
                {}
            end
        end

        def context_stuff
            context = Thread.current[:exceptional_context]
            (context.nil? || context.empty?) ? {} : {'context' => context}
        end

        def framework
            nil
        end    


        def self.sanitize_hash(hash)

            case hash
            when Hash
                hash.inject({}) do |result, (key, value)|            
                    result.update(key => sanitize_hash(value))
                end
            when Array
                hash.collect{|value| sanitize_hash(value)}
            when Fixnum, String, Bignum
                hash
            else
                hash.to_s
            end
        rescue Exception => e
            {}
        end

        def extract_http_headers(env)
            headers = {}
            env.select{|k, v| k =~ /^HTTP_/}.each do |name, value|
                proper_name = name.sub(/^HTTP_/, '').split('_').map{|upper_case| upper_case.capitalize}.join('-')
                headers[proper_name] = value
            end
            unless headers['Cookie'].nil?
                headers['Cookie'] = headers['Cookie'].sub(/_session=\S+/, '_session=[FILTERED]')
            end
            headers
        end  

        def self.sanitize_session(request)

            session_hash = {'session_id' => "", 'data' => {}}

            if request.respond_to?(:session)      

                session = request.session
                session_hash['session_id'] = request.session_options ? request.session_options[:id] : nil
                session_hash['session_id'] ||= session.respond_to?(:session_id) ? session.session_id : session.instance_variable_get("@session_id")
                session_hash['data'] = session.respond_to?(:to_hash) ? session.to_hash : session.instance_variable_get("@data") || {}
                session_hash['session_id'] ||= session_hash['data'][:session_id]
                session_hash['data'].delete(:session_id)
            end

            # Don't return the session hash if there is nothing in it
            if session_hash['session_id'].nil? && session_hash['data'].empty?
                {}
            else
                self.sanitize_hash(session_hash)
            end 

        end  

    end # class end
end # module end
