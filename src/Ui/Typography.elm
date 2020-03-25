module Ui.Typography exposing (Typography(..), typography)

import Css exposing (color, cursor, pointer, textDecoration, underline)
import Html.Styled as Styled
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events as Events
import Ui.Typography.Internal.Color as Color
import Ui.Typography.Internal.Style as Style


type Typography msg
    = Secondary (Typography msg)
    | Interactive msg (Typography msg)
    | Disabled (Typography msg)
    | Error (Typography msg)
    | Heading
    | Body
    | Label
    | Placeholder


typography : Typography msg -> String -> Styled.Html msg
typography t =
    let
        attrs t_ =
            case t_ of
                Secondary t__ ->
                    color Color.secondary :: attrs t__

                Interactive _ t__ ->
                    color Color.interactive :: textDecoration underline :: cursor pointer :: attrs t__

                Disabled t__ ->
                    color Color.disabled :: attrs t__

                Error t__ ->
                    color Color.error :: attrs t__

                Heading ->
                    Style.heading

                Body ->
                    Style.body

                Label ->
                    Style.label

                Placeholder ->
                    Style.placeholder
    in
    case t of
        Interactive msg _ ->
            Styled.a [ Events.onClick msg, css (attrs t) ] << List.singleton << Styled.text

        _ ->
            Styled.div [ css (attrs t) ] << List.singleton << Styled.text
