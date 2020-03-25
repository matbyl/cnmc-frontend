module Ui.Storybook exposing (..)

import Css exposing (..)
import Html
import Html.Attributes exposing (style)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import UIExplorer exposing (UIExplorerProgram, category, createCategories, defaultConfig, exploreWithCategories, storiesOf)
import Ui.Button as Button
import Ui.Color as Color
import Ui.Typography exposing (Typography(..), typography)


colorSwatch : Color -> Html.Html msg
colorSwatch color =
    toUnstyled <| div [ css [ width (px 50), height (px 50), backgroundColor color ] ] []


main : UIExplorerProgram {} () {}
main =
    exploreWithCategories
        defaultConfig
        (createCategories
            |> category
                "Styles"
                [ storiesOf
                    "Colors"
                  <|
                    [ ( "Swatches", \_ -> Html.div [] [ colorSwatch Color.primary, colorSwatch Color.secondary ], {} )
                    ]
                , storiesOf
                    "Typography"
                  <|
                    [ ( "All"
                      , \_ ->
                            toUnstyled <|
                                Html.Styled.div []
                                    [ typography Heading "Heading"
                                    , typography Body "Body"
                                    , typography Label "Label"
                                    , typography Placeholder "Placeholder"
                                    , typography (Interactive () Body) "Interactive"
                                    , typography (Secondary Body) "Secondary"
                                    , typography (Error Body) "Error"
                                    , typography (Disabled Body) "Disabled"
                                    ]
                      , {}
                      )
                    ]
                ]
            |> category
                "Components"
                [ storiesOf
                    "Buttons"
                  <|
                    [ ( "Stroked"
                      , \_ ->
                            toUnstyled <|
                                Html.Styled.div []
                                    [ Button.stroked { label = "Primary", color = Color.primary }
                                    , Button.stroked { label = "Secondary", color = Color.secondary }
                                    ]
                      , {}
                      )
                    , ( "Raised"
                      , \_ ->
                            toUnstyled <|
                                Html.Styled.div []
                                    [ Button.raised { label = "Primary", color = Color.primary }
                                    , Button.raised { label = "Secondary", color = Color.secondary }
                                    ]
                      , {}
                      )
                    ]
                ]
        )
