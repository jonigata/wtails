module Wtails
  module Stdin
    extend self

    ENTITY_MAP = {
      "&lt;" => "<",
      "&gt;" => ">",
    }

    def run
      STDIN.each do |line|
        line = unescape_entity(line)
        line = strip_ansi_sequence(line)
        Wtails.channel('-') << line
      end
    end

    private

    def strip_ansi_sequence(str)
      str.gsub(/\e\[.*?m/, "")
    end

    def unescape_entity(str)
      str.gsub(/#{Regexp.union(ENTITY_MAP.keys)}/o) {|key| ENTITY_MAP[key] }
    end
  end
end
