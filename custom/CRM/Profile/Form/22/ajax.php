<?php 
/* Initialize Joomla framework */
define( '_JEXEC', 1 );
define('JPATH_BASE', '/home/ecelsadm/public_html');

/* Required Files */
require_once ( JPATH_BASE.'/includes/defines.php' );
require_once ( JPATH_BASE.'/includes/framework.php' );
/* To use Joomla's Database Class */
require_once ( JPATH_BASE.'/libraries/joomla/factory.php' );
/* Create the Application */
$app =& JFactory::getApplication('site');
$input = $app->input;

$state_province_id = $input->get('state_province_id','1037','int');

$db =& JFactory::GetDbo();
$query = $db->getQuery(true);
$query
	->select(array('id','name'))
	->from('civicrm_county')
	->where('state_province_id = '.$state_province_id)
	->order('name');

$db->setQuery($query);
$result = json_encode($db->loadAssocList('id'));
echo $result;


