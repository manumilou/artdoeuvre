<?php

if ($node->type == 'story' && isNotEmpty ($node->field_video)) {

    $html5 .= "<div id='html5-embed-video'>";
    $youtube = $node->field_video_youtube[0]['value'];

    foreach ($node->field_video AS $value=>$key) {

        if (html5Compatible ($node->field_video[$value]['filemime'])) {

            $filepath = "/".$key['filepath'];
            $html5 .= "<video controls width='400' height='300' src='".$filepath."' type=";
            $html5 .= $node->field_video[$value]['filemime'].">";
            $html5 .= flashFallback ($youtube);
            $html5 .= "</video>";
        }
    }
    $html5 .= "</div>";

    print $html5;
}


function isNotEmpty ($videos) {

    // Check the first item of the array
    empty($videos[0]['filename']) ? $res=FALSE : $res=TRUE;
    return $res;
}

function html5Compatible ($mimetype) {

    $validExtensions = array ('video/ogv', 'video/ogg', 'application/ogg');

    in_array ($mimetype, $validExtensions) ? $res = TRUE : $res = FALSE;
    return $res;
}

function flashFallback ($src) {

    $error = t("Aie, votre naviguateur ne supporte pas HTML5. Vous pouvez soit upgrader, soit changer de naviguateur (Firefox ?) ou voir nos vidéos sur ");

    if (empty ($src))
        $flash = "<div class='messages warning'>".$error."<a target='_blank' href='http://www.youtube.com/artdoeuvre'>Youtube</a></span></p>";

    else {

        $flash = "";
        $flash .= "<object width='400' height='300'>";
        $flash .= "<param name='movie' value='".$src."'>";
        $flash .= "</param>";
        $flash .= "<embed src='".$src."' type='application/x-shockwave-flash' allowscriptaccess='always' allowfullscreen='true' width='400' height='300'>";
        $flash .= "</embed>";
        $flash .= "</object>";
    }
    return $flash;
}
?>

