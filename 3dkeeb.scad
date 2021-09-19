
// view can be "bot-center", "bot-rl", "mid-center", "mid-rl", "top-rl",
// "top-center", to render only the specified part, otherwise shows exploded
// version of the keyboard.
view = "exploded";

eps = 0.01;
$fs = 0.1;

module get(layer, height) {
  linear_extrude(height, convexity=3)
    import("keyboard-outline.dxf", layer=layer);
}

module screws() {
  translate([0, 0, -500])
    get("2-screw-holes", 1000);
}

module botCenter() {
  difference() {
    get("bot-center", 5);
    screws();
    translate([0, 0, -eps])
      get("bot-rl-groove", 2);
    translate([0, 0, 3 + eps])
      get("3-interp", 2);
    translate([0, 0, 3+eps])
      get("bot-groove", 2);
  }
}

module botRL() {
  difference() {
    get("bot-rl", 5);
    screws();
    translate([0, 0, -eps])
      get("3-interp", 3);
    translate([0, 0, -eps])
      get("bot-rl-groove", 2);
    translate([0, 0, 3+eps])
      get("bot-groove", 2);
  }
}

module midCenter() {
  difference() {
    get("mid-center", 3);
    screws();
  }
}

module midRL() {
  difference() {
    get("mid-rl", 3);
    screws();
    translate([0, 0, -eps])
      get("mid-rl-holes", 3 + 2*eps);
    translate([0, 0, -eps])
      get("mid-rl-sockets", 1.75 + eps);
  }
}

module topCenter() {
  difference() {
    get("top-center", 5);
    screws();
    translate([0, 0, -eps]) {
      get("top-center-groove", 3 + eps);
      get("3-interp", 2 + eps);
    }
    translate([0, 0, 5 - 2 + eps])
      get("top-screw-groove", 2);
  }
}

module topRL() {
  difference() {
    get("top-rl", 5);
    screws();
    translate([0, 0, -eps])
      get("top-rl-groove", 5 - 1.5);
    translate([0, 0, 2 + eps])
      get("3-interp", 3);
    translate([0, 0, 5 - 2 + eps])
      get("top-screw-groove", 2);
  }
}

if (view == "bot-center") {
  translate([0, 0, 5])
    rotate([0, 180, 0])
      botCenter();
} else if (view == "bot-rl") {
  botRL();
} else if (view == "mid-center") {
  midCenter();
} else if (view == "mid-rl") {
  translate([0, 0, 3])
    rotate([0, 180, 0])
      midRL();
} else if (view == "top-rl") {
  translate([0, 0, 5])
    rotate([0, 180, 0])
      topRL();
} else if (view == "top-center") {
  translate([0, 0, 5])
    rotate([0, 180, 0])
      topCenter();
} else {
  step = 20;
  translate([0, 50, -75]) {
    translate([0, 0, 0 + 1 * step]) botCenter();
    translate([0, 0, 0 + 2 * step]) botRL();
    translate([0, 0, 3 + 3 * step]) midCenter();
    translate([0, 0, 3 + 4 * step]) midRL();
    translate([0, 0, 5 + 5 * step]) topRL();
    translate([0, 0, 5 + 6 * step]) topCenter();
  }
}
