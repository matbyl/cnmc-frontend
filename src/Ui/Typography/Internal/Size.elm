module Ui.Typography.Internal.Size exposing (modular)


modular : Float -> Float -> Int -> Float
modular normal ratio rescale =
    if rescale == 0 then
        normal

    else if rescale < 0 then
        normal * ratio ^ toFloat rescale

    else
        normal * ratio ^ (toFloat rescale - 1)
