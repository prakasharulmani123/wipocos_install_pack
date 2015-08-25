<?php include_once 'bar.php'; ?>
<table border="0" width="100%" cellpadding="0" cellspacing="0" id="product-table">
<tr>
					<th class="table-header-repeat line-left minwidth-1"><a href="#">Informations</a></th>
					<th class="table-header-repeat line-left"><a href="#">Recommended</a></th>
					<th class="table-header-repeat line-left minwidth-1"><a href="#">Current Host (<?php echo $_SERVER['HTTP_HOST']?>)</a></th>
					<th class="table-header-repeat line-left"><a href="#">Status</a></th>
    </tr>
    <tr>
        <td>PHP Version:</td>
        <td>5.4+</td>
        <td><?php echo phpversion(); ?></td>
        <td><?php echo (phpversion() >= '5.4') ? 'Ok' : 'Not Ok'; ?></td>
    </tr>
    <tr>
        <td>Session Auto Start:</td>
        <td>Off</td>
        <td><?php echo (ini_get('session_auto_start')) ? 'On' : 'Off'; ?></td>
        <td><?php echo (!ini_get('session_auto_start')) ? 'Ok' : 'Not Ok'; ?></td>
    </tr>
    <tr>
        <td>MySQL:</td>
        <td>On</td>
        <td><?php echo extension_loaded('mysql') ? 'On' : 'Off'; ?></td>
        <td><?php echo extension_loaded('mysql') ? 'Ok' : 'Not Ok'; ?></td>
    </tr>
    <tr>
        <td>GD:</td>
        <td>On</td>
        <td><?php echo extension_loaded('gd') ? 'On' : 'Off'; ?></td>
        <td><?php echo extension_loaded('gd') ? 'Ok' : 'Not Ok'; ?></td>
    </tr>
    <tr>
        <td>database.php</td>
        <td>Writable</td>
        <td><?php echo is_writable('database.php') ? 'Writable' : 'Unwritable'; ?></td>
        <td><?php echo is_writable('database.php') ? 'Ok' : 'Not Ok'; ?></td>
    </tr>
</table>

<form action="index.php?step=2" method="post">
    <input type="hidden" name="pre_error" id="pre_error" value="<?php echo $pre_error; ?>" />
    <input type="submit" name="continue" value="Continue" class="form-submit" />
</form>
