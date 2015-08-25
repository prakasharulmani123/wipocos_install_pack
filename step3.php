<?php include_once 'bar.php'; ?>
<form action="index.php?step=3" method="post">
<table border="0" cellpadding="0" cellspacing="0"  id="id-form">
    <tr>
        <td colspan="3"><h2>Host Details</h2></td>
    </tr>
    <tr>
        <th valign="top"><label for="database_host">Host*</label></th>
        <td><input class="inp-form" type="text" name="database_host" value='<?php echo $database_host; ?>' size="30"></td>
        <td></td>
    </tr>
    <tr>
        <th valign="top"><label for="database_username">Username*</label></th>
        <td><input class="inp-form" type="text" name="database_username" size="30" value="<?php echo $database_username; ?>"></td>
        <td></td>
    </tr>
    <tr>
        <th valign="top"><label for="database_password">Password</label></th>
        <td><input class="inp-form" type="password" name="database_password" size="30" value="<?php echo $database_password; ?>"></td>
        <td></td>
    </tr>
    <tr>
        <th valign="top"><label for="database_name">Database Name*</label></th>
        <td><input class="inp-form" type="text" name="database_name" size="30" value="<?php echo $database_name; ?>"></td>
        <td></td>
    </tr>
    <tr>
        <th valign="top"><label for="database_name">Create New Database</label></th>
        <td><input class="inp-form" type="checkbox" name="new_database" size="30" <?php echo $new_db ? 'checked' : ''?>></td>
        <td></td>
    </tr>
    <tr>
        <td colspan="3">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="3"><h2>Admin Details</h2></td>
    </tr>
<!--    <tr>
        <td colspan="3">&nbsp;</td>
    </tr>-->
    <tr>
        <th valign="top"><label for="username">Username*</label></th>
        <td><input class="inp-form" type="text" name="admin_name" size="30" value="<?php echo $admin_name; ?>"></td>
        <td></td>
    </tr>
    <tr>
        <th valign="top"><label for="useremail">Email*</label></th>
        <td><input class="inp-form" type="text" name="admin_email" size="30" value="<?php echo $admin_email; ?>"></td>
        <td></td>
    </tr>
    <tr>
        <th valign="top"><label for="password">Password*</label></th>
        <td><input class="inp-form" name="admin_password" type="password" size="30" maxlength="15" value="<?php echo $admin_password; ?>"></td>
        <td></td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td valign="top">
            <input type="submit" value="" class="form-submit" />
        </td>
        <td></td>
    </tr>
<tr>
        <th valign="top">&nbsp;</th>
        <td><b>Note: Don't refresh or click back button after submit the form</b></td>
        <td></td>
    </tr>
</table>
</form>