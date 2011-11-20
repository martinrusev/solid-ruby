require 'digest/md5'

module Ramon
class ApplicationEnvironment
    def self.to_hash(framework)
      {
          'language' => 'ruby',
          'language_version' => language_version_string,
          'framework' => framework,
          #'libraries_loaded' => libraries_loaded
      }
    end

 
    def self.get_hostname
      require 'socket' unless defined?(Socket)
      Socket.gethostname
    rescue
      'UNKNOWN'
    end

    def self.language_version_string
      "#{RUBY_VERSION rescue '?.?.?'} p#{RUBY_PATCHLEVEL rescue '???'}
		 #{RUBY_RELEASE_DATE rescue '????-??-??'} #{RUBY_PLATFORM rescue '????'}"
    end


    def self.libraries_loaded
      begin
        return Hash[*Gem.loaded_specs.map{|name, gem_specification| [name, gem_specification.version.to_s]}.flatten]
      rescue
      end
      {}
    end

end # class end
end # module end
