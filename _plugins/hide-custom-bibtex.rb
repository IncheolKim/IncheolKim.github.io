module Jekyll
  module HideCustomBibtex
    def hideCustomBibtex(input)
      keywords = @context.registers[:site].config['filtered_bibtex_keywords']

      keywords.each do |keyword|
        # Match the keyword field with multi-line braces using a non-greedy match
        input = input.gsub(/^\s*#{keyword}\s*=\s*\{(?:[^{}]*|\{[^{}]*\})*\},?\s*\n?/mi, '')
      end

      # Clean superscripts in author field
      input = input.gsub(/^.*\bauthor\b\s*=\s*\{.*$\n/) { |line| line.gsub(/[*†‡§¶‖&^]/, '') }

      # Remove all HTML tags like <b>, <span>, <u>, etc.
      input = input.gsub(/<[^>]*>/, '')

      return input
    end
  end
end

Liquid::Template.register_filter(Jekyll::HideCustomBibtex)
