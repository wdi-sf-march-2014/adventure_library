# Adventure Library

## WDI mini-project for 2/13/2014

This is your start for making your node in our distributed text adventure library.

Each of you will build a website which allows a user to view text adventures, click through the pages, and add text adventures to the database.  Here's the twist.  A user on your site will also be able to put in the name of another text adventure library, and your site will retrieve all the text adventures which were made in that library, and all of the other libraries that that library knows about.  Conversely, your library will make available via JSON endpoints all the text adventures which are locally made, and a list of all the servers which your server knows about.

## The HTML user interface

A user is able to go to a form to build a NEW text adventure.  Submitting this form will CREATE an adventure.  When an adventure is created, it will be automatically assigned a guid, a Global Unique identifier, using SecureRandom. (SecureRandom.urlsafe_base64(10))

A user can EDIT and UPDATE an adventure by changing the title, deleting pages, or adding pages.

A user can view an INDEX of adventures and click through to a specific adventure.

A user can be SHOWn an adventure.  This will start them on the page for that adventure which has the name "start".  I.E, `adventure.pages.where(:name => "start")`.  The text for that page will be shown, with any connections between pages in that text turned into links in the HTML.  Connections between pages are in the following format: [[link text|linked_to_page_name]].

A user can click through links on a page to go to connected pages.

A user can go to a form to enter in the URL of another library server.  When a user submits that form, it will start the library scraping process.

## The JSON interface

A JSON client can GET '/libraries' to get a list of libraries which the current server knows about in JSON format.

A JSON client can GET '/adventures' to get a list of adventures created on the local library server, with their pages.

## The Library scraping process

When a user submits a new library URL, "alibrary.com", this should start the library scraping process.  Your library will save that server ("alibrary.com") to the database, then set off jobs to GET all the adventures from that library ("alibrary.com/adventures.json") and GET all the libraries ("alibrary.com/libraries.json") which that library knows about.

BONUS: After a library has been added to the server, use Sidetiq to retrieve updated adventures from that server on a regular basis.  Overwrite the correct adventure in your database using the GUID.

## The schema

Adventure:
  *  has many Pages
  *  belongs to a Library
  *  has a title (string)
  *  has an author (string)
  *  has timestamps
  *  has a GUID (string)

Page:
  * belongs to an Adventure
  * has a name (string)
  * has text (text)

Library:
  * has many Adventures
  * has a URL


