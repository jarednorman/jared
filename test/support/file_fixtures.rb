module JarEd
  class Test
    module FileFixtures
      def readme
        File.open readme_path, "r"
      end

      private

      def readme_path
        @readme_path ||= File.expand_path("../../../README.md", __FILE__)
      end
    end
  end
end
