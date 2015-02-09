# rottentomatoes

<b>Hours spent:</b> 4 hours

<b>User stories:</b>
User can view a list of movies from Rotten Tomatoes. Poster images must be loading asynchronously.
User can view movie details by tapping on a cell.
Hint: The Rotten Tomatoes API stopped returning high resolution images. To get around that, use the URL to the thumbnail poster, but replace 'tmb' with 'ori'.
User sees loading state while waiting for movies API. You can use one of the 3rd party libraries at http://cocoapods.wantedly.com?q=hud.
User sees error message when there's a networking error. You may not use UIAlertView or a 3rd party library to display the error. See this screenshot for what the error message should look like: network error screenshot.
User can pull to refresh the movie list. Guide: Using UIRefreshControl

<img class="embeddedObject" src="http://content.screencast.com/users/sweiii/folders/Default/media/e9679e2b-c812-45d9-bd63-1e8d938eecaf/rottentomatoes.gif" width="313" height="565" border="0" />
