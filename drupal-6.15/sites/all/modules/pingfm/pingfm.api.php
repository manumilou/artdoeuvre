<?php
// $Id: pingfm.api.php,v 1.1.2.1 2009/03/27 19:49:10 robloach Exp $

/**
 * @file
 * Details of the Ping.fm Drupal module API.
 */

/**
 * Called when a custom URL is invoked from Ping.fm.
 *
 * Note that this is already passed through the security check on the user's application key.
 *
 * @param $user
 *   The Drupal user account that called the custom URL.
 * @param $data
 *   The data that's passed from Ping.fm. An associative array detailing:
 *   $data['method']
 *     The method of the message being sent (blog, microblog, status).
 *   $data['title']
 *     If method is "blog" then this contain the blog's title.
 *   $data['message']
 *     The posted message content.
 *   $data['location']
 *     Any location updates posted with the message.  This is plaintext, verbatim from the posting interface.
 *   $data['media']
 *     If media is posted, this will contain a URL to the media file.
 *   $data['raw_message']
 *     If media is posted, this will contain the posted message WITHOUT the hosted media link (i.e. http://ping.fm/p/12345)
 *   $data['trigger']
 *     If you post a message with a custom trigger (http://ping.fm/triggers/), it will show here.
 */
function hook_pingfm_custom_url($user, $data = array()) {
  // In this example, we create a node for the user.
  $node = array(
    'title' => $data['title'],
    'uid' => $user->uid,
    'name' => $user->name,
    'body' => $data['message'],
    'type' => $user->pingfm_customurl_nodetype,
    'promote' => 1,
  );
  if ($node = node_submit($node)) {
    node_save($node);
  }
}
