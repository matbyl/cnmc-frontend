module Ui.Button exposing (raised, stroked)

import Css exposing (..)
import Css.Animations exposing (..)
import Html.Styled as Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Ui.Color as Color


stroked : { label : String, color : Color } -> Styled.Html msg
stroked { label, color } =
    button
        [ css
            [ display inlineBlock
            , padding2 (px 8) (px 15)
            , Css.color color
            , Css.border3 (px 2) solid color
            , borderRadius (px 20)
            , overflow hidden
            , position relative
            , after
                [ display none
                , Css.property "content" "\"\""
                , position absolute
                , borderRadius (pct 50)
                , Css.backgroundColor color
                , width (px 100)
                , height (px 100)
                , marginTop (px -50)
                , marginLeft (px -50)
                , top (pct 50)
                , left (pct 50)
                , Css.opacity (num 0)
                , animationDuration (ms 500)
                , animationName <|
                    keyframes
                        [ ( 0, [ Css.Animations.opacity (num 1), Css.Animations.transform [ Css.scale 0 ] ] )
                        , ( 100, [ Css.Animations.opacity (num 0), Css.Animations.transform [ Css.scale 1 ] ] )
                        ]
                ]
            , Css.focus
                [ boxShadow4 (px 0) (px 0) (px 2) color
                , outline none
                , pseudoClass "not(:active)"
                    [ after
                        [ display block
                        ]
                    ]
                ]
            , hover
                []
            ]
        ]
        [ text label ]


raised : { label : String, color : Color } -> Styled.Html msg
raised { label, color } =
    button
        [ css
            [ display inlineBlock
            , padding2 (px 8) (px 15)
            , Css.color Color.white
            , Css.backgroundColor color
            , borderRadius (px 20)
            , overflow hidden
            , position relative
            , after
                [ display none
                , Css.property "content" "\"\""
                , position absolute
                , borderRadius (pct 50)
                , Css.backgroundColor <| rgba 0 0 0 0.3
                , width (px 100)
                , height (px 100)
                , marginTop (px -50)
                , marginLeft (px -50)
                , top (pct 50)
                , left (pct 50)
                , Css.opacity (num 0)
                , animationDuration (ms 500)
                , animationName <|
                    keyframes
                        [ ( 0, [ Css.Animations.opacity (num 1), Css.Animations.transform [ Css.scale 0 ] ] )
                        , ( 100, [ Css.Animations.opacity (num 0), Css.Animations.transform [ Css.scale 1 ] ] )
                        ]
                ]
            , Css.focus
                [ boxShadow4 (px 0) (px 0) (px 2) color
                , outline none
                , pseudoClass "not(:active)"
                    [ after
                        [ display block
                        ]
                    ]
                ]
            , hover
                []
            ]
        ]
        [ text label ]
