Personal project of mine for practicing Haskell. The end goal is a program that will quietly in the background, download NASA's daily Astronomy Picture of the Day as it becomes available, and set it as the desktop background. I don't know which desktop environment I will write this for.
This was inspired by an app for my phone that downloads the Astronomy Picture of the Day from apod.nasa.gov and sets it as a phone background.

Overview of the modules:
* APODdownload exports download, which takes a String and performs an IO action, namely downloading whatever is in the given URI (if it's a valid URI)
* APODparse searches the apod.nasa.gov page and returns the URL of the daily image as an IO (String)

To use these together:

	main = do
		url <- mHTML
		download url

