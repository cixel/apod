module APODdownload (download) where

import Network.HTTP
import Network.URI
import Data.Text (replace)
import qualified Data.ByteString as B

baseURI = "http://apod.nasa.gov/apod/"
dailyURI = "image/1405/scorpio_guisard_1328.jpg"

cleanName :: String -> String
cleanName [] = []
cleanName xs =  filter (/= '/') xs

-- using defaultGETRequest_ instead of getRequest so as not to return a string
download :: String -> IO ()
download img = do
         jpg <- get $ img
         B.writeFile (cleanName $ img) jpg
       where
         get url = let uri = case parseURI url of 
                               Nothing -> error $ "Invalid URI: " ++ url
                               Just u  -> u in
                   simpleHTTP (defaultGETRequest_ uri) >>= getResponseBody
         -- "borrowed" from definition of getRequest in Network.HTTP
         -- adapted for defaultGetRequest_

-- write version of download whose signature is URI -> IO ()
