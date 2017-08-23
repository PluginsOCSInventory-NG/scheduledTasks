<?php
function plugin_version_scheduledtasks()
{
return array('name' => 'scheduledtasks',
'version' => '1.0',
'author'=> 'Valentin DEVILLE, Guillaume PRIOU',
'license' => 'GPLv2',
'verMinOcs' => '2.2');
}

function plugin_init_scheduledtasks()
{
$object = new plugins;
$object -> add_cd_entry("scheduledtasks","other");

$object -> sql_query("
                    CREATE TABLE IF NOT EXISTS `scheduledtasks` (
                    `ID` INT(11) NOT NULL AUTO_INCREMENT,
                    `HARDWARE_ID` INT(11) NOT NULL,
                    `NAME` VARCHAR(255) NOT NULL, 
                    `NEXTEXECHOUR` VARCHAR(255) NOT NULL, 
                    `STATE` VARCHAR(255) NOT NULL, 
                    `LASTEXECHOUR` VARCHAR(255) NOT NULL, 
                    `LASTRESULT` INTEGER DEFAULT NULL, 
                    `CREATOR` VARCHAR(255) NOT NULL,
                    `PLANNING` VARCHAR(255) NOT NULL, 
                    `TASKTOEXECUTE` VARCHAR(255) NOT NULL, 
                    `STARTIN` VARCHAR(255) NOT NULL, 
                    `COMMENT` VARCHAR(255) NOT NULL,
                    `TASKSTATUS` VARCHAR(255) NOT NULL,
                    `TYPE` VARCHAR(255) NOT NULL,
                    `BEGINHOUR` VARCHAR(255) NOT NULL,
                    `BEGINDATE` VARCHAR(255) NOT NULL,
                    `ENDDATE` VARCHAR(255) NOT NULL,
                    `DAY` VARCHAR(255) NOT NULL,
                    `MONTH` VARCHAR(255) NOT NULL,
                    `EXECUTEAS` VARCHAR(255) NOT NULL,
                    `DELTASK` VARCHAR(255) NOT NULL,
                    `STOPTASKAFTER` VARCHAR(255) NOT NULL,
                    PRIMARY KEY (`ID`,`HARDWARE_ID`)
                      ) ENGINE=INNODB;");

}

function plugin_delete_scheduledtasks()
{
$object = new plugins;
$object -> del_cd_entry("scheduledtasks");
$object -> sql_query("DROP TABLE `scheduledtasks`");

}

?>
