<?php
// $Id: pingfm.admin.inc,v 1.1.2.4 2009/03/27 19:49:10 robloach Exp $

/**
 * @file
 * Provides the administration settings for the Ping.fm web service.
 */

/**
 * Menu callback; Administration settings for Ping.fm.
 */
function pingfm_admin_settings() {
  $form['pingfm_dev_key'] = array(
    '#type' => 'textfield',
    '#title' => t('Developer key'),
    '#description' => t('The global application key obtained !pingfm. This defaults to the Ping.fm Drupal application key, but you can use your own if you have one.', array('!pingfm' => l('Ping.fm', 'http://ping.fm/developers/'))),
    '#default_value' => variable_get('pingfm_dev_key', '4c625cb344fe57ba6167eb16036c7c35'),
    '#required' => TRUE,
  );
  $form['node_settings'] = array(
    '#type' => 'fieldset',
    '#title' => t('Node settings'),
    '#description' => t('Settings related to pushing posts to Ping.fm when new nodes are created.'),
    '#collapsible' => TRUE,
  );
  $form['node_settings']['pingfm_nodetypes'] = array(
    '#type' => 'checkboxes',
    '#title' => t('Node types'),
    '#description' => t('Allow Ping.fm updates from these node types.'),
    '#default_value' => variable_get('pingfm_nodetypes', array()),
    '#options' => node_get_types('names'),
  );
  $form['node_settings']['pingfm_default_format'] = array(
    '#type' => 'textfield',
    '#title' => t('Default format'),
    '#description' => t('The default format when posting to Ping.fm.'),
    '#default_value' => variable_get('pingfm_default_format', '!title: !url'),
  );
  $form['advanced'] = array(
    '#type' => 'fieldset',
    '#collapsible' => TRUE,
    '#collapsed' => TRUE,
    '#title' => t('Advanced'),
  );
  $form['advanced']['pingfm_debug'] = array(
    '#type' => 'checkbox',
    '#title' => t('Debug'),
    '#description' => t('When enabled, tells Ping.fm that we are in debugging mode.'),
    '#default_value' => variable_get('pingfm_debug', FALSE),
  );
  return system_settings_form($form);
}
