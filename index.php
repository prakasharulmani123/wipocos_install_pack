<?php

ob_start();
error_reporting(E_ALL & ~E_WARNING);
include 'header.php';

function step_1() {
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['agree'])) {
        header('Location: index.php?step=2');
        exit;
    }
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && !isset($_POST['agree'])) {
        echo '<div id="message-red">
				<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="red-left">You must agree to the license.</td>
					<td class="red-right"><a class="close-red"><img src="images/table/icon_close_red.gif"   alt="" /></a></td>
				</tr>
				</table>
				</div>';
    }
    include 'step1.php';
}

function step_2() {
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && $_POST['pre_error'] == '') {
        header('Location: index.php?step=3');
        exit;
    }
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && $_POST['pre_error'] != '')
        echo '<div id="message-red">
				<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="red-left">' . $_POST['pre_error'] . '</td>
					<td class="red-right"><a class="close-red"><img src="images/table/icon_close_red.gif"   alt="" /></a></td>
				</tr>
				</table>
				</div>';

    $pre_error = '';
    if (phpversion() < '5.4') {
        $pre_error = 'You need to use PHP 5.4 or above for our site!<br />';
    }
    if (ini_get('session.auto_start')) {
        $pre_error .= 'Our site will not work with session.auto_start enabled!<br />';
    }
    if (!extension_loaded('mysql')) {
        $pre_error .= 'MySQL extension needs to be loaded for our site to work!<br />';
    }
    if (!extension_loaded('gd')) {
        $pre_error .= 'GD extension needs to be loaded for our site to work!<br />';
    }
    if (!is_writable('database.php')) {
        $pre_error .= 'database.php needs to be writable for our site to be installed!';
    }
    include 'step2.php';
}

