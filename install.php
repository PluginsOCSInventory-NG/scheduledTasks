<?php

/**
 * This function is called on installation and is used to create database schema for the plugin
 */
function extension_install_scheduledtasks()
{
    $commonObject = new ExtensionCommon;

    $commonObject -> sqlQuery("CREATE TABLE IF NOT EXISTS `scheduledtasks` (
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

/**
 * This function is called on removal and is used to destroy database schema for the plugin
 */
function extension_delete_scheduledtasks()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE `scheduledtasks`;");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_scheduledtasks()
{

}
