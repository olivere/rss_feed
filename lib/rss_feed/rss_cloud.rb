module RSSFeed
  class RSSCloud

    # Initializes the cloud element.
    def initialize(node)
      @node = node
    end

    # Domain
    def domain
      @node["domain"]
    end

    # Port
    def port
      @node["port"].nonzero?
    end

    # Path 
    def path
      @node["path"]
    end

    # Register procedure
    def register_procedure
      @node["registerProcedure"]
    end

    # Protocol
    def protocol
      @node["protocol"]
    end

  end
end
