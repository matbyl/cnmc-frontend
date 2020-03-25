module Ui.Color exposing
    ( black
    , primary
    , secondary
    , white
    )

import Css exposing (Color, hex, rgb)


primary : Color
primary =
    hex "#5B74A6"


secondary : Color
secondary =
    hex "#BFA53B"


black : Color
black =
    rgb 0 0 0


white : Color
white =
    rgb 242 242 242
