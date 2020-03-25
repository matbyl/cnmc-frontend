module Session exposing (Session(..), navKey, fromViewer)

import Browser.Navigation as Nav


type Session
    = Guest Nav.Key



navKey : Session -> Nav.Key
navKey session =
    case session of
        Guest key ->
            key


fromViewer : Nav.Key  -> Session
fromViewer key  =
            Guest key