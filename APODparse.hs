module APODparse (mHTML) where

import Network.HTTP
import Network.URI
import Control.Monad
import Data.Maybe

apod = "http://apod.nasa.gov/apod/astropix.html"
img  = "http://apod.nasa.gov/apod/image/"

fetchBody = simpleHTTP (getRequest apod) >>= getResponseBody

-- length 15
match = "<a href=\"image/"
parseString :: String -> Maybe String
parseString [] = Nothing
parseString xs = if sub == match
                 then Just (img ++ takeWhile (/= '"') (drop 15 xs))
                 else parseString (drop 1 xs)
                    where sub = take 15 xs

--fromJust feels unsafe here?
uriToString' :: URI -> String
uriToString' u = (uriScheme u) ++
                 (uriAuthToString $ fromJust $ uriAuthority u) ++
                 (uriPath u) ++
                 (uriQuery u) ++
                 (uriFragment u)

mHTML = do
  url <- (liftM parseString $ fetchBody)
  -- returns IO String
  return $ case isURI $ fromJust url of
    False -> error "unable to fetch URL"
    True  -> fromJust url
  -- String to URI to String
  {-return $ case parseURI $ fromJust url of
    Nothing -> error "unable to fetch URL"
    Just good -> uriToString' good
  -}

