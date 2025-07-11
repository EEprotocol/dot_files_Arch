xev | sed -n 's/^.*keycode *\([0-9]\+\) (keysym .*, \(.*\)),.*$/keycode \1 = \2/p'