function step_3() {
    $database_host = $database_name = $database_username = $database_password = $admin_name = $admin_password = $admin_email = '';
    $new_db = false;
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $database_host = isset($_POST['database_host']) ? $_POST['database_host'] : "";
        $database_name = isset($_POST['database_name']) ? $_POST['database_name'] : "";
        $database_username = isset($_POST['database_username']) ? $_POST['database_username'] : "";
        $database_password = isset($_POST['database_password']) ? $_POST['database_password'] : "";
        $admin_name = isset($_POST['admin_name']) ? $_POST['admin_name'] : "";
        $admin_password = isset($_POST['admin_password']) ? $_POST['admin_password'] : "";
        $admin_email = isset($_POST['admin_email']) ? $_POST['admin_email'] : "";
        $new_db = isset($_POST['new_database']);
        
        $pass_len = strlen($admin_password);

        if (empty($admin_name) || empty($admin_password) || empty($admin_email) || !filter_var($admin_email, FILTER_VALIDATE_EMAIL) || empty($database_host) || empty($database_username) || empty($database_name) || $pass_len < 6) {
            $err_msg = 'Please fill mandatory fields.';
            if (!filter_var($admin_email, FILTER_VALIDATE_EMAIL) && $admin_email != '')
                $err_msg = " '$admin_email' is not a valid email address.";
            if ($pass_len < 6 && $pass_len != '')
                $err_msg = " Password must be more than 6 letters.";
            echo '<div id="message-red">
				<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="red-left">' . $err_msg . '</td>
					<td class="red-right"><a class="close-red"><img src="images/table/icon_close_red.gif"   alt="" /></a></td>
				</tr>
				</table>
				</div>';
        } else {
            $connection = mysqli_connect($database_host, $database_username, $database_password);
            if ($connection) {
                // Create database
                $sql = "CREATE DATABASE $database_name";
                if ($new_db) {
                    $db_check = mysqli_query($connection, $sql);
                } else {
                    $db_check = true;
                }

                if ($db_check) {
                    $select_db = mysqli_select_db($connection, $database_name);
                    if ($select_db) {
                        $file = 'core/wipocos_install.sql';
                        if ($sql = file($file)) {
                            # MySQL with PDO_MYSQL  
                            $db = new PDO("mysql:host=$database_host;dbname=$database_name", $database_username, $database_password);
                            $query = file_get_contents("core/wipocos_install.sql");
                            $stmt = $db->prepare($query);
                            if ($stmt->execute()) {
                                $zip = new ZipArchive;
                                if ($zip->open('core/wipo_install.zip') === TRUE) {
                                    $zip->extractTo('../');
                                    $zip->close();

                                    $password_hash = hash("sha512", $admin_password);
                                    $insert = "INSERT INTO $database_name.`wipo_user` (`username`, `name`, `password_hash`, `email`, `role`) values('$admin_name','$admin_name','$password_hash','$admin_email', 1);";
                                    $stmt = $db->prepare($insert);
                                    $stmt->execute();

                                    $f = fopen("database.php", "w");
                                    $database_inf = "<?php
                                return array(
                                    'connectionString' => 'mysql:host=$database_host;dbname=$database_name',
                                    'emulatePrepare' => true,
                                    'username' => '$database_username',
                                    'password' => '$database_password',
                                    'charset' => 'utf8',
                                    'tablePrefix' => 'wipo_',
                                );";
                                    if (fwrite($f, $database_inf) > 0) {
                                        fclose($f);
                                        if (copy('database.php', '../protected/config/database.php')) {
                                            header("Location: index.php?step=4");
                                        } else {
                                            //Failed to copy
                                        echo '<div id="message-red">
                                                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                        <td class="red-left">Failed to copy database.php</td>
                                                        <td class="red-right"><a class="close-red"><img src="images/table/icon_close_red.gif"   alt="" /></a></td>
                                                </tr>
                                                </table>
                                                </div>';
                                        }
                                    } else {
                                        //Failed to write
                                        echo '<div id="message-red">
                                                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                        <td class="red-left">Failed to write database.php</td>
                                                        <td class="red-right"><a class="close-red"><img src="images/table/icon_close_red.gif"   alt="" /></a></td>
                                                </tr>
                                                </table>
                                                </div>';
                                    }
                                } else {
                                    //Failed to archieve
                                    echo '<div id="message-red">
                                                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                        <td class="red-left">Failed to open the archive!</td>
                                                        <td class="red-right"><a class="close-red"><img src="images/table/icon_close_red.gif"   alt="" /></a></td>
                                                </tr>
                                                </table>
                                                </div>';
                                }
                            } else {
                                //Failed to execute sql
                                echo '<div id="message-red">
                                                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                        <td class="red-left">Error: Failed to execute sql. Please try again. </td>
                                                        <td class="red-right"><a class="close-red"><img src="images/table/icon_close_red.gif"   alt="" /></a></td>
                                                </tr>
                                                </table>
                                                </div>';
                            }
                        } else {
                            //Failed to load sql
                            echo '<div id="message-red">
				<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="red-left">Error: Failed to load sql. Please try again. </td>
					<td class="red-right"><a class="close-red"><img src="images/table/icon_close_red.gif"   alt="" /></a></td>
				</tr>
				</table>
				</div>';
                        }
                    } else {
                        //Failed to connect db
                        echo '<div id="message-red">
				<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="red-left">Error : Failed to load sql</td>
					<td class="red-right"><a class="close-red"><img src="images/table/icon_close_red.gif"   alt="" /></a></td>
				</tr>
				</table>
				</div>';
                    }
                } else {
                    //Failed to create DB
                    echo '<div id="message-red">
                                                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                        <td class="red-left">Error ' . mysqli_errno($connection) . ": " . mysqli_error($connection) . '</td>
                                                        <td class="red-right"><a class="close-red"><img src="images/table/icon_close_red.gif"   alt="" /></a></td>
                                                </tr>
                                                </table>
                                                </div>';
                }
            } else {
                //Unable to connect host
                echo '<div id="message-red">
				<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="red-left">Unable to connect to MySQL. Check you host details.</td>
					<td class="red-right"><a class="close-red"><img src="images/table/icon_close_red.gif"   alt="" /></a></td>
				</tr>
				</table>
				</div>';
            }
        }
    }
    include 'step3.php';
}

function step_4() {
    include 'step4.php';
}

include 'footer.php';
?>