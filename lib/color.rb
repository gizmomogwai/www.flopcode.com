class String
  def to_rgb()
    scan(/../).map{|i|i.hex}
  end
end

def find_colors(colors, f)
  res1 = colors[0]
  count = 1
  res2 = colors[count]
  while (f > res2[0])
    count = count + 1
    res1 = res2
    res2 = colors[count]
  end
  return res1, res2
end

def interpolate_linear(v1, v2, f)
  return v1*(1.0-f) + v2*f
end

def interpolate(colors, f)
  c1, c2 = find_colors(colors, f)
  f1 = c1[0]
  f2 = c2[0]
  c1c = c1[1]
  c2c = c2[1]

  total_delta = f2-f1
  delta = (f-f1) / total_delta

  return (0..2).each_with_index.map{|i, v| interpolate_linear(c1c[i], c2c[i], f).to_i }
end

def get_colors
  h = File.read('layouts/default.haml')
  colors = /.*weightGradient: {(.*?)},.*/.match(h)
  colors = colors[1].scan(/([\d\.]+):'#(.+?)'/).map{|e| [e[0].to_f, e[1].to_rgb]}
  return colors.each_with_index.map{|e, i|[e[0], colors[-i-1][1]]}
end

def assert(m, c)
  if not c
    raise m
  end
end

def to_html(c)
  format("%.2x%.2x%.2x", c[0], c[1], c[2])
end

def test_colors
  colors = get_colors
  assert('first color', interpolate(colors, 0) == colors[0][1])
  assert('last color', interpolate(colors, 1) == colors[-1][1])
end
