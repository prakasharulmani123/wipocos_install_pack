<?php 
$step1 = $step2 = $step3 = $step4 = 'light';
if(isset($_REQUEST['step']) && $step = $_REQUEST['step']){
    switch ($step) {
        case 1:
            $step1 = 'dark';
            break;
        case 2:
            $step2 = 'dark';
            break;
        case 3:
            $step3 = 'dark';
            break;
        case 4:
            $step4 = 'dark';
            break;
    }
}else{
    $step1 = 'dark';
}
?>
<div id="step-holder">
    <div class="step-no">1</div>
    <div class="step-<?php echo $step1?>-left">License Information</div>
    <div class="step-<?php echo $step1?>-right">&nbsp;</div>
    <div class="step-no-off">2</div>
    <div class="step-<?php echo $step2?>-left">PHP Information</div>
    <div class="step-<?php echo $step2?>-right">&nbsp;</div>
    <div class="step-no-off">3</div>
    <div class="step-<?php echo $step3?>-left">Database information</div>
    <div class="step-<?php echo $step3?>-right">&nbsp;</div>
    <div class="step-no-off">4</div>
    <div class="step-<?php echo $step4?>-left">Success</div>
    <div class="clear"></div>
</div>
