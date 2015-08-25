/*
SQLyog Ultimate v8.55 
MySQL - 5.6.14 : Database - wipo_install
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `wipo_audit_trail` */

DROP TABLE IF EXISTS `wipo_audit_trail`;

CREATE TABLE `wipo_audit_trail` (
  `aud_id` int(11) NOT NULL AUTO_INCREMENT,
  `aud_user` int(11) NOT NULL,
  `aud_class` varchar(100) DEFAULT 'comment-o',
  `aud_action` varchar(255) DEFAULT NULL,
  `aud_message` varchar(255) NOT NULL,
  `aud_ip_address` varchar(100) DEFAULT NULL,
  `aud_created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`aud_id`),
  KEY `FK_wipo_audit_trail_user` (`aud_user`),
  CONSTRAINT `FK_wipo_audit_trail_user` FOREIGN KEY (`aud_user`) REFERENCES `wipo_user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_audit_trail` */

/*Table structure for table `wipo_auth_resources` */

DROP TABLE IF EXISTS `wipo_auth_resources`;

CREATE TABLE `wipo_auth_resources` (
  `Master_Resource_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Master_User_ID` int(11) DEFAULT NULL,
  `Master_Role_ID` int(11) DEFAULT NULL,
  `Master_Module_ID` int(11) NOT NULL,
  `Master_Screen_ID` int(11) NOT NULL,
  `Master_Task_ADD` enum('0','1') NOT NULL DEFAULT '0',
  `Master_Task_SEE` enum('0','1') NOT NULL DEFAULT '0',
  `Master_Task_UPT` enum('0','1') NOT NULL DEFAULT '0',
  `Master_Task_DEL` enum('0','1') NOT NULL DEFAULT '0',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Rowversion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Resource_ID`),
  KEY `FK_master_res_module` (`Master_Module_ID`),
  KEY `FK_master_res_task` (`Master_Screen_ID`),
  KEY `FK_master_res_role` (`Master_Role_ID`),
  KEY `FK_wipo_master_auth_resources_task` (`Master_Task_ADD`),
  KEY `FK_wipo_auth_resources_user` (`Master_User_ID`),
  CONSTRAINT `FK_wipo_auth_resources_role` FOREIGN KEY (`Master_Role_ID`) REFERENCES `wipo_master_role` (`Master_Role_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_auth_resources_user` FOREIGN KEY (`Master_User_ID`) REFERENCES `wipo_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_master_auth_resources_module` FOREIGN KEY (`Master_Module_ID`) REFERENCES `wipo_master_module` (`Master_Module_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_master_auth_resources_screen` FOREIGN KEY (`Master_Screen_ID`) REFERENCES `wipo_master_screen` (`Master_Screen_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_auth_resources` */

/*Table structure for table `wipo_author_account` */

DROP TABLE IF EXISTS `wipo_author_account`;

CREATE TABLE `wipo_author_account` (
  `Auth_Acc_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Auth_GUID` varchar(50) NOT NULL,
  `Auth_Is_Performer` enum('Y','N') NOT NULL DEFAULT 'N',
  `Auth_Sur_Name` varchar(50) NOT NULL,
  `Auth_First_Name` varchar(255) NOT NULL,
  `Auth_Internal_Code` varchar(255) NOT NULL,
  `Auth_Ipi` int(11) DEFAULT NULL,
  `Auth_Ipi_Base_Number` int(11) DEFAULT NULL,
  `Auth_Ipn_Number` int(11) DEFAULT NULL,
  `Auth_Place_Of_Birth_Id` int(11) DEFAULT NULL,
  `Auth_Birth_Country_Id` int(11) DEFAULT NULL,
  `Auth_Nationality_Id` int(11) DEFAULT NULL,
  `Auth_Language_Id` int(11) DEFAULT NULL,
  `Auth_Identity_Number` varchar(255) DEFAULT NULL,
  `Auth_Marital_Status_Id` int(11) DEFAULT NULL,
  `Auth_Spouse_Name` varchar(255) DEFAULT NULL,
  `Auth_Gender` enum('M','F') DEFAULT 'M',
  `Auth_DOB` date DEFAULT NULL,
  `Auth_Non_Member` enum('Y','N') DEFAULT 'N',
  `Auth_Photo` varchar(500) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Auth_Acc_Id`),
  UNIQUE KEY `Internal_Code` (`Auth_Internal_Code`),
  UNIQUE KEY `Auth_GUID_unique` (`Auth_GUID`),
  KEY `Auth_Account_index` (`Auth_Place_Of_Birth_Id`,`Auth_Birth_Country_Id`,`Auth_Nationality_Id`,`Auth_Language_Id`,`Auth_Marital_Status_Id`),
  KEY `FK_wipo_author_account_country` (`Auth_Birth_Country_Id`),
  KEY `FK_wipo_author_account_nationality` (`Auth_Nationality_Id`),
  KEY `FK_wipo_author_account_language` (`Auth_Language_Id`),
  KEY `FK_wipo_author_account` (`Auth_Marital_Status_Id`),
  KEY `NewIndex1` (`Auth_Internal_Code`),
  CONSTRAINT `FK_wipo_author_account` FOREIGN KEY (`Auth_Marital_Status_Id`) REFERENCES `wipo_master_marital_status` (`Master_Marital_State_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_account_country` FOREIGN KEY (`Auth_Birth_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_account_language` FOREIGN KEY (`Auth_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_account_nationality` FOREIGN KEY (`Auth_Nationality_Id`) REFERENCES `wipo_master_nationality` (`Master_Nation_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_author_account` */

/*Table structure for table `wipo_author_account_address` */

DROP TABLE IF EXISTS `wipo_author_account_address`;

CREATE TABLE `wipo_author_account_address` (
  `Auth_Addr_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Auth_Acc_Id` int(11) NOT NULL,
  `Auth_Home_Address_1` varchar(255) NOT NULL,
  `Auth_Home_Address_2` varchar(255) DEFAULT NULL,
  `Auth_Home_Address_3` varchar(255) DEFAULT NULL,
  `Auth_Home_Fax` varchar(25) DEFAULT NULL,
  `Auth_Home_Telephone` varchar(25) NOT NULL,
  `Auth_Home_Email` varchar(50) NOT NULL,
  `Auth_Home_Website` varchar(100) DEFAULT NULL,
  `Auth_Mailing_Address_1` varchar(255) NOT NULL,
  `Auth_Mailing_Address_2` varchar(255) DEFAULT NULL,
  `Auth_Mailing_Address_3` varchar(255) DEFAULT NULL,
  `Auth_Mailing_Telephone` varchar(25) NOT NULL,
  `Auth_Mailing_Fax` varchar(25) DEFAULT NULL,
  `Auth_Mailing_Email` varchar(50) NOT NULL,
  `Auth_Mailing_Website` varchar(100) DEFAULT NULL,
  `Auth_Author_Account_1` varchar(255) DEFAULT NULL,
  `Auth_Author_Account_2` varchar(255) DEFAULT NULL,
  `Auth_Author_Account_3` varchar(255) DEFAULT NULL,
  `Auth_Performer_Account_1` varchar(255) DEFAULT NULL,
  `Auth_Performer_Account_2` varchar(255) DEFAULT NULL,
  `Auth_Performer_Account_3` varchar(255) DEFAULT NULL,
  `Auth_Unknown_Address` enum('Y','N') DEFAULT 'N',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Auth_Addr_Id`),
  KEY `FK_wipo_author_account_address_account_id` (`Auth_Acc_Id`),
  CONSTRAINT `FK_wipo_author_account_address_account_id` FOREIGN KEY (`Auth_Acc_Id`) REFERENCES `wipo_author_account` (`Auth_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_author_account_address` */

/*Table structure for table `wipo_author_biograph_uploads` */

DROP TABLE IF EXISTS `wipo_author_biograph_uploads`;

CREATE TABLE `wipo_author_biograph_uploads` (
  `Auth_Biogrph_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Auth_Biogrph_Id` int(11) NOT NULL,
  `Auth_Biogrph_Upl_File` varchar(500) NOT NULL,
  `Auth_Biogrph_Upl_Description` text,
  `Created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Auth_Biogrph_Upl_Id`),
  KEY `FK_wipo_author_biograph_uploads_biography` (`Auth_Biogrph_Id`),
  CONSTRAINT `FK_wipo_author_biograph_uploads_biography` FOREIGN KEY (`Auth_Biogrph_Id`) REFERENCES `wipo_author_biography` (`Auth_Biogrph_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_author_biograph_uploads` */

/*Table structure for table `wipo_author_biography` */

DROP TABLE IF EXISTS `wipo_author_biography`;

CREATE TABLE `wipo_author_biography` (
  `Auth_Biogrph_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Auth_Acc_Id` int(11) NOT NULL,
  `Auth_Biogrph_Annotation` text NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Auth_Biogrph_Id`),
  KEY `FK_wipo_author_biography_account_id` (`Auth_Acc_Id`),
  CONSTRAINT `FK_wipo_author_biography_account_id` FOREIGN KEY (`Auth_Acc_Id`) REFERENCES `wipo_author_account` (`Auth_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_author_biography` */

/*Table structure for table `wipo_author_death_inheritance` */

DROP TABLE IF EXISTS `wipo_author_death_inheritance`;

CREATE TABLE `wipo_author_death_inheritance` (
  `Auth_Death_Inhrt_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Auth_Acc_Id` int(11) NOT NULL,
  `Auth_Death_Inhrt_Firstname` varchar(50) NOT NULL,
  `Auth_Death_Inhrt_Surname` varchar(50) NOT NULL,
  `Auth_Death_Inhrt_Email` varchar(100) NOT NULL,
  `Auth_Death_Inhrt_Phone` varchar(50) NOT NULL,
  `Auth_Death_Inhrt_Address_1` varchar(500) NOT NULL,
  `Auth_Death_Inhrt_Address_2` varchar(500) NOT NULL,
  `Auth_Death_Inhrt_Address_3` varchar(500) NOT NULL,
  `Auth_Death_Inhrt_Addtion_Annotation` text,
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Auth_Death_Inhrt_Id`),
  KEY `FK_wipo_author_death_inheritance_account_id` (`Auth_Acc_Id`),
  CONSTRAINT `FK_wipo_author_death_inheritance_account_id` FOREIGN KEY (`Auth_Acc_Id`) REFERENCES `wipo_author_account` (`Auth_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_author_death_inheritance` */

/*Table structure for table `wipo_author_manage_rights` */

DROP TABLE IF EXISTS `wipo_author_manage_rights`;

CREATE TABLE `wipo_author_manage_rights` (
  `Auth_Mnge_Rgt_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Auth_Acc_Id` int(11) NOT NULL,
  `Auth_Mnge_Society_Id` int(11) NOT NULL,
  `Auth_Mnge_Entry_Date` date NOT NULL,
  `Auth_Mnge_Exit_Date` date DEFAULT NULL,
  `Auth_Mnge_Internal_Position_Id` int(11) NOT NULL,
  `Auth_Mnge_Entry_Date_2` date NOT NULL,
  `Auth_Mnge_Exit_Date_2` date DEFAULT NULL,
  `Auth_Mnge_Region_Id` int(11) DEFAULT NULL,
  `Auth_Mnge_Profession_Id` int(11) DEFAULT NULL,
  `Auth_Mnge_File` varchar(255) DEFAULT NULL,
  `Auth_Mnge_Duration` varchar(100) DEFAULT NULL,
  `Auth_Mnge_Avl_Work_Cat_Id` int(11) NOT NULL,
  `Auth_Mnge_Type_Rght_Id` int(11) NOT NULL,
  `Auth_Mnge_Managed_Rights_Id` int(11) NOT NULL,
  `Auth_Mnge_Territories_Id` int(11) NOT NULL,
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Auth_Mnge_Rgt_Id`),
  KEY `FK_wipo_author_manage_rights_account_id` (`Auth_Acc_Id`),
  KEY `FK_wipo_author_manage_rights_internal_position` (`Auth_Mnge_Internal_Position_Id`),
  KEY `FK_wipo_author_manage_rights_region` (`Auth_Mnge_Region_Id`),
  KEY `FK_wipo_author_manage_rights_profession` (`Auth_Mnge_Profession_Id`),
  KEY `FK_wipo_author_manage_rights_work_category` (`Auth_Mnge_Avl_Work_Cat_Id`),
  KEY `FK_wipo_author_manage_rights_type_of_rights` (`Auth_Mnge_Type_Rght_Id`),
  KEY `FK_wipo_author_manage_rights_managerd_rights` (`Auth_Mnge_Managed_Rights_Id`),
  KEY `FK_wipo_author_manage_rights_territories` (`Auth_Mnge_Territories_Id`),
  KEY `FK_wipo_author_manage_rights_society` (`Auth_Mnge_Society_Id`),
  CONSTRAINT `FK_wipo_author_manage_rights_account_id` FOREIGN KEY (`Auth_Acc_Id`) REFERENCES `wipo_author_account` (`Auth_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_manage_rights_internal_position` FOREIGN KEY (`Auth_Mnge_Internal_Position_Id`) REFERENCES `wipo_master_internal_position` (`Master_Int_Post_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_manage_rights_managerd_rights` FOREIGN KEY (`Auth_Mnge_Managed_Rights_Id`) REFERENCES `wipo_master_managed_rights` (`Master_Mgd_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_manage_rights_profession` FOREIGN KEY (`Auth_Mnge_Profession_Id`) REFERENCES `wipo_master_profession` (`Master_Profession_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_manage_rights_region` FOREIGN KEY (`Auth_Mnge_Region_Id`) REFERENCES `wipo_master_region` (`Master_Region_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_manage_rights_society` FOREIGN KEY (`Auth_Mnge_Society_Id`) REFERENCES `wipo_society` (`Society_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_manage_rights_territories` FOREIGN KEY (`Auth_Mnge_Territories_Id`) REFERENCES `wipo_master_territories` (`Master_Territory_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_manage_rights_type_of_rights` FOREIGN KEY (`Auth_Mnge_Type_Rght_Id`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_manage_rights_work_category` FOREIGN KEY (`Auth_Mnge_Avl_Work_Cat_Id`) REFERENCES `wipo_master_works_category` (`Master_Work_Category_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_author_manage_rights` */

/*Table structure for table `wipo_author_payment_method` */

DROP TABLE IF EXISTS `wipo_author_payment_method`;

CREATE TABLE `wipo_author_payment_method` (
  `Auth_Pay_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Auth_Acc_Id` int(11) NOT NULL,
  `Auth_Pay_Method_id` int(11) NOT NULL,
  `Auth_Bank_Account_1` varchar(255) NOT NULL,
  `Auth_Bank_Account_2` varchar(255) NOT NULL,
  `Auth_Bank_Account_3` varchar(255) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Auth_Pay_Id`),
  KEY `FK_wipo_author_payment_method_account_id` (`Auth_Acc_Id`),
  KEY `FK_wipo_author_payment_method_payment_mode` (`Auth_Pay_Method_id`),
  CONSTRAINT `FK_wipo_author_payment_method_account_id` FOREIGN KEY (`Auth_Acc_Id`) REFERENCES `wipo_author_account` (`Auth_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_payment_method_payment_mode` FOREIGN KEY (`Auth_Pay_Method_id`) REFERENCES `wipo_master_payment_method` (`Master_Paymode_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_author_payment_method` */

/*Table structure for table `wipo_author_pseudonym` */

DROP TABLE IF EXISTS `wipo_author_pseudonym`;

CREATE TABLE `wipo_author_pseudonym` (
  `Auth_Pseudo_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Auth_Acc_Id` int(11) NOT NULL,
  `Auth_Pseudo_Type_Id` int(11) NOT NULL,
  `Auth_Pseudo_Name` varchar(50) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Auth_Pseudo_Id`),
  KEY `FK_wipo_author_pseudonym_pseodo_type` (`Auth_Pseudo_Type_Id`),
  KEY `FK_wipo_author_pseudonym_author_account` (`Auth_Acc_Id`),
  CONSTRAINT `FK_wipo_author_pseudonym_author_account` FOREIGN KEY (`Auth_Acc_Id`) REFERENCES `wipo_author_account` (`Auth_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_author_pseudonym_pseodo_type` FOREIGN KEY (`Auth_Pseudo_Type_Id`) REFERENCES `wipo_master_pseudonym_types` (`Pseudo_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_author_pseudonym` */

/*Table structure for table `wipo_author_upload` */

DROP TABLE IF EXISTS `wipo_author_upload`;

CREATE TABLE `wipo_author_upload` (
  `Auth_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Auth_Acc_Id` int(11) NOT NULL,
  `Auth_Upl_Doc_Name` varchar(255) NOT NULL,
  `Auth_Upl_File` varchar(1000) NOT NULL,
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Auth_Upl_Id`),
  KEY `FK_wipo_author_upload_auth` (`Auth_Acc_Id`),
  CONSTRAINT `FK_wipo_author_upload_auth` FOREIGN KEY (`Auth_Acc_Id`) REFERENCES `wipo_author_account` (`Auth_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_author_upload` */

/*Table structure for table `wipo_contract_invoice` */

DROP TABLE IF EXISTS `wipo_contract_invoice`;

CREATE TABLE `wipo_contract_invoice` (
  `Inv_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Inv_Invoice` varchar(50) NOT NULL,
  `Inv_Date` date NOT NULL,
  `Tarf_Cont_Id` int(11) NOT NULL,
  `Inv_Repeat_Id` mediumint(9) DEFAULT NULL COMMENT 'Not needed. Not used',
  `Inv_Repeat_Count` smallint(6) DEFAULT NULL,
  `Inv_Next_Date` date DEFAULT NULL,
  `Inv_Amount` decimal(10,2) DEFAULT NULL,
  `Inv_Created_Type` enum('A','M') DEFAULT 'M' COMMENT 'A -> Automatic, M -> Manual',
  `Inv_Created_Mode` enum('C','B') DEFAULT 'C' COMMENT 'C -> Current, B -> Back Date',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Inv_Id`),
  UNIQUE KEY `invoiceUnique` (`Inv_Invoice`),
  KEY `FK_wipo_contract_invoice_tarif` (`Tarf_Cont_Id`),
  CONSTRAINT `FK_wipo_contract_invoice_tarif` FOREIGN KEY (`Tarf_Cont_Id`) REFERENCES `wipo_tariff_contracts` (`Tarf_Cont_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_contract_invoice` */

/*Table structure for table `wipo_customer_user` */

DROP TABLE IF EXISTS `wipo_customer_user`;

CREATE TABLE `wipo_customer_user` (
  `User_Cust_Id` int(11) NOT NULL AUTO_INCREMENT,
  `User_Cust_GUID` varchar(40) NOT NULL,
  `User_Cust_Internal_Code` varchar(50) NOT NULL,
  `User_Cust_Place_Id` int(11) NOT NULL,
  `User_Cust_Code` varchar(50) NOT NULL,
  `User_Cust_Name` varchar(100) NOT NULL,
  `User_Cust_Address` varchar(255) DEFAULT NULL,
  `User_Cust_Email` varchar(100) DEFAULT NULL,
  `User_Cust_Telephone` varchar(50) DEFAULT NULL,
  `User_Cust_Website` varchar(100) DEFAULT NULL,
  `User_Cust_Fax` varchar(50) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`User_Cust_Id`),
  UNIQUE KEY `NewIndex1` (`User_Cust_Internal_Code`),
  KEY `FK_wipo_customer_user` (`User_Cust_Place_Id`),
  CONSTRAINT `FK_wipo_customer_user` FOREIGN KEY (`User_Cust_Place_Id`) REFERENCES `wipo_master_place` (`Master_Place_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_customer_user` */

/*Table structure for table `wipo_email_template` */

DROP TABLE IF EXISTS `wipo_email_template`;

CREATE TABLE `wipo_email_template` (
  `Email_Temp_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Email_Temp_Name` varchar(100) NOT NULL,
  `Email_Temp_Username` varchar(50) DEFAULT NULL,
  `Email_Temp_From` varchar(50) DEFAULT NULL,
  `Email_Temp_ReplyTo` varchar(50) DEFAULT NULL,
  `Email_Temp_Subject` varchar(100) NOT NULL,
  `Email_Temp_Content` text NOT NULL,
  `Email_Temp_Params` text,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Email_Temp_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_email_template` */

insert  into `wipo_email_template`(`Email_Temp_Id`,`Email_Temp_Name`,`Email_Temp_Username`,`Email_Temp_From`,`Email_Temp_ReplyTo`,`Email_Temp_Subject`,`Email_Temp_Content`,`Email_Temp_Params`,`Created_Date`,`Rowversion`,`Created_By`,`Updated_By`) values (1,'Invoice Template','','softwaretesterid@gmail.com','softwaretesterid@gmail.com','{CURRENT_MONTH} Invoice {INVOICE_NO} From {SOCIETY_NAME}','<div class=\"row invoice-info\" style=\"margin-right: -15px; margin-left: -15px;\">\r\n    <div class=\"col-sm-12\" style=\"width: 100%; min-height: 1px; padding-left: 15px; padding-right: 15px; position: relative; float: left;\">\r\n        <p style=\"font-weight: normal; font-size: 13px; line-height: 20px;\">Hi {CUSTOMER_NAME},</p>\r\n        <p style=\"font-weight: normal; font-size: 13px; line-height: 20px;\">Here is your {CURRENT_MONTH} invoice {INVOICE_NO} for {INVOICE_AMOUNT}</p>\r\n        <p style=\"font-size: 13px; line-height: 20px;\">If you have any question please let us know.</p>\r\n    </div>\r\n</div>\r\n<div class=\"row invoice-info\" style=\"font-weight: normal; margin-right: -15px; margin-left: -15px;\">\r\n    <div class=\"col-sm-6 invoice-col\" style=\"width: 45%;min-height: 1px;padding-left: 15px;padding-right: 15px;position: relative;float: left;\">\r\n        <p class=\"lead\" style=\"margin-bottom: 20px;font-size: 16px;font-weight: 300;line-height: 1.4;\">User Details:</p>\r\n        <address style=\"margin-bottom: 20px;font-style: normal;line-height: 1.42857143;\">\r\n            <strong>{CUSTOMER_NAME}</strong><br>\r\n            {CUST_ADDRESS}<br>\r\n            Phone: {CUST_PHONE}<br>\r\n            Fax: {CUST_FAX}<br>\r\n            Website: {CUST_WEBSITE}<br>\r\n            Email: {CUST_EMAIL}\r\n        </address>\r\n    </div>\r\n    <div class=\"col-sm-6 invoice-col\" style=\"width: 45%;min-height: 1px;padding-left: 15px;padding-right: 15px;position: relative;float: left;\">\r\n        <p class=\"lead\" style=\"margin-bottom: 20px;font-size: 16px;font-weight: 300;line-height: 1.4;\">Agreement:</p>\r\n        <b>Contract Number:</b> {CONTRACT_NO}<br>\r\n        <b>Contract Start:</b> {TAR_FROM}<br>\r\n        <b>Contract End:</b> {TAR_TO}<br>\r\n        <b>Date of signature:</b> {TAR_SIGN}<br>\r\n        <b>Payment Frequency:</b> {TAR_PAYMENT}<br>\r\n    </div>\r\n</div>\r\n<div class=\"clearfix\" style=\"font-weight: normal; clear: both;\"></div>\r\n\r\n<div class=\"row\" style=\"font-weight: normal; margin-right: -15px; margin-left: -15px;\">\r\n    <div class=\"col-xs-12\" style=\"float: left;width: 96%;min-height: 1px;padding-left: 15px;padding-right: 15px;position: relative;\">\r\n        <p class=\"lead\" style=\"margin-bottom: 20px;font-size: 16px;font-weight: 300;line-height: 1.4;\">Royalty:</p>\r\n        <div class=\"table-responsive\" style=\"min-height: .01%;overflow-x: auto;\">\r\n            <table class=\"table\" style=\"width: 100%;max-width: 100%;margin-bottom: 20px;text-align: left;border-collapse: collapse !important;\">\r\n                <tbody><tr>\r\n                    <th style=\"width: 50%;border-bottom: 1px solid #cccccc;padding: 8px;\">Invoice:</th>\r\n                    <td style=\"border-bottom: 1px solid #cccccc;padding: 8px;\">{INVOICE_NO}</td>\r\n                </tr>\r\n                <tr>\r\n                    <th style=\"border-bottom: 1px solid #cccccc;padding: 8px;\">Amount:</th>\r\n                    <td style=\"border-bottom: 1px solid #cccccc;padding: 8px;\">{TAR_TO_PAY}</td>\r\n                </tr>\r\n                <tr>\r\n                    <th style=\"border-bottom: 1px solid #cccccc;padding: 8px;\">To:</th>\r\n                    <td style=\"border-bottom: 1px solid #cccccc;padding: 8px;\">{TAR_TO}</td>\r\n                </tr>\r\n                <tr>\r\n                    <th style=\"border-bottom: 1px solid #cccccc;padding: 8px;\">Contract Duration:</th>\r\n                    <td style=\"border-bottom: 1px solid #cccccc;padding: 8px;\">{TAR_SIGN}</td>\r\n                </tr>\r\n            </tbody>\r\n</table>\r\n        </div>\r\n    </div>\r\n</div>\r\n','CONTRACT_NO,CONTRACT_DURATION,CUSTOMER_NAME,CUST_ADDRESS,CUST_PHONE,CUST_FAX,CUST_WEBSITE,CUST_EMAIL,CURRENT_MONTH,INVOICE_NO,INVOICE_AMOUNT,SOCIETY_NAME,TAR_CITY,TAR_DISTRICT,TAR_AREA,TAR_TARIF_CODE,TAR_INSP,TAR_BALANCE,TAR_TYPE,TAR_EVE_DATE,TAR_EVE_COMMENT,TAR_TO_PAY,TAR_FROM,TAR_TO,TAR_SIGN,TAR_PAYMENT,TAR_PORTION,TAR_ROY_COMMENT','2015-08-08 18:59:11','0000-00-00 00:00:00',NULL,NULL);

/*Table structure for table `wipo_group` */

DROP TABLE IF EXISTS `wipo_group`;

CREATE TABLE `wipo_group` (
  `Group_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Group_GUID` varchar(50) NOT NULL,
  `Group_Name` varchar(100) NOT NULL,
  `Group_Is_Author` enum('0','1') DEFAULT '0',
  `Group_Is_Performer` enum('0','1') DEFAULT '0',
  `Group_Internal_Code` varchar(50) NOT NULL,
  `Group_IPI_Name_Number` int(11) DEFAULT NULL,
  `Group_IPN_Base_Number` int(11) DEFAULT NULL,
  `Group_IPN_Number` int(11) DEFAULT NULL,
  `Group_Date` date NOT NULL,
  `Group_Place` varchar(100) DEFAULT NULL,
  `Group_Country_Id` int(11) NOT NULL,
  `Group_Legal_Form_Id` int(11) DEFAULT NULL,
  `Group_Language_Id` int(11) DEFAULT NULL,
  `Group_Non_Member` enum('Y','N') DEFAULT 'N',
  `Group_Photo` varchar(500) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Group_Id`),
  UNIQUE KEY `Group_GUID_unique` (`Group_GUID`),
  KEY `FK_wipo_group_country` (`Group_Country_Id`),
  KEY `FK_wipo_group_language` (`Group_Language_Id`),
  KEY `FK_wipo_group_legal_form` (`Group_Legal_Form_Id`),
  CONSTRAINT `FK_wipo_group_country` FOREIGN KEY (`Group_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_language` FOREIGN KEY (`Group_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_legal_form` FOREIGN KEY (`Group_Legal_Form_Id`) REFERENCES `wipo_master_legal_form` (`Master_Legal_Form_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_group` */

/*Table structure for table `wipo_group_biograph_uploads` */

DROP TABLE IF EXISTS `wipo_group_biograph_uploads`;

CREATE TABLE `wipo_group_biograph_uploads` (
  `Group_Biogrph_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Group_Biogrph_Id` int(11) NOT NULL,
  `Group_Biogrph_Upl_File` varchar(500) NOT NULL,
  `Group_Biogrph_Upl_Description` text,
  `Created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Group_Biogrph_Upl_Id`),
  KEY `FK_wipo_group_biograph_uploads_biography` (`Group_Biogrph_Id`),
  CONSTRAINT `FK_wipo_group_biograph_uploads_biography` FOREIGN KEY (`Group_Biogrph_Id`) REFERENCES `wipo_group_biography` (`Group_Biogrph_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_group_biograph_uploads` */

/*Table structure for table `wipo_group_biography` */

DROP TABLE IF EXISTS `wipo_group_biography`;

CREATE TABLE `wipo_group_biography` (
  `Group_Biogrph_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Group_Id` int(11) NOT NULL,
  `Group_Biogrph_Annotation` text NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Group_Biogrph_Id`),
  KEY `FK_wipo_group_biography_account_id` (`Group_Id`),
  CONSTRAINT `FK_wipo_group_biography_account_id` FOREIGN KEY (`Group_Id`) REFERENCES `wipo_group` (`Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_group_biography` */

/*Table structure for table `wipo_group_manage_rights` */

DROP TABLE IF EXISTS `wipo_group_manage_rights`;

CREATE TABLE `wipo_group_manage_rights` (
  `Group_Mnge_Rgt_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Group_Id` int(11) NOT NULL,
  `Group_Mnge_Society_Id` int(11) NOT NULL,
  `Group_Mnge_Entry_Date` date NOT NULL,
  `Group_Mnge_Exit_Date` date DEFAULT NULL,
  `Group_Mnge_Internal_Position_Id` int(11) NOT NULL,
  `Group_Mnge_Entry_Date_2` date NOT NULL,
  `Group_Mnge_Exit_Date_2` date DEFAULT NULL,
  `Group_Mnge_Region_Id` int(11) DEFAULT NULL,
  `Group_Mnge_Profession_Id` int(11) DEFAULT NULL,
  `Group_Mnge_File` varchar(255) DEFAULT NULL,
  `Group_Mnge_Duration` varchar(100) DEFAULT NULL,
  `Group_Mnge_Avl_Work_Cat_Id` int(11) NOT NULL,
  `Group_Mnge_Type_Rght_Id` int(11) NOT NULL,
  `Group_Mnge_Managed_Rights_Id` int(11) NOT NULL,
  `Group_Mnge_Territories_Id` int(11) NOT NULL,
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Group_Mnge_Rgt_Id`),
  KEY `FK_wipo_group_manage_rights_account_id` (`Group_Id`),
  KEY `FK_wipo_group_manage_rights_internal_position` (`Group_Mnge_Internal_Position_Id`),
  KEY `FK_wipo_group_manage_rights_region` (`Group_Mnge_Region_Id`),
  KEY `FK_wipo_group_manage_rights_profession` (`Group_Mnge_Profession_Id`),
  KEY `FK_wipo_group_manage_rights_work_category` (`Group_Mnge_Avl_Work_Cat_Id`),
  KEY `FK_wipo_group_manage_rights_type_of_rights` (`Group_Mnge_Type_Rght_Id`),
  KEY `FK_wipo_group_manage_rights_managerd_rights` (`Group_Mnge_Managed_Rights_Id`),
  KEY `FK_wipo_group_manage_rights_territories` (`Group_Mnge_Territories_Id`),
  KEY `FK_wipo_group_manage_rights_society` (`Group_Mnge_Society_Id`),
  CONSTRAINT `FK_wipo_group_manage_rights_account_id` FOREIGN KEY (`Group_Id`) REFERENCES `wipo_group` (`Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_manage_rights_internal_position` FOREIGN KEY (`Group_Mnge_Internal_Position_Id`) REFERENCES `wipo_master_internal_position` (`Master_Int_Post_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_manage_rights_managerd_rights` FOREIGN KEY (`Group_Mnge_Managed_Rights_Id`) REFERENCES `wipo_master_managed_rights` (`Master_Mgd_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_manage_rights_profession` FOREIGN KEY (`Group_Mnge_Profession_Id`) REFERENCES `wipo_master_profession` (`Master_Profession_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_manage_rights_region` FOREIGN KEY (`Group_Mnge_Region_Id`) REFERENCES `wipo_master_region` (`Master_Region_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_manage_rights_society` FOREIGN KEY (`Group_Mnge_Society_Id`) REFERENCES `wipo_society` (`Society_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_manage_rights_territories` FOREIGN KEY (`Group_Mnge_Territories_Id`) REFERENCES `wipo_master_territories` (`Master_Territory_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_manage_rights_type_of_rights` FOREIGN KEY (`Group_Mnge_Type_Rght_Id`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_manage_rights_work_category` FOREIGN KEY (`Group_Mnge_Avl_Work_Cat_Id`) REFERENCES `wipo_master_works_category` (`Master_Work_Category_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_group_manage_rights` */

/*Table structure for table `wipo_group_members` */

DROP TABLE IF EXISTS `wipo_group_members`;

CREATE TABLE `wipo_group_members` (
  `Group_Member_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Group_Id` int(11) NOT NULL,
  `Group_Member_GUID` varchar(50) NOT NULL,
  `Created_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Group_Member_Id`),
  KEY `FK_wipo_group_biography_account_id` (`Group_Id`),
  KEY `FK_wipo_group_members_Perf_Internal_Code` (`Group_Member_GUID`),
  CONSTRAINT `FK_wipo_group_members_group` FOREIGN KEY (`Group_Id`) REFERENCES `wipo_group` (`Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_group_members` */

/*Table structure for table `wipo_group_payment_method` */

DROP TABLE IF EXISTS `wipo_group_payment_method`;

CREATE TABLE `wipo_group_payment_method` (
  `Group_Pay_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Group_Id` int(11) NOT NULL,
  `Group_Pay_Method_id` int(11) NOT NULL,
  `Group_Bank_Account_1` varchar(255) NOT NULL,
  `Group_Bank_Account_2` varchar(255) NOT NULL,
  `Group_Bank_Account_3` varchar(255) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Group_Pay_Id`),
  KEY `FK_wipo_group_payment_method_account_id` (`Group_Id`),
  KEY `FK_wipo_group_payment_method_payment_mode` (`Group_Pay_Method_id`),
  CONSTRAINT `FK_wipo_group_payment_method_account_id` FOREIGN KEY (`Group_Id`) REFERENCES `wipo_group` (`Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_payment_method_payment_mode` FOREIGN KEY (`Group_Pay_Method_id`) REFERENCES `wipo_master_payment_method` (`Master_Paymode_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_group_payment_method` */

/*Table structure for table `wipo_group_pseudonym` */

DROP TABLE IF EXISTS `wipo_group_pseudonym`;

CREATE TABLE `wipo_group_pseudonym` (
  `Group_Pseudo_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Group_Id` int(11) NOT NULL,
  `Group_Pseudo_Type_Id` int(11) NOT NULL,
  `Group_Pseudo_Name` varchar(50) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Group_Pseudo_Id`),
  KEY `FK_wipo_group_pseudonym_pseodo_type` (`Group_Pseudo_Type_Id`),
  KEY `FK_wipo_group_pseudonym_group` (`Group_Id`),
  CONSTRAINT `FK_wipo_group_pseudonym_group` FOREIGN KEY (`Group_Id`) REFERENCES `wipo_group` (`Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_pseudonym_pseodo_type` FOREIGN KEY (`Group_Pseudo_Type_Id`) REFERENCES `wipo_master_pseudonym_types` (`Pseudo_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_group_pseudonym` */

/*Table structure for table `wipo_group_representative` */

DROP TABLE IF EXISTS `wipo_group_representative`;

CREATE TABLE `wipo_group_representative` (
  `Group_Addr_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Group_Id` int(11) NOT NULL,
  `Group_Rep_Name` varchar(100) NOT NULL,
  `Group_Rep_Address_1` varchar(255) DEFAULT NULL,
  `Group_Rep_Address_2` varchar(255) DEFAULT NULL,
  `Group_Rep_Address_3` varchar(255) DEFAULT NULL,
  `Group_Rep_Address_4` varchar(255) DEFAULT NULL,
  `Group_Home_Address_1` varchar(255) NOT NULL,
  `Group_Home_Address_2` varchar(255) DEFAULT NULL,
  `Group_Home_Address_3` varchar(255) DEFAULT NULL,
  `Group_Home_Address_4` varchar(255) DEFAULT NULL,
  `Group_Home_Fax` varchar(25) DEFAULT NULL,
  `Group_Home_Telephone` varchar(25) NOT NULL,
  `Group_Home_Email` varchar(50) NOT NULL,
  `Group_Home_Website` varchar(100) DEFAULT NULL,
  `Group_Mailing_Address_1` varchar(255) NOT NULL,
  `Group_Mailing_Address_2` varchar(255) DEFAULT NULL,
  `Group_Mailing_Address_3` varchar(255) DEFAULT NULL,
  `Group_Mailing_Address_4` varchar(255) DEFAULT NULL,
  `Group_Mailing_Telephone` varchar(25) NOT NULL,
  `Group_Mailing_Fax` varchar(25) DEFAULT NULL,
  `Group_Mailing_Email` varchar(50) NOT NULL,
  `Group_Mailing_Website` varchar(100) DEFAULT NULL,
  `Group_Country_Id` int(11) DEFAULT NULL,
  `Group_Unknown_Address` enum('Y','N') DEFAULT 'N',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Group_Addr_Id`),
  KEY `FK_wipo_group_representative_account_id` (`Group_Id`),
  KEY `FK_wipo_group_representative_country` (`Group_Country_Id`),
  CONSTRAINT `FK_wipo_group_representative_account_id` FOREIGN KEY (`Group_Id`) REFERENCES `wipo_group` (`Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_group_representative_country` FOREIGN KEY (`Group_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_group_representative` */

/*Table structure for table `wipo_inspector` */

DROP TABLE IF EXISTS `wipo_inspector`;

CREATE TABLE `wipo_inspector` (
  `Insp_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Insp_Internal_Code` varchar(50) NOT NULL,
  `Insp_GUID` varchar(40) NOT NULL,
  `Insp_Name` varchar(100) NOT NULL,
  `Insp_Occupation` varchar(100) DEFAULT NULL,
  `Insp_DOB` date DEFAULT NULL,
  `Insp_Nationality_Id` int(11) DEFAULT NULL,
  `Insp_Birth_Place` varchar(100) DEFAULT NULL,
  `Insp_Identity_Number` varchar(50) DEFAULT NULL,
  `Insp_Date` date DEFAULT NULL,
  `Insp_Region_Id` int(11) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Insp_Id`),
  KEY `FK_wipo_inspector_region` (`Insp_Region_Id`),
  KEY `FK_wipo_inspector_nationality` (`Insp_Nationality_Id`),
  CONSTRAINT `FK_wipo_inspector_nationality` FOREIGN KEY (`Insp_Nationality_Id`) REFERENCES `wipo_master_nationality` (`Master_Nation_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_inspector_region` FOREIGN KEY (`Insp_Region_Id`) REFERENCES `wipo_master_region` (`Master_Region_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_inspector` */

/*Table structure for table `wipo_internalcode_generate` */

DROP TABLE IF EXISTS `wipo_internalcode_generate`;

CREATE TABLE `wipo_internalcode_generate` (
  `Gen_Inter_Code_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Gen_Soc_Id` varchar(10) NOT NULL,
  `Gen_User_Type` varchar(4) NOT NULL COMMENT 'A -> Author, P -> Performer, G -> Group, O -> Organization, PU -> Publisher, PR -> Producer, PG -> Publisher/producer group, W -> Work, R -> Recording, GA -> Group Author, GP -> Group Performer, GE -> Group Publisher, GR -> Group Producer, AP -> Author & Performer, EP -> Publisher & producer',
  `Gen_Prefix` varchar(10) DEFAULT NULL,
  `Gen_Inter_Code` varchar(50) NOT NULL,
  `Gen_Suffix` varchar(10) DEFAULT NULL,
  `Gen_Code_Pad` tinyint(4) NOT NULL DEFAULT '7',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Gen_Inter_Code_Id`),
  UNIQUE KEY `UserType` (`Gen_User_Type`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_internalcode_generate` */

insert  into `wipo_internalcode_generate`(`Gen_Inter_Code_Id`,`Gen_Soc_Id`,`Gen_User_Type`,`Gen_Prefix`,`Gen_Inter_Code`,`Gen_Suffix`,`Gen_Code_Pad`,`Created_Date`,`Rowversion`,`Created_By`,`Updated_By`) values (1,'SOC','A','A','1','',7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(2,'SOC','P','P','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(4,'SOC','O','SOC','1',NULL,3,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(5,'SOC','PU','E','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(7,'SOC','PR','PR','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(8,'SOC','W','W','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(9,'SOC','R','R','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(10,'SOC','GA','GA','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(11,'SOC','GP','GP','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(12,'SOC','GE','GE','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(13,'SOC','GR','GPR','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(14,'SOC','AP','AP','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(15,'SOC','EP','EPR','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(16,'SOC','RP','S','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(17,'SOC','S','SC','1','',7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(18,'SOC','SP','SP','1','',7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(19,'SOC','RS','RSS','1','',7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(20,'SOC','IS','I','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(21,'SOC','TF','CON','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(22,'SOC','TMS','TAR','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1),(23,'SOC','CUS','U','1',NULL,7,'2015-07-23 12:01:01','2015-08-20 13:28:47',NULL,1);

/*Table structure for table `wipo_master_city` */

DROP TABLE IF EXISTS `wipo_master_city`;

CREATE TABLE `wipo_master_city` (
  `Master_City_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Country_Id` int(11) NOT NULL,
  `City_Code` varchar(20) NOT NULL,
  `City_Name` varchar(100) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Master_City_Id`),
  KEY `FK_wipo_master_city_country` (`Country_Id`),
  CONSTRAINT `FK_wipo_master_city_country` FOREIGN KEY (`Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_city` */

insert  into `wipo_master_city`(`Master_City_Id`,`Country_Id`,`City_Code`,`City_Name`,`Active`,`Created_Date`,`Rowversion`,`Created_By`,`Updated_By`) values (1,2,'ACH','Achham','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(2,2,'ARG','Arghakhanchi','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(3,2,'BAG','Baglung','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(4,2,'BAI','Baitadi','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(5,2,'BAJ','Bajhang','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(6,2,'BAJ','Bajura','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(7,2,'BAN','Banke','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(8,2,'BAR','Bara','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(9,2,'BAR','Bardiya','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(10,2,'BHA','Bhaktapur','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(11,2,'BHO','Bhojpur','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(12,2,'CHI','Chitwan','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(13,2,'DAD','Dadeldhura','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(14,2,'DAI','Dailekh','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(15,2,'DAN','Dang Deukhuri','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(16,2,'DAR','Darchula','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(17,2,'DHA','Dhading','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(18,2,'DHA','Dhankuta','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(19,2,'DHA','Dhanusa','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(20,2,'DHO','Dholkha','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(21,2,'DOL','Dolpa','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(22,2,'DOT','Doti','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(23,2,'GOR','Gorkha','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(24,2,'GUL','Gulmi','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(25,2,'HUM','Humla','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(26,2,'ILA','Ilam','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(27,2,'JAJ','Jajarkot','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(28,2,'JHA','Jhapa','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(29,2,'JUM','Jumla','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(30,2,'KAI','Kailali','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(31,2,'KAL','Kalikot','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(32,2,'KAN','Kanchanpur','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(33,2,'KAP','Kapilvastu','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(34,2,'KAS','Kaski','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(35,2,'KAT','Kathmandu','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(36,2,'KAV','Kavrepalanchok','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(37,2,'KHO','Khotang','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(38,2,'LAL','Lalitpur','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(39,2,'LAM','Lamjung','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(40,2,'MAH','Mahottari','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(41,2,'MAK','Makwanpur','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(42,2,'MAN','Manang','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(43,2,'MOR','Morang','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(44,2,'MUG','Mugu','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(45,2,'MUS','Mustang','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(46,2,'MYA','Myagdi','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(47,2,'NAW','Nawalparasi','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(48,2,'NUW','Nuwakot','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(49,2,'OKH','Okhaldhunga','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(50,2,'PAL','Palpa','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(51,2,'PAN','Panchthar','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(52,2,'PAR','Parbat','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(53,2,'PAR','Parsa','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(54,2,'PYU','Pyuthan','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(55,2,'RAM','Ramechhap','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(56,2,'RAS','Rasuwa','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(57,2,'RAU','Rautahat','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(58,2,'ROL','Rolpa','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(59,2,'RUK','Rukum','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(60,2,'RUP','Rupandehi','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(61,2,'SAL','Salyan','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(62,2,'SAN','Sankhuwasabha','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(63,2,'SAP','Saptari','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(64,2,'SAR','Sarlahi','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(65,2,'SIN','Sindhuli','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(66,2,'SIN','Sindhupalchok','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(67,2,'SIR','Siraha','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(68,2,'SOL','Solukhumbu','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(69,2,'SUN','Sunsari','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(70,2,'SUR','Surkhet','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(71,2,'SYA','Syangja','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(72,2,'TAN','Tanahu','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(73,2,'TAP','Taplejung','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(74,2,'TER','Terhathum','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL),(75,2,'UDA','Udayapur','1','2015-08-03 18:59:27','0000-00-00 00:00:00',1,NULL);

/*Table structure for table `wipo_master_country` */

DROP TABLE IF EXISTS `wipo_master_country`;

CREATE TABLE `wipo_master_country` (
  `Master_Country_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Country_Name` varchar(45) NOT NULL COMMENT 'Name:',
  `Country_Two_Code` varchar(3) DEFAULT NULL COMMENT 'Two Code:',
  `Country_Three_Code` varchar(5) DEFAULT NULL COMMENT 'Three Code:',
  `Active` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Status',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Country_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_country` */

insert  into `wipo_master_country`(`Master_Country_Id`,`Country_Name`,`Country_Two_Code`,`Country_Three_Code`,`Active`,`Created_Date`,`Rowversion`) values (2,'NEPAL','NP','0524','1','2015-03-15 00:12:13','0000-00-00 00:00:00'),(5,'AFGHANISTAN','AF','0004','1','2015-04-10 21:28:14','0000-00-00 00:00:00'),(7,'ALBANIA','AL','0008','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(8,'ALGERIA','DZ','0012','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(9,'ANDORRA','AD','0020','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(10,'ANGOLA','AO','0024','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(11,'ANTIGUA AND BARBUDA','AG','0028','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(12,'AZERBAIJAN','AZ','0031','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(13,'ARGENTINA','AR','0032','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(14,'AUSTRALIA','AU','0036','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(15,'AUSTRIA','AT','0040','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(16,'BAHAMAS','BS','0044','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(17,'BAHRAIN','BH','0048','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(18,'BANGLADESH','BD','0050','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(19,'ARMENIA','AM','0051','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(20,'BARBADOS','BB','0052','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(21,'BELGIUM','BE','0056','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(22,'BHUTAN','BT','0064','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(23,'BOLIVIA','BO','0068','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(24,'BOSNIA AND HERZEGOVINA','BA','0070','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(25,'BOTSWANA','BW','0072','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(26,'BRAZIL','BR','0076','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(27,'BELIZE','BZ','0084','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(28,'SOLOMON ISLANDS','SB','0090','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(29,'BRUNEI DARUSSALAM','BN','0096','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(30,'BULGARIA','BG','0100','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(31,'BURMA','BU','0104','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(32,'MYANMAR','MM','0104','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(33,'BURUNDI','BI','0108','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(34,'BELARUS','BY','0112','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(35,'CAMBODIA','KH','0116','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(36,'CAMEROON','CM','0120','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(37,'CANADA','CA','0124','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(38,'CAPE VERDE','CV','0132','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(39,'CENTRAL AFRICAN REPUBLIC','CF','0140','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(40,'SRI LANKA','LK','0144','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(41,'CHAD','TD','0148','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(42,'CHILE','CL','0152','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(43,'CHINA','CN','0156','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(44,'TAIWAN, PROVINCE OF CHINA','TW','0158','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(45,'COLOMBIA','CO','0170','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(46,'COMOROS','KM','0174','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(47,'CONGO','CG','0178','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(48,'ZAIRE','ZR','0180','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(49,'CONGO, THE DEMOCRATIC REPUBLIC OF THE','CD','0180','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(50,'COSTA RICA','CR','0188','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(51,'CROATIA','HR','0191','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(52,'CUBA','CU','0192','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(53,'CYPRUS','CY','0196','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(54,'CZECHOSLOVAKIA','CS','0200','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(55,'CZECH REPUBLIC','CZ','0203','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(56,'BENIN','BJ','0204','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(57,'DENMARK','DK','0208','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(58,'DOMINICA','DM','0212','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(59,'DOMINICAN REPUBLIC','DO','0214','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(60,'ECUADOR','EC','0218','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(61,'EL SALVADOR','SV','0222','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(62,'EQUATORIAL GUINEA','GQ','0226','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(63,'ETHIOPIA','ET','0230','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(64,'ETHIOPIA','ET','0231','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(65,'ERITREA','ER','0232','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(66,'ESTONIA','EE','0233','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(67,'FIJI','FJ','0242','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(68,'FINLAND','FI','0246','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(69,'FRANCE','FR','0250','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(70,'FRENCH POLYNESIA','PF','0258','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(71,'DJIBOUTI','DJ','0262','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(72,'GABON','GA','0266','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(73,'GEORGIA','GE','0268','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(74,'GAMBIA','GM','0270','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(75,'GERMANY','DE','0276','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(76,'GERMAN DEMOCRATIC REPUBLIC','DD','0278','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(77,'GERMANY','DE','0280','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(78,'GHANA','GH','0288','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(79,'KIRIBATI','KI','0296','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(80,'GREECE','GR','0300','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(81,'GRENADA','GD','0308','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(82,'GUATEMALA','GT','0320','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(83,'GUINEA','GN','0324','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(84,'GUYANA','GY','0328','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(85,'HAITI','HT','0332','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(86,'HOLY SEE (VATICAN CITY STATE)','VA','0336','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(87,'HONDURAS','HN','0340','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(88,'HONG KONG','HK','0344','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(89,'HUNGARY','HU','0348','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(90,'ICELAND','IS','0352','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(91,'INDIA','IN','0356','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(92,'INDONESIA','ID','0360','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(93,'IRAN, ISLAMIC REPUBLIC OF','IR','0364','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(94,'IRAQ','IQ','0368','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(95,'IRELAND','IE','0372','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(96,'ISRAEL','IL','0376','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(97,'ITALY','IT','0380','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(98,'COTE D\'IVOIRE','CI','0384','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(99,'JAMAICA','JM','0388','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(100,'JAPAN','JP','0392','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(101,'KAZAKSTAN','KZ','0398','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(102,'JORDAN','JO','0400','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(103,'KENYA','KE','0404','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(104,'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF','KP','0408','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(105,'KOREA, REPUBLIC OF','KR','0410','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(106,'KUWAIT','KW','0414','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(107,'KYRGYZSTAN','KG','0417','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(108,'LAO PEOPLE\'S DEMOCRATIC REPUBLIC','LA','0418','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(109,'LEBANON','LB','0422','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(110,'LESOTHO','LS','0426','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(111,'LATVIA','LV','0428','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(112,'LIBERIA','LR','0430','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(113,'LIBYAN ARAB JAMAHIRIYA','LY','0434','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(114,'LIECHTENSTEIN','LI','0438','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(115,'LITHUANIA','LT','0440','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(116,'LUXEMBOURG','LU','0442','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(117,'MADAGASCAR','MG','0450','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(118,'MALAWI','MW','0454','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(119,'MALAYSIA','MY','0458','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(120,'MALDIVES','MV','0462','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(121,'MALI','ML','0466','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(122,'MALTA','MT','0470','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(123,'MAURITANIA','MR','0478','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(124,'MAURITIUS','MU','0480','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(125,'MEXICO','MX','0484','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(126,'MONACO','MC','0492','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(127,'MONGOLIA','MN','0496','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(128,'MOLDOVA, REPUBLIC OF','MD','0498','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(129,'MOROCCO','MA','0504','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(130,'MOZAMBIQUE','MZ','0508','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(131,'OMAN','OM','0512','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(132,'NAMIBIA','NA','0516','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(133,'NAURU','NR','0520','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(135,'NETHERLANDS','NL','0528','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(136,'VANUATU','VU','0548','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(137,'NEW ZEALAND','NZ','0554','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(138,'NICARAGUA','NI','0558','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(139,'NIGER','NE','0562','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(140,'NIGERIA','NG','0566','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(141,'NORWAY','NO','0578','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(142,'MICRONESIA, FEDERATED STATES OF','FM','0583','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(143,'MARSHALL ISLANDS','MH','0584','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(144,'PALAU','PW','0585','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(145,'PAKISTAN','PK','0586','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(146,'PANAMA','PA','0591','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(147,'PAPUA NEW GUINEA','PG','0598','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(148,'PARAGUAY','PY','0600','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(149,'PERU','PE','0604','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(150,'PHILIPPINES','PH','0608','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(151,'POLAND','PL','0616','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(152,'PORTUGAL','PT','0620','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(153,'GUINEA-BISSAU','GW','0624','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(154,'PUERTO RICO','PR','0630','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(155,'QATAR','QA','0634','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(156,'ROMANIA','RO','0642','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(157,'RUSSIAN FEDERATION','RU','0643','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(158,'RWANDA','RW','0646','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(159,'SAINT KITTS AND NEVIS','KN','0659','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(160,'SAINT LUCIA','LC','0662','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(161,'SAINT VINCENT AND THE GRENADINES','VC','0670','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(162,'SAN MARINO','SM','0674','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(163,'SAO TOME AND PRINCIPE','ST','0678','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(164,'SAUDI ARABIA','SA','0682','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(165,'SENEGAL','SN','0686','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(166,'SEYCHELLES','SC','0690','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(167,'SIERRA LEONE','SL','0694','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(168,'SINGAPORE','SG','0702','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(169,'SLOVAKIA','SK','0703','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(170,'VIET NAM','VN','0704','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(171,'SLOVENIA','SI','0705','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(172,'SOMALIA','SO','0706','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(173,'SOUTH AFRICA','ZA','0710','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(174,'ZIMBABWE','ZW','0716','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(175,'YEMEN, DEMOCRATIC','YD','0720','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(176,'SPAIN','ES','0724','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(177,'WESTERN SAHARA','EH','0732','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(178,'SUDAN','SD','0736','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(179,'SURINAME','SR','0740','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(180,'SWAZILAND','SZ','0748','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(181,'SWEDEN','SE','0752','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(182,'SWITZERLAND','CH','0756','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(183,'SYRIAN ARAB REPUBLIC','SY','0760','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(184,'TAJIKISTAN','TJ','0762','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(185,'THAILAND','TH','0764','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(186,'TOGO','TG','0768','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(187,'TONGA','TO','0776','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(188,'TRINIDAD AND TOBAGO','TT','0780','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(189,'UNITED ARAB EMIRATES','AE','0784','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(190,'TUNISIA','TN','0788','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(191,'TURKEY','TR','0792','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(192,'TURKMENISTAN','TM','0795','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(193,'TUVALU','TV','0798','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(194,'UGANDA','UG','0800','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(195,'UKRAINE','UA','0804','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(196,'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF','MK','0807','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(197,'USSR','SU','0810','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(198,'EGYPT','EG','0818','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(199,'UNITED KINGDOM','GB','0826','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(200,'TANZANIA, UNITED REPUBLIC OF','TZ','0834','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(201,'UNITED STATES','US','0840','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(202,'BURKINA FASO','BF','0854','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(203,'URUGUAY','UY','0858','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(204,'UZBEKISTAN','UZ','0860','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(205,'VENEZUELA','VE','0862','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(206,'SAMOA','WS','0882','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(207,'YEMEN (0886)','YE','0886','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(208,'YEMEN (0887)','YE','0887','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(209,'YUGOSLAVIA (0890)','YU','0890','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(210,'YUGOSLAVIA (0891)','YU','0891','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(211,'ZAMBIA','ZM','0894','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(212,'AFRICA','2AF','2100','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(213,'AMERICA','2AM','2101','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(214,'AMERICAN CONTINENT','2AC','2102','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(215,'ANTILLES','2AN','2103','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(216,'APEC COUNTRIES','2AP','2104','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(217,'ASEAN COUNTRIES','2AE','2105','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(218,'ASIA','2AS','2106','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(219,'AUSTRALASIA','2AA','2107','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(220,'BALKANS','2BA','2108','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(221,'BALTIC STATES','2BS','2109','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(222,'BENELUX','2BE','2110','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(223,'BRITISH ISLES','2BI','2111','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(224,'BRITISH WEST INDIES','2BW','2112','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(225,'CENTRAL AMERICA','2CA','2113','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(226,'COMMONWEALTH','2CO','2114','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(227,'COMMONWEALTH AFRICAN TERRITORIES','2CF','2115','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(228,'COMMONWEALTH ASIAN TERRITORIES','2CS','2116','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(229,'COMMONWEALTH AUSTRALASIAN TERRITORIES','2CU','2117','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(230,'COMMONWEALTH OF INDEPENDENT STATES','2CI','2118','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(231,'EASTERN EUROPE','2EE','2119','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(232,'EUROPE','2EU','2120','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(233,'EUROPEAN ECONOMIC AREA','2EM','2121','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(234,'EUROPEAN CONTINENT','2EC','2122','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(235,'EUROPEAN ECONOMIC COMMUNITY','2EY','2123','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(236,'EUROPEAN UNION','2EN','2123','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(237,'GSA COUNTRIES','2GC','2124','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(238,'MIDDLE EAST','2ME','2125','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(239,'NAFTA COUNTRIES','2NT','2126','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(240,'NORDIC COUNTRIES','2NC','2127','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(241,'NORTH AFRICA','2NF','2128','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(242,'NORTH AMERICA','2NA','2129','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(243,'OCEANIA','2OC','2130','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(244,'SCANDINAVIA','2SC','2131','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(245,'SOUTH AMERICA','2SA','2132','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(246,'SOUTH EAST ASIA','2SE','2133','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(247,'WEST INDIES','2WI','2134','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(248,'WORLD','2WL','2136','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(249,'WEST AFRICA REGION','WAR','WA','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(250,'CENTRAL AFRICA REGION','CAR','CA','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(251,'EAST AFRICA REGION','EAR','EA','1','2015-06-02 11:58:36','0000-00-00 00:00:00'),(252,'SOUTH AFRICA REGION','SAR','SA','1','2015-06-02 11:58:36','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_currency` */

DROP TABLE IF EXISTS `wipo_master_currency`;

CREATE TABLE `wipo_master_currency` (
  `Master_Crncy_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Currency_Code` varchar(10) DEFAULT NULL,
  `Currency_Name` varchar(50) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Crncy_Id`),
  UNIQUE KEY `Master_Crncy_Id` (`Master_Crncy_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_currency` */

insert  into `wipo_master_currency`(`Master_Crncy_Id`,`Currency_Code`,`Currency_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'US','Dollar','1','2015-03-29 03:10:18','0000-00-00 00:00:00'),(2,'EUR','Euro','1','2015-03-29 03:10:28','0000-00-00 00:00:00'),(3,'INR','Rupee','1','2015-03-29 03:10:34','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_destination` */

DROP TABLE IF EXISTS `wipo_master_destination`;

CREATE TABLE `wipo_master_destination` (
  `Master_Dist_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Dist_Name` varchar(100) NOT NULL,
  `Dist_Code` varchar(50) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Master_Dist_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_destination` */

insert  into `wipo_master_destination`(`Master_Dist_Id`,`Dist_Name`,`Dist_Code`,`Active`,`Created_Date`,`Rowversion`,`Created_By`,`Updated_By`) values (1,'Test Destination','TD','1','2015-07-14 17:57:10','0000-00-00 00:00:00',NULL,NULL);

/*Table structure for table `wipo_master_document` */

DROP TABLE IF EXISTS `wipo_master_document`;

CREATE TABLE `wipo_master_document` (
  `Master_Doc_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Doc_Code` varchar(10) DEFAULT NULL,
  `Doc_Name` varchar(90) NOT NULL COMMENT 'Document Name:',
  `Doc_Comment` varchar(90) NOT NULL COMMENT 'Document Comment:',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Doc_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_document` */

insert  into `wipo_master_document`(`Master_Doc_Id`,`Doc_Code`,`Doc_Name`,`Doc_Comment`,`Active`,`Created_Date`,`Rowversion`) values (1,'CUE','CUE-SHEET (AUDIOVISUAL MUSICAL WORKS DOC)','CUE-SHEET (AUDIOVISUAL MUSICAL WORKS DOC)','1','2015-03-16 03:59:26','0000-00-00 00:00:00'),(2,'INT','INTERNATIONAL DOCUMENTATION (FI, ETC.)','INTERNATIONAL DOCUMENTATION (FI, ETC.)','1','2015-03-16 03:59:38','0000-00-00 00:00:00'),(3,'WDF','WORK DECLARATION FORM','WORK DECLARATION FORM','1','2015-04-11 09:14:04','0000-00-00 00:00:00'),(6,'COM','LETTERS AND OTHER COMMUNICATIONS','','1','2015-06-02 11:08:35','0000-00-00 00:00:00'),(8,'WID','WID DECLARATION','','1','2015-06-02 11:08:35','0000-00-00 00:00:00'),(9,'RDF','RECORDING DECLARATION FORM','','1','2015-06-02 11:08:35','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_document_status` */

DROP TABLE IF EXISTS `wipo_master_document_status`;

CREATE TABLE `wipo_master_document_status` (
  `Master_Document_Sts_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id:',
  `Document_Sts_Code` char(1) NOT NULL COMMENT 'Code:',
  `Document_Sts_Name` varchar(50) NOT NULL COMMENT 'Name:',
  `Document_Sts_Comment` text COMMENT 'Comment:',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Document_Sts_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_document_status` */

insert  into `wipo_master_document_status`(`Master_Document_Sts_Id`,`Document_Sts_Code`,`Document_Sts_Name`,`Document_Sts_Comment`,`Active`,`Created_Date`,`Rowversion`) values (1,'N','Declared','Declared work','1','2015-03-16 20:40:40','0000-00-00 00:00:00'),(2,'I','Work documented','work documented in an international file','1','2015-03-16 20:41:14','0000-00-00 00:00:00'),(3,'U','Undeclared national work','undeclared national work; the author has been invited to declare it','1','2015-03-16 20:41:34','0000-00-00 00:00:00'),(4,'V','Undocumented foreign work','undocumented foreign work which has been identified by the name of its author and for which the fees have been paid on the basis of the CISAC “Warsaw Rule”;','1','2015-03-16 20:41:56','0000-00-00 00:00:00'),(5,'W','Foreign work','foreign work for which the data have been transferred from the WWL or WID documentation','1','2015-03-16 20:42:16','0000-00-00 00:00:00'),(6,'Q','Unidentified work','unidentified work which has been entered in an inquiry list according to the CISAC rules','1','2015-03-16 20:42:30','0000-00-00 00:00:00'),(7,'X','Non-identified work','non-identified work which appeared in a statement of works performed, broadcast or reproduced','1','2015-03-16 20:42:43','0000-00-00 00:00:00'),(8,'Y','Worldwide non documented work','Worldwide non documented work (WID,WWL)','1','2015-03-16 20:43:01','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_document_type` */

DROP TABLE IF EXISTS `wipo_master_document_type`;

CREATE TABLE `wipo_master_document_type` (
  `Master_Doc_Type_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Doc_Type_Name` varchar(90) NOT NULL COMMENT 'Type:',
  `Doc_Type_Comment` varchar(255) NOT NULL COMMENT 'Comments:',
  `Doc_Type_Status_Id` int(11) NOT NULL COMMENT 'Status:',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Doc_Type_Id`),
  KEY `Doc_Type_Status` (`Doc_Type_Status_Id`),
  CONSTRAINT `FK_wipo_master_document_type` FOREIGN KEY (`Doc_Type_Status_Id`) REFERENCES `wipo_master_document_status` (`Master_Document_Sts_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_document_type` */

insert  into `wipo_master_document_type`(`Master_Doc_Type_Id`,`Doc_Type_Name`,`Doc_Type_Comment`,`Doc_Type_Status_Id`,`Active`,`Created_Date`,`Rowversion`) values (1,'Declared','Declared',1,'1','2015-03-16 20:49:32','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_event_type` */

DROP TABLE IF EXISTS `wipo_master_event_type`;

CREATE TABLE `wipo_master_event_type` (
  `Master_Evt_Type_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Event Type ID:',
  `Evt_Type_Name` varchar(45) NOT NULL COMMENT 'Event Type Name:',
  `Evt_Type_Comment` varchar(500) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Evt_Type_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_event_type` */

insert  into `wipo_master_event_type`(`Master_Evt_Type_Id`,`Evt_Type_Name`,`Evt_Type_Comment`,`Active`,`Created_Date`,`Rowversion`) values (1,'Close','Establishment Closes','1','2015-03-16 04:08:13','0000-00-00 00:00:00'),(2,'Stop','Establishment Stop using the protected works ','1','2015-03-16 04:08:30','0000-00-00 00:00:00'),(3,'Terminate','Establishment Terminates the Contract','1','2015-03-16 04:08:39','0000-00-00 00:00:00'),(4,'Transfer','Establishment Transfers to other owner','1','2015-03-16 04:08:48','0000-00-00 00:00:00'),(5,'Other','Other types','1','2015-03-16 04:08:58','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_factor` */

DROP TABLE IF EXISTS `wipo_master_factor`;

CREATE TABLE `wipo_master_factor` (
  `Master_Factor_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Factor` decimal(10,2) NOT NULL,
  `Factor_Name` varchar(100) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Factor_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_factor` */

insert  into `wipo_master_factor`(`Master_Factor_Id`,`Factor`,`Factor_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'2.00',NULL,'1','2015-05-31 13:01:14','0000-00-00 00:00:00'),(2,'3.00',NULL,'1','2015-05-31 13:01:14','0000-00-00 00:00:00'),(3,'4.00',NULL,'1','2015-05-31 13:01:14','0000-00-00 00:00:00'),(4,'5.00',NULL,'1','2015-05-31 13:01:14','0000-00-00 00:00:00'),(5,'1.00','UNKNOWN WORKS/RECORDINGS','1','2015-05-31 13:01:14','0000-00-00 00:00:00'),(6,'0.16','JINGLES','0','2015-05-31 13:01:14','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_hierarchy` */

DROP TABLE IF EXISTS `wipo_master_hierarchy`;

CREATE TABLE `wipo_master_hierarchy` (
  `Master_Hierarchy_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Hierarchy_Name` varchar(100) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Hierarchy_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_hierarchy` */

insert  into `wipo_master_hierarchy`(`Master_Hierarchy_Id`,`Hierarchy_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'Full member','1','2015-04-02 00:41:25','0000-00-00 00:00:00'),(2,'Candidate Member','1','2015-04-02 00:46:07','0000-00-00 00:00:00'),(3,'Honorary Member','1','2015-04-02 00:50:28','0000-00-00 00:00:00'),(4,'Associate Member','1','2015-04-11 09:11:15','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_instrument` */

DROP TABLE IF EXISTS `wipo_master_instrument`;

CREATE TABLE `wipo_master_instrument` (
  `Master_Inst_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Instrument_Code` varchar(50) NOT NULL,
  `Instrument_Name` varchar(255) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Inst_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_instrument` */

insert  into `wipo_master_instrument`(`Master_Inst_Id`,`Instrument_Code`,`Instrument_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'ACC','Accordion','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(2,'ALP','Alp Horn','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(3,'ACL','Alto Carinet','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(4,'AFL','Alto flute','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(5,'AHN','Alto Horn','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(6,'ARC','Alto Recorder','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(7,'ASX','Alto Saxophone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(8,'ALT','Alto Voice','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(9,'AMP','Amplifier','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(10,'BAG','Bagpipes','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(11,'BKA','Balalaika','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(12,'BBF','Bamboo Flute','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(13,'BDN','Bandoneon','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(14,'BNJ','Banjo','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(15,'BAR','Baritone Horn','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(16,'BSX','Baritone Saxophone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(17,'BTN','Baritone Voice','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(18,'BQF','Baroque Flute','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(19,'BBT','Bass Baritone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(20,'BCL','Bass Clarinet','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(21,'BDR','Bass Drum','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(22,'BFT','Bass Flute','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(23,'BGT','Bass Guitar','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(24,'BOB','Bass Oboe','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(25,'BRC','Bass Recorder','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(26,'BSP','Bass Saxophone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(27,'BRT','Bass Trombone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(28,'BSS','Bass Voice','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(29,'BHN','Basset Horn','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(30,'BSN','Bassoon','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(31,'BEL','Bells','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(32,'BNG','Bongos','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(33,'BOY','Boy Soprano','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(34,'BGL','Bugle','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(35,'CAR','Carillon','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(36,'CST','Castanets','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(37,'CEL','Celesta','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(38,'CHM','Chimes','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(39,'CIM','Cimbalom','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(40,'CLR','Clarinet','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(41,'CVD','Clavichord','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(42,'COM','Computer','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(43,'CNB','Concertina','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(44,'CNG','Congas','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(45,'CBN','Contra Bassoon','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(46,'CBC','Contrabass Clarinet','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(47,'CCL','Contralto Clarinet','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(48,'CAL','Contralto Voice','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(49,'CNT','Cornet','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(50,'CTN','Countertenor Voice','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(51,'CYM','Cymbals','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(52,'DIJ','Didjeridu','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(53,'DIZ','Dizi/D\'Tzu','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(54,'DJM','Djembe','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(55,'BASDBS','Double Bass','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(56,'DRM','Drum','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(57,'DRK','Drum Kit/Drum Set','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(58,'DUL','Dulcimer','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(59,'EFC','E-Flat Clarinet','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(60,'EBG','Electric Bass Guitar','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(61,'EGT','Electric Guitar','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(62,'EOG','Electronic Organ','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(63,'ELL','Electronics, Live','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(64,'ELP','Electronics, Pre-recorded','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(65,'EHN','English Horn','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(66,'ERH','Erhu','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(67,'EUP','Euphonium','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(68,'FLG','Flugelhorn','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(69,'FLT','Flute','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(70,'FRN','French Horn','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(71,'GHM','Glass Harmonica','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(72,'GHP','Glass  Harp','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(73,'GLS','Glockenspiel','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(74,'GNG','Gong','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(75,'GTR','Guitar','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(76,'HBL','Handbells','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(77,'HAR','Harmonica','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(78,'HRM','Harmonium','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(79,'HRP','Harp','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(80,'HPS','Harpsichord','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(81,'HCK','Heckelphone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(82,'HRN','Horn','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(83,'HUR','Hurdy-Gurdy','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(84,'KAZ','Kazoo','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(85,'KEY','Keyboard','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(86,'KLV','Klavier','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(87,'KOT','Koto','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(88,'LUT','Lute','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(89,'LYR','Lyre','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(90,'MAN','Mandolin','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(91,'MCS','Maracas','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(92,'MAR','Marimba','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(93,'MBR','Mbira','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(94,'MEL','Melodica','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(95,'MEZ','Mezzo Soprano Voice','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(96,'MID','Midi','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(97,'MSB','Music Box','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(98,'NAR','Narrator/Speaker','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(99,'NAF','Native American Flute','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(100,'NHN','Natural Horn','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(101,'OBO','Oboe','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(102,'OBD','Oboe d\'Amore','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(103,'OND','Ondes Martinot','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(104,'ORG','Organ','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(105,'PWH','Pennywhistle','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(106,'PER','Percussion','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(107,'PIA','Piano','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(108,'PIC','Piccolo','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(109,'PPA','Pipa','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(110,'PRP','Prepared Piano','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(111,'PRO','Processor','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(112,'REC','Recorder','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(113,'RUA','Ruan','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(114,'SAM','Sampler','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(115,'SAX','Saxophone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(116,'SEQ','Sequencer','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(117,'SHK','Shakuhachi','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(118,'SHM','Shamisen','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(119,'SHW','Shawm','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(120,'SHO','Sho','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(121,'SIT','Sitar','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(122,'SDM','Snare Drum','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(123,'SNR','Sopranino Recorder','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(124,'SNS','Sopranino Saxophone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(125,'SRC','Soprano Recorder','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(126,'SSX','Soprano Saxophone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(127,'SOP','Soprano Voice','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(128,'SOU','Sousaphone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(129,'SPO','Spoons','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(130,'STD','Steel Drums','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(131,'SYN','Synthesizer','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(132,'TAB','Tabla','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(133,'TAM','Tambour','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(134,'TMN','Tambourine','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(135,'TTM','TAMTAM','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(136,'TAP','Tape','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(137,'THN','Tenor Horn','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(138,'TRC','Tenor Recorder','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(139,'TSX','Tenor Saxophone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(140,'TEN','Tenor Voice','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(141,'THE','Theremin','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(142,'TIM','Timpani','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(143,'TYP','Toy Piano','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(144,'TRI','Triangle','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(145,'TMB','Trombone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(146,'TRM','Trumpet','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(147,'TBA','Tuba','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(148,'UKE','Ukelele','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(149,'VIB','Vibraphone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(150,'VID','Video','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(151,'VLA','Viola','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(152,'VDG','Viola Da Gamba','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(153,'VLN','Violin','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(154,'VCL','Violoncello','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(155,'VOC','Voice','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(156,'WTB','Wagner Tuba','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(157,'WHS','Whistle','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(158,'WBK','Wood block','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(159,'XYL','Xylophone','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(160,'YQN','Yang Quin','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(161,'ZHG','Zheng','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(162,'ZIT','Zither','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(163,'KEY','KEYBOARD','1','2015-05-31 13:05:03','0000-00-00 00:00:00'),(164,'ORGAN','ORGAN','1','2015-05-31 13:05:03','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_internal_position` */

DROP TABLE IF EXISTS `wipo_master_internal_position`;

CREATE TABLE `wipo_master_internal_position` (
  `Master_Int_Post_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Int_Post_Code` varchar(10) DEFAULT NULL,
  `Int_Post_Name` varchar(90) NOT NULL COMMENT 'Internal position:',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Int_Post_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_internal_position` */

insert  into `wipo_master_internal_position`(`Master_Int_Post_Id`,`Int_Post_Code`,`Int_Post_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'FM','Full member','1','2015-03-16 03:53:51','0000-00-00 00:00:00'),(3,'HM','Honorary Member','1','2015-04-11 09:27:12','0000-00-00 00:00:00'),(4,'PM','Provisional Member','1','2015-06-02 11:35:15','0000-00-00 00:00:00'),(6,'CM','Candidate Member','1','2015-06-02 11:35:15','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_international_number` */

DROP TABLE IF EXISTS `wipo_master_international_number`;

CREATE TABLE `wipo_master_international_number` (
  `Master_International_Id` int(11) NOT NULL AUTO_INCREMENT,
  `International_Number_Type` varchar(100) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_International_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_international_number` */

insert  into `wipo_master_international_number`(`Master_International_Id`,`International_Number_Type`,`Active`,`Created_Date`,`Rowversion`) values (1,'IPI','1','2015-04-02 01:43:25','0000-00-00 00:00:00'),(2,'AV Index','1','2015-04-02 01:43:34','0000-00-00 00:00:00'),(3,'ISAN','1','2015-04-02 01:43:42','0000-00-00 00:00:00'),(4,'ISRC','1','2015-04-02 01:43:52','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_label` */

DROP TABLE IF EXISTS `wipo_master_label`;

CREATE TABLE `wipo_master_label` (
  `Master_Label_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Label_Code` varchar(50) NOT NULL,
  `Label_Name` varchar(100) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Label_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_label` */

insert  into `wipo_master_label`(`Master_Label_Id`,`Label_Code`,`Label_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'NL','No Label','1','2015-05-10 16:10:05','0000-00-00 00:00:00'),(2,'SNY','Sony','1','2015-06-02 06:54:24','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_language` */

DROP TABLE IF EXISTS `wipo_master_language`;

CREATE TABLE `wipo_master_language` (
  `Master_Lang_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Lang_Code` varchar(10) DEFAULT NULL,
  `Lang_Name` varchar(45) NOT NULL COMMENT 'Language:',
  `Active` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Status:',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Lang_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_language` */

insert  into `wipo_master_language`(`Master_Lang_Id`,`Lang_Code`,`Lang_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'EN','English','1','2015-03-16 03:41:49','0000-00-00 00:00:00'),(5,'NE','Nepalese','1','2015-04-11 08:58:57','0000-00-00 00:00:00'),(9,'FR','French','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(11,'ES','Spanish','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(12,'DE','German','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(13,'RU','Russian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(14,'OA','(Afan) Oromo','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(15,'AB','Abkhasian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(16,'AA','Afar','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(17,'AF','Afrikaans','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(18,'SQ','Albanian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(19,'AM','Amharic','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(20,'AR','Arabic','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(21,'HY','Armenian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(22,'AS','Assamese','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(23,'AY','Aymara','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(24,'AZ','Azerbaijani','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(25,'BA','Bashkir','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(26,'EU','Basque','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(27,'BN','Bengali;Bangla','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(28,'DZ','Bhutani','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(29,'BH','Bihari','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(30,'BI','Bislama','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(31,'BR','Breton','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(32,'BG','Bulgarian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(33,'MY','Burmese','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(34,'BE','Byelorussian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(35,'KM','Cambodian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(36,'CA','Catalan','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(37,'ZH','Chinese','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(38,'CO','Corsican','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(39,'HR','Croatian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(40,'CS','Czech','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(41,'DA','Danish','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(42,'NL','Dutch','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(43,'EO','Esperanto','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(44,'ET','Estonian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(45,'FO','Faeroese','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(46,'FA','Farsi','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(47,'FJ','Fiji','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(48,'FI','Finnish','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(49,'FY','Frisian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(50,'GL','Galician','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(51,'KA','Georgian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(52,'EL','Greek','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(53,'KL','Greenlandic','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(54,'GN','Guarani','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(55,'GU','Gujarati','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(56,'HA','Hausa','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(57,'HW','Hawaii','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(58,'IW','Hebrew','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(59,'HI','Hindi','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(60,'HU','Hungarian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(61,'IS','Icelandic','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(62,'IN','Indonesian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(63,'IA','Interlingua','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(64,'IE','Interlingue','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(65,'IK','Inupiak','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(66,'GA','Irish','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(67,'IT','Italian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(68,'JA','Japanese','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(69,'JW','Javanese','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(70,'KN','Kannada','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(71,'KS','Kashmiri','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(72,'KK','Kazakh','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(73,'RW','Kinyarwanda','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(74,'KY','Kirghiz','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(75,'RN','Kirundi','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(76,'KO','Korean','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(77,'KU','Kurdish','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(78,'LO','Laothian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(79,'LA','Latin','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(80,'LV','Latvian;Lettish','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(81,'LN','Lingala','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(82,'LT','Lithuanian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(83,'MK','Macedonian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(84,'MG','Malagasy','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(85,'MS','Malay','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(86,'ML','Malayalam','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(87,'MT','Maltese','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(88,'MI','Maori','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(89,'MR','Marathi','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(90,'MO','Moldavian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(91,'MN','Mongolian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(92,'NA','Nauru','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(94,'NO','Norwegian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(95,'OC','Occitan','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(96,'OR','Oriya','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(97,'OM','Oromo','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(98,'PM','Papiamento','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(99,'PS','Pashto;Pushto','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(100,'FA','Persian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(101,'PL','Polish','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(102,'PT','Portuguese','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(103,'PA','Punjabi','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(104,'QU','Quechua','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(105,'RM','Rhaeto-Romance','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(106,'RO','Romanian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(107,'SM','Samoan','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(108,'SG','Sangro','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(109,'SA','Sanskrit','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(110,'GD','Scots Gaelic','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(111,'SR','Serbian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(112,'SH','Serbo-Croatian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(113,'ST','Sesotho','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(114,'TN','Setswana','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(115,'SN','Shona','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(116,'SD','Sindhi','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(117,'SI','Singhalese','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(118,'SS','Siswati','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(119,'SK','Slovak','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(120,'SL','Slovenian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(121,'SO','Somali','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(122,'SU','Sundanese','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(123,'SW','Swahili','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(124,'SV','Swedish','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(125,'TL','Tagalog','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(126,'TG','Tajik','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(127,'TA','Tamil','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(128,'TT','Tatar','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(129,'TE','Tegulu','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(130,'TH','Thai','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(131,'BO','Tibetan','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(132,'TI','Tigrinya','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(133,'TO','Tonga','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(134,'TS','Tsonga','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(135,'TR','Turkish','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(136,'TK','Turkmen','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(137,'TW','Twi','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(138,'UK','Ukrainian','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(139,'UR','Urdu','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(140,'UZ','Uzbek','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(141,'VI','Vietnamese','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(142,'VO','Volapuk','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(143,'CY','Welsh','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(144,'WO','Wolof','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(145,'XH','Xhosa','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(146,'JI','Yiddish','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(147,'YO','Yoruba','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(148,'ZU','Zulu','1','2015-05-31 14:06:06','0000-00-00 00:00:00'),(151,'TE','asdasd','1','2015-07-18 13:52:29','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_legal_form` */

DROP TABLE IF EXISTS `wipo_master_legal_form`;

CREATE TABLE `wipo_master_legal_form` (
  `Master_Legal_Form_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Legal_Form_Name` varchar(90) NOT NULL COMMENT 'Legal Form:',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Legal_Form_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_legal_form` */

insert  into `wipo_master_legal_form`(`Master_Legal_Form_Id`,`Legal_Form_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'Limited company','1','2015-03-16 03:54:02','0000-00-00 00:00:00'),(2,'Partnership','1','2015-03-16 03:54:10','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_managed_rights` */

DROP TABLE IF EXISTS `wipo_master_managed_rights`;

CREATE TABLE `wipo_master_managed_rights` (
  `Master_Mgd_Rights_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Mgd_Rights_Name` varchar(90) NOT NULL COMMENT 'Managed rights:',
  `Mgd_Rights_Rank` smallint(6) DEFAULT '0',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Mgd_Rights_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_managed_rights` */

insert  into `wipo_master_managed_rights`(`Master_Mgd_Rights_Id`,`Mgd_Rights_Name`,`Mgd_Rights_Rank`,`Active`,`Created_Date`,`Rowversion`) values (1,'All rights',10,'1','2015-03-16 03:52:15','0000-00-00 00:00:00'),(2,'Exclusive rights',10,'1','2015-03-16 03:52:27','0000-00-00 00:00:00'),(3,'Equitable Remuneration',5,'0','2015-03-16 03:52:41','0000-00-00 00:00:00'),(4,'Neighboring Rights',10,'1','2015-03-16 03:52:54','0000-00-00 00:00:00'),(5,'Retransmission Right',11,'1','2015-06-29 19:17:05','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_manufacturer` */

DROP TABLE IF EXISTS `wipo_master_manufacturer`;

CREATE TABLE `wipo_master_manufacturer` (
  `Master_Manf_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Manf_Code` varchar(50) DEFAULT NULL,
  `Manf_Name` varchar(100) NOT NULL,
  `Manf_Description` text,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Manf_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_manufacturer` */

insert  into `wipo_master_manufacturer`(`Master_Manf_Id`,`Manf_Code`,`Manf_Name`,`Manf_Description`,`Active`,`Created_Date`,`Rowversion`) values (1,NULL,'Manufacturer 1','Manufacturer onee','1','2015-07-04 15:31:39','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_marital_status` */

DROP TABLE IF EXISTS `wipo_master_marital_status`;

CREATE TABLE `wipo_master_marital_status` (
  `Master_Marital_State_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Marital_Code` varchar(10) DEFAULT NULL,
  `Marital_State` varchar(100) NOT NULL COMMENT 'Marital Status:',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Marital_State_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_marital_status` */

insert  into `wipo_master_marital_status`(`Master_Marital_State_Id`,`Marital_Code`,`Marital_State`,`Active`,`Created_Date`,`Rowversion`) values (1,'SIN','SINGLE','1','2015-03-28 02:56:21','0000-00-00 00:00:00'),(2,'DIV','DIVORCED','1','2015-06-02 11:29:37','0000-00-00 00:00:00'),(3,'LTD','LIMITED ','0','2015-06-02 11:29:37','0000-00-00 00:00:00'),(4,'MAR','MARRIED','1','2015-06-02 11:29:37','0000-00-00 00:00:00'),(5,'PAT','PARTERNER','0','2015-06-02 11:29:37','0000-00-00 00:00:00'),(6,'REL','RELIGIOUS','1','2015-06-02 11:29:37','0000-00-00 00:00:00'),(7,'WID','WIDOWED','1','2015-06-02 11:29:37','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_medium` */

DROP TABLE IF EXISTS `wipo_master_medium`;

CREATE TABLE `wipo_master_medium` (
  `Master_Medium_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Medium_Name` varchar(100) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Master_Medium_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_medium` */

insert  into `wipo_master_medium`(`Master_Medium_Id`,`Medium_Name`,`Active`,`Created_Date`,`Rowversion`,`Created_By`,`Updated_By`) values (1,'CD','1','2015-07-07 15:38:35','0000-00-00 00:00:00',NULL,NULL),(2,'Discs','1','2015-07-07 15:39:21','0000-00-00 00:00:00',1,NULL),(3,'Cassette','1','2015-07-07 15:39:29','0000-00-00 00:00:00',1,NULL);

/*Table structure for table `wipo_master_module` */

DROP TABLE IF EXISTS `wipo_master_module`;

CREATE TABLE `wipo_master_module` (
  `Master_Module_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Module_Code` varchar(45) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Rowversion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Module_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_module` */

insert  into `wipo_master_module`(`Master_Module_ID`,`Module_Code`,`Description`,`Active`,`Created_Date`,`Rowversion`) values (1,'site','Master','1','2015-06-30 17:41:24','0000-00-00 00:00:00'),(2,'site','Administration','1','2015-06-30 15:21:56','0000-00-00 00:00:00'),(3,'site','Documentation','1','2015-06-30 17:40:24','0000-00-00 00:00:00'),(4,'site','Licensing','1','2015-07-22 18:43:50','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_nationality` */

DROP TABLE IF EXISTS `wipo_master_nationality`;

CREATE TABLE `wipo_master_nationality` (
  `Master_Nation_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Nation_Code` varchar(10) DEFAULT NULL,
  `Nation_Name` varchar(90) NOT NULL COMMENT 'Nationality:',
  `Active` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Status:',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Nation_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_nationality` */

insert  into `wipo_master_nationality`(`Master_Nation_Id`,`Nation_Code`,`Nation_Name`,`Active`,`Created_Date`,`Rowversion`) values (2,'NP','NEPAL','1','2015-03-16 03:40:20','0000-00-00 00:00:00'),(4,'MY','MALAYSIA','1','2015-03-16 03:40:35','0000-00-00 00:00:00'),(6,'WL','WORLD','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(7,'AF','AFGHANISTAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(8,'AL','ALBANIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(9,'DZ','ALGERIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(10,'AD','ANDORRA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(11,'AO','ANGOLA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(12,'AG','ANTIGUA AND BARBUDA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(13,'AZ','AZERBAIJAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(14,'AR','ARGENTINA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(15,'AU','AUSTRALIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(16,'AT','AUSTRIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(17,'BS','BAHAMAS','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(18,'BH','BAHRAIN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(19,'BD','BANGLADESH','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(20,'AM','ARMENIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(21,'BB','BARBADOS','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(22,'BE','BELGIUM','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(23,'BT','BHUTAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(24,'BO','BOLIVIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(25,'BA','BOSNIA AND HERZEGOVINA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(26,'BW','BOTSWANA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(27,'BR','BRAZIL','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(28,'BZ','BELIZE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(29,'SB','SOLOMON ISLANDS','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(30,'BN','BRUNEI DARUSSALAM','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(31,'BG','BULGARIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(32,'BU','BURMA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(33,'MM','MYANMAR','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(34,'BI','BURUNDI','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(35,'BY','BELARUS','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(36,'KH','CAMBODIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(37,'CM','CAMEROON','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(38,'CA','CANADA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(39,'CV','CAPE VERDE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(40,'CF','CENTRAL AFRICAN REPUBLIC','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(41,'LK','SRI LANKA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(42,'TD','CHAD','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(43,'CL','CHILE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(44,'CN','CHINA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(45,'TW','TAIWAN, PROVINCE OF CHINA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(46,'CO','COLOMBIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(47,'KM','COMOROS','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(48,'CG','CONGO','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(49,'ZR','ZAIRE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(50,'CD','CONGO, THE DEMOCRATIC REPUBLIC OF THE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(51,'CR','COSTA RICA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(52,'HR','CROATIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(53,'CU','CUBA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(54,'CY','CYPRUS','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(55,'CS','CZECHOSLOVAKIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(56,'CZ','CZECH REPUBLIC','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(57,'BJ','BENIN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(58,'DK','DENMARK','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(59,'DM','DOMINICA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(60,'DO','DOMINICAN REPUBLIC','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(61,'EC','ECUADOR','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(62,'SV','EL SALVADOR','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(63,'GQ','EQUATORIAL GUINEA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(64,'ER','ERITREA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(65,'EE','ESTONIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(66,'FJ','FIJI','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(67,'FI','FINLAND','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(68,'FR','FRANCE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(69,'PF','FRENCH POLYNESIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(70,'DJ','DJIBOUTI','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(71,'GA','GABON','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(72,'GE','GEORGIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(73,'GM','GAMBIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(74,'DE','GERMANY','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(75,'DD','GERMAN DEMOCRATIC REPUBLIC','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(76,'GH','GHANA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(77,'KI','KIRIBATI','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(78,'GR','GREECE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(79,'GD','GRENADA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(80,'GT','GUATEMALA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(81,'GN','GUINEA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(82,'GY','GUYANA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(83,'HT','HAITI','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(84,'VA','HOLY SEE (VATICAN CITY STATE)','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(85,'HN','HONDURAS','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(86,'HK','HONG KONG','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(87,'HU','HUNGARY','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(88,'IS','ICELAND','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(89,'IN','INDIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(90,'ID','INDONESIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(91,'IR','IRAN, ISLAMIC REPUBLIC OF','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(92,'IQ','IRAQ','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(93,'IE','IRELAND','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(94,'IL','ISRAEL','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(95,'IT','ITALY','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(96,'CI','COTE D\'IVOIRE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(97,'JM','JAMAICA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(98,'JP','JAPAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(99,'KZ','KAZAKSTAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(100,'JO','JORDAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(101,'KE','KENYA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(102,'KP','KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(103,'KR','KOREA, REPUBLIC OF','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(104,'KW','KUWAIT','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(105,'KG','KYRGYZSTAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(106,'LA','LAO PEOPLE\'S DEMOCRATIC REPUBLIC','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(107,'LB','LEBANON','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(108,'LS','LESOTHO','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(109,'LV','LATVIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(110,'LR','LIBERIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(111,'LY','LIBYAN ARAB JAMAHIRIYA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(112,'LI','LIECHTENSTEIN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(113,'LT','LITHUANIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(114,'LU','LUXEMBOURG','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(115,'MG','MADAGASCAR','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(116,'MW','MALAWI','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(118,'MV','MALDIVES','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(119,'ML','MALI','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(120,'MT','MALTA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(121,'MR','MAURITANIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(122,'MU','MAURITIUS','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(123,'MX','MEXICO','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(124,'MC','MONACO','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(125,'MN','MONGOLIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(126,'MD','MOLDOVA, REPUBLIC OF','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(127,'MA','MOROCCO','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(128,'MZ','MOCAMBIQUE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(129,'OM','OMAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(130,'NA','NAMIBIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(131,'NR','NAURU','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(133,'NL','NETHERLANDS','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(134,'VU','VANUATU','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(135,'NZ','NEW ZEALAND','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(136,'NI','NICARAGUA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(137,'NE','NIGER','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(138,'NG','NIGERIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(139,'NO','NORWAY','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(140,'FM','MICRONESIA, FEDERATED STATES OF','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(141,'MH','MARSHALL ISLANDS','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(142,'PW','PALAU','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(143,'PK','PAKISTAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(144,'PA','PANAMA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(145,'PG','PAPUA NEW GUINEA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(146,'PY','PARAGUAY','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(147,'PE','PERU','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(148,'PH','PHILIPPINES','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(149,'PL','POLAND','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(150,'PT','PORTUGAL','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(151,'GW','GUINEA-BISSAU','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(152,'PR','PUERTO RICO','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(153,'QA','QATAR','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(154,'RO','ROMANIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(155,'RU','RUSSIAN FEDERATION','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(156,'RW','RWANDA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(157,'KN','SAINT KITTS AND NEVIS','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(158,'LC','SAINT LUCIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(159,'VC','SAINT VINCENT AND THE GRENADINES','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(160,'SM','SAN MARINO','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(161,'ST','SAO TOME AND PRINCIPE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(162,'SA','SAUDI ARABIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(163,'SN','SENEGAL','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(164,'SC','SEYCHELLES','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(165,'SL','SIERRA LEONE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(166,'SG','SINGAPORE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(167,'SK','SLOVAKIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(168,'VN','VIET NAM','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(169,'SI','SLOVENIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(170,'SO','SOMALIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(171,'ZA','SOUTH AFRICA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(172,'ZW','ZIMBABWE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(173,'YD','YEMEN, DEMOCRATIC','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(174,'ES','SPAIN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(175,'EH','WESTERN SAHARA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(176,'SD','SUDAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(177,'SR','SURINAME','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(178,'SZ','SWAZILAND','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(179,'SE','SWEDEN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(180,'CH','SWITZERLAND','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(181,'SY','SYRIAN ARAB REPUBLIC','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(182,'TJ','TAJIKISTAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(183,'TH','THAILAND','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(184,'TG','TOGO','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(185,'TO','TONGA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(186,'TT','TRINIDAD AND TOBAGO','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(187,'AE','UNITED ARAB EMIRATES','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(188,'TN','TUNISIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(189,'TR','TURKEY','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(190,'TM','TURKMENISTAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(191,'TV','TUVALU','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(192,'UG','UGANDA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(193,'UA','UKRAINE','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(194,'MK','MACEDONIA, THE FORMER YUGOSLAV REPUBLIC','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(195,'SU','USSR','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(196,'EG','EGYPT','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(197,'GB','UNITED KINGDOM','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(198,'TZ','TANZANIA, UNITED REPUBLIC OF','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(199,'US','UNITED STATES','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(200,'UY','URUGUAY','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(201,'UZ','UZBEKISTAN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(202,'VE','VENEZUELA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(203,'WS','SAMOA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(204,'YE','YEMEN','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(205,'YU','YUGOSLAVIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(206,'ZA','ZAMBIA','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(207,'BF','BURKINA FASO','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(208,'KMP','KUMVI PROFFESSIONALS','1','2015-05-31 14:24:39','0000-00-00 00:00:00'),(209,'XX','UNKNOWN COUNTRY','1','2015-05-31 14:24:39','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_payment_method` */

DROP TABLE IF EXISTS `wipo_master_payment_method`;

CREATE TABLE `wipo_master_payment_method` (
  `Master_Paymode_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Paymode_Code` varchar(10) DEFAULT NULL,
  `Paymode_Name` varchar(45) NOT NULL COMMENT 'Payment Method:',
  `Paymode_Comment` varchar(90) NOT NULL COMMENT 'Payment Comment:',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Paymode_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_payment_method` */

insert  into `wipo_master_payment_method`(`Master_Paymode_Id`,`Paymode_Code`,`Paymode_Name`,`Paymode_Comment`,`Active`,`Created_Date`,`Rowversion`) values (1,'CH','CHEQUE','CHEQUE','1','2015-03-16 04:03:36','0000-00-00 00:00:00'),(2,'CS','CASH','CASH','1','2015-03-16 04:05:07','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_place` */

DROP TABLE IF EXISTS `wipo_master_place`;

CREATE TABLE `wipo_master_place` (
  `Master_Place_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Place_Code` varchar(50) NOT NULL,
  `Place_Name` varchar(100) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Master_Place_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_place` */

insert  into `wipo_master_place`(`Master_Place_Id`,`Place_Code`,`Place_Name`,`Active`,`Created_Date`,`Rowversion`,`Created_By`,`Updated_By`) values (1,'01','Radios','1','2015-07-22 12:07:56','0000-00-00 00:00:00',NULL,NULL),(2,'02','Download','1','2015-07-22 12:08:09','0000-00-00 00:00:00',NULL,NULL),(4,'03','Television','1','2015-07-22 12:10:27','0000-00-00 00:00:00',NULL,NULL);

/*Table structure for table `wipo_master_profession` */

DROP TABLE IF EXISTS `wipo_master_profession`;

CREATE TABLE `wipo_master_profession` (
  `Master_Profession_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Profession_Name` varchar(45) NOT NULL COMMENT 'Profession Title:',
  `Active` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Status:',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Profession_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_profession` */

insert  into `wipo_master_profession`(`Master_Profession_Id`,`Profession_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'Singer','1','2015-03-16 03:47:52','0000-00-00 00:00:00'),(2,'Author','1','2015-04-11 09:40:59','0000-00-00 00:00:00'),(3,'Writer','1','2015-04-11 09:41:09','0000-00-00 00:00:00'),(4,'Guitarist','1','2015-04-11 09:41:21','0000-00-00 00:00:00'),(5,'Lyricist','1','2015-04-11 09:41:33','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_pseudonym_types` */

DROP TABLE IF EXISTS `wipo_master_pseudonym_types`;

CREATE TABLE `wipo_master_pseudonym_types` (
  `Pseudo_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Pseudo_Code` varchar(5) NOT NULL COMMENT 'Pseudonym Types:',
  `Pseudo_Fulltype` varchar(255) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Pseudo_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_pseudonym_types` */

insert  into `wipo_master_pseudonym_types`(`Pseudo_Id`,`Pseudo_Code`,`Pseudo_Fulltype`,`Active`,`Created_Date`,`Rowversion`) values (1,'PP','PSEUDONYM, PEN NAME','1','2015-03-16 04:09:20','0000-00-00 00:00:00'),(2,'PA','PATRONYM','1','2015-03-16 04:09:24','0000-00-00 00:00:00'),(5,'PG','GROUP PSEUDONYM','1','2015-06-02 11:18:00','0000-00-00 00:00:00'),(6,'PC','COLLECTIVE PSEUDONYM','1','2015-06-02 11:18:00','0000-00-00 00:00:00'),(7,'DF','DIFFERENT SPELLING','1','2015-06-02 11:18:00','0000-00-00 00:00:00'),(8,'ST','STANDARDISED NAME','1','2015-06-02 11:18:00','0000-00-00 00:00:00'),(9,'MO','MODIFIED NAME, FORMER PATRONYN','1','2015-06-02 11:18:00','0000-00-00 00:00:00'),(10,'OR','OTHER REFERENCES  FOR LEGAL ENTITIES','1','2015-06-02 11:18:00','0000-00-00 00:00:00'),(11,'HR','HOLDING REFERENCES FOR LEGAL ENTITIES','1','2015-06-02 11:18:00','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_record_type` */

DROP TABLE IF EXISTS `wipo_master_record_type`;

CREATE TABLE `wipo_master_record_type` (
  `Master_Rec_Type_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rec_Type_Name` varchar(255) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Rec_Type_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_record_type` */

insert  into `wipo_master_record_type`(`Master_Rec_Type_Id`,`Rec_Type_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'Normal','1','2015-06-02 06:32:54','0000-00-00 00:00:00'),(2,'Digital','1','2015-06-09 06:32:12','0000-00-00 00:00:00'),(3,'Non identified','1','2015-06-09 06:32:12','0000-00-00 00:00:00'),(4,'Other','1','2015-06-09 06:32:12','0000-00-00 00:00:00'),(5,'Recording Sessions','1','2015-06-09 06:32:12','0000-00-00 00:00:00'),(6,'Sound Carriers','1','2015-06-09 06:32:12','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_region` */

DROP TABLE IF EXISTS `wipo_master_region`;

CREATE TABLE `wipo_master_region` (
  `Master_Region_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Region_Code` varchar(10) DEFAULT NULL,
  `Region_Name` varchar(90) NOT NULL COMMENT 'Region:',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Region_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_region` */

insert  into `wipo_master_region`(`Master_Region_Id`,`Region_Code`,`Region_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'NEP','NEPAL','1','2015-03-16 03:44:44','0000-00-00 00:00:00'),(3,'BLK','BALAKA','1','2015-03-16 03:44:57','0000-00-00 00:00:00'),(7,'BT','BLANTYRE','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(8,'CK','CHIKWAWA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(9,'CP','CHITIPA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(10,'CZ','CHIRADZULU','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(11,'DA','DOWA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(12,'DZ','DEDZA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(13,'KA','KARONGA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(14,'KK','NKHOTAKOTA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(15,'KU','KASUNGU','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(16,'LA','LIKOMA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(17,'LL','LILONGWE','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(18,'MC','MCHINJI','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(19,'MH','MANGOCHI','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(20,'MHG','MACHINGA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(21,'MJ','MULANJE','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(22,'MN','MWANZA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(23,'MV','MVERA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(24,'MZ','MZUZU','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(25,'MZI','MZIMBA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(26,'NE','NSANJE','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(27,'NJ','NTAJA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(28,'NS','NTCHISI','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(29,'NU','NTCHEU','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(30,'PMB','PHALOMBE','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(31,'SA','SALIMA','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(32,'TO','THYOLO','1','2015-06-02 11:23:47','0000-00-00 00:00:00'),(33,'ZA','ZOMBA','1','2015-06-02 11:23:47','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_role` */

DROP TABLE IF EXISTS `wipo_master_role`;

CREATE TABLE `wipo_master_role` (
  `Master_Role_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Role_Code` varchar(45) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Rank` smallint(6) DEFAULT '100',
  `is_Admin` enum('0','1') NOT NULL DEFAULT '0',
  `Active` enum('0','1') DEFAULT '1',
  `Created_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Rowversion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Role_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_role` */

insert  into `wipo_master_role`(`Master_Role_ID`,`Role_Code`,`Description`,`Rank`,`is_Admin`,`Active`,`Created_Date`,`Rowversion`) values (1,'A','Admin',100,'1','1','2015-08-20 17:19:58','0000-00-00 00:00:00'),(2,'DE','Data Entry',200,'0','1','2015-08-20 17:20:49','0000-00-00 00:00:00'),(3,'DO','Documentation Officer',300,'0','1','2015-08-20 17:20:51','0000-00-00 00:00:00'),(4,'DS','Distribution Office',400,'0','1','2015-08-20 17:20:52','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_screen` */

DROP TABLE IF EXISTS `wipo_master_screen`;

CREATE TABLE `wipo_master_screen` (
  `Master_Screen_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Module_ID` int(11) NOT NULL,
  `Screen_code` varchar(45) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Rowversion` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Screen_ID`),
  KEY `FK_wipo_master_screen_module` (`Module_ID`),
  CONSTRAINT `FK_wipo_master_screen_module` FOREIGN KEY (`Module_ID`) REFERENCES `wipo_master_module` (`Master_Module_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_screen` */

insert  into `wipo_master_screen`(`Master_Screen_ID`,`Module_ID`,`Screen_code`,`Description`,`Active`,`Created_Date`,`Rowversion`) values (1,1,'mastercurrency','Currency','1','2015-06-30 17:43:13','0000-00-00 00:00:00'),(2,1,'mastercountry','Country','1','2015-06-30 17:43:43','0000-00-00 00:00:00'),(3,1,'masterdocumentstatus','Document Status ','1','2015-06-30 17:43:55','0000-00-00 00:00:00'),(4,1,'masterdocumenttype','Document Types ','1','2015-06-30 17:44:26','0000-00-00 00:00:00'),(5,1,'masterdocument','Documents ','1','2015-06-30 17:44:24','0000-00-00 00:00:00'),(6,1,'masterinternalposition','Internal Position','1','2015-06-30 17:44:40','0000-00-00 00:00:00'),(7,1,'masterinternationalnumber','International Number','1','2015-06-30 17:44:56','0000-00-00 00:00:00'),(8,1,'masterlabel','Labels','1','2015-06-30 17:45:13','0000-00-00 00:00:00'),(9,1,'masterlegalform','Legal Forms','1','2015-06-30 17:45:30','0000-00-00 00:00:00'),(10,1,'masterlanguage','Languages','1','2015-06-30 17:46:04','0000-00-00 00:00:00'),(11,1,'mastermanagedrights','Managed Rights ','1','2015-06-30 17:45:51','0000-00-00 00:00:00'),(12,1,'mastermaritalstatus','Marital Statuses ','1','2015-06-30 17:46:01','0000-00-00 00:00:00'),(13,1,'masternationality','Nationalities','1','2015-06-30 17:46:23','0000-00-00 00:00:00'),(14,1,'organization','Organizations','1','2015-06-30 17:46:35','0000-00-00 00:00:00'),(15,1,'masterpseudonymtypes','Pseudonym Types','1','2015-06-30 17:46:50','0000-00-00 00:00:00'),(16,1,'masterpaymentmethod','Payment Methods','1','2015-06-30 17:47:05','0000-00-00 00:00:00'),(17,1,'masterprofession','Professions','1','2015-06-30 17:47:20','0000-00-00 00:00:00'),(18,1,'masterregion','Regions','1','2015-06-30 17:47:44','0000-00-00 00:00:00'),(19,1,'sharedefinitionperrole','Share Definition Per Roles ','1','2015-06-30 17:47:57','0000-00-00 00:00:00'),(20,1,'mastertype','Types','1','2015-06-30 17:48:22','0000-00-00 00:00:00'),(21,1,'mastereventtype','Event Types ','1','2015-06-30 17:48:38','0000-00-00 00:00:00'),(22,1,'mastertyperights','Right Holder Types ','1','2015-06-30 17:48:52','0000-00-00 00:00:00'),(23,1,'masterterritories','Territories','1','2015-06-30 17:49:03','0000-00-00 00:00:00'),(24,1,'masterworkscategory','Works Categories','1','2015-06-30 17:49:15','0000-00-00 00:00:00'),(25,2,'society','Societies','1','2015-06-30 17:50:42','0000-00-00 00:00:00'),(26,2,'masterrole','Roles','1','2015-06-30 17:50:49','0000-00-00 00:00:00'),(27,2,'user','Users','1','2015-06-30 17:50:59','0000-00-00 00:00:00'),(28,3,'authoraccount','Authors','1','2015-06-30 17:51:16','0000-00-00 00:00:00'),(29,3,'performeraccount','Performers','1','2015-06-30 17:51:26','0000-00-00 00:00:00'),(30,3,'publisheraccount','Publishers','1','2015-06-30 17:51:44','0000-00-00 00:00:00'),(31,3,'produceraccount','Producers','1','2015-06-30 17:51:56','0000-00-00 00:00:00'),(32,3,'authorgroup','Author Groups','1','2015-07-01 10:56:05','0000-00-00 00:00:00'),(33,3,'performergroup','Performer Groups','1','2015-07-01 10:56:12','0000-00-00 00:00:00'),(34,3,'publishergroup','Publisher Groups','1','2015-06-30 17:53:27','0000-00-00 00:00:00'),(35,3,'producergroup','Producer Groups','1','2015-07-01 10:56:16','0000-00-00 00:00:00'),(36,3,'work','Works','1','2015-06-30 17:53:53','0000-00-00 00:00:00'),(37,3,'recording','Recordings','1','2015-06-30 17:53:50','0000-00-00 00:00:00'),(38,3,'contractexpiry','Contract Expiry','1','2015-07-01 13:52:54','0000-00-00 00:00:00'),(39,3,'producerlabelowner','Product Label Owner','1','2015-07-01 16:30:49','0000-00-00 00:00:00'),(40,3,'soundcarrier','Sound Carrier','1','2015-07-07 18:04:51','0000-00-00 00:00:00'),(41,3,'recordingsession','Recording Session','1','2015-07-14 16:34:08','0000-00-00 00:00:00'),(42,1,'internalcodegenerate','Code Definition','1','2015-07-20 19:17:28','0000-00-00 00:00:00'),(43,1,'masterplace','Type (Places)','1','2015-07-22 12:03:17','0000-00-00 00:00:00'),(44,1,'mastertariff','Tariff','1','2015-07-22 18:31:35','0000-00-00 00:00:00'),(45,4,'customeruser','Users & Customers','1','2015-07-22 19:31:54','0000-00-00 00:00:00'),(46,4,'inspector','Inspectors','1','2015-07-23 11:49:34','0000-00-00 00:00:00'),(47,1,'mastercity','City','1','2015-07-28 13:49:45','0000-00-00 00:00:00'),(48,4,'tariffcontracts','Customer Tariffication','1','2015-07-28 13:53:22','0000-00-00 00:00:00'),(49,4,'contractinvoice','Invoice','1','2015-08-06 12:49:33','0000-00-00 00:00:00'),(50,4,'emailtemplate','Email Template','1','2015-08-11 13:48:17','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_studio` */

DROP TABLE IF EXISTS `wipo_master_studio`;

CREATE TABLE `wipo_master_studio` (
  `Master_Studio_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Studio_Code` varchar(10) DEFAULT NULL,
  `Studio_Name` varchar(100) NOT NULL,
  `Studio_Description` text,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Master_Studio_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_studio` */

insert  into `wipo_master_studio`(`Master_Studio_Id`,`Studio_Code`,`Studio_Name`,`Studio_Description`,`Active`,`Created_Date`,`Rowversion`,`Created_By`,`Updated_By`) values (1,NULL,'Studio 1','Studio 1','1','2015-07-09 11:00:15','0000-00-00 00:00:00',NULL,NULL),(2,NULL,'Studio 2','Studio 1','1','2015-07-09 11:00:22','0000-00-00 00:00:00',NULL,NULL),(3,NULL,'Studio 3','Studio 3','1','2015-07-09 11:01:06','0000-00-00 00:00:00',NULL,NULL);

/*Table structure for table `wipo_master_tariff` */

DROP TABLE IF EXISTS `wipo_master_tariff`;

CREATE TABLE `wipo_master_tariff` (
  `Master_Tarif_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Tarif_Internal_Code` varchar(50) NOT NULL,
  `Tarif_Code` varchar(50) NOT NULL,
  `Tarif_Description` varchar(100) NOT NULL,
  `Tarif_Min_Tarif_Amount` decimal(10,2) DEFAULT NULL,
  `Tarif_Max_Tarif_Amount` decimal(10,2) DEFAULT NULL,
  `Tarif_Amount` decimal(10,2) DEFAULT NULL,
  `Tarif_Percentage` enum('1','0') DEFAULT '0',
  `Tarif_Comment` text,
  `Tarif_Currency_Id` int(11) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`Master_Tarif_Id`),
  UNIQUE KEY `NewIndex1` (`Tarif_Internal_Code`),
  KEY `FK_wipo_master_tariff` (`Tarif_Currency_Id`),
  CONSTRAINT `FK_wipo_master_tariff` FOREIGN KEY (`Tarif_Currency_Id`) REFERENCES `wipo_master_currency` (`Master_Crncy_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_tariff` */

insert  into `wipo_master_tariff`(`Master_Tarif_Id`,`Tarif_Internal_Code`,`Tarif_Code`,`Tarif_Description`,`Tarif_Min_Tarif_Amount`,`Tarif_Max_Tarif_Amount`,`Tarif_Amount`,`Tarif_Percentage`,`Tarif_Comment`,`Tarif_Currency_Id`,`Created_Date`,`Rowversion`,`Created_By`,`Updated_By`,`Active`) values (1,'SOC-TAR-0000001','FIX10K','ANNUAL FIXED AMOUNT','10000.00','10000.00','10000.00','1','Test',3,'2015-07-22 18:19:58','0000-00-00 00:00:00',NULL,NULL,'1'),(3,'SOC-TAR-0000002','FIX12K','ANNUAL FIXED AMOUNT','12000.00','24000.00','12000.00','0','',1,'2015-08-05 12:01:34','0000-00-00 00:00:00',NULL,NULL,'1');

/*Table structure for table `wipo_master_territories` */

DROP TABLE IF EXISTS `wipo_master_territories`;

CREATE TABLE `wipo_master_territories` (
  `Master_Territory_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Territory_Name` varchar(90) NOT NULL COMMENT 'Territory:',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Territory_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_territories` */

insert  into `wipo_master_territories`(`Master_Territory_Id`,`Territory_Name`,`Active`,`Created_Date`,`Rowversion`) values (8,'Worldwide','1','2015-04-11 09:01:02','0000-00-00 00:00:00'),(9,'Asean','1','2015-04-11 09:01:14','0000-00-00 00:00:00'),(10,'AFGHANISTAN                                                                     ','1','2015-06-12 06:48:16','0000-00-00 00:00:00'),(11,'AFRICA                                                                          ','1','2015-06-12 06:48:27','0000-00-00 00:00:00'),(12,'ALBANIA                                                                         ','1','2015-06-12 06:48:40','0000-00-00 00:00:00'),(13,'ALGERIA                                                                         ','1','2015-06-12 06:48:49','0000-00-00 00:00:00'),(14,'AMERICA                                                                         ','1','2015-06-12 06:48:57','0000-00-00 00:00:00'),(15,'AMERICAN CONTINENT                                                              ','1','2015-06-12 06:49:08','0000-00-00 00:00:00'),(16,'ANDORRA                                                                         ','1','2015-06-12 06:49:16','0000-00-00 00:00:00'),(17,'ANGOLA                                                                          ','1','2015-06-12 06:49:23','0000-00-00 00:00:00'),(18,'ANTIGUA AND BARBUDA                                                             ','1','2015-06-12 06:49:33','0000-00-00 00:00:00'),(19,'ANTILLES                                                                        ','1','2015-06-12 06:49:43','0000-00-00 00:00:00'),(20,'APEC COUNTRIES                                                                  ','1','2015-06-12 06:49:52','0000-00-00 00:00:00'),(21,'ARGENTINA                                                                       ','1','2015-06-12 06:50:02','0000-00-00 00:00:00'),(22,'ARMENIA                                                                         ','1','2015-06-12 06:50:13','0000-00-00 00:00:00'),(23,'ASEAN COUNTRIES                                                                 ','1','2015-06-12 06:50:26','0000-00-00 00:00:00'),(24,'ASIA ','1','2015-06-12 06:50:48','0000-00-00 00:00:00'),(25,'AUSTRALASIA','1','2015-06-12 06:51:17','0000-00-00 00:00:00'),(26,'AUSTRALIA                                                                       ','1','2015-06-12 06:51:28','0000-00-00 00:00:00'),(27,'AZERBAIJAN                                                                      ','1','2015-06-12 06:51:37','0000-00-00 00:00:00'),(28,'BAHAMAS                                                                         ','1','2015-06-12 06:51:53','0000-00-00 00:00:00'),(29,'BAHRAIN                                                                         ','1','2015-06-12 06:52:01','0000-00-00 00:00:00'),(30,'BALKANS                                                                         ','1','2015-06-12 06:52:09','0000-00-00 00:00:00'),(31,'BALTIC STATES                                                                   ','1','2015-06-12 06:52:17','0000-00-00 00:00:00'),(32,'BANGLADESH                                                                      ','1','2015-06-12 06:52:26','0000-00-00 00:00:00'),(33,'BARBADOS                                                                        ','1','2015-06-12 06:52:40','0000-00-00 00:00:00'),(34,'BELARUS                                                                         ','1','2015-06-12 06:52:50','0000-00-00 00:00:00'),(35,'BELGIUM                                                                         ','1','2015-06-12 06:53:00','0000-00-00 00:00:00'),(36,'BOSNIA AND HERZEGOVINA                                                          ','1','2015-06-12 06:53:16','0000-00-00 00:00:00'),(37,'BRITISH WEST INDIES                                                             ','1','2015-06-12 06:53:27','0000-00-00 00:00:00'),(38,'BRITISH WEST INDIES                                                             ','1','2015-06-12 06:53:27','0000-00-00 00:00:00'),(39,'BRITISH ISLES                                                                   ','1','2015-06-12 06:53:35','0000-00-00 00:00:00'),(40,'BRUNEI DARUSSALAM                                                               ','1','2015-06-12 06:53:45','0000-00-00 00:00:00'),(41,'BURKINA FASO                                                                    ','1','2015-06-12 06:53:55','0000-00-00 00:00:00'),(42,'CAMBODIA                                                                        ','1','2015-06-12 06:54:10','0000-00-00 00:00:00'),(43,'CAMEROON                                                                        ','1','2015-06-12 06:54:17','0000-00-00 00:00:00'),(44,'CANADA                                                                          ','1','2015-06-12 06:54:24','0000-00-00 00:00:00'),(45,'CAPE VERDE                                                                      ','1','2015-06-12 06:54:37','0000-00-00 00:00:00'),(46,'CENTRAL AFRICA REGION                                                           ','1','2015-06-12 06:54:47','0000-00-00 00:00:00'),(47,'CENTRAL AFRICAN REPUBLIC                                                        ','1','2015-06-12 06:54:57','0000-00-00 00:00:00'),(48,'CENTRAL AMERICA                                                                 ','1','2015-06-12 06:55:10','0000-00-00 00:00:00'),(49,'COMMONWEALTH                                                                    ','1','2015-06-12 06:55:19','0000-00-00 00:00:00'),(50,'COMMONWEALTH AFRICAN TERRITORIES                                                ','1','2015-06-12 06:55:35','0000-00-00 00:00:00'),(51,'COMMONWEALTH ASIAN TERRITORIES                                                  ','1','2015-06-12 06:55:52','0000-00-00 00:00:00'),(52,'COMMONWEALTH AUSTRALASIAN TERRITORIES                                           ','1','2015-06-12 06:56:03','0000-00-00 00:00:00'),(53,'COMMONWEALTH OF INDEPENDENT STATES                                              ','1','2015-06-12 06:56:11','0000-00-00 00:00:00'),(54,'TAIWAN, PROVINCE OF CHINA                                                       ','1','2015-06-12 07:33:30','0000-00-00 00:00:00'),(55,'EQUATORIAL GUINEA                                                               ','1','2015-06-12 07:33:47','0000-00-00 00:00:00'),(56,'ETHIOPIA                                                                        ','1','2015-06-12 07:43:20','0000-00-00 00:00:00'),(57,'FRENCH POLYNESIA                                                                ','1','2015-06-12 07:43:49','0000-00-00 00:00:00'),(58,'FINLAND                                                                         ','1','2015-06-12 07:43:59','0000-00-00 00:00:00'),(59,'FRANCE                                                                          ','1','2015-06-12 07:44:26','0000-00-00 00:00:00'),(60,'DJIBOUTI                                                                        ','1','2015-06-12 07:44:36','0000-00-00 00:00:00'),(61,'GABON                                                                           ','1','2015-06-12 07:54:02','0000-00-00 00:00:00'),(62,'GEORGIA                                                                         ','1','2015-06-12 07:55:39','0000-00-00 00:00:00'),(63,'GAMBIA                                                                          ','1','2015-06-12 07:55:49','0000-00-00 00:00:00'),(64,'GERMANY                                                                         ','1','2015-06-12 07:55:58','0000-00-00 00:00:00'),(65,'GERMAN DEMOCRATIC REPUBLIC                                                      ','1','2015-06-12 07:56:08','0000-00-00 00:00:00'),(66,'KIRIBATI                                                                           ','1','2015-06-12 07:56:51','0000-00-00 00:00:00'),(67,'GREECE                                                                          ','1','2015-06-12 07:57:01','0000-00-00 00:00:00'),(68,'GRENADA                                                                         ','1','2015-06-12 07:57:09','0000-00-00 00:00:00'),(69,'GUATEMALA                                                                       ','1','2015-06-12 07:57:17','0000-00-00 00:00:00'),(70,'HOLY SEE (VATICAN CITY STATE)                                                   ','1','2015-06-12 07:57:29','0000-00-00 00:00:00'),(71,'HONDURAS                                                                        ','1','2015-06-12 07:57:37','0000-00-00 00:00:00'),(72,'HONG KONG                                                                       ','1','2015-06-12 07:57:44','0000-00-00 00:00:00'),(73,'HUNGARY                                                                         ','1','2015-06-12 07:57:52','0000-00-00 00:00:00'),(74,'ICELAND                                                                         ','1','2015-06-12 07:57:59','0000-00-00 00:00:00'),(75,'INDIA                                                                           ','1','2015-06-12 07:58:07','0000-00-00 00:00:00'),(76,'INDONESIA                                                                       ','1','2015-06-12 07:58:27','0000-00-00 00:00:00'),(77,'IRAN, ISLAMIC REPUBLIC OF                                                       ','1','2015-06-12 07:58:36','0000-00-00 00:00:00'),(78,'IRAQ                                                                            ','1','2015-06-12 07:59:10','0000-00-00 00:00:00'),(79,'IRELAND                                                                         ','1','2015-06-12 07:59:18','0000-00-00 00:00:00'),(80,'ISRAEL                                                                          ','1','2015-06-12 07:59:26','0000-00-00 00:00:00'),(81,'ITALY                                                                           ','1','2015-06-12 07:59:34','0000-00-00 00:00:00'),(82,'COTE D\'IVOIRE                                                                   ','1','2015-06-12 07:59:42','0000-00-00 00:00:00'),(83,'JAMAICA                                                                         ','1','2015-06-12 07:59:53','0000-00-00 00:00:00'),(84,'JAPAN                                                                           ','1','2015-06-12 08:00:02','0000-00-00 00:00:00'),(85,'KAZAKSTAN                                                                       ','1','2015-06-12 08:00:10','0000-00-00 00:00:00'),(86,'JORDAN                                                                          ','1','2015-06-12 08:00:18','0000-00-00 00:00:00'),(87,'KENYA                                                                           ','1','2015-06-12 08:00:26','0000-00-00 00:00:00'),(88,'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF                                          ','1','2015-06-12 08:00:34','0000-00-00 00:00:00'),(89,'KUWAIT                                                                          ','1','2015-06-12 08:00:47','0000-00-00 00:00:00'),(90,'KYRGYZSTAN                                                                      ','1','2015-06-12 08:00:57','0000-00-00 00:00:00'),(91,'LAO PEOPLE\'S DEMOCRATIC REPUBLIC                                                ','1','2015-06-12 08:01:49','0000-00-00 00:00:00'),(92,'LEBANON                                                                         ','1','2015-06-12 08:01:57','0000-00-00 00:00:00'),(93,'LESOTHO                                                                         ','1','2015-06-12 08:02:05','0000-00-00 00:00:00'),(94,'LIBERIA                                                                         ','1','2015-06-12 08:02:13','0000-00-00 00:00:00'),(95,'LIBYAN ARAB JAMAHIRIYA                                                          ','1','2015-06-12 08:10:32','0000-00-00 00:00:00'),(96,'LIECHTENSTEIN                                                                   ','1','2015-06-12 08:10:40','0000-00-00 00:00:00'),(97,'LUXEMBOURG                                                                      ','1','2015-06-12 08:10:49','0000-00-00 00:00:00'),(98,'MADAGASCAR                                                                      ','1','2015-06-12 08:10:58','0000-00-00 00:00:00'),(99,'MALAWI                                                                          ','1','2015-06-12 08:11:06','0000-00-00 00:00:00'),(100,'MALAYSIA                                                                        ','1','2015-06-12 08:11:13','0000-00-00 00:00:00'),(101,'MALDIVES                                                                        ','1','2015-06-12 08:11:19','0000-00-00 00:00:00'),(102,'MALI                                                                            ','1','2015-06-12 08:12:44','0000-00-00 00:00:00'),(103,'MAURITANIA                                                                      ','1','2015-06-12 08:13:07','0000-00-00 00:00:00'),(104,'MAURITIUS                                                                       ','1','2015-06-12 08:13:16','0000-00-00 00:00:00'),(105,'MEXICO                                                                          ','1','2015-06-12 08:13:25','0000-00-00 00:00:00'),(106,'MOLDOVA, REPUBLIC OF                                                            ','1','2015-06-12 08:13:35','0000-00-00 00:00:00'),(107,'MOZAMBIQUE                                                                      ','1','2015-06-12 08:13:44','0000-00-00 00:00:00'),(108,'NETHERLANDS                                                                     ','1','2015-06-12 08:13:54','0000-00-00 00:00:00'),(109,'NEPAL                                                                           ','1','2015-06-12 08:14:02','0000-00-00 00:00:00'),(110,'VANUATU                                                                         ','1','2015-06-12 08:14:10','0000-00-00 00:00:00'),(111,'NEW ZEALAND                                                                     ','1','2015-06-12 08:14:16','0000-00-00 00:00:00'),(112,'NICARAGUA                                                                       ','1','2015-06-12 08:14:24','0000-00-00 00:00:00'),(113,'NIGER                                                                           ','1','2015-06-12 08:14:32','0000-00-00 00:00:00'),(114,'NIGERIA                                                                         ','1','2015-06-12 08:14:40','0000-00-00 00:00:00'),(115,'MICRONESIA, FEDERATED STATES OF                                                 ','1','2015-06-12 08:14:53','0000-00-00 00:00:00'),(116,'NORWAY                                                                          ','1','2015-06-12 08:15:00','0000-00-00 00:00:00'),(117,'MARSHALL ISLANDS                                                                ','1','2015-06-12 08:15:08','0000-00-00 00:00:00'),(118,'PAKISTAN                                                                        ','1','2015-06-12 08:15:15','0000-00-00 00:00:00'),(119,'PANAMA                                                                          ','1','2015-06-12 08:15:23','0000-00-00 00:00:00'),(120,'PAPUA NEW GUINEA                                                                ','1','2015-06-12 08:15:30','0000-00-00 00:00:00'),(121,'PARAGUAY                                                                        ','1','2015-06-12 08:15:37','0000-00-00 00:00:00'),(122,'PERU                                                                            ','1','2015-06-12 08:15:45','0000-00-00 00:00:00'),(123,'PHILIPPINES                                                                     ','1','2015-06-12 08:15:51','0000-00-00 00:00:00'),(124,'POLAND                                                                          ','1','2015-06-12 08:15:58','0000-00-00 00:00:00'),(125,'PORTUGAL                                                                        ','1','2015-06-12 08:16:04','0000-00-00 00:00:00'),(126,'GUINEA-BISSAU                                                                   ','1','2015-06-12 08:16:10','0000-00-00 00:00:00'),(127,'PUERTO RICO                                                                     ','1','2015-06-12 08:16:18','0000-00-00 00:00:00'),(128,'QATAR                                                                           ','1','2015-06-12 08:16:29','0000-00-00 00:00:00'),(129,'ROMANIA                                                                         ','1','2015-06-12 08:16:35','0000-00-00 00:00:00'),(130,'RUSSIAN FEDERATION                                                              ','1','2015-06-12 08:16:44','0000-00-00 00:00:00'),(131,'RWANDA                                                                          ','1','2015-06-12 08:16:54','0000-00-00 00:00:00'),(132,'SAINT KITTS AND NEVIS                                                           ','1','2015-06-12 08:17:28','0000-00-00 00:00:00'),(133,'SAINT LUCIA                                                                     ','1','2015-06-12 08:17:35','0000-00-00 00:00:00'),(134,'SAINT VINCENT AND THE GRENADINES                                                ','1','2015-06-12 08:17:54','0000-00-00 00:00:00'),(135,'SAO TOME AND PRINCIPE                                                           ','1','2015-06-12 08:18:22','0000-00-00 00:00:00'),(136,'SAUDI ARABIA                                                                    ','1','2015-06-12 08:20:32','0000-00-00 00:00:00'),(137,'SENEGAL                                                                         ','1','2015-06-12 08:20:41','0000-00-00 00:00:00'),(138,'SIERRA LEONE                                                                    ','1','2015-06-12 08:21:23','0000-00-00 00:00:00'),(139,'SINGAPORE                                                                       ','1','2015-06-12 08:21:31','0000-00-00 00:00:00'),(140,'SLOVAKIA                                                                        ','1','2015-06-12 08:21:39','0000-00-00 00:00:00'),(141,'VIET NAM                                                                        ','1','2015-06-12 08:21:48','0000-00-00 00:00:00'),(142,'SOMALIA                                                                         ','1','2015-06-12 08:21:58','0000-00-00 00:00:00'),(143,'SOUTH AFRICA                                                                    ','1','2015-06-12 08:22:05','0000-00-00 00:00:00'),(144,'ZIMBABWE                                                                        ','1','2015-06-12 08:22:13','0000-00-00 00:00:00'),(145,'YEMEN, DEMOCRATIC                                                               ','1','2015-06-12 08:22:20','0000-00-00 00:00:00'),(146,'SPAIN                                                                           ','1','2015-06-12 08:22:27','0000-00-00 00:00:00'),(147,'WESTERN SAHARA                                                                  ','1','2015-06-12 08:22:33','0000-00-00 00:00:00'),(148,'SUDAN                                                                           ','1','2015-06-12 08:22:40','0000-00-00 00:00:00'),(149,'SWAZILAND                                                                       ','1','2015-06-12 08:22:50','0000-00-00 00:00:00'),(150,'SWEDEN                                                                          ','1','2015-06-12 08:22:58','0000-00-00 00:00:00'),(151,'SWITZERLAND                                                                     ','1','2015-06-12 08:23:05','0000-00-00 00:00:00'),(152,'SYRIAN ARAB REPUBLIC                                                            ','1','2015-06-12 08:23:14','0000-00-00 00:00:00'),(153,'TAJIKISTAN                                                                      ','1','2015-06-12 08:23:21','0000-00-00 00:00:00'),(154,'THAILAND                                                                        ','1','2015-06-12 08:23:29','0000-00-00 00:00:00'),(155,'TRINIDAD AND TOBAGO                                                             ','1','2015-06-12 08:23:40','0000-00-00 00:00:00'),(156,'UNITED ARAB EMIRATES                                                            ','1','2015-06-12 08:23:49','0000-00-00 00:00:00'),(157,'TUNISIA                                                                         ','1','2015-06-12 08:23:57','0000-00-00 00:00:00'),(158,'TURKEY                                                                          ','1','2015-06-12 08:24:05','0000-00-00 00:00:00'),(159,'TURKMENISTAN                                                                    ','1','2015-06-12 08:24:38','0000-00-00 00:00:00'),(160,'UGANDA                                                                          ','1','2015-06-12 08:24:48','0000-00-00 00:00:00'),(161,'UKRAINE                                                                         ','1','2015-06-12 08:24:56','0000-00-00 00:00:00'),(162,'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF                                      ','1','2015-06-12 08:25:02','0000-00-00 00:00:00'),(163,'EGYPT                                                                           ','1','2015-06-12 08:25:13','0000-00-00 00:00:00'),(164,'UNITED KINGDOM                                                                  ','1','2015-06-12 08:25:19','0000-00-00 00:00:00'),(165,'TANZANIA, UNITED REPUBLIC OF                                                    ','1','2015-06-12 08:25:27','0000-00-00 00:00:00'),(166,'UNITED STATES                                                                   ','1','2015-06-12 08:25:35','0000-00-00 00:00:00'),(167,'BURKINA FASO                                                                    ','1','2015-06-12 08:25:42','0000-00-00 00:00:00'),(168,'URUGUAY                                                                         ','1','2015-06-12 08:25:53','0000-00-00 00:00:00'),(169,'UZBEKISTAN                                                                      ','1','2015-06-12 08:26:00','0000-00-00 00:00:00'),(170,'VENEZUELA                                                                       ','1','2015-06-12 08:26:08','0000-00-00 00:00:00'),(171,'SAMOA                                                                           ','1','2015-06-12 08:26:14','0000-00-00 00:00:00'),(172,'YUGOSLAVIA (0890)                                                               ','1','2015-06-12 08:26:26','0000-00-00 00:00:00'),(173,'ZAMBIA                                                                          ','1','2015-06-12 08:26:33','0000-00-00 00:00:00'),(174,'WEST AFRICA REGION                                                              ','1','2015-06-12 08:27:07','0000-00-00 00:00:00'),(175,'WEST INDIES                                                                     ','1','2015-06-12 08:27:17','0000-00-00 00:00:00'),(176,'SOUTH EAST ASIA                                                                 ','1','2015-06-12 08:27:25','0000-00-00 00:00:00'),(177,'SOUTH AMERICA                                                                   ','1','2015-06-12 08:27:38','0000-00-00 00:00:00'),(178,'SCANDINAVIA                                                                     ','1','2015-06-12 08:27:49','0000-00-00 00:00:00'),(179,'OCEANIA                                                                         ','1','2015-06-12 08:27:57','0000-00-00 00:00:00'),(180,'NORTH AMERICA                                                                   ','1','2015-06-12 08:28:04','0000-00-00 00:00:00'),(181,'NORTH AFRICA                                                                    ','1','2015-06-12 08:28:11','0000-00-00 00:00:00'),(182,'NORDIC COUNTRIES                                                                ','1','2015-06-12 08:28:18','0000-00-00 00:00:00'),(183,'NAFTA COUNTRIES                                                                 ','1','2015-06-12 08:28:25','0000-00-00 00:00:00'),(184,'MIDDLE EAST                                                                     ','1','2015-06-12 08:28:33','0000-00-00 00:00:00'),(185,'GSA COUNTRIES                                                                   ','1','2015-06-12 08:28:40','0000-00-00 00:00:00'),(186,'EUROPEAN UNION                                                                  ','1','2015-06-12 08:28:46','0000-00-00 00:00:00'),(187,'EUROPEAN ECONOMIC COMMUNITY                                                     ','1','2015-06-12 08:28:53','0000-00-00 00:00:00'),(188,'EUROPEAN CONTINENT                                                              ','1','2015-06-12 08:29:04','0000-00-00 00:00:00'),(189,'EUROPEAN ECONOMIC AREA                                                          ','1','2015-06-12 08:29:13','0000-00-00 00:00:00'),(190,'EASTERN EUROPE                                                                  ','1','2015-06-12 08:29:22','0000-00-00 00:00:00'),(191,'SOUTH AFRICA REGION                                                             ','1','2015-06-12 08:30:01','0000-00-00 00:00:00'),(192,'EAST AFRICA REGION                                                              ','1','2015-06-12 08:30:22','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_type` */

DROP TABLE IF EXISTS `wipo_master_type`;

CREATE TABLE `wipo_master_type` (
  `Master_Type_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type_Name` varchar(255) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Type_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_type` */

insert  into `wipo_master_type`(`Master_Type_Id`,`Type_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'Jazz','1','2015-04-02 00:56:59','0000-00-00 00:00:00'),(2,'Popular','1','2015-04-02 00:57:05','0000-00-00 00:00:00'),(3,'Serious','1','2015-04-02 00:57:16','0000-00-00 00:00:00'),(4,'Modern','1','2015-05-21 14:29:34','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_type_rights` */

DROP TABLE IF EXISTS `wipo_master_type_rights`;

CREATE TABLE `wipo_master_type_rights` (
  `Master_Type_Rights_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Type_Rights_Name` varchar(90) NOT NULL COMMENT 'Type of Right holder:',
  `Type_Rights_Code` varchar(10) NOT NULL,
  `Type_Rights_Standard` varchar(10) DEFAULT NULL,
  `Type_Rights_Rank` smallint(6) DEFAULT NULL,
  `Type_Rights_Occupation` enum('AU','PE','PU','PR') NOT NULL COMMENT 'AU -> Author, PE -> Performer, PU -> Publisher, PR -> Producer',
  `Type_Rights_Domain` enum('C','R') NOT NULL COMMENT 'C -> Copyright, R -> Releated Right',
  `Type_Right_Use` varchar(100) DEFAULT NULL COMMENT 'Not used',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Type_Rights_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_type_rights` */

insert  into `wipo_master_type_rights`(`Master_Type_Rights_Id`,`Type_Rights_Name`,`Type_Rights_Code`,`Type_Rights_Standard`,`Type_Rights_Rank`,`Type_Rights_Occupation`,`Type_Rights_Domain`,`Type_Right_Use`,`Active`,`Created_Date`,`Rowversion`) values (1,'MC- Music composer','MC','MC',5,'AU','C',NULL,'1','2015-03-16 03:48:28','0000-00-00 00:00:00'),(2,'Sub- Publisher','SE','SE',5,'PU','C',NULL,'1','2015-05-09 14:20:00','0000-00-00 00:00:00'),(4,'Other Musicians and Perfomers','OMP','OMP',6,'PE','R',NULL,'1','2015-05-22 08:49:23','0000-00-00 00:00:00'),(5,'Author, Writer, Lyricist','A','A',1,'AU','C',NULL,'1','2015-06-05 07:48:25','0000-00-00 00:00:00'),(6,'Composer','C','C',1,'AU','C',NULL,'1','2015-06-05 07:55:14','0000-00-00 00:00:00'),(7,'Composer/Author','CA','CA',5,'AU','C',NULL,'1','2015-06-05 07:55:31','0000-00-00 00:00:00'),(8,'Publisher','E','E',5,'PU','C',NULL,'1','2015-06-05 07:55:48','0000-00-00 00:00:00'),(9,'Lyricist','LY','LY',1,'AU','C',NULL,'1','2015-06-05 07:56:19','0000-00-00 00:00:00'),(11,'Producer','PRO','PRO',4,'PR','R',NULL,'1','2015-06-05 07:57:06','0000-00-00 00:00:00'),(12,'Sub-Author','SA','SA',1,'AU','C',NULL,'1','2015-06-05 07:57:23','0000-00-00 00:00:00'),(14,'Soloist, Lead Singer','SLC','SLC',6,'PE','R',NULL,'1','2015-06-05 08:10:28','0000-00-00 00:00:00'),(17,'Guest Singers, Musicians or Supporting Actor','AMG','AMG',6,'PE','R',NULL,'1','2015-06-05 08:11:44','0000-00-00 00:00:00'),(19,'Arranger','AR','AR',1,'AU','C',NULL,'1','2015-06-05 08:16:19','0000-00-00 00:00:00'),(21,'Sub-Arranger','SR','SR',1,'AU','C',NULL,'1','2015-06-05 08:17:10','0000-00-00 00:00:00'),(22,'Adapter / Translator','AD/TR','AD/TR',1,'AU','C',NULL,'1','2015-06-18 08:14:06','0000-00-00 00:00:00'),(23,'Music Publisher','EM','EM',3,'PU','C',NULL,'1','2015-06-18 08:14:56','0000-00-00 00:00:00');

/*Table structure for table `wipo_master_works_category` */

DROP TABLE IF EXISTS `wipo_master_works_category`;

CREATE TABLE `wipo_master_works_category` (
  `Master_Work_Category_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID:',
  `Work_Category_Name` varchar(90) NOT NULL COMMENT 'Works Category ',
  `Active` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Status:',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Master_Work_Category_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `wipo_master_works_category` */

insert  into `wipo_master_works_category`(`Master_Work_Category_Id`,`Work_Category_Name`,`Active`,`Created_Date`,`Rowversion`) values (1,'MW-Music works','1','2015-03-16 03:48:12','0000-00-00 00:00:00');

/*Table structure for table `wipo_number_assignment` */

DROP TABLE IF EXISTS `wipo_number_assignment`;

CREATE TABLE `wipo_number_assignment` (
  `Num_Assgn_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Num_Assgn_System_Id` varchar(100) NOT NULL,
  `Num_Assgn_Series_From` mediumint(6) NOT NULL,
  `Num_Assgn_Series_To` mediumint(6) NOT NULL,
  `Num_Assgn_List` varchar(50) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Num_Assgn_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_number_assignment` */

/*Table structure for table `wipo_organization` */

DROP TABLE IF EXISTS `wipo_organization`;

CREATE TABLE `wipo_organization` (
  `Org_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Org_Code` varchar(25) NOT NULL,
  `Org_Abbrevation` varchar(100) NOT NULL,
  `Org_Nation_Id` int(11) DEFAULT NULL,
  `Org_Country_Id` int(11) DEFAULT NULL,
  `Org_Currency_Id` int(11) DEFAULT NULL,
  `Org_Society_Type_Id` varchar(50) DEFAULT NULL,
  `Org_Address` text,
  `Org_Telephone` varchar(50) DEFAULT NULL,
  `Org_Email` varchar(50) DEFAULT NULL,
  `Org_Fax` varchar(50) DEFAULT NULL,
  `Org_Website` varchar(50) DEFAULT NULL,
  `Org_Bank_Account` varchar(100) DEFAULT NULL,
  `Org_Related_Rights` int(11) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Org_Id`),
  UNIQUE KEY `NewIndex1` (`Org_Code`),
  KEY `FK_wipo_organization_nation` (`Org_Nation_Id`),
  KEY `Country` (`Org_Country_Id`),
  KEY `Currency` (`Org_Currency_Id`),
  CONSTRAINT `FK_wipo_organization` FOREIGN KEY (`Org_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_organization_currency` FOREIGN KEY (`Org_Currency_Id`) REFERENCES `wipo_master_currency` (`Master_Crncy_Id`),
  CONSTRAINT `FK_wipo_organization_nation` FOREIGN KEY (`Org_Nation_Id`) REFERENCES `wipo_master_nationality` (`Master_Nation_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_organization` */

/*Table structure for table `wipo_performer_account` */

DROP TABLE IF EXISTS `wipo_performer_account`;

CREATE TABLE `wipo_performer_account` (
  `Perf_Acc_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Perf_GUID` varchar(50) NOT NULL,
  `Perf_Is_Author` enum('Y','N') DEFAULT 'N',
  `Perf_Sur_Name` varchar(50) NOT NULL,
  `Perf_First_Name` varchar(255) NOT NULL,
  `Perf_Internal_Code` varchar(255) NOT NULL,
  `Perf_Ipi` int(11) DEFAULT NULL,
  `Perf_Ipi_Base_Number` int(11) DEFAULT NULL,
  `Perf_Ipn_Number` int(11) DEFAULT NULL,
  `Perf_DOB` date DEFAULT NULL,
  `Perf_Place_Of_Birth_Id` int(11) DEFAULT NULL,
  `Perf_Birth_Country_Id` int(11) DEFAULT NULL,
  `Perf_Nationality_Id` int(11) DEFAULT NULL,
  `Perf_Language_Id` int(11) DEFAULT NULL,
  `Perf_Identity_Number` varchar(255) DEFAULT NULL,
  `Perf_Marital_Status_Id` int(11) DEFAULT NULL,
  `Perf_Spouse_Name` varchar(255) DEFAULT NULL,
  `Perf_Gender` enum('M','F') DEFAULT 'M',
  `Perf_Non_Member` enum('Y','N') DEFAULT 'N',
  `Perf_Photo` varchar(500) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Perf_Acc_Id`),
  UNIQUE KEY `Internal_Code` (`Perf_Internal_Code`),
  UNIQUE KEY `Perf_GUID_unique` (`Perf_GUID`),
  KEY `Perf_Account_index` (`Perf_Place_Of_Birth_Id`,`Perf_Birth_Country_Id`,`Perf_Nationality_Id`,`Perf_Language_Id`,`Perf_Marital_Status_Id`),
  KEY `FK_wipo_performer_account_country` (`Perf_Birth_Country_Id`),
  KEY `FK_wipo_performer_account_nationality` (`Perf_Nationality_Id`),
  KEY `FK_wipo_performer_account_language` (`Perf_Language_Id`),
  KEY `FK_wipo_performer_account` (`Perf_Marital_Status_Id`),
  CONSTRAINT `FK_wipo_performer_account` FOREIGN KEY (`Perf_Marital_Status_Id`) REFERENCES `wipo_master_marital_status` (`Master_Marital_State_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_performer_account_country` FOREIGN KEY (`Perf_Birth_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_performer_account_language` FOREIGN KEY (`Perf_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_performer_account_nationality` FOREIGN KEY (`Perf_Nationality_Id`) REFERENCES `wipo_master_nationality` (`Master_Nation_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_performer_account` */

/*Table structure for table `wipo_performer_account_address` */

DROP TABLE IF EXISTS `wipo_performer_account_address`;

CREATE TABLE `wipo_performer_account_address` (
  `Perf_Addr_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Perf_Acc_Id` int(11) NOT NULL,
  `Perf_Home_Address_1` varchar(255) NOT NULL,
  `Perf_Home_Address_2` varchar(255) DEFAULT NULL,
  `Perf_Home_Address_3` varchar(255) DEFAULT NULL,
  `Perf_Home_Fax` varchar(25) DEFAULT NULL,
  `Perf_Home_Telephone` varchar(25) NOT NULL,
  `Perf_Home_Email` varchar(50) NOT NULL,
  `Perf_Home_Website` varchar(100) DEFAULT NULL,
  `Perf_Mailing_Address_1` varchar(255) NOT NULL,
  `Perf_Mailing_Address_2` varchar(255) DEFAULT NULL,
  `Perf_Mailing_Address_3` varchar(255) DEFAULT NULL,
  `Perf_Mailing_Telephone` varchar(25) NOT NULL,
  `Perf_Mailing_Fax` varchar(25) DEFAULT NULL,
  `Perf_Mailing_Email` varchar(50) NOT NULL,
  `Perf_Mailing_Website` varchar(100) DEFAULT NULL,
  `Perf_Author_Account_1` varchar(255) DEFAULT NULL,
  `Perf_Author_Account_2` varchar(255) DEFAULT NULL,
  `Perf_Author_Account_3` varchar(255) DEFAULT NULL,
  `Perf_Performer_Account_1` varchar(255) DEFAULT NULL,
  `Perf_Performer_Account_2` varchar(255) DEFAULT NULL,
  `Perf_Performer_Account_3` varchar(255) DEFAULT NULL,
  `Perf_Unknown_Address` enum('Y','N') DEFAULT 'N',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Perf_Addr_Id`),
  KEY `FK_wipo_performer_account_address_account_id` (`Perf_Acc_Id`),
  CONSTRAINT `FK_wipo_performer_account_address_account_id` FOREIGN KEY (`Perf_Acc_Id`) REFERENCES `wipo_performer_account` (`Perf_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_performer_account_address` */

/*Table structure for table `wipo_performer_biograph_uploads` */

DROP TABLE IF EXISTS `wipo_performer_biograph_uploads`;

CREATE TABLE `wipo_performer_biograph_uploads` (
  `Perf_Biogrph_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Perf_Biogrph_Id` int(11) NOT NULL,
  `Perf_Biogrph_Upl_File` varchar(500) NOT NULL,
  `Perf_Biogrph_Upl_Description` text,
  `Created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Perf_Biogrph_Upl_Id`),
  KEY `FK_wipo_performer_biograph_uploads_biography` (`Perf_Biogrph_Id`),
  CONSTRAINT `FK_wipo_performer_biograph_uploads_biography` FOREIGN KEY (`Perf_Biogrph_Id`) REFERENCES `wipo_performer_biography` (`Perf_Biogrph_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_performer_biograph_uploads` */

/*Table structure for table `wipo_performer_biography` */

DROP TABLE IF EXISTS `wipo_performer_biography`;

CREATE TABLE `wipo_performer_biography` (
  `Perf_Biogrph_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Perf_Acc_Id` int(11) NOT NULL,
  `Perf_Biogrph_Annotation` text NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Perf_Biogrph_Id`),
  KEY `FK_wipo_performer_biography_account_id` (`Perf_Acc_Id`),
  CONSTRAINT `FK_wipo_performer_biography_account_id` FOREIGN KEY (`Perf_Acc_Id`) REFERENCES `wipo_performer_account` (`Perf_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_performer_biography` */

/*Table structure for table `wipo_performer_death_inheritance` */

DROP TABLE IF EXISTS `wipo_performer_death_inheritance`;

CREATE TABLE `wipo_performer_death_inheritance` (
  `Perf_Death_Inhrt_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Perf_Acc_Id` int(11) NOT NULL,
  `Perf_Death_Inhrt_Firstname` varchar(50) NOT NULL,
  `Perf_Death_Inhrt_Surname` varchar(50) NOT NULL,
  `Perf_Death_Inhrt_Email` varchar(100) NOT NULL,
  `Perf_Death_Inhrt_Phone` varchar(50) NOT NULL,
  `Perf_Death_Inhrt_Address_1` varchar(500) NOT NULL,
  `Perf_Death_Inhrt_Address_2` varchar(500) NOT NULL,
  `Perf_Death_Inhrt_Address_3` varchar(500) NOT NULL,
  `Perf_Death_Inhrt_Addtion_Annotation` text,
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Perf_Death_Inhrt_Id`),
  KEY `FK_wipo_performer_death_inheritance_account_id` (`Perf_Acc_Id`),
  CONSTRAINT `FK_wipo_performer_death_inheritance_account_id` FOREIGN KEY (`Perf_Acc_Id`) REFERENCES `wipo_performer_account` (`Perf_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_performer_death_inheritance` */

/*Table structure for table `wipo_performer_payment_method` */

DROP TABLE IF EXISTS `wipo_performer_payment_method`;

CREATE TABLE `wipo_performer_payment_method` (
  `Perf_Pay_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Perf_Acc_Id` int(11) NOT NULL,
  `Perf_Pay_Method_id` int(11) NOT NULL,
  `Perf_Bank_Account_1` varchar(255) NOT NULL,
  `Perf_Bank_Account_2` varchar(255) NOT NULL,
  `Perf_Bank_Account_3` varchar(255) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Perf_Pay_Id`),
  KEY `FK_wipo_performer_payment_method_account_id` (`Perf_Acc_Id`),
  KEY `FK_wipo_performer_payment_method_payment_mode` (`Perf_Pay_Method_id`),
  CONSTRAINT `FK_wipo_performer_payment_method_account_id` FOREIGN KEY (`Perf_Acc_Id`) REFERENCES `wipo_performer_account` (`Perf_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_performer_payment_method_payment_mode` FOREIGN KEY (`Perf_Pay_Method_id`) REFERENCES `wipo_master_payment_method` (`Master_Paymode_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_performer_payment_method` */

/*Table structure for table `wipo_performer_pseudonym` */

DROP TABLE IF EXISTS `wipo_performer_pseudonym`;

CREATE TABLE `wipo_performer_pseudonym` (
  `Perf_Pseudo_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Perf_Acc_Id` int(11) NOT NULL,
  `Perf_Pseudo_Type_Id` int(11) NOT NULL,
  `Perf_Pseudo_Name` varchar(50) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Perf_Pseudo_Id`),
  KEY `FK_wipo_performer_pseudonym_pseodo_type` (`Perf_Pseudo_Type_Id`),
  KEY `FK_wipo_performer_pseudonym_performer_account` (`Perf_Acc_Id`),
  CONSTRAINT `FK_wipo_performer_pseudonym_performer_account` FOREIGN KEY (`Perf_Acc_Id`) REFERENCES `wipo_performer_account` (`Perf_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_performer_pseudonym_pseodo_type` FOREIGN KEY (`Perf_Pseudo_Type_Id`) REFERENCES `wipo_master_pseudonym_types` (`Pseudo_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_performer_pseudonym` */

/*Table structure for table `wipo_performer_related_rights` */

DROP TABLE IF EXISTS `wipo_performer_related_rights`;

CREATE TABLE `wipo_performer_related_rights` (
  `Perf_Rel_Rgt_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Perf_Acc_Id` int(11) NOT NULL,
  `Perf_Rel_Society_Id` int(11) NOT NULL,
  `Perf_Rel_Entry_Date` date NOT NULL,
  `Perf_Rel_Exit_Date` date DEFAULT NULL,
  `Perf_Rel_Internal_Position_Id` int(11) NOT NULL,
  `Perf_Rel_Entry_Date_2` date NOT NULL,
  `Perf_Rel_Exit_Date_2` date DEFAULT NULL,
  `Perf_Rel_Region_Id` int(11) DEFAULT NULL,
  `Perf_Rel_Profession_Id` int(11) DEFAULT NULL,
  `Perf_Rel_File` varchar(255) DEFAULT NULL,
  `Perf_Rel_Duration` varchar(100) DEFAULT NULL,
  `Perf_Rel_Avl_Work_Cat_Id` int(11) NOT NULL,
  `Perf_Rel_Type_Rght_Id` int(11) NOT NULL,
  `Perf_Rel_Managed_Rights_Id` int(11) NOT NULL,
  `Perf_Rel_Territories_Id` int(11) NOT NULL,
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Perf_Rel_Rgt_Id`),
  KEY `FK_wipo_performer_related_rights_account_id` (`Perf_Acc_Id`),
  KEY `FK_wipo_performer_related_rights_internal_position` (`Perf_Rel_Internal_Position_Id`),
  KEY `FK_wipo_performer_related_rights_region` (`Perf_Rel_Region_Id`),
  KEY `FK_wipo_performer_related_rights_profession` (`Perf_Rel_Profession_Id`),
  KEY `FK_wipo_performer_related_rights_work_category` (`Perf_Rel_Avl_Work_Cat_Id`),
  KEY `FK_wipo_performer_related_rights_type_of_rights` (`Perf_Rel_Type_Rght_Id`),
  KEY `FK_wipo_performer_related_rights_managerd_rights` (`Perf_Rel_Managed_Rights_Id`),
  KEY `FK_wipo_performer_related_rights_territories` (`Perf_Rel_Territories_Id`),
  CONSTRAINT `FK_wipo_performer_related_rights_account_id` FOREIGN KEY (`Perf_Acc_Id`) REFERENCES `wipo_performer_account` (`Perf_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_performer_related_rights_internal_position` FOREIGN KEY (`Perf_Rel_Internal_Position_Id`) REFERENCES `wipo_master_internal_position` (`Master_Int_Post_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_performer_related_rights_managerd_rights` FOREIGN KEY (`Perf_Rel_Managed_Rights_Id`) REFERENCES `wipo_master_managed_rights` (`Master_Mgd_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_performer_related_rights_profession` FOREIGN KEY (`Perf_Rel_Profession_Id`) REFERENCES `wipo_master_profession` (`Master_Profession_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_performer_related_rights_region` FOREIGN KEY (`Perf_Rel_Region_Id`) REFERENCES `wipo_master_region` (`Master_Region_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_performer_related_rights_territories` FOREIGN KEY (`Perf_Rel_Territories_Id`) REFERENCES `wipo_master_territories` (`Master_Territory_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_performer_related_rights_type_of_rights` FOREIGN KEY (`Perf_Rel_Type_Rght_Id`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_performer_related_rights_work_category` FOREIGN KEY (`Perf_Rel_Avl_Work_Cat_Id`) REFERENCES `wipo_master_works_category` (`Master_Work_Category_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_performer_related_rights` */

/*Table structure for table `wipo_performer_upload` */

DROP TABLE IF EXISTS `wipo_performer_upload`;

CREATE TABLE `wipo_performer_upload` (
  `Perf_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Perf_Acc_Id` int(11) NOT NULL,
  `Perf_Upl_Doc_Name` varchar(255) NOT NULL,
  `Perf_Upl_File` varchar(1000) NOT NULL,
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Perf_Upl_Id`),
  KEY `FK_wipo_performer_upload_auth` (`Perf_Acc_Id`),
  CONSTRAINT `FK_wipo_performer_upload_auth` FOREIGN KEY (`Perf_Acc_Id`) REFERENCES `wipo_performer_account` (`Perf_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_performer_upload` */

/*Table structure for table `wipo_producer_account` */

DROP TABLE IF EXISTS `wipo_producer_account`;

CREATE TABLE `wipo_producer_account` (
  `Pro_Acc_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pro_GUID` varchar(50) NOT NULL,
  `Pro_Is_Publisher` enum('N','Y') NOT NULL DEFAULT 'N',
  `Pro_Corporate_Name` varchar(255) NOT NULL,
  `Pro_Internal_Code` varchar(255) NOT NULL,
  `Pro_Ipi` mediumint(9) DEFAULT NULL,
  `Pro_Ipi_Base_Number` mediumint(9) DEFAULT NULL,
  `Pro_Date` date NOT NULL,
  `Pro_Place` varchar(255) DEFAULT NULL,
  `Pro_Country_Id` int(11) DEFAULT NULL,
  `Pro_Legal_Form_id` int(11) DEFAULT NULL,
  `Pro_Reg_Date` date DEFAULT NULL,
  `Pro_Reg_Number` varchar(255) DEFAULT NULL,
  `Pro_Excerpt_Date` date DEFAULT NULL,
  `Pro_Language_Id` int(11) DEFAULT NULL,
  `Pro_Non_Member` enum('Y','N') DEFAULT 'N',
  `Pro_Photo` varchar(500) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pro_Acc_Id`),
  UNIQUE KEY `Pro_GUID_unique` (`Pro_GUID`),
  KEY `FK_wipo_producer_account_country` (`Pro_Country_Id`),
  KEY `FK_wipo_producer_account_legal_form` (`Pro_Legal_Form_id`),
  KEY `FK_wipo_producer_account_language` (`Pro_Language_Id`),
  CONSTRAINT `FK_wipo_producer_account_country` FOREIGN KEY (`Pro_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_account_language` FOREIGN KEY (`Pro_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_account_legal_form` FOREIGN KEY (`Pro_Legal_Form_id`) REFERENCES `wipo_master_legal_form` (`Master_Legal_Form_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_producer_account` */

/*Table structure for table `wipo_producer_account_address` */

DROP TABLE IF EXISTS `wipo_producer_account_address`;

CREATE TABLE `wipo_producer_account_address` (
  `Pro_Addr_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pro_Acc_Id` int(11) NOT NULL,
  `Pro_Head_Address_1` varchar(255) NOT NULL,
  `Pro_Head_Address_2` varchar(255) DEFAULT NULL,
  `Pro_Head_Address_3` varchar(255) DEFAULT NULL,
  `Pro_Head_Fax` varchar(25) DEFAULT NULL,
  `Pro_Head_Telephone` varchar(25) NOT NULL,
  `Pro_Head_Email` varchar(50) NOT NULL,
  `Pro_Head_Website` varchar(100) DEFAULT NULL,
  `Pro_Mailing_Address_1` varchar(255) NOT NULL,
  `Pro_Mailing_Address_2` varchar(255) DEFAULT NULL,
  `Pro_Mailing_Address_3` varchar(255) DEFAULT NULL,
  `Pro_Mailing_Telephone` varchar(25) NOT NULL,
  `Pro_Mailing_Fax` varchar(25) DEFAULT NULL,
  `Pro_Mailing_Email` varchar(50) NOT NULL,
  `Pro_Mailing_Website` varchar(100) DEFAULT NULL,
  `Pro_Publisher_Account_1` varchar(255) DEFAULT NULL,
  `Pro_Publisher_Account_2` varchar(255) DEFAULT NULL,
  `Pro_Publisher_Account_3` varchar(255) DEFAULT NULL,
  `Pro_Producer_Account_1` varchar(255) DEFAULT NULL,
  `Pro_Producer_Account_2` varchar(255) DEFAULT NULL,
  `Pro_Producer_Account_3` varchar(255) DEFAULT NULL,
  `Pro_Addr_Country_Id` int(11) DEFAULT NULL,
  `Pro_Unknown_Address` enum('Y','N') DEFAULT 'N',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pro_Addr_Id`),
  KEY `FK_wipo_producer_account_address_account_id` (`Pro_Acc_Id`),
  KEY `FK_wipo_producer_account_address_country` (`Pro_Addr_Country_Id`),
  CONSTRAINT `FK_wipo_producer_account_address_account_id` FOREIGN KEY (`Pro_Acc_Id`) REFERENCES `wipo_producer_account` (`Pro_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_account_address_country` FOREIGN KEY (`Pro_Addr_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_producer_account_address` */

/*Table structure for table `wipo_producer_biograph_uploads` */

DROP TABLE IF EXISTS `wipo_producer_biograph_uploads`;

CREATE TABLE `wipo_producer_biograph_uploads` (
  `Pro_Biogrph_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pro_Biogrph_Id` int(11) NOT NULL,
  `Pro_Biogrph_Upl_File` varchar(500) NOT NULL,
  `Pro_Biogrph_Upl_Description` text,
  `Created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT NULL,
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pro_Biogrph_Upl_Id`),
  KEY `FK_wipo_producer_biograph_uploads_biography` (`Pro_Biogrph_Id`),
  CONSTRAINT `FK_wipo_producer_biograph_uploads_biography` FOREIGN KEY (`Pro_Biogrph_Id`) REFERENCES `wipo_producer_biography` (`Pro_Biogrph_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_producer_biograph_uploads` */

/*Table structure for table `wipo_producer_biography` */

DROP TABLE IF EXISTS `wipo_producer_biography`;

CREATE TABLE `wipo_producer_biography` (
  `Pro_Biogrph_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pro_Acc_Id` int(11) NOT NULL,
  `Pro_Managers` varchar(500) DEFAULT NULL,
  `Pro_Biogrph_Annotation` text NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pro_Biogrph_Id`),
  KEY `FK_wipo_producer_biography_account_id` (`Pro_Acc_Id`),
  CONSTRAINT `FK_wipo_producer_biography_account_id` FOREIGN KEY (`Pro_Acc_Id`) REFERENCES `wipo_producer_account` (`Pro_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_producer_biography` */

/*Table structure for table `wipo_producer_label_owner` */

DROP TABLE IF EXISTS `wipo_producer_label_owner`;

CREATE TABLE `wipo_producer_label_owner` (
  `Label_Owner_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pro_Acc_Id` int(11) NOT NULL,
  `Label_Id` int(11) NOT NULL,
  `Label_Owner_From` date NOT NULL,
  `Label_Owner_To` date NOT NULL,
  `Label_Share` decimal(10,2) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Label_Owner_Id`),
  KEY `FK_wipo_producer_label_owner_label` (`Label_Id`),
  KEY `FK_wipo_producer_label_owner_producer` (`Pro_Acc_Id`),
  CONSTRAINT `FK_wipo_producer_label_owner_label` FOREIGN KEY (`Label_Id`) REFERENCES `wipo_master_label` (`Master_Label_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_label_owner_producer` FOREIGN KEY (`Pro_Acc_Id`) REFERENCES `wipo_producer_account` (`Pro_Acc_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_producer_label_owner` */

/*Table structure for table `wipo_producer_payment_method` */

DROP TABLE IF EXISTS `wipo_producer_payment_method`;

CREATE TABLE `wipo_producer_payment_method` (
  `Pro_Pay_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pro_Acc_Id` int(11) NOT NULL,
  `Pro_Pay_Method_id` int(11) NOT NULL,
  `Pro_Bank_Account` mediumint(9) NOT NULL,
  `Pro_Bank_Code` mediumint(9) DEFAULT NULL,
  `Pro_Bank_Branch` mediumint(9) DEFAULT NULL,
  `Pro_Pay_Address` varchar(255) DEFAULT NULL,
  `Pro_Pay_Iban` varchar(255) DEFAULT NULL,
  `Pro_Pay_Swift` varchar(255) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pro_Pay_Id`),
  KEY `FK_wipo_producer_payment_method_account_id` (`Pro_Acc_Id`),
  KEY `FK_wipo_producer_payment_method_payment_mode` (`Pro_Pay_Method_id`),
  CONSTRAINT `FK_wipo_producer_payment_method_account_id` FOREIGN KEY (`Pro_Acc_Id`) REFERENCES `wipo_producer_account` (`Pro_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_payment_method_payment_mode` FOREIGN KEY (`Pro_Pay_Method_id`) REFERENCES `wipo_master_payment_method` (`Master_Paymode_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_producer_payment_method` */

/*Table structure for table `wipo_producer_pseudonym` */

DROP TABLE IF EXISTS `wipo_producer_pseudonym`;

CREATE TABLE `wipo_producer_pseudonym` (
  `Pro_Pseudo_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pro_Acc_Id` int(11) NOT NULL,
  `Pro_Pseudo_Type_Id` int(11) NOT NULL,
  `Pro_Pseudo_Name` varchar(50) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pro_Pseudo_Id`),
  KEY `FK_wipo_producer_pseudonym_pseodo_type` (`Pro_Pseudo_Type_Id`),
  KEY `FK_wipo_producer_pseudonym_producer_account` (`Pro_Acc_Id`),
  CONSTRAINT `FK_wipo_producer_pseudonym_producer_account` FOREIGN KEY (`Pro_Acc_Id`) REFERENCES `wipo_producer_account` (`Pro_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_pseudonym_pseodo_type` FOREIGN KEY (`Pro_Pseudo_Type_Id`) REFERENCES `wipo_master_pseudonym_types` (`Pseudo_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_producer_pseudonym` */

/*Table structure for table `wipo_producer_related_rights` */

DROP TABLE IF EXISTS `wipo_producer_related_rights`;

CREATE TABLE `wipo_producer_related_rights` (
  `Pro_Rel_Rgt_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pro_Acc_Id` int(11) NOT NULL,
  `Pro_Rel_Society_Id` int(11) NOT NULL,
  `Pro_Rel_Entry_Date` date NOT NULL,
  `Pro_Rel_Exit_Date` date DEFAULT NULL,
  `Pro_Rel_Internal_Position_Id` int(11) NOT NULL,
  `Pro_Rel_Entry_Date_2` date NOT NULL,
  `Pro_Rel_Exit_Date_2` date DEFAULT NULL,
  `Pro_Rel_Region_Id` int(11) DEFAULT NULL,
  `Pro_Rel_Profession_Id` int(11) DEFAULT NULL,
  `Pro_Rel_File` varchar(255) DEFAULT NULL,
  `Pro_Rel_Duration` varchar(100) DEFAULT NULL,
  `Pro_Rel_Avl_Work_Cat_Id` int(11) NOT NULL,
  `Pro_Rel_Type_Rght_Id` int(11) DEFAULT NULL,
  `Pro_Rel_Managed_Rights_Id` int(11) NOT NULL,
  `Pro_Rel_Territories_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pro_Rel_Rgt_Id`),
  KEY `FK_wipo_producer_related_rights_account_id` (`Pro_Acc_Id`),
  KEY `FK_wipo_producer_related_rights_internal_position` (`Pro_Rel_Internal_Position_Id`),
  KEY `FK_wipo_producer_related_rights_region` (`Pro_Rel_Region_Id`),
  KEY `FK_wipo_producer_related_rights_profession` (`Pro_Rel_Profession_Id`),
  KEY `FK_wipo_producer_related_rights_work_category` (`Pro_Rel_Avl_Work_Cat_Id`),
  KEY `FK_wipo_producer_related_rights_type_of_rights` (`Pro_Rel_Type_Rght_Id`),
  KEY `FK_wipo_producer_related_rights_managerd_rights` (`Pro_Rel_Managed_Rights_Id`),
  KEY `FK_wipo_producer_related_rights_territories` (`Pro_Rel_Territories_Id`),
  CONSTRAINT `FK_wipo_producer_related_rights_account_id` FOREIGN KEY (`Pro_Acc_Id`) REFERENCES `wipo_producer_account` (`Pro_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_related_rights_internal_position` FOREIGN KEY (`Pro_Rel_Internal_Position_Id`) REFERENCES `wipo_master_internal_position` (`Master_Int_Post_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_related_rights_managerd_rights` FOREIGN KEY (`Pro_Rel_Managed_Rights_Id`) REFERENCES `wipo_master_managed_rights` (`Master_Mgd_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_related_rights_profession` FOREIGN KEY (`Pro_Rel_Profession_Id`) REFERENCES `wipo_master_profession` (`Master_Profession_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_related_rights_region` FOREIGN KEY (`Pro_Rel_Region_Id`) REFERENCES `wipo_master_region` (`Master_Region_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_related_rights_territories` FOREIGN KEY (`Pro_Rel_Territories_Id`) REFERENCES `wipo_master_territories` (`Master_Territory_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_related_rights_type_of_rights` FOREIGN KEY (`Pro_Rel_Type_Rght_Id`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_producer_related_rights_work_category` FOREIGN KEY (`Pro_Rel_Avl_Work_Cat_Id`) REFERENCES `wipo_master_works_category` (`Master_Work_Category_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_producer_related_rights` */

/*Table structure for table `wipo_producer_succession` */

DROP TABLE IF EXISTS `wipo_producer_succession`;

CREATE TABLE `wipo_producer_succession` (
  `Pro_Suc_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pro_Acc_Id` int(11) NOT NULL,
  `Pro_Suc_Date_Transfer` date DEFAULT NULL,
  `Pro_Suc_Name` varchar(255) NOT NULL,
  `Pro_Suc_Address_1` varchar(500) NOT NULL,
  `Pro_Suc_Address_2` varchar(500) DEFAULT NULL,
  `Pro_Suc_Annotation` text NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pro_Suc_Id`),
  KEY `FK_wipo_producer_succession_acount` (`Pro_Acc_Id`),
  CONSTRAINT `FK_wipo_producer_succession_acount` FOREIGN KEY (`Pro_Acc_Id`) REFERENCES `wipo_producer_account` (`Pro_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_producer_succession` */

/*Table structure for table `wipo_publisher_account` */

DROP TABLE IF EXISTS `wipo_publisher_account`;

CREATE TABLE `wipo_publisher_account` (
  `Pub_Acc_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_GUID` varchar(50) NOT NULL,
  `Pub_Is_Producer` enum('N','Y') DEFAULT 'N',
  `Pub_Corporate_Name` varchar(255) NOT NULL,
  `Pub_Internal_Code` varchar(255) NOT NULL,
  `Pub_Ipi` mediumint(9) DEFAULT NULL,
  `Pub_Ipi_Base_Number` mediumint(9) DEFAULT NULL,
  `Pub_Date` date NOT NULL,
  `Pub_Place` varchar(255) DEFAULT NULL,
  `Pub_Country_Id` int(11) DEFAULT NULL,
  `Pub_Legal_Form_id` int(11) DEFAULT NULL,
  `Pub_Reg_Date` date DEFAULT NULL,
  `Pub_Reg_Number` varchar(255) DEFAULT NULL,
  `Pub_Excerpt_Date` date DEFAULT NULL,
  `Pub_Language_Id` int(11) DEFAULT NULL,
  `Pub_Non_Member` enum('Y','N') DEFAULT 'N',
  `Pub_Photo` varchar(500) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Acc_Id`),
  UNIQUE KEY `Pub_GUID_unique` (`Pub_GUID`),
  KEY `FK_wipo_publisher_account_country` (`Pub_Country_Id`),
  KEY `FK_wipo_publisher_account_legal_form` (`Pub_Legal_Form_id`),
  KEY `FK_wipo_publisher_account_language` (`Pub_Language_Id`),
  CONSTRAINT `FK_wipo_publisher_account_country` FOREIGN KEY (`Pub_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_account_language` FOREIGN KEY (`Pub_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_account_legal_form` FOREIGN KEY (`Pub_Legal_Form_id`) REFERENCES `wipo_master_legal_form` (`Master_Legal_Form_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_account` */

/*Table structure for table `wipo_publisher_account_address` */

DROP TABLE IF EXISTS `wipo_publisher_account_address`;

CREATE TABLE `wipo_publisher_account_address` (
  `Pub_Addr_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Acc_Id` int(11) NOT NULL,
  `Pub_Head_Address_1` varchar(255) NOT NULL,
  `Pub_Head_Address_2` varchar(255) DEFAULT NULL,
  `Pub_Head_Address_3` varchar(255) DEFAULT NULL,
  `Pub_Head_Fax` varchar(25) DEFAULT NULL,
  `Pub_Head_Telephone` varchar(25) NOT NULL,
  `Pub_Head_Email` varchar(50) NOT NULL,
  `Pub_Head_Website` varchar(100) DEFAULT NULL,
  `Pub_Mailing_Address_1` varchar(255) NOT NULL,
  `Pub_Mailing_Address_2` varchar(255) DEFAULT NULL,
  `Pub_Mailing_Address_3` varchar(255) DEFAULT NULL,
  `Pub_Mailing_Telephone` varchar(25) NOT NULL,
  `Pub_Mailing_Fax` varchar(25) DEFAULT NULL,
  `Pub_Mailing_Email` varchar(50) NOT NULL,
  `Pub_Mailing_Website` varchar(100) DEFAULT NULL,
  `Pub_Publisher_Account_1` varchar(255) DEFAULT NULL,
  `Pub_Publisher_Account_2` varchar(255) DEFAULT NULL,
  `Pub_Publisher_Account_3` varchar(255) DEFAULT NULL,
  `Pub_Producer_Account_1` varchar(255) DEFAULT NULL,
  `Pub_Producer_Account_2` varchar(255) DEFAULT NULL,
  `Pub_Producer_Account_3` varchar(255) DEFAULT NULL,
  `Pub_Addr_Country_Id` int(11) DEFAULT NULL,
  `Pub_Unknown_Address` enum('Y','N') DEFAULT 'N',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Addr_Id`),
  KEY `FK_wipo_publisher_account_address_account_id` (`Pub_Acc_Id`),
  KEY `FK_wipo_publisher_account_address_country` (`Pub_Addr_Country_Id`),
  CONSTRAINT `FK_wipo_publisher_account_address_account_id` FOREIGN KEY (`Pub_Acc_Id`) REFERENCES `wipo_publisher_account` (`Pub_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_account_address_country` FOREIGN KEY (`Pub_Addr_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_account_address` */

/*Table structure for table `wipo_publisher_biograph_uploads` */

DROP TABLE IF EXISTS `wipo_publisher_biograph_uploads`;

CREATE TABLE `wipo_publisher_biograph_uploads` (
  `Pub_Biogrph_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Biogrph_Id` int(11) NOT NULL,
  `Pub_Biogrph_Upl_File` varchar(500) NOT NULL,
  `Pub_Biogrph_Upl_Description` text,
  `Created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Biogrph_Upl_Id`),
  KEY `FK_wipo_publisher_biograph_uploads_biography` (`Pub_Biogrph_Id`),
  CONSTRAINT `FK_wipo_publisher_biograph_uploads_biography` FOREIGN KEY (`Pub_Biogrph_Id`) REFERENCES `wipo_publisher_biography` (`Pub_Biogrph_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_biograph_uploads` */

/*Table structure for table `wipo_publisher_biography` */

DROP TABLE IF EXISTS `wipo_publisher_biography`;

CREATE TABLE `wipo_publisher_biography` (
  `Pub_Biogrph_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Acc_Id` int(11) NOT NULL,
  `Pub_Managers` varchar(500) DEFAULT NULL,
  `Pub_Biogrph_Annotation` text NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Biogrph_Id`),
  KEY `FK_wipo_publisher_biography_account_id` (`Pub_Acc_Id`),
  CONSTRAINT `FK_wipo_publisher_biography_account_id` FOREIGN KEY (`Pub_Acc_Id`) REFERENCES `wipo_publisher_account` (`Pub_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_biography` */

/*Table structure for table `wipo_publisher_group` */

DROP TABLE IF EXISTS `wipo_publisher_group`;

CREATE TABLE `wipo_publisher_group` (
  `Pub_Group_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Group_GUID` varchar(50) NOT NULL,
  `Pub_Group_Name` varchar(100) NOT NULL,
  `Pub_Group_Is_Publisher` enum('0','1') DEFAULT '0',
  `Pub_Group_Is_Producer` enum('0','1') DEFAULT '0',
  `Pub_Group_Internal_Code` varchar(50) NOT NULL,
  `Pub_Group_IPI_Name_Number` int(11) DEFAULT NULL,
  `Pub_Group_IPN_Base_Number` int(11) DEFAULT NULL,
  `Pub_Group_IPD_Number` int(11) DEFAULT NULL,
  `Pub_Group_Date` date NOT NULL,
  `Pub_Group_Place` varchar(100) DEFAULT NULL,
  `Pub_Group_Country_Id` int(11) DEFAULT NULL,
  `Pub_Group_Legal_Form_Id` int(11) DEFAULT NULL,
  `Pub_Group_Language_Id` int(11) DEFAULT NULL,
  `Pub_Group_Non_Member` enum('Y','N') DEFAULT 'N',
  `Pub_Group_Photo` varchar(500) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Id`),
  UNIQUE KEY `Pub_Group_GUID_unique` (`Pub_Group_GUID`),
  KEY `FK_wipo_publisher_group_country` (`Pub_Group_Country_Id`),
  KEY `FK_wipo_publisher_group_language` (`Pub_Group_Language_Id`),
  KEY `FK_wipo_publisher_group_legal_form` (`Pub_Group_Legal_Form_Id`),
  CONSTRAINT `FK_wipo_publisher_group_country` FOREIGN KEY (`Pub_Group_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_group_language` FOREIGN KEY (`Pub_Group_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_group_legal_form` FOREIGN KEY (`Pub_Group_Legal_Form_Id`) REFERENCES `wipo_master_legal_form` (`Master_Legal_Form_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group` */

/*Table structure for table `wipo_publisher_group_biograph_uploads` */

DROP TABLE IF EXISTS `wipo_publisher_group_biograph_uploads`;

CREATE TABLE `wipo_publisher_group_biograph_uploads` (
  `Pub_Group_Biogrph_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Biogrph_Id` int(11) NOT NULL,
  `Pub_Group_Biogrph_Upl_File` varchar(500) NOT NULL,
  `Pub_Group_Biogrph_Upl_Description` text,
  `Created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Biogrph_Upl_Id`),
  KEY `FK_wipo_publisher_group_biograph_uploads_biography` (`Pub_Group_Biogrph_Id`),
  CONSTRAINT `FK_wipo_publisher_group_biograph_uploads_biography` FOREIGN KEY (`Pub_Group_Biogrph_Id`) REFERENCES `wipo_publisher_group_biography` (`Pub_Group_Biogrph_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_biograph_uploads` */

/*Table structure for table `wipo_publisher_group_biography` */

DROP TABLE IF EXISTS `wipo_publisher_group_biography`;

CREATE TABLE `wipo_publisher_group_biography` (
  `Pub_Group_Biogrph_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Id` int(11) NOT NULL,
  `Pub_Group_Biogrph_Annotation` text NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Biogrph_Id`),
  KEY `FK_wipo_publisher_group_biography_account_id` (`Pub_Group_Id`),
  CONSTRAINT `FK_wipo_publisher_group_biography_account_id` FOREIGN KEY (`Pub_Group_Id`) REFERENCES `wipo_publisher_group` (`Pub_Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_biography` */

/*Table structure for table `wipo_publisher_group_catalogue` */

DROP TABLE IF EXISTS `wipo_publisher_group_catalogue`;

CREATE TABLE `wipo_publisher_group_catalogue` (
  `Pub_Group_Cat_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Id` int(11) NOT NULL,
  `Pub_Group_Cat_Number` varchar(100) NOT NULL,
  `Pub_Group_Cat_Start_Date` date NOT NULL,
  `Pub_Group_Cat_End_Date` date NOT NULL,
  `Pub_Group_Cat_Name` varchar(100) NOT NULL,
  `Pub_Group_Cat_Territory_Id` int(11) NOT NULL,
  `Pub_Group_Cat_Clasue` enum('M','S') NOT NULL DEFAULT 'M',
  `Pub_Group_Cat_Sign_Date` date NOT NULL,
  `Pub_Group_Cat_File` varchar(255) NOT NULL,
  `Pub_Group_Cat_Reference` smallint(6) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Cat_Id`),
  KEY `FK_wipo_publisher_group_catalogue_group` (`Pub_Group_Id`),
  KEY `FK_wipo_publisher_group_catalogue_territory` (`Pub_Group_Cat_Territory_Id`),
  CONSTRAINT `FK_wipo_publisher_group_catalogue_group` FOREIGN KEY (`Pub_Group_Id`) REFERENCES `wipo_publisher_group` (`Pub_Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_group_catalogue_territory` FOREIGN KEY (`Pub_Group_Cat_Territory_Id`) REFERENCES `wipo_master_territories` (`Master_Territory_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_catalogue` */

/*Table structure for table `wipo_publisher_group_copyright_payment` */

DROP TABLE IF EXISTS `wipo_publisher_group_copyright_payment`;

CREATE TABLE `wipo_publisher_group_copyright_payment` (
  `Pub_Group_Pay_Copy_Id` int(10) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Id` int(11) NOT NULL,
  `Pub_Group_Pay_Copy_Payee` varchar(100) NOT NULL,
  `Pub_Group_Pay_Copy_Rate` decimal(10,2) NOT NULL,
  `Pub_Group_Pay_Copy_Pay_Method` int(11) NOT NULL,
  `Pub_Group_Pay_Copy_Bank_Account` mediumint(9) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Pay_Copy_Id`),
  KEY `FK_wipo_publisher_group_copyright_payment_group` (`Pub_Group_Id`),
  CONSTRAINT `FK_wipo_publisher_group_copyright_payment_group` FOREIGN KEY (`Pub_Group_Id`) REFERENCES `wipo_publisher_group` (`Pub_Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_copyright_payment` */

/*Table structure for table `wipo_publisher_group_manage_rights` */

DROP TABLE IF EXISTS `wipo_publisher_group_manage_rights`;

CREATE TABLE `wipo_publisher_group_manage_rights` (
  `Pub_Group_Mnge_Rgt_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Id` int(11) NOT NULL,
  `Pub_Group_Mnge_Society_Id` int(11) NOT NULL,
  `Pub_Group_Mnge_Entry_Date` date NOT NULL,
  `Pub_Group_Mnge_Exit_Date` date DEFAULT NULL,
  `Pub_Group_Mnge_Internal_Position_Id` int(11) NOT NULL,
  `Pub_Group_Mnge_Entry_Date_2` date NOT NULL,
  `Pub_Group_Mnge_Exit_Date_2` date DEFAULT NULL,
  `Pub_Group_Mnge_Region_Id` int(11) DEFAULT NULL,
  `Pub_Group_Mnge_Profession_Id` int(11) DEFAULT NULL,
  `Pub_Group_Mnge_File` varchar(255) DEFAULT NULL,
  `Pub_Group_Mnge_Duration` varchar(100) DEFAULT NULL,
  `Pub_Group_Mnge_Avl_Work_Cat_Id` int(11) NOT NULL,
  `Pub_Group_Mnge_Type_Rght_Id` int(11) NOT NULL,
  `Pub_Group_Mnge_Managed_Rights_Id` int(11) NOT NULL,
  `Pub_Group_Mnge_Territories_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Mnge_Rgt_Id`),
  KEY `FK_wipo_publisher_group_manage_rights_account_id` (`Pub_Group_Id`),
  KEY `FK_wipo_publisher_group_manage_rights_internal_position` (`Pub_Group_Mnge_Internal_Position_Id`),
  KEY `FK_wipo_publisher_group_manage_rights_region` (`Pub_Group_Mnge_Region_Id`),
  KEY `FK_wipo_publisher_group_manage_rights_profession` (`Pub_Group_Mnge_Profession_Id`),
  KEY `FK_wipo_publisher_group_manage_rights_work_category` (`Pub_Group_Mnge_Avl_Work_Cat_Id`),
  KEY `FK_wipo_publisher_group_manage_rights_type_of_rights` (`Pub_Group_Mnge_Type_Rght_Id`),
  KEY `FK_wipo_publisher_group_manage_rights_managerd_rights` (`Pub_Group_Mnge_Managed_Rights_Id`),
  KEY `FK_wipo_publisher_group_manage_rights_territories` (`Pub_Group_Mnge_Territories_Id`),
  KEY `FK_wipo_publisher_group_manage_rights_society` (`Pub_Group_Mnge_Society_Id`),
  CONSTRAINT `FK_wipo_publisher_group_manage_rights_account_id` FOREIGN KEY (`Pub_Group_Id`) REFERENCES `wipo_publisher_group` (`Pub_Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_group_manage_rights_internal_position` FOREIGN KEY (`Pub_Group_Mnge_Internal_Position_Id`) REFERENCES `wipo_master_internal_position` (`Master_Int_Post_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_group_manage_rights_managerd_rights` FOREIGN KEY (`Pub_Group_Mnge_Managed_Rights_Id`) REFERENCES `wipo_master_managed_rights` (`Master_Mgd_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_group_manage_rights_profession` FOREIGN KEY (`Pub_Group_Mnge_Profession_Id`) REFERENCES `wipo_master_profession` (`Master_Profession_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_group_manage_rights_region` FOREIGN KEY (`Pub_Group_Mnge_Region_Id`) REFERENCES `wipo_master_region` (`Master_Region_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_group_manage_rights_society` FOREIGN KEY (`Pub_Group_Mnge_Society_Id`) REFERENCES `wipo_society` (`Society_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_group_manage_rights_territories` FOREIGN KEY (`Pub_Group_Mnge_Territories_Id`) REFERENCES `wipo_master_territories` (`Master_Territory_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_group_manage_rights_type_of_rights` FOREIGN KEY (`Pub_Group_Mnge_Type_Rght_Id`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_group_manage_rights_work_category` FOREIGN KEY (`Pub_Group_Mnge_Avl_Work_Cat_Id`) REFERENCES `wipo_master_works_category` (`Master_Work_Category_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_manage_rights` */

/*Table structure for table `wipo_publisher_group_members` */

DROP TABLE IF EXISTS `wipo_publisher_group_members`;

CREATE TABLE `wipo_publisher_group_members` (
  `Pub_Group_Member_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Id` int(11) NOT NULL,
  `Pub_Group_Member_GUID` varchar(50) NOT NULL,
  `Created_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Pub_Group_Member_Id`),
  KEY `FK_wipo_publisher_group_biography_account_id` (`Pub_Group_Id`),
  KEY `FK_wipo_publisher_group_members_Internal_Code` (`Pub_Group_Member_GUID`),
  CONSTRAINT `FK_wipo_publisher_group_members_publisher_group` FOREIGN KEY (`Pub_Group_Id`) REFERENCES `wipo_publisher_group` (`Pub_Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_members` */

/*Table structure for table `wipo_publisher_group_original_publisher` */

DROP TABLE IF EXISTS `wipo_publisher_group_original_publisher`;

CREATE TABLE `wipo_publisher_group_original_publisher` (
  `Pub_Group_Org_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Id` int(11) NOT NULL,
  `Pub_Group_Org_IPI_Name_Number` varchar(100) NOT NULL,
  `Pub_Group_Org_IPI_Base_Number` varchar(100) NOT NULL,
  `Pub_Group_Org_Internal_Code` varchar(100) NOT NULL,
  `Pub_Group_Org_Name` varchar(100) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Org_Id`),
  KEY `FK_wipo_publisher_group_original_publisher_group` (`Pub_Group_Id`),
  CONSTRAINT `FK_wipo_publisher_group_original_publisher_group` FOREIGN KEY (`Pub_Group_Id`) REFERENCES `wipo_publisher_group` (`Pub_Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_original_publisher` */

/*Table structure for table `wipo_publisher_group_original_share` */

DROP TABLE IF EXISTS `wipo_publisher_group_original_share`;

CREATE TABLE `wipo_publisher_group_original_share` (
  `Pub_Group_Share_Org_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Id` int(11) NOT NULL,
  `Pub_Group_Org_Share_Broadcast` decimal(10,2) NOT NULL,
  `Pub_Group_Org_Share_Mechanical` decimal(10,2) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Share_Org_Id`),
  KEY `FK_wipo_publisher_group_original_share_group` (`Pub_Group_Id`),
  CONSTRAINT `FK_wipo_publisher_group_original_share_group` FOREIGN KEY (`Pub_Group_Id`) REFERENCES `wipo_publisher_group` (`Pub_Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_original_share` */

/*Table structure for table `wipo_publisher_group_pseudonym` */

DROP TABLE IF EXISTS `wipo_publisher_group_pseudonym`;

CREATE TABLE `wipo_publisher_group_pseudonym` (
  `Pub_Group_Pseudo_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Id` int(11) NOT NULL,
  `Pub_Group_Pseudo_Type_Id` int(11) NOT NULL,
  `Pub_Group_Pseudo_Name` varchar(50) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Pseudo_Id`),
  KEY `FK_wipo_publisher_group_pseudonym_group` (`Pub_Group_Id`),
  KEY `FK_wipo_publisher_group_pseudonym` (`Pub_Group_Pseudo_Type_Id`),
  CONSTRAINT `FK_wipo_publisher_group_pseudonym` FOREIGN KEY (`Pub_Group_Pseudo_Type_Id`) REFERENCES `wipo_master_pseudonym_types` (`Pseudo_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_group_pseudonym_group` FOREIGN KEY (`Pub_Group_Id`) REFERENCES `wipo_publisher_group` (`Pub_Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_pseudonym` */

/*Table structure for table `wipo_publisher_group_related_payment` */

DROP TABLE IF EXISTS `wipo_publisher_group_related_payment`;

CREATE TABLE `wipo_publisher_group_related_payment` (
  `Pub_Group_Pay_Rel_Id` int(10) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Id` int(11) NOT NULL,
  `Pub_Group_Pay_Rel_Payee` varchar(100) NOT NULL,
  `Pub_Group_Pay_Rel_Rate` decimal(10,2) NOT NULL,
  `Pub_Group_Pay_Rel_Pay_Method` int(11) NOT NULL,
  `Pub_Group_Pay_Rel_Bank_Account` mediumint(9) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Pay_Rel_Id`),
  KEY `FK_wipo_publisher_group_related_payment_group` (`Pub_Group_Id`),
  CONSTRAINT `FK_wipo_publisher_group_related_payment_group` FOREIGN KEY (`Pub_Group_Id`) REFERENCES `wipo_publisher_group` (`Pub_Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_related_payment` */

/*Table structure for table `wipo_publisher_group_representative` */

DROP TABLE IF EXISTS `wipo_publisher_group_representative`;

CREATE TABLE `wipo_publisher_group_representative` (
  `Pub_Group_Addr_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Id` int(11) NOT NULL,
  `Pub_Group_Rep_Name` varchar(100) NOT NULL,
  `Pub_Group_Rep_Address_1` varchar(255) DEFAULT NULL,
  `Pub_Group_Rep_Address_2` varchar(255) DEFAULT NULL,
  `Pub_Group_Rep_Address_3` varchar(255) DEFAULT NULL,
  `Pub_Group_Rep_Address_4` varchar(255) DEFAULT NULL,
  `Pub_Group_Home_Address_1` varchar(255) NOT NULL,
  `Pub_Group_Home_Address_2` varchar(255) DEFAULT NULL,
  `Pub_Group_Home_Address_3` varchar(255) DEFAULT NULL,
  `Pub_Group_Home_Address_4` varchar(255) DEFAULT NULL,
  `Pub_Group_Home_Fax` varchar(25) DEFAULT NULL,
  `Pub_Group_Home_Telephone` varchar(25) NOT NULL,
  `Pub_Group_Home_Email` varchar(50) NOT NULL,
  `Pub_Group_Home_Website` varchar(100) DEFAULT NULL,
  `Pub_Group_Mailing_Address_1` varchar(255) NOT NULL,
  `Pub_Group_Mailing_Address_2` varchar(255) DEFAULT NULL,
  `Pub_Group_Mailing_Address_3` varchar(255) DEFAULT NULL,
  `Pub_Group_Mailing_Address_4` varchar(255) DEFAULT NULL,
  `Pub_Group_Mailing_Telephone` varchar(25) NOT NULL,
  `Pub_Group_Mailing_Fax` varchar(25) DEFAULT NULL,
  `Pub_Group_Mailing_Email` varchar(50) NOT NULL,
  `Pub_Group_Mailing_Website` varchar(100) DEFAULT NULL,
  `Pub_Group_Unknown_Address` enum('Y','N') DEFAULT 'N',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Addr_Id`),
  KEY `Pub_Group_id` (`Pub_Group_Id`),
  CONSTRAINT `FK_wipo_publisher_group_representative_group` FOREIGN KEY (`Pub_Group_Id`) REFERENCES `wipo_publisher_group` (`Pub_Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_representative` */

/*Table structure for table `wipo_publisher_group_sub_publisher` */

DROP TABLE IF EXISTS `wipo_publisher_group_sub_publisher`;

CREATE TABLE `wipo_publisher_group_sub_publisher` (
  `Pub_Group_Sub_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Id` int(11) NOT NULL,
  `Pub_Group_Sub_IPI_Name_Number` varchar(100) NOT NULL,
  `Pub_Group_Sub_IPI_Base_Number` varchar(100) NOT NULL,
  `Pub_Group_Sub_Internal_Code` varchar(100) NOT NULL,
  `Pub_Group_Sub_Name` varchar(100) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Sub_Id`),
  KEY `FK_wipo_publisher_group_sub_publisher_group` (`Pub_Group_Id`),
  CONSTRAINT `FK_wipo_publisher_group_sub_publisher_group` FOREIGN KEY (`Pub_Group_Id`) REFERENCES `wipo_publisher_group` (`Pub_Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_sub_publisher` */

/*Table structure for table `wipo_publisher_group_sub_share` */

DROP TABLE IF EXISTS `wipo_publisher_group_sub_share`;

CREATE TABLE `wipo_publisher_group_sub_share` (
  `Pub_Group_Sub_Share_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Group_Id` int(11) NOT NULL,
  `Pub_Group_Sub_Share_Broadcast` decimal(10,2) NOT NULL,
  `Pub_Group_Sub_Share_Mechanical` decimal(10,2) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Group_Sub_Share_Id`),
  KEY `FK_wipo_publisher_group_sub_share_group` (`Pub_Group_Id`),
  CONSTRAINT `FK_wipo_publisher_group_sub_share_group` FOREIGN KEY (`Pub_Group_Id`) REFERENCES `wipo_publisher_group` (`Pub_Group_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_group_sub_share` */

/*Table structure for table `wipo_publisher_manage_rights` */

DROP TABLE IF EXISTS `wipo_publisher_manage_rights`;

CREATE TABLE `wipo_publisher_manage_rights` (
  `Pub_Mnge_Rgt_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Acc_Id` int(11) NOT NULL,
  `Pub_Mnge_Society_Id` int(11) NOT NULL,
  `Pub_Mnge_Entry_Date` date NOT NULL,
  `Pub_Mnge_Exit_Date` date DEFAULT NULL,
  `Pub_Mnge_Internal_Position_Id` int(11) NOT NULL,
  `Pub_Mnge_Entry_Date_2` date NOT NULL,
  `Pub_Mnge_Exit_Date_2` date DEFAULT NULL,
  `Pub_Mnge_Region_Id` int(11) DEFAULT NULL,
  `Pub_Mnge_Profession_Id` int(11) DEFAULT NULL,
  `Pub_Mnge_File` varchar(255) DEFAULT NULL,
  `Pub_Mnge_Duration` varchar(100) DEFAULT NULL,
  `Pub_Mnge_Avl_Work_Cat_Id` int(11) NOT NULL,
  `Pub_Mnge_Type_Rght_Id` int(11) NOT NULL,
  `Pub_Mnge_Managed_Rights_Id` int(11) NOT NULL,
  `Pub_Mnge_Territories_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Mnge_Rgt_Id`),
  KEY `FK_wipo_publisher_manage_rights_account_id` (`Pub_Acc_Id`),
  KEY `FK_wipo_publisher_manage_rights_internal_position` (`Pub_Mnge_Internal_Position_Id`),
  KEY `FK_wipo_publisher_manage_rights_region` (`Pub_Mnge_Region_Id`),
  KEY `FK_wipo_publisher_manage_rights_profession` (`Pub_Mnge_Profession_Id`),
  KEY `FK_wipo_publisher_manage_rights_work_category` (`Pub_Mnge_Avl_Work_Cat_Id`),
  KEY `FK_wipo_publisher_manage_rights_type_of_rights` (`Pub_Mnge_Type_Rght_Id`),
  KEY `FK_wipo_publisher_manage_rights_managerd_rights` (`Pub_Mnge_Managed_Rights_Id`),
  KEY `FK_wipo_publisher_manage_rights_territories` (`Pub_Mnge_Territories_Id`),
  KEY `FK_wipo_publisher_manage_rights_society` (`Pub_Mnge_Society_Id`),
  CONSTRAINT `FK_wipo_publisher_manage_rights_account_id` FOREIGN KEY (`Pub_Acc_Id`) REFERENCES `wipo_publisher_account` (`Pub_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_manage_rights_internal_position` FOREIGN KEY (`Pub_Mnge_Internal_Position_Id`) REFERENCES `wipo_master_internal_position` (`Master_Int_Post_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_manage_rights_managerd_rights` FOREIGN KEY (`Pub_Mnge_Managed_Rights_Id`) REFERENCES `wipo_master_managed_rights` (`Master_Mgd_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_manage_rights_profession` FOREIGN KEY (`Pub_Mnge_Profession_Id`) REFERENCES `wipo_master_profession` (`Master_Profession_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_manage_rights_region` FOREIGN KEY (`Pub_Mnge_Region_Id`) REFERENCES `wipo_master_region` (`Master_Region_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_manage_rights_society` FOREIGN KEY (`Pub_Mnge_Society_Id`) REFERENCES `wipo_society` (`Society_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_manage_rights_territories` FOREIGN KEY (`Pub_Mnge_Territories_Id`) REFERENCES `wipo_master_territories` (`Master_Territory_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_manage_rights_type_of_rights` FOREIGN KEY (`Pub_Mnge_Type_Rght_Id`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_manage_rights_work_category` FOREIGN KEY (`Pub_Mnge_Avl_Work_Cat_Id`) REFERENCES `wipo_master_works_category` (`Master_Work_Category_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_manage_rights` */

/*Table structure for table `wipo_publisher_payment_method` */

DROP TABLE IF EXISTS `wipo_publisher_payment_method`;

CREATE TABLE `wipo_publisher_payment_method` (
  `Pub_Pay_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Acc_Id` int(11) NOT NULL,
  `Pub_Pay_Method_id` int(11) NOT NULL,
  `Pub_Bank_Account` mediumint(9) NOT NULL,
  `Pub_Bank_Code` mediumint(9) DEFAULT NULL,
  `Pub_Bank_Branch` mediumint(9) DEFAULT NULL,
  `Pub_Pay_Address` varchar(255) DEFAULT NULL,
  `Pub_Pay_Iban` varchar(255) DEFAULT NULL,
  `Pub_Pay_Swift` varchar(255) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Pay_Id`),
  KEY `FK_wipo_publisher_payment_method_account_id` (`Pub_Acc_Id`),
  KEY `FK_wipo_publisher_payment_method_payment_mode` (`Pub_Pay_Method_id`),
  CONSTRAINT `FK_wipo_publisher_payment_method_account_id` FOREIGN KEY (`Pub_Acc_Id`) REFERENCES `wipo_publisher_account` (`Pub_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_payment_method_payment_mode` FOREIGN KEY (`Pub_Pay_Method_id`) REFERENCES `wipo_master_payment_method` (`Master_Paymode_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_payment_method` */

/*Table structure for table `wipo_publisher_pseudonym` */

DROP TABLE IF EXISTS `wipo_publisher_pseudonym`;

CREATE TABLE `wipo_publisher_pseudonym` (
  `Pub_Pseudo_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Acc_Id` int(11) NOT NULL,
  `Pub_Pseudo_Type_Id` int(11) NOT NULL,
  `Pub_Pseudo_Name` varchar(50) NOT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Pseudo_Id`),
  KEY `FK_wipo_publisher_pseudonym_pseodo_type` (`Pub_Pseudo_Type_Id`),
  KEY `FK_wipo_publisher_pseudonym_publisher_account` (`Pub_Acc_Id`),
  CONSTRAINT `FK_wipo_publisher_pseudonym_pseodo_type` FOREIGN KEY (`Pub_Pseudo_Type_Id`) REFERENCES `wipo_master_pseudonym_types` (`Pseudo_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_pseudonym_publisher_account` FOREIGN KEY (`Pub_Acc_Id`) REFERENCES `wipo_publisher_account` (`Pub_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_pseudonym` */

/*Table structure for table `wipo_publisher_related_rights` */

DROP TABLE IF EXISTS `wipo_publisher_related_rights`;

CREATE TABLE `wipo_publisher_related_rights` (
  `Pub_Rel_Rgt_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Acc_Id` int(11) NOT NULL,
  `Pub_Rel_Society_Id` int(11) NOT NULL,
  `Pub_Rel_Entry_Date` date NOT NULL,
  `Pub_Rel_Exit_Date` date DEFAULT NULL,
  `Pub_Rel_Internal_Position_Id` int(11) NOT NULL,
  `Pub_Rel_Entry_Date_2` date NOT NULL,
  `Pub_Rel_Exit_Date_2` date DEFAULT NULL,
  `Pub_Rel_Region_Id` int(11) DEFAULT NULL,
  `Pub_Rel_Profession_Id` int(11) DEFAULT NULL,
  `Pub_Rel_File` varchar(255) DEFAULT NULL,
  `Pub_Rel_Duration` varchar(100) DEFAULT NULL,
  `Pub_Rel_Avl_Work_Cat_Id` int(11) NOT NULL,
  `Pub_Rel_Type_Rght_Id` int(11) DEFAULT NULL,
  `Pub_Rel_Managed_Rights_Id` int(11) NOT NULL,
  `Pub_Rel_Territories_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Rel_Rgt_Id`),
  KEY `FK_wipo_publisher_related_rights_account_id` (`Pub_Acc_Id`),
  KEY `FK_wipo_publisher_related_rights_internal_position` (`Pub_Rel_Internal_Position_Id`),
  KEY `FK_wipo_publisher_related_rights_region` (`Pub_Rel_Region_Id`),
  KEY `FK_wipo_publisher_related_rights_profession` (`Pub_Rel_Profession_Id`),
  KEY `FK_wipo_publisher_related_rights_work_category` (`Pub_Rel_Avl_Work_Cat_Id`),
  KEY `FK_wipo_publisher_related_rights_type_of_rights` (`Pub_Rel_Type_Rght_Id`),
  KEY `FK_wipo_publisher_related_rights_managerd_rights` (`Pub_Rel_Managed_Rights_Id`),
  KEY `FK_wipo_publisher_related_rights_territories` (`Pub_Rel_Territories_Id`),
  CONSTRAINT `FK_wipo_publisher_related_rights_account_id` FOREIGN KEY (`Pub_Acc_Id`) REFERENCES `wipo_publisher_account` (`Pub_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_related_rights_internal_position` FOREIGN KEY (`Pub_Rel_Internal_Position_Id`) REFERENCES `wipo_master_internal_position` (`Master_Int_Post_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_related_rights_managerd_rights` FOREIGN KEY (`Pub_Rel_Managed_Rights_Id`) REFERENCES `wipo_master_managed_rights` (`Master_Mgd_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_related_rights_profession` FOREIGN KEY (`Pub_Rel_Profession_Id`) REFERENCES `wipo_master_profession` (`Master_Profession_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_related_rights_region` FOREIGN KEY (`Pub_Rel_Region_Id`) REFERENCES `wipo_master_region` (`Master_Region_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_related_rights_territories` FOREIGN KEY (`Pub_Rel_Territories_Id`) REFERENCES `wipo_master_territories` (`Master_Territory_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_related_rights_type_of_rights` FOREIGN KEY (`Pub_Rel_Type_Rght_Id`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_publisher_related_rights_work_category` FOREIGN KEY (`Pub_Rel_Avl_Work_Cat_Id`) REFERENCES `wipo_master_works_category` (`Master_Work_Category_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_related_rights` */

/*Table structure for table `wipo_publisher_succession` */

DROP TABLE IF EXISTS `wipo_publisher_succession`;

CREATE TABLE `wipo_publisher_succession` (
  `Pub_Suc_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Pub_Acc_Id` int(11) NOT NULL,
  `Pub_Suc_Date_Transfer` date DEFAULT NULL,
  `Pub_Suc_Name` varchar(255) NOT NULL,
  `Pub_Suc_Address_1` varchar(500) NOT NULL,
  `Pub_Suc_Address_2` varchar(500) DEFAULT NULL,
  `Pub_Suc_Annotation` text NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Pub_Suc_Id`),
  KEY `FK_wipo_publisher_succession_acount` (`Pub_Acc_Id`),
  CONSTRAINT `FK_wipo_publisher_succession_acount` FOREIGN KEY (`Pub_Acc_Id`) REFERENCES `wipo_publisher_account` (`Pub_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_publisher_succession` */

/*Table structure for table `wipo_recording` */

DROP TABLE IF EXISTS `wipo_recording`;

CREATE TABLE `wipo_recording` (
  `Rcd_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_GUID` varchar(50) NOT NULL,
  `Rcd_Title` varchar(255) NOT NULL,
  `Rcd_Language_Id` int(11) DEFAULT NULL,
  `Rcd_Internal_Code` varchar(100) NOT NULL,
  `Rcd_Type_Id` int(11) NOT NULL,
  `Rcd_Date` date NOT NULL,
  `Rcd_Duration` time NOT NULL,
  `Rcd_Record_Country_id` int(11) NOT NULL,
  `Rcd_Product_Country_Id` int(11) NOT NULL,
  `Rcd_Doc_Status_Id` int(11) NOT NULL,
  `Rcd_Record_Type_Id` int(11) NOT NULL,
  `Rcd_Label_Id` int(11) NOT NULL,
  `Rcd_Reference` varchar(255) DEFAULT NULL,
  `Rcd_File` varchar(255) DEFAULT NULL,
  `Rcd_Isrc_Code` varchar(100) DEFAULT NULL,
  `Rcd_Iswc_Number` varchar(100) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rcd_Id`),
  UNIQUE KEY `NewIndex1` (`Rcd_Internal_Code`),
  KEY `FK_wipo_recording_language` (`Rcd_Language_Id`),
  KEY `FK_wipo_recording_type` (`Rcd_Type_Id`),
  KEY `FK_wipo_recording_record_country` (`Rcd_Record_Country_id`),
  KEY `FK_wipo_recording_production_country` (`Rcd_Product_Country_Id`),
  KEY `FK_wipo_recording_record_type` (`Rcd_Record_Type_Id`),
  KEY `FK_wipo_recording_document_sts` (`Rcd_Doc_Status_Id`),
  KEY `FK_wipo_recording_label` (`Rcd_Label_Id`),
  CONSTRAINT `FK_wipo_recording_document_sts` FOREIGN KEY (`Rcd_Doc_Status_Id`) REFERENCES `wipo_master_document_status` (`Master_Document_Sts_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_label` FOREIGN KEY (`Rcd_Label_Id`) REFERENCES `wipo_master_label` (`Master_Label_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_language` FOREIGN KEY (`Rcd_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_production_country` FOREIGN KEY (`Rcd_Product_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_record_country` FOREIGN KEY (`Rcd_Record_Country_id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_record_type` FOREIGN KEY (`Rcd_Record_Type_Id`) REFERENCES `wipo_master_record_type` (`Master_Rec_Type_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_type` FOREIGN KEY (`Rcd_Type_Id`) REFERENCES `wipo_master_type` (`Master_Type_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording` */

/*Table structure for table `wipo_recording_link` */

DROP TABLE IF EXISTS `wipo_recording_link`;

CREATE TABLE `wipo_recording_link` (
  `Rcd_Link_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_Id` int(11) NOT NULL,
  `Rcd_Link_Title` varchar(255) NOT NULL,
  `Rcd_Perf_Id` int(11) NOT NULL,
  `Rcd_Prod_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rcd_Link_Id`),
  KEY `FK_wipo_recording_link_recording` (`Rcd_Id`),
  KEY `FK_wipo_recording_link_performer` (`Rcd_Perf_Id`),
  KEY `FK_wipo_recording_link_producer` (`Rcd_Prod_Id`),
  CONSTRAINT `FK_wipo_recording_link_performer` FOREIGN KEY (`Rcd_Perf_Id`) REFERENCES `wipo_performer_account` (`Perf_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_link_producer` FOREIGN KEY (`Rcd_Prod_Id`) REFERENCES `wipo_producer_account` (`Pro_Acc_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_link_recording` FOREIGN KEY (`Rcd_Id`) REFERENCES `wipo_recording` (`Rcd_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording_link` */

/*Table structure for table `wipo_recording_publication` */

DROP TABLE IF EXISTS `wipo_recording_publication`;

CREATE TABLE `wipo_recording_publication` (
  `Rcd_Publ_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_Id` int(11) NOT NULL,
  `Rcd_Publ_Internal_Code` varchar(100) NOT NULL,
  `Rcd_Publ_Year` year(4) NOT NULL,
  `Rcd_Publ_Country_Id` int(11) NOT NULL,
  `Rcd_Publ_Prod_Nation_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rcd_Publ_Id`),
  UNIQUE KEY `NewIndex1` (`Rcd_Publ_Internal_Code`),
  KEY `FK_wipo_recording_publication_recording` (`Rcd_Id`),
  KEY `FK_wipo_recording_publication_country` (`Rcd_Publ_Country_Id`),
  KEY `FK_wipo_recording_publication_nationality` (`Rcd_Publ_Prod_Nation_Id`),
  CONSTRAINT `FK_wipo_recording_publication_country` FOREIGN KEY (`Rcd_Publ_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_publication_nationality` FOREIGN KEY (`Rcd_Publ_Prod_Nation_Id`) REFERENCES `wipo_master_nationality` (`Master_Nation_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_publication_recording` FOREIGN KEY (`Rcd_Id`) REFERENCES `wipo_recording` (`Rcd_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording_publication` */

/*Table structure for table `wipo_recording_rightholder` */

DROP TABLE IF EXISTS `wipo_recording_rightholder`;

CREATE TABLE `wipo_recording_rightholder` (
  `Rcd_Right_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_Id` int(11) NOT NULL,
  `Rcd_Member_GUID` varchar(50) NOT NULL,
  `Rcd_Right_Role` int(11) NOT NULL,
  `Rcd_Right_Equal_Share` decimal(10,2) NOT NULL,
  `Rcd_Right_Equal_Org_id` int(11) NOT NULL,
  `Rcd_Right_Blank_Share` decimal(10,2) NOT NULL,
  `Rcd_Right_Blank_Org_Id` int(11) NOT NULL,
  `Created_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rcd_Right_Id`),
  KEY `FK_wipo_work_rightholder_work` (`Rcd_Id`),
  KEY `FK_wipo_work_rightholder_organization` (`Rcd_Right_Equal_Org_id`),
  KEY `FK_wipo_work_rightholder_organization_mechanical` (`Rcd_Right_Blank_Org_Id`),
  KEY `FK_wipo_work_rightholder_role` (`Rcd_Right_Role`),
  CONSTRAINT `FK_wipo_recording_rightholder_balnk_org` FOREIGN KEY (`Rcd_Right_Blank_Org_Id`) REFERENCES `wipo_organization` (`Org_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_rightholder_equal_org` FOREIGN KEY (`Rcd_Right_Equal_Org_id`) REFERENCES `wipo_organization` (`Org_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_rightholder_recording` FOREIGN KEY (`Rcd_Id`) REFERENCES `wipo_recording` (`Rcd_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_rightholder_type_right` FOREIGN KEY (`Rcd_Right_Role`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording_rightholder` */

/*Table structure for table `wipo_recording_session` */

DROP TABLE IF EXISTS `wipo_recording_session`;

CREATE TABLE `wipo_recording_session` (
  `Rcd_Ses_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_Ses_GUID` varchar(40) NOT NULL,
  `Rcd_Ses_Title` varchar(255) NOT NULL,
  `Rcd_Ses_Internal_Code` varchar(100) NOT NULL,
  `Rcd_Ses_Language_Id` int(11) DEFAULT NULL,
  `Rcd_Ses_Orchestra` varchar(50) DEFAULT NULL,
  `Rcd_Ses_Ref_Medium` varchar(50) DEFAULT NULL,
  `Rcd_Ses_Hours` smallint(6) DEFAULT NULL,
  `Rcd_Ses_Record_Date` date NOT NULL,
  `Rcd_Ses_Studio_Id` int(11) NOT NULL,
  `Rcd_Ses_Producer` int(11) NOT NULL,
  `Rcd_Ses_Main_Artist` int(11) NOT NULL,
  `Rcd_Ses_Medium_Id` int(11) NOT NULL,
  `Rcd_Ses_Type_Id` int(11) NOT NULL,
  `Rcd_Ses_Destination_Id` int(11) NOT NULL,
  `Rcd_Ses_Country_Id` int(11) NOT NULL,
  `Rcd_Ses_Factor_Id` int(11) NOT NULL,
  `Rcd_Ses_Release_Year` year(4) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rcd_Ses_Id`),
  KEY `FK_wipo_recording_session_language` (`Rcd_Ses_Language_Id`),
  KEY `FK_wipo_recording_session_studio` (`Rcd_Ses_Studio_Id`),
  KEY `FK_wipo_recording_session_medium` (`Rcd_Ses_Medium_Id`),
  KEY `FK_wipo_recording_session_type` (`Rcd_Ses_Type_Id`),
  KEY `FK_wipo_recording_session_country` (`Rcd_Ses_Country_Id`),
  KEY `FK_wipo_recording_session_factor` (`Rcd_Ses_Factor_Id`),
  KEY `FK_wipo_recording_session_destination` (`Rcd_Ses_Destination_Id`),
  CONSTRAINT `FK_wipo_recording_session_country` FOREIGN KEY (`Rcd_Ses_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_session_destination` FOREIGN KEY (`Rcd_Ses_Destination_Id`) REFERENCES `wipo_master_destination` (`Master_Dist_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_session_factor` FOREIGN KEY (`Rcd_Ses_Factor_Id`) REFERENCES `wipo_master_factor` (`Master_Factor_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_session_language` FOREIGN KEY (`Rcd_Ses_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_session_medium` FOREIGN KEY (`Rcd_Ses_Medium_Id`) REFERENCES `wipo_master_medium` (`Master_Medium_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_session_studio` FOREIGN KEY (`Rcd_Ses_Studio_Id`) REFERENCES `wipo_master_studio` (`Master_Studio_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_session_type` FOREIGN KEY (`Rcd_Ses_Type_Id`) REFERENCES `wipo_master_type` (`Master_Type_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording_session` */

/*Table structure for table `wipo_recording_session_biograph_uploads` */

DROP TABLE IF EXISTS `wipo_recording_session_biograph_uploads`;

CREATE TABLE `wipo_recording_session_biograph_uploads` (
  `Rcd_Ses_Biogrph_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_Ses_Biogrph_Id` int(11) NOT NULL,
  `Rcd_Ses_Biogrph_Upl_File` varchar(500) NOT NULL,
  `Rcd_Ses_Biogrph_Upl_Description` text,
  `Created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rcd_Ses_Biogrph_Upl_Id`),
  KEY `FK_wipo_recording_session_biograph_uploads_biography` (`Rcd_Ses_Biogrph_Id`),
  CONSTRAINT `FK_wipo_recording_session_biograph_uploads_biography` FOREIGN KEY (`Rcd_Ses_Biogrph_Id`) REFERENCES `wipo_recording_session_biography` (`Rcd_Ses_Biogrph_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording_session_biograph_uploads` */

/*Table structure for table `wipo_recording_session_biography` */

DROP TABLE IF EXISTS `wipo_recording_session_biography`;

CREATE TABLE `wipo_recording_session_biography` (
  `Rcd_Ses_Biogrph_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_Ses_Id` int(11) NOT NULL,
  `Rcd_Ses_Biogrph_Annotation` text NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rcd_Ses_Biogrph_Id`),
  KEY `FK_wipo_recording_session_biography_recording_session` (`Rcd_Ses_Id`),
  CONSTRAINT `FK_wipo_recording_session_biography_recording_session` FOREIGN KEY (`Rcd_Ses_Id`) REFERENCES `wipo_recording_session` (`Rcd_Ses_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording_session_biography` */

/*Table structure for table `wipo_recording_session_documentation` */

DROP TABLE IF EXISTS `wipo_recording_session_documentation`;

CREATE TABLE `wipo_recording_session_documentation` (
  `Rcd_Ses_Doc_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_Ses_Id` int(11) NOT NULL,
  `Rcd_Ses_Doc_Status_Id` int(11) NOT NULL,
  `Rcd_Ses_Doc_Type_Id` int(11) NOT NULL,
  `Rcd_Ses_Doc_Sign_Date` date NOT NULL,
  `Rcd_Ses_Doc_File` varchar(255) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rcd_Ses_Doc_Id`),
  KEY `FK_wipo_recording_session_documentation_work` (`Rcd_Ses_Id`),
  KEY `FK_wipo_recording_session_documentation_document_status` (`Rcd_Ses_Doc_Status_Id`),
  KEY `FK_wipo_recording_session_documentation_document_type` (`Rcd_Ses_Doc_Type_Id`),
  CONSTRAINT `FK_wipo_recording_session_documentation_document_status` FOREIGN KEY (`Rcd_Ses_Doc_Status_Id`) REFERENCES `wipo_master_document_status` (`Master_Document_Sts_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_session_documentation_document_type` FOREIGN KEY (`Rcd_Ses_Doc_Type_Id`) REFERENCES `wipo_master_document` (`Master_Doc_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_session_documentation_work` FOREIGN KEY (`Rcd_Ses_Id`) REFERENCES `wipo_recording_session` (`Rcd_Ses_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording_session_documentation` */

/*Table structure for table `wipo_recording_session_folio` */

DROP TABLE IF EXISTS `wipo_recording_session_folio`;

CREATE TABLE `wipo_recording_session_folio` (
  `Rcd_Ses_Folio_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_Ses_Id` int(11) NOT NULL,
  `Rcd_Ses_Folio_Name` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rcd_Ses_Folio_Id`),
  KEY `FK_wipo_recording_session_folio_recording_session` (`Rcd_Ses_Id`),
  CONSTRAINT `FK_wipo_recording_session_folio_recording_session` FOREIGN KEY (`Rcd_Ses_Id`) REFERENCES `wipo_recording_session` (`Rcd_Ses_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording_session_folio` */

/*Table structure for table `wipo_recording_session_rightholder` */

DROP TABLE IF EXISTS `wipo_recording_session_rightholder`;

CREATE TABLE `wipo_recording_session_rightholder` (
  `Rcd_Ses_Right_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_Ses_Id` int(11) NOT NULL,
  `Rcd_Ses_Right_Work_GUID` varchar(40) NOT NULL,
  `Rcd_Ses_Right_Member_GUID` varchar(40) NOT NULL,
  `Rcd_Ses_Right_Work_Type` enum('W','R') NOT NULL DEFAULT 'R' COMMENT 'W -> Work, R -> Recording',
  `Rcd_Ses_Right_Member_Type` enum('A','P') DEFAULT 'P' COMMENT 'A -> Author, P -> Performer',
  `Rcd_Ses_Right_Role` int(11) NOT NULL,
  `Rcd_Ses_Right_Equal_Share` decimal(10,2) NOT NULL,
  `Rcd_Ses_Right_Equal_Org_Id` int(11) NOT NULL,
  `Rcd_Ses_Right_Blank_Share` decimal(10,2) NOT NULL,
  `Rcd_Ses_Right_Blank_Org_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rcd_Ses_Right_Id`),
  KEY `FK_wipo_recording_session_rightholder_sound` (`Rcd_Ses_Id`),
  KEY `FK_wipo_recording_session_rightholder_equal_organization` (`Rcd_Ses_Right_Equal_Org_Id`),
  KEY `FK_wipo_recording_session_rightholder_blank_organization` (`Rcd_Ses_Right_Blank_Org_Id`),
  KEY `FK_wipo_recording_session_rightholder_role` (`Rcd_Ses_Right_Role`),
  CONSTRAINT `FK_wipo_recording_session_rightholder_blank_organization` FOREIGN KEY (`Rcd_Ses_Right_Blank_Org_Id`) REFERENCES `wipo_organization` (`Org_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_session_rightholder_equal_organization` FOREIGN KEY (`Rcd_Ses_Right_Equal_Org_Id`) REFERENCES `wipo_organization` (`Org_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_session_rightholder_role` FOREIGN KEY (`Rcd_Ses_Right_Role`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_session_rightholder_sound` FOREIGN KEY (`Rcd_Ses_Id`) REFERENCES `wipo_recording_session` (`Rcd_Ses_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording_session_rightholder` */

/*Table structure for table `wipo_recording_session_subtitle` */

DROP TABLE IF EXISTS `wipo_recording_session_subtitle`;

CREATE TABLE `wipo_recording_session_subtitle` (
  `Rcd_Ses_Subtitle_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_Ses_Id` int(11) NOT NULL,
  `Rcd_Ses_Subtitle_Name` varchar(255) NOT NULL,
  `Rcd_Ses_Subtitle_Type_Id` int(11) NOT NULL,
  `Rcd_Ses_Subtitle_Language_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rcd_Ses_Subtitle_Id`),
  KEY `FK_wipo_recording_session_subtitle_session` (`Rcd_Ses_Id`),
  KEY `FK_wipo_recording_session_subtitle_type` (`Rcd_Ses_Subtitle_Type_Id`),
  KEY `FK_wipo_recording_session_subtitle_language` (`Rcd_Ses_Subtitle_Language_Id`),
  CONSTRAINT `FK_wipo_recording_session_subtitle_language` FOREIGN KEY (`Rcd_Ses_Subtitle_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_session_subtitle_session` FOREIGN KEY (`Rcd_Ses_Id`) REFERENCES `wipo_recording_session` (`Rcd_Ses_Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_wipo_recording_session_subtitle_type` FOREIGN KEY (`Rcd_Ses_Subtitle_Type_Id`) REFERENCES `wipo_master_type` (`Master_Type_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording_session_subtitle` */

/*Table structure for table `wipo_recording_session_upload` */

DROP TABLE IF EXISTS `wipo_recording_session_upload`;

CREATE TABLE `wipo_recording_session_upload` (
  `Rcd_Ses_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_Ses_Id` int(11) NOT NULL,
  `Rcd_Ses_Upl_Doc_Name` varchar(255) NOT NULL,
  `Rcd_Ses_Upl_File` varchar(1000) NOT NULL,
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Rcd_Ses_Upl_Id`),
  KEY `FK_wipo_recording_session_upload_auth` (`Rcd_Ses_Id`),
  CONSTRAINT `FK_wipo_recording_session_upload_auth` FOREIGN KEY (`Rcd_Ses_Id`) REFERENCES `wipo_recording_session` (`Rcd_Ses_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording_session_upload` */

/*Table structure for table `wipo_recording_subtitle` */

DROP TABLE IF EXISTS `wipo_recording_subtitle`;

CREATE TABLE `wipo_recording_subtitle` (
  `Rcd_Subtitle_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rcd_Id` int(11) NOT NULL,
  `Rcd_Subtitle_Name` varchar(255) NOT NULL,
  `Rcd_Subtitle_Type_Id` int(11) NOT NULL,
  `Rcd_Subtitle_Language_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Rcd_Subtitle_Id`),
  KEY `FK_wipo_recording_subtitle_recording` (`Rcd_Id`),
  KEY `FK_wipo_recording_subtitle_type` (`Rcd_Subtitle_Type_Id`),
  KEY `FK_wipo_recording_subtitle_language` (`Rcd_Subtitle_Language_Id`),
  CONSTRAINT `FK_wipo_recording_subtitle_language` FOREIGN KEY (`Rcd_Subtitle_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_recording_subtitle_recording` FOREIGN KEY (`Rcd_Id`) REFERENCES `wipo_recording` (`Rcd_Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_wipo_recording_subtitle_type` FOREIGN KEY (`Rcd_Subtitle_Type_Id`) REFERENCES `wipo_master_type` (`Master_Type_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_recording_subtitle` */

/*Table structure for table `wipo_share_definition_per_role` */

DROP TABLE IF EXISTS `wipo_share_definition_per_role`;

CREATE TABLE `wipo_share_definition_per_role` (
  `Shr_Def_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Shr_Def_Role` int(11) NOT NULL,
  `Shr_Def_Equ_remn` decimal(10,2) NOT NULL COMMENT 'Equitable remuneration',
  `Shr_Def_Blank_Tape_remn` decimal(10,2) NOT NULL COMMENT 'Blank tape remuneration rights',
  `Shr_Def_Neigh_Rgts` decimal(10,2) NOT NULL COMMENT 'Neighboring rights ',
  `Shr_Def_Excl_Rgts` decimal(10,2) NOT NULL COMMENT 'Exclusive rights',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Shr_Def_Id`),
  UNIQUE KEY `FK_wipo_share_definition_per_role_role` (`Shr_Def_Role`),
  CONSTRAINT `FK_wipo_share_definition_per_role` FOREIGN KEY (`Shr_Def_Role`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_share_definition_per_role` */

/*Table structure for table `wipo_society` */

DROP TABLE IF EXISTS `wipo_society`;

CREATE TABLE `wipo_society` (
  `Society_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Society_Code` varchar(50) NOT NULL,
  `Society_Abbr_Id` int(11) NOT NULL,
  `Society_Logo_File` varchar(255) NOT NULL,
  `Society_Language_Id` int(11) NOT NULL,
  `Society_Mailing_Address` varchar(500) NOT NULL,
  `Society_Country_Id` int(11) DEFAULT NULL,
  `Society_Territory_Id` int(11) DEFAULT NULL,
  `Society_Region_Id` int(11) DEFAULT NULL,
  `Society_Profession_Id` int(11) DEFAULT NULL,
  `Society_Role_Id` int(11) DEFAULT NULL,
  `Society_Hirearchy_Id` int(11) DEFAULT NULL,
  `Society_Payment_Id` int(11) DEFAULT NULL,
  `Society_Type_Id` int(11) DEFAULT NULL,
  `Society_Factor` int(11) DEFAULT NULL,
  `Society_Doc_Type_Id` int(11) DEFAULT NULL,
  `Society_Doc_Id` int(11) DEFAULT NULL,
  `Society_Duration` smallint(6) DEFAULT NULL,
  `Society_CopyRight` mediumint(9) DEFAULT NULL,
  `Society_RelatedRights` mediumint(9) DEFAULT NULL,
  `Society_Currency_Id` int(11) DEFAULT NULL,
  `Society_Rate` decimal(10,2) DEFAULT NULL,
  `Society_Main_Performer_Id` varchar(100) DEFAULT NULL,
  `Society_Producer_Id` varchar(100) DEFAULT NULL,
  `Society_Subscription` varchar(100) DEFAULT NULL,
  `Soceity_Work_Cat_Id` int(11) DEFAULT NULL,
  `Soceity_Int_Pos_Id` int(11) DEFAULT NULL,
  `Soceity_Mnge_Rght_Id` int(11) DEFAULT NULL,
  `Soceity_Doc_Sts_Id` int(11) DEFAULT NULL,
  `Soceity_Rec_Type_Id` int(11) DEFAULT NULL,
  `Soceity_Medium_Id` int(11) DEFAULT NULL,
  `Soceity_Legal_Form_Id` int(11) DEFAULT NULL,
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Society_Id`),
  KEY `FK_wipo_organization_country` (`Society_Country_Id`),
  KEY `FK_wipo_organization_document` (`Society_Doc_Id`),
  KEY `FK_wipo_organization_doc_type` (`Society_Doc_Type_Id`),
  KEY `FK_wipo_organization_payment` (`Society_Payment_Id`),
  KEY `FK_wipo_organization_profession` (`Society_Profession_Id`),
  KEY `FK_wipo_organization_region` (`Society_Region_Id`),
  KEY `FK_wipo_organization_role` (`Society_Role_Id`),
  KEY `FK_wipo_organization_territory` (`Society_Territory_Id`),
  KEY `Abbrevation` (`Society_Abbr_Id`),
  KEY `Hierarchy` (`Society_Hirearchy_Id`),
  KEY `FK_wipo_society_type` (`Society_Type_Id`),
  KEY `FK_wipo_society_language` (`Society_Language_Id`),
  KEY `FK_wipo_society_mailing_address` (`Society_Mailing_Address`),
  KEY `FK_wipo_society_currency` (`Society_Currency_Id`),
  KEY `FK_wipo_society_work_category` (`Soceity_Work_Cat_Id`),
  KEY `FK_wipo_society_int_pos` (`Soceity_Int_Pos_Id`),
  KEY `FK_wipo_society_managed_rights` (`Soceity_Mnge_Rght_Id`),
  KEY `FK_wipo_society_doc_sts` (`Soceity_Doc_Sts_Id`),
  KEY `FK_wipo_society_record_type` (`Soceity_Rec_Type_Id`),
  KEY `FK_wipo_society_medium` (`Soceity_Medium_Id`),
  KEY `FK_wipo_society_legal_form` (`Soceity_Legal_Form_Id`),
  CONSTRAINT `FK_wipo_organization_country` FOREIGN KEY (`Society_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_organization_document` FOREIGN KEY (`Society_Doc_Id`) REFERENCES `wipo_master_document` (`Master_Doc_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_organization_doc_type` FOREIGN KEY (`Society_Doc_Type_Id`) REFERENCES `wipo_master_document_type` (`Master_Doc_Type_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_organization_payment` FOREIGN KEY (`Society_Payment_Id`) REFERENCES `wipo_master_payment_method` (`Master_Paymode_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_organization_profession` FOREIGN KEY (`Society_Profession_Id`) REFERENCES `wipo_master_profession` (`Master_Profession_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_organization_region` FOREIGN KEY (`Society_Region_Id`) REFERENCES `wipo_master_region` (`Master_Region_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_organization_role` FOREIGN KEY (`Society_Role_Id`) REFERENCES `wipo_master_role` (`Master_Role_ID`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_organization_territory` FOREIGN KEY (`Society_Territory_Id`) REFERENCES `wipo_master_territories` (`Master_Territory_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_society` FOREIGN KEY (`Society_Abbr_Id`) REFERENCES `wipo_organization` (`Org_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_society_currency` FOREIGN KEY (`Society_Currency_Id`) REFERENCES `wipo_master_currency` (`Master_Crncy_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_society_doc_sts` FOREIGN KEY (`Soceity_Doc_Sts_Id`) REFERENCES `wipo_master_document_status` (`Master_Document_Sts_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_society_hierarchy` FOREIGN KEY (`Society_Hirearchy_Id`) REFERENCES `wipo_master_hierarchy` (`Master_Hierarchy_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_society_int_pos` FOREIGN KEY (`Soceity_Int_Pos_Id`) REFERENCES `wipo_master_internal_position` (`Master_Int_Post_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_society_language` FOREIGN KEY (`Society_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_society_legal_form` FOREIGN KEY (`Soceity_Legal_Form_Id`) REFERENCES `wipo_master_legal_form` (`Master_Legal_Form_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_society_managed_rights` FOREIGN KEY (`Soceity_Mnge_Rght_Id`) REFERENCES `wipo_master_managed_rights` (`Master_Mgd_Rights_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_society_medium` FOREIGN KEY (`Soceity_Medium_Id`) REFERENCES `wipo_master_medium` (`Master_Medium_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_society_record_type` FOREIGN KEY (`Soceity_Rec_Type_Id`) REFERENCES `wipo_master_record_type` (`Master_Rec_Type_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_society_type` FOREIGN KEY (`Society_Type_Id`) REFERENCES `wipo_master_type` (`Master_Type_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_society_work_category` FOREIGN KEY (`Soceity_Work_Cat_Id`) REFERENCES `wipo_master_works_category` (`Master_Work_Category_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_society` */

/*Table structure for table `wipo_sound_carrier` */

DROP TABLE IF EXISTS `wipo_sound_carrier`;

CREATE TABLE `wipo_sound_carrier` (
  `Sound_Car_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Sound_Car_GUID` varchar(50) NOT NULL,
  `Sound_Car_Title` varchar(255) NOT NULL,
  `Sound_Car_Language_Id` int(11) DEFAULT NULL,
  `Sound_Car_Internal_Code` varchar(100) NOT NULL,
  `Sound_Car_Standardized_Code` varchar(100) DEFAULT NULL,
  `Sound_Car_Catelog` varchar(100) DEFAULT NULL,
  `Sound_Car_Barcode` varchar(255) DEFAULT NULL,
  `Sound_Car_Label_Id` int(11) DEFAULT NULL,
  `Sound_Car_Distributor` varchar(100) DEFAULT NULL,
  `Sound_Car_Medium` int(11) NOT NULL,
  `Sound_Car_Type_Id` int(11) DEFAULT NULL,
  `Sound_Car_Main_Artist` int(11) NOT NULL,
  `Sound_Car_Producer` int(11) NOT NULL,
  `Sound_Car_Product_Country_Id` int(11) NOT NULL,
  `Sound_Car_Year` year(4) NOT NULL,
  `Sound_Car_Release_Year` year(4) NOT NULL,
  `Sound_Car_Manf_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Sound_Car_Id`),
  UNIQUE KEY `NewIndex1` (`Sound_Car_Internal_Code`),
  KEY `FK_wipo_sound_carrier_language` (`Sound_Car_Language_Id`),
  KEY `FK_wipo_sound_carrier_type` (`Sound_Car_Type_Id`),
  KEY `FK_wipo_sound_carrier_production_country` (`Sound_Car_Product_Country_Id`),
  KEY `FK_wipo_sound_carrier` (`Sound_Car_Manf_Id`),
  KEY `FK_wipo_sound_carrier_label` (`Sound_Car_Label_Id`),
  KEY `FK_wipo_sound_carrier_medium` (`Sound_Car_Medium`),
  KEY `FK_wipo_sound_carrier_performer` (`Sound_Car_Main_Artist`),
  KEY `FK_wipo_sound_carrier_producer` (`Sound_Car_Producer`),
  CONSTRAINT `FK_wipo_sound_carrier` FOREIGN KEY (`Sound_Car_Manf_Id`) REFERENCES `wipo_master_manufacturer` (`Master_Manf_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_label` FOREIGN KEY (`Sound_Car_Label_Id`) REFERENCES `wipo_master_label` (`Master_Label_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_language` FOREIGN KEY (`Sound_Car_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_medium` FOREIGN KEY (`Sound_Car_Medium`) REFERENCES `wipo_master_medium` (`Master_Medium_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_production_country` FOREIGN KEY (`Sound_Car_Product_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_type` FOREIGN KEY (`Sound_Car_Type_Id`) REFERENCES `wipo_master_type` (`Master_Type_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_sound_carrier` */

/*Table structure for table `wipo_sound_carrier_biograph_uploads` */

DROP TABLE IF EXISTS `wipo_sound_carrier_biograph_uploads`;

CREATE TABLE `wipo_sound_carrier_biograph_uploads` (
  `Sound_Car_Biogrph_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Sound_Car_Biogrph_Id` int(11) NOT NULL,
  `Sound_Car_Biogrph_Upl_File` varchar(500) NOT NULL,
  `Sound_Car_Biogrph_Upl_Description` text,
  `Created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Sound_Car_Biogrph_Upl_Id`),
  KEY `FK_wipo_sound_carrier_biograph_uploads_biography` (`Sound_Car_Biogrph_Id`),
  CONSTRAINT `FK_wipo_sound_carrier_biograph_uploads_biography` FOREIGN KEY (`Sound_Car_Biogrph_Id`) REFERENCES `wipo_sound_carrier_biography` (`Sound_Car_Biogrph_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_sound_carrier_biograph_uploads` */

/*Table structure for table `wipo_sound_carrier_biography` */

DROP TABLE IF EXISTS `wipo_sound_carrier_biography`;

CREATE TABLE `wipo_sound_carrier_biography` (
  `Sound_Car_Biogrph_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Sound_Car_Id` int(11) NOT NULL,
  `Sound_Car_Biogrph_Annotation` text NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Sound_Car_Biogrph_Id`),
  KEY `FK_wipo_sound_carrier_biography_rcd` (`Sound_Car_Id`),
  CONSTRAINT `FK_wipo_sound_carrier_biography_rcd` FOREIGN KEY (`Sound_Car_Id`) REFERENCES `wipo_sound_carrier` (`Sound_Car_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_sound_carrier_biography` */

/*Table structure for table `wipo_sound_carrier_documentation` */

DROP TABLE IF EXISTS `wipo_sound_carrier_documentation`;

CREATE TABLE `wipo_sound_carrier_documentation` (
  `Sound_Car_Doc_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Sound_Car_Id` int(11) NOT NULL,
  `Sound_Car_Doc_Status_Id` int(11) NOT NULL,
  `Sound_Car_Doc_Type_Id` int(11) NOT NULL,
  `Sound_Car_Doc_Sign_Date` date NOT NULL,
  `Sound_Car_Doc_File` varchar(255) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Sound_Car_Doc_Id`),
  KEY `FK_wipo_sound_carrier_documentation_work` (`Sound_Car_Id`),
  KEY `FK_wipo_sound_carrier_documentation_document_status` (`Sound_Car_Doc_Status_Id`),
  KEY `FK_wipo_sound_carrier_documentation_document_type` (`Sound_Car_Doc_Type_Id`),
  CONSTRAINT `FK_wipo_sound_carrier_documentation_document_status` FOREIGN KEY (`Sound_Car_Doc_Status_Id`) REFERENCES `wipo_master_document_status` (`Master_Document_Sts_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_documentation_document_type` FOREIGN KEY (`Sound_Car_Doc_Type_Id`) REFERENCES `wipo_master_document` (`Master_Doc_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_documentation_work` FOREIGN KEY (`Sound_Car_Id`) REFERENCES `wipo_sound_carrier` (`Sound_Car_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_sound_carrier_documentation` */

/*Table structure for table `wipo_sound_carrier_fixations` */

DROP TABLE IF EXISTS `wipo_sound_carrier_fixations`;

CREATE TABLE `wipo_sound_carrier_fixations` (
  `Sound_Car_Fix_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Sound_Car_Id` int(11) NOT NULL,
  `Sound_Car_Fix_GUID` varchar(40) NOT NULL,
  `Sound_Car_Fix_Duration` time NOT NULL,
  `Sound_Car_Fix_Date` date NOT NULL,
  `Sound_Car_Fix_Studio` int(11) NOT NULL,
  `Sound_Car_Fix_Country_Id` int(11) NOT NULL,
  `Sound_Car_Fix_Work_Type` enum('W','R') NOT NULL DEFAULT 'W',
  `Sound_Car_Fix_ISRC` varchar(50) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Sound_Car_Fix_Id`),
  KEY `FK_wipo_sound_carrier_fixations_sound_carrier` (`Sound_Car_Id`),
  KEY `FK_wipo_sound_carrier_fixations_recording` (`Sound_Car_Fix_GUID`),
  KEY `FK_wipo_sound_carrier_fixations_country` (`Sound_Car_Fix_Country_Id`),
  KEY `FK_wipo_sound_carrier_fixations_studio` (`Sound_Car_Fix_Studio`),
  CONSTRAINT `FK_wipo_sound_carrier_fixations_country` FOREIGN KEY (`Sound_Car_Fix_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_fixations_sound_carrier` FOREIGN KEY (`Sound_Car_Id`) REFERENCES `wipo_sound_carrier` (`Sound_Car_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_fixations_studio` FOREIGN KEY (`Sound_Car_Fix_Studio`) REFERENCES `wipo_master_studio` (`Master_Studio_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_sound_carrier_fixations` */

/*Table structure for table `wipo_sound_carrier_publication` */

DROP TABLE IF EXISTS `wipo_sound_carrier_publication`;

CREATE TABLE `wipo_sound_carrier_publication` (
  `Sound_Car_Publ_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Sound_Car_Id` int(11) NOT NULL,
  `Sound_Car_Publ_GUID` varchar(40) NOT NULL,
  `Sound_Car_Publ_Internal_Code` varchar(100) NOT NULL,
  `Sound_Car_Publ_Year` year(4) NOT NULL,
  `Sound_Car_Publ_Country_Id` int(11) NOT NULL,
  `Sound_Car_Publ_Prod_Nation_Id` int(11) NOT NULL,
  `Sound_Car_Publ_Studio` int(11) NOT NULL,
  `Sound_Car_Publ_Work_Type` enum('W','R') NOT NULL DEFAULT 'W',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Sound_Car_Publ_Id`),
  UNIQUE KEY `NewIndex1` (`Sound_Car_Publ_Internal_Code`),
  KEY `FK_wipo_sound_carrier_publication_recording` (`Sound_Car_Id`),
  KEY `FK_wipo_sound_carrier_publication_country` (`Sound_Car_Publ_Country_Id`),
  KEY `FK_wipo_sound_carrier_publication_nationality` (`Sound_Car_Publ_Prod_Nation_Id`),
  KEY `FK_wipo_sound_carrier_publication` (`Sound_Car_Publ_Studio`),
  CONSTRAINT `FK_wipo_sound_carrier_publication` FOREIGN KEY (`Sound_Car_Publ_Studio`) REFERENCES `wipo_master_studio` (`Master_Studio_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_publication_country` FOREIGN KEY (`Sound_Car_Publ_Country_Id`) REFERENCES `wipo_master_country` (`Master_Country_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_publication_nationality` FOREIGN KEY (`Sound_Car_Publ_Prod_Nation_Id`) REFERENCES `wipo_master_nationality` (`Master_Nation_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_publication_recording` FOREIGN KEY (`Sound_Car_Id`) REFERENCES `wipo_sound_carrier` (`Sound_Car_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_sound_carrier_publication` */

/*Table structure for table `wipo_sound_carrier_rightholder` */

DROP TABLE IF EXISTS `wipo_sound_carrier_rightholder`;

CREATE TABLE `wipo_sound_carrier_rightholder` (
  `Sound_Car_Right_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Sound_Car_Id` int(11) NOT NULL,
  `Sound_Car_Right_Work_GUID` varchar(40) NOT NULL,
  `Sound_Car_Right_Member_GUID` varchar(40) NOT NULL,
  `Sound_Car_Right_Work_Type` enum('W','R') NOT NULL DEFAULT 'W' COMMENT 'W -> Work, R -> Recording',
  `Sound_Car_Right_Member_Type` enum('A','P') DEFAULT 'A' COMMENT 'A -> Author, P -> Performer',
  `Sound_Car_Right_Role` int(11) NOT NULL,
  `Sound_Car_Right_Equal_Share` decimal(10,2) NOT NULL,
  `Sound_Car_Right_Equal_Org_Id` int(11) NOT NULL,
  `Sound_Car_Right_Blank_Share` decimal(10,2) NOT NULL,
  `Sound_Car_Right_Blank_Org_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Sound_Car_Right_Id`),
  KEY `FK_wipo_sound_carrier_rightholder_sound` (`Sound_Car_Id`),
  KEY `FK_wipo_sound_carrier_rightholder_equal_organization` (`Sound_Car_Right_Equal_Org_Id`),
  KEY `FK_wipo_sound_carrier_rightholder_blank_organization` (`Sound_Car_Right_Blank_Org_Id`),
  KEY `FK_wipo_sound_carrier_rightholder_role` (`Sound_Car_Right_Role`),
  CONSTRAINT `FK_wipo_sound_carrier_rightholder_blank_organization` FOREIGN KEY (`Sound_Car_Right_Blank_Org_Id`) REFERENCES `wipo_organization` (`Org_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_rightholder_equal_organization` FOREIGN KEY (`Sound_Car_Right_Equal_Org_Id`) REFERENCES `wipo_organization` (`Org_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_rightholder_role` FOREIGN KEY (`Sound_Car_Right_Role`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_rightholder_sound` FOREIGN KEY (`Sound_Car_Id`) REFERENCES `wipo_sound_carrier` (`Sound_Car_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_sound_carrier_rightholder` */

/*Table structure for table `wipo_sound_carrier_subtitle` */

DROP TABLE IF EXISTS `wipo_sound_carrier_subtitle`;

CREATE TABLE `wipo_sound_carrier_subtitle` (
  `Sound_Car_Subtitle_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Sound_Car_Id` int(11) NOT NULL,
  `Sound_Car_Subtitle_Name` varchar(255) NOT NULL,
  `Sound_Car_Subtitle_Type_Id` int(11) NOT NULL,
  `Sound_Car_Subtitle_Language_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Sound_Car_Subtitle_Id`),
  KEY `FK_wipo_sound_carrier_subtitle_recording` (`Sound_Car_Id`),
  KEY `FK_wipo_sound_carrier_subtitle_type` (`Sound_Car_Subtitle_Type_Id`),
  KEY `FK_wipo_sound_carrier_subtitle_language` (`Sound_Car_Subtitle_Language_Id`),
  CONSTRAINT `FK_wipo_sound_carrier_subtitle_language` FOREIGN KEY (`Sound_Car_Subtitle_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_sound_carrier_subtitle_recording` FOREIGN KEY (`Sound_Car_Id`) REFERENCES `wipo_sound_carrier` (`Sound_Car_Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_wipo_sound_carrier_subtitle_type` FOREIGN KEY (`Sound_Car_Subtitle_Type_Id`) REFERENCES `wipo_master_type` (`Master_Type_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_sound_carrier_subtitle` */

/*Table structure for table `wipo_tariff_contracts` */

DROP TABLE IF EXISTS `wipo_tariff_contracts`;

CREATE TABLE `wipo_tariff_contracts` (
  `Tarf_Cont_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Tarf_Cont_GUID` varchar(40) NOT NULL,
  `Tarf_Cont_Internal_Code` varchar(50) NOT NULL,
  `Tarf_Invoice` varchar(50) DEFAULT NULL COMMENT 'Not Used',
  `Tarf_Cont_User_Id` int(11) NOT NULL,
  `Tarf_Cont_City_Id` int(11) DEFAULT NULL,
  `Tarf_Cont_District` varchar(100) DEFAULT NULL,
  `Tarf_Cont_Area` varchar(100) DEFAULT NULL,
  `Tarf_Cont_Tariff_Id` int(11) NOT NULL,
  `Tarf_Cont_Insp_Id` int(11) NOT NULL,
  `Tarf_Cont_Balance` decimal(10,2) DEFAULT NULL,
  `Tarf_Cont_Amt_Pay` decimal(10,2) NOT NULL,
  `Tarf_Cont_From` date NOT NULL,
  `Tarf_Cont_To` date NOT NULL,
  `Tarf_Cont_Sign_Date` date NOT NULL,
  `Tarf_Cont_Pay_Id` int(11) NOT NULL,
  `Tarf_Cont_Portion` decimal(10,2) NOT NULL COMMENT 'Not used',
  `Tarf_Cont_Comment` text,
  `Tarf_Cont_Event_Id` int(11) DEFAULT NULL,
  `Tarf_Cont_Event_Date` date DEFAULT NULL,
  `Tarf_Cont_Event_Comment` text,
  `Tarf_Recurring_Amount` decimal(10,2) NOT NULL,
  `Tarf_Cont_Next_Inv_Date` date NOT NULL,
  `Tarf_Cont_Due_Count` smallint(6) NOT NULL,
  `Tarf_Cont_Renewal` enum('Y','N') DEFAULT 'N',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Tarf_Cont_Id`),
  UNIQUE KEY `NewIndex2` (`Tarf_Cont_Internal_Code`),
  KEY `FK_wipo_tariff_contracts_tariff` (`Tarf_Cont_Tariff_Id`),
  KEY `FK_wipo_tariff_contracts_inspector` (`Tarf_Cont_Insp_Id`),
  KEY `FK_wipo_tariff_contracts_customer_user` (`Tarf_Cont_User_Id`),
  KEY `FK_wipo_tariff_contracts_events` (`Tarf_Cont_Event_Id`),
  CONSTRAINT `FK_wipo_tariff_contracts_customer_user` FOREIGN KEY (`Tarf_Cont_User_Id`) REFERENCES `wipo_customer_user` (`User_Cust_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_tariff_contracts_events` FOREIGN KEY (`Tarf_Cont_Event_Id`) REFERENCES `wipo_master_event_type` (`Master_Evt_Type_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_tariff_contracts_inspector` FOREIGN KEY (`Tarf_Cont_Insp_Id`) REFERENCES `wipo_inspector` (`Insp_Id`) ON UPDATE NO ACTION,
  CONSTRAINT `FK_wipo_tariff_contracts_tariff` FOREIGN KEY (`Tarf_Cont_Tariff_Id`) REFERENCES `wipo_master_tariff` (`Master_Tarif_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_tariff_contracts` */

/*Table structure for table `wipo_tariff_contracts_history` */

DROP TABLE IF EXISTS `wipo_tariff_contracts_history`;

CREATE TABLE `wipo_tariff_contracts_history` (
  `Tarf_Hist_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Tarf_Cont_Id` int(11) NOT NULL,
  `Tarf_Hist_City_Id` int(11) DEFAULT NULL,
  `Tarf_Hist_District` varchar(100) DEFAULT NULL,
  `Tarf_Hist_Area` varchar(100) DEFAULT NULL,
  `Tarf_Hist_Tariff_Id` int(11) NOT NULL,
  `Tarf_Hist_Insp_Id` int(11) NOT NULL,
  `Tarf_Hist_Balance` decimal(10,2) DEFAULT NULL,
  `Tarf_Hist_Amt_Pay` decimal(10,2) NOT NULL,
  `Tarf_Hist_From` date NOT NULL,
  `Tarf_Hist_To` date NOT NULL,
  `Tarf_Hist_Sign_Date` date NOT NULL,
  `Tarf_Hist_Pay_Id` int(11) NOT NULL,
  `Tarf_Hist_Portion` decimal(10,2) NOT NULL COMMENT 'Not used',
  `Tarf_Hist_Comment` text,
  `Tarf_Hist_Event_Id` int(11) DEFAULT NULL,
  `Tarf_Hist_Event_Date` date DEFAULT NULL,
  `Tarf_Hist_Event_Comment` text,
  `Tarf_Recurring_Amount` decimal(10,2) NOT NULL,
  `Tarf_Hist_Next_Inv_Date` date NOT NULL,
  `Tarf_Hist_Due_Count` smallint(6) NOT NULL,
  `Created_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Tarf_Hist_Id`),
  KEY `FK_wipo_tariff_contracts_tariff` (`Tarf_Hist_Tariff_Id`),
  KEY `FK_wipo_tariff_contracts_inspector` (`Tarf_Hist_Insp_Id`),
  KEY `FK_wipo_tariff_contracts_events` (`Tarf_Hist_Event_Id`),
  KEY `FK_wipo_tariff_contracts_history_cont` (`Tarf_Cont_Id`),
  CONSTRAINT `FK_wipo_tariff_contracts_history_cont` FOREIGN KEY (`Tarf_Cont_Id`) REFERENCES `wipo_tariff_contracts` (`Tarf_Cont_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_tariff_contracts_history_events` FOREIGN KEY (`Tarf_Hist_Event_Id`) REFERENCES `wipo_master_event_type` (`Master_Evt_Type_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_tariff_contracts_history_inspector` FOREIGN KEY (`Tarf_Hist_Insp_Id`) REFERENCES `wipo_inspector` (`Insp_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_tariff_contracts_history_tariff` FOREIGN KEY (`Tarf_Hist_Tariff_Id`) REFERENCES `wipo_master_tariff` (`Master_Tarif_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_tariff_contracts_history` */

/*Table structure for table `wipo_user` */

DROP TABLE IF EXISTS `wipo_user`;

CREATE TABLE `wipo_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `role` int(11) NOT NULL,
  `status` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK_wipo_user_role` (`role`),
  CONSTRAINT `FK_wipo_user_role` FOREIGN KEY (`role`) REFERENCES `wipo_master_role` (`Master_Role_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `wipo_user` */

/*Table structure for table `wipo_work` */

DROP TABLE IF EXISTS `wipo_work`;

CREATE TABLE `wipo_work` (
  `Work_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Work_GUID` varchar(50) NOT NULL,
  `Work_Org_Title` varchar(100) NOT NULL,
  `Work_Language_Id` int(11) DEFAULT NULL,
  `Work_Internal_Code` varchar(100) NOT NULL,
  `Work_Iswc` varchar(100) DEFAULT NULL,
  `Work_Wic_Code` varchar(100) DEFAULT NULL,
  `Work_Type_Id` int(11) NOT NULL,
  `Work_Factor_Id` int(11) NOT NULL,
  `Work_Instrumentation` varchar(500) DEFAULT NULL,
  `Work_Duration` time NOT NULL,
  `Work_Creation` year(4) DEFAULT NULL,
  `Work_Opus_Number` smallint(6) DEFAULT NULL,
  `Work_Unknown` enum('Y','N') DEFAULT 'N',
  `Active` enum('0','1') NOT NULL DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Work_Id`),
  KEY `FK_wipo_works_language` (`Work_Language_Id`),
  KEY `FK_wipo_work_type` (`Work_Type_Id`),
  KEY `FK_wipo_work` (`Work_Factor_Id`),
  CONSTRAINT `FK_wipo_work` FOREIGN KEY (`Work_Factor_Id`) REFERENCES `wipo_master_factor` (`Master_Factor_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_works_language` FOREIGN KEY (`Work_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_work_type` FOREIGN KEY (`Work_Type_Id`) REFERENCES `wipo_master_type` (`Master_Type_Id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_work` */

/*Table structure for table `wipo_work_biograph_uploads` */

DROP TABLE IF EXISTS `wipo_work_biograph_uploads`;

CREATE TABLE `wipo_work_biograph_uploads` (
  `Work_Biogrph_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Work_Biogrph_Id` int(11) NOT NULL,
  `Work_Biogrph_Upl_File` varchar(500) NOT NULL,
  `Work_Biogrph_Upl_Description` text,
  `Created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Work_Biogrph_Upl_Id`),
  KEY `FK_wipo_work_biograph_uploads_biography` (`Work_Biogrph_Id`),
  CONSTRAINT `FK_wipo_work_biograph_uploads_biography` FOREIGN KEY (`Work_Biogrph_Id`) REFERENCES `wipo_work_biography` (`Work_Biogrph_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_work_biograph_uploads` */

/*Table structure for table `wipo_work_biography` */

DROP TABLE IF EXISTS `wipo_work_biography`;

CREATE TABLE `wipo_work_biography` (
  `Work_Biogrph_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Work_Id` int(11) NOT NULL,
  `Work_Biogrph_Annotation` text NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Work_Biogrph_Id`),
  KEY `FK_wipo_work_biography_work` (`Work_Id`),
  CONSTRAINT `FK_wipo_work_biography_work` FOREIGN KEY (`Work_Id`) REFERENCES `wipo_work` (`Work_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_work_biography` */

/*Table structure for table `wipo_work_documentation` */

DROP TABLE IF EXISTS `wipo_work_documentation`;

CREATE TABLE `wipo_work_documentation` (
  `Work_Doc_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Work_Id` int(11) NOT NULL,
  `Work_Doc_Status_Id` int(11) NOT NULL,
  `Work_Doc_Inclusion` enum('Y','N') DEFAULT NULL,
  `Work_Doc_Dispute` enum('Y','N') DEFAULT NULL,
  `Work_Doc_Type_Id` int(11) NOT NULL,
  `Work_Doc_Sign_Date` date NOT NULL,
  `Work_Doc_File` varchar(255) DEFAULT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Work_Doc_Id`),
  KEY `FK_wipo_work_documentation_work` (`Work_Id`),
  KEY `FK_wipo_work_documentation_document_status` (`Work_Doc_Status_Id`),
  KEY `FK_wipo_work_documentation_document_type` (`Work_Doc_Type_Id`),
  CONSTRAINT `FK_wipo_work_documentation_document_status` FOREIGN KEY (`Work_Doc_Status_Id`) REFERENCES `wipo_master_document_status` (`Master_Document_Sts_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_work_documentation_document_type` FOREIGN KEY (`Work_Doc_Type_Id`) REFERENCES `wipo_master_document` (`Master_Doc_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_work_documentation_work` FOREIGN KEY (`Work_Id`) REFERENCES `wipo_work` (`Work_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_work_documentation` */

/*Table structure for table `wipo_work_publishing` */

DROP TABLE IF EXISTS `wipo_work_publishing`;

CREATE TABLE `wipo_work_publishing` (
  `Work_Pub_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Work_Id` int(11) NOT NULL,
  `Work_Pub_Contact_Start` date NOT NULL,
  `Work_Pub_Contact_End` date NOT NULL,
  `Work_Pub_Territories` varchar(500) NOT NULL,
  `Work_Pub_Sign_Date` date NOT NULL,
  `Work_Pub_File` varchar(255) DEFAULT NULL,
  `Work_Pub_References` smallint(6) NOT NULL,
  `Work_Pub_Tacit` enum('Y','N') DEFAULT 'N',
  `Work_Pub_Renewal_Period` smallint(6) DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Work_Pub_Id`),
  KEY `FK_wipo_work_publishing_territory` (`Work_Pub_Territories`),
  KEY `FK_wipo_work_publishing_work` (`Work_Id`),
  CONSTRAINT `FK_wipo_work_publishing_work` FOREIGN KEY (`Work_Id`) REFERENCES `wipo_work` (`Work_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_work_publishing` */

/*Table structure for table `wipo_work_publishing_uploads` */

DROP TABLE IF EXISTS `wipo_work_publishing_uploads`;

CREATE TABLE `wipo_work_publishing_uploads` (
  `Work_Pub_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Work_Pub_Id` int(11) NOT NULL,
  `Work_Pub_Upl_Name` varchar(255) DEFAULT NULL,
  `Work_Pub_Upl_File` varchar(500) NOT NULL,
  `Work_Pub_Upl_Description` text,
  `Created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Work_Pub_Upl_Id`),
  KEY `FK_wipo_author_biograph_uploads_author` (`Work_Pub_Id`),
  CONSTRAINT `FK_wipo_work_publishing_uploads_publishing` FOREIGN KEY (`Work_Pub_Id`) REFERENCES `wipo_work_publishing` (`Work_Pub_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_work_publishing_uploads` */

/*Table structure for table `wipo_work_rightholder` */

DROP TABLE IF EXISTS `wipo_work_rightholder`;

CREATE TABLE `wipo_work_rightholder` (
  `Work_Right_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Work_Id` int(11) NOT NULL,
  `Work_Member_GUID` varchar(50) NOT NULL,
  `Work_Right_Role` int(11) NOT NULL,
  `Work_Right_Broad_Share` decimal(10,2) NOT NULL,
  `Work_Right_Broad_Special` enum('DI','IN','OT','PL') DEFAULT NULL,
  `Work_Right_Broad_Org_id` int(11) NOT NULL,
  `Work_Right_Mech_Share` decimal(10,2) NOT NULL,
  `Work_Right_Mech_Special` enum('DI','IN','OT','PL') DEFAULT NULL,
  `Work_Right_Mech_Org_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Work_Right_Id`),
  KEY `FK_wipo_work_rightholder_work` (`Work_Id`),
  KEY `FK_wipo_work_rightholder_organization` (`Work_Right_Broad_Org_id`),
  KEY `FK_wipo_work_rightholder_organization_mechanical` (`Work_Right_Mech_Org_Id`),
  KEY `FK_wipo_work_rightholder_role` (`Work_Right_Role`),
  CONSTRAINT `FK_wipo_work_rightholder_organization` FOREIGN KEY (`Work_Right_Broad_Org_id`) REFERENCES `wipo_organization` (`Org_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_work_rightholder_organization_mechanical` FOREIGN KEY (`Work_Right_Mech_Org_Id`) REFERENCES `wipo_organization` (`Org_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_work_rightholder_role` FOREIGN KEY (`Work_Right_Role`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_work_rightholder_work` FOREIGN KEY (`Work_Id`) REFERENCES `wipo_work` (`Work_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_work_rightholder` */

/*Table structure for table `wipo_work_rightholder_audit` */

DROP TABLE IF EXISTS `wipo_work_rightholder_audit`;

CREATE TABLE `wipo_work_rightholder_audit` (
  `Work_Right_Audit_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Work_Id` int(11) NOT NULL,
  `Work_Member_GUID` varchar(50) NOT NULL,
  `Work_Right_Audit_Role` int(11) NOT NULL,
  `Work_Right_Audit_Broad_Share` decimal(10,2) NOT NULL,
  `Work_Right_Audit_Broad_Special` enum('DI','IN','OT','PL') DEFAULT NULL,
  `Work_Right_Audit_Broad_Org_id` int(11) NOT NULL,
  `Work_Right_Audit_Mech_Share` decimal(10,2) NOT NULL,
  `Work_Right_Audit_Mech_Special` enum('DI','IN','OT','PL') DEFAULT NULL,
  `Work_Right_Audit_Mech_Org_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Work_Right_Audit_Id`),
  KEY `FK_wipo_work_rightholder_audit_work` (`Work_Id`),
  KEY `FK_wipo_work_rightholder_audit_organization` (`Work_Right_Audit_Broad_Org_id`),
  KEY `FK_wipo_work_rightholder_audit_organization_mechanical` (`Work_Right_Audit_Mech_Org_Id`),
  KEY `FK_wipo_work_rightholder_audit_role` (`Work_Right_Audit_Role`),
  CONSTRAINT `FK_wipo_work_rightholder_audit_organization` FOREIGN KEY (`Work_Right_Audit_Broad_Org_id`) REFERENCES `wipo_organization` (`Org_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_work_rightholder_audit_organization_mechanical` FOREIGN KEY (`Work_Right_Audit_Mech_Org_Id`) REFERENCES `wipo_organization` (`Org_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_work_rightholder_audit_role` FOREIGN KEY (`Work_Right_Audit_Role`) REFERENCES `wipo_master_type_rights` (`Master_Type_Rights_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_work_rightholder_audit_work` FOREIGN KEY (`Work_Id`) REFERENCES `wipo_work` (`Work_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_work_rightholder_audit` */

/*Table structure for table `wipo_work_sub_publishing` */

DROP TABLE IF EXISTS `wipo_work_sub_publishing`;

CREATE TABLE `wipo_work_sub_publishing` (
  `Work_Sub_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Work_Id` int(11) NOT NULL,
  `Work_Sub_Contact_Start` date NOT NULL,
  `Work_Sub_Contact_End` date NOT NULL,
  `Work_Sub_Territories` varchar(500) NOT NULL,
  `Work_Sub_Clause` enum('M','S') NOT NULL DEFAULT 'M',
  `Work_Sub_Sign_Date` date NOT NULL,
  `Work_Sub_File` varchar(255) DEFAULT NULL,
  `Work_Sub_References` smallint(6) NOT NULL,
  `Work_Sub_Catelog_Number` varchar(100) NOT NULL,
  `Work_Sub_Tacit` enum('Y','N') DEFAULT 'N',
  `Work_Sub_Renewal_Period` smallint(6) DEFAULT '1',
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Work_Sub_Id`),
  KEY `FK_wipo_work_sub_publishing_territory` (`Work_Sub_Territories`),
  KEY `FK_wipo_work_sub_publishing_work` (`Work_Id`),
  CONSTRAINT `FK_wipo_work_sub_publishing_work` FOREIGN KEY (`Work_Id`) REFERENCES `wipo_work` (`Work_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_work_sub_publishing` */

/*Table structure for table `wipo_work_sub_publishing_uploads` */

DROP TABLE IF EXISTS `wipo_work_sub_publishing_uploads`;

CREATE TABLE `wipo_work_sub_publishing_uploads` (
  `Work_Sub_Upl_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Work_Sub_Id` int(11) NOT NULL,
  `Work_Sub_Upl_Name` varchar(255) DEFAULT NULL,
  `Work_Sub_Upl_File` varchar(500) NOT NULL,
  `Work_Sub_Upl_Description` text,
  `Created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Work_Sub_Upl_Id`),
  KEY `FK_wipo_author_biograph_uploads_author` (`Work_Sub_Id`),
  CONSTRAINT `FK_wipo_work_sub_publishing_uploads_subpublishing` FOREIGN KEY (`Work_Sub_Id`) REFERENCES `wipo_work_sub_publishing` (`Work_Sub_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_work_sub_publishing_uploads` */

/*Table structure for table `wipo_work_subtitle` */

DROP TABLE IF EXISTS `wipo_work_subtitle`;

CREATE TABLE `wipo_work_subtitle` (
  `Work_Subtitle_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Work_Id` int(11) NOT NULL,
  `Work_Subtitle_Name` varchar(255) NOT NULL,
  `Work_Subtitle_Type_Id` int(11) NOT NULL,
  `Work_Subtitle_Language_Id` int(11) NOT NULL,
  `Created_Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Rowversion` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `Created_By` int(11) DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  PRIMARY KEY (`Work_Subtitle_Id`),
  KEY `FK_wipo_work_subtitle_work` (`Work_Id`),
  KEY `FK_wipo_work_subtitle_type` (`Work_Subtitle_Type_Id`),
  KEY `FK_wipo_work_subtitle_language` (`Work_Subtitle_Language_Id`),
  CONSTRAINT `FK_wipo_work_subtitle_language` FOREIGN KEY (`Work_Subtitle_Language_Id`) REFERENCES `wipo_master_language` (`Master_Lang_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_work_subtitle_type` FOREIGN KEY (`Work_Subtitle_Type_Id`) REFERENCES `wipo_master_type` (`Master_Type_Id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_wipo_work_subtitle_work` FOREIGN KEY (`Work_Id`) REFERENCES `wipo_work` (`Work_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `wipo_work_subtitle` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
