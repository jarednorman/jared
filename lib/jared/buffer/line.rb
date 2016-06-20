module JarEd
  class Buffer
    class Line
      attr_reader :raw_text

      def initialize(raw_text)
        @raw_text = raw_text
      end

      def text
        @text ||= raw_text.chomp
      end

      def blank?
        text == ""
      end

      def wrap(width:)
        if blank?
          [""]
        else
          text.scan(/.{1,#{width}}/)
        end
      end
    end
  end
end
