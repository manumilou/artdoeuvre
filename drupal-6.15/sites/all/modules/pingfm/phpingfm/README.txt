This is an abbreviated version of the README; you can find a more
comprehensive version at http://dmitrizone.com/projects/phpingfm.

The PHPingFM library is a method of accessing Ping.fm [1] from PHP.
It uses Ping.fm's [1] public APIs [2] to accomplish all of it's requests.

There are only two steps needed to begin using the library:
  1: You need to get an account on Ping.fm [1].  You also need a beta
     code as Ping.fm [1] is currently in private beta.
  2: You need to get a developer key.  This is done at 
     http://ping.fm/developers/, once you already have an account.
     (DISCLAIMER: by mis-using the API [3], your API key may be terminated
     and you may be banned from Ping.fm [1] for good.  We do not take
     any responsibility for this.)

Once those steps are done, you may start using the library.  Obviously,
the first thing will be to include the file, like this:
<?php
include_once 'PHPingFM.php';
?>

Once that is done, you may begin using the library.  PHPing.fm is object
oriented; everything lives in one single class, PHPingFM.
The constructor for this class takes two parameters - the developer key
(required), and the user's application key [4] (optional, can be set later).

Once that is done, you may begin using the methods.

The methods are as follows (refer to the extended documentation [6] for examples
and details of return values):

 - Validate: validates the given user's application key.  This method takes
   no parameters and returns a simple boolean - whether the key validates
   or not.

- Services: gets a list of services the particular user has set up through
  Ping.fm [1].  Takes no parameters and returns an array of services.

- Triggers: gets a user's custom triggers.  This method takes no parameters
  and returns an array of the user's custom triggers.

- Latest: gets the last 25 messages a user has posted through Ping.fm.  Takes
  two optional parameters: $limit, the number of posts to show, default 25, and
  $order, which direction to order the returned results by date (ASC or DESC,
  defaults to DESC).  Returns an array of messages.

- Post: posts a message to Ping.fm [1].  Takes 4 parameters, two required and
  two optional: $post_method, either "blog", "microblog", or "status"
  (required), $body, the body of the post (required), $title, the title of
  the post (optional), $services, a single service or array of
  services to post to (optional). Returns a boolean value of whether the posting
  was successful or not.

- Tpost:  posts a message to Ping.fm [1] using one of the user's custom triggers. 
  Takes 3 parameters, two required and one optional: $trigger, the name of the
  user's custom trigger (required), $body, the body of the post (required), and
  $title, the title of the post (optional). Returns a boolean value of whether
  the posting was successful or not.
  

Footnotes/references:
  [1]: http://ping.fm/; a service that makes updating social networks
       easy.
  [2]: http://groups.google.com/group/pingfm-developers/web/api-documentation
  [3]: http://groups.google.com/group/pingfm-developers/web/terms-of-service
  [4]: The authentication for Ping.fm [1] uses an application key - the user
       gets their application key and uses it instead of a password.  The
       application key provides limited access.  Please see the Terms of
       Service [3].
  [5]: http://php.net/print_r; prints out arrays.
