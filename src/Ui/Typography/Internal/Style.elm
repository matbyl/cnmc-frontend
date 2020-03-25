module Ui.Typography.Internal.Style exposing (body, heading, label, placeholder)

import Css exposing (Px, Style, bold, color, fontFamilies, fontSize, fontWeight, px, sansSerif)
import Ui.Typography.Internal.Color as Color
import Ui.Typography.Internal.Size as Size


scale : Int -> Px
scale =
    px << Size.modular 16 1.25


oxygen : Style
oxygen =
    fontFamilies [ "Oxygen", "OpenSans", "Helvetica", .value sansSerif ]


heading : List Style
heading =
    [ oxygen, fontSize <| scale 2, fontWeight bold ]


body : List Style
body =
    [ oxygen, fontSize <| scale 1 ]


label : List Style
label =
    [ oxygen, fontSize <| scale 0 ]


placeholder : List Style
placeholder =
    [ oxygen, fontSize <| scale 0, color Color.secondary ]
