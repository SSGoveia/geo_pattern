module GeoPattern
  class DiamondPattern < BasePattern
    def render_to_svg
      diamond_width  = map(hex_val(0, 1), 0, 15, 10, 50)
      diamond_height = map(hex_val(1, 1), 0, 15, 10, 50)
      diamond        = build_diamond_shape(diamond_width, diamond_height)

      svg.set_width(diamond_width * 6)
      svg.set_height(diamond_height * 3)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = hex_val(i, 1)
          opacity = opacity(val)
          fill    = fill_color(val)

          styles = {
            "fill"           => fill,
            "fill-opacity"   => opacity,
            "stroke"         => STROKE_COLOR,
            "stroke-opacity" => STROKE_OPACITY
          }

          dx = (y % 2 == 0) ? 0 : diamond_width / 2

          svg.polyline(diamond, styles.merge({
            "transform" => "translate(#{x*diamond_width - diamond_width/2 + dx}, #{diamond_height/2*y - diamond_height/2})"}))

          # Add an extra one at top-right, for tiling.
          if (x == 0)
            svg.polyline(diamond, styles.merge({
              "transform" => "translate(#{6*diamond_width - diamond_width/2 + dx}, #{diamond_height/2*y - diamond_height/2})"}))
          end

          # Add an extra row at the end that matches the first row, for tiling.
          if (y == 0)
            svg.polyline(diamond, styles.merge({
              "transform" => "translate(#{x*diamond_width - diamond_width/2 + dx}, #{diamond_height/2*6 - diamond_height/2})"}))
          end

          # Add an extra one at bottom-right, for tiling.
          if (x == 0 and y == 0)
            svg.polyline(diamond, styles.merge({
              "transform" => "translate(#{6*diamond_width - diamond_width/2 + dx}, #{diamond_height/2*6 - diamond_height/2})"}))
          end
          i += 1
        end
      end
    end

    def build_diamond_shape(width, height)
      "#{width/2}, 0, #{width}, #{height/2}, #{width/2}, #{height}, 0, #{height/2}"
    end
  end
end
