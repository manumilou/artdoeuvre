<div class="node <?php print $classes; ?>" id="node-<?php print $node->nid; ?>">
  <div class="node-inner">

    <?php if (!$page): ?>
      <h2 class="title"><a href="<?php print $node_url; ?>"><?php print $title; ?></a></h2>
    <?php endif; ?>

    <?php print $picture; ?>

    <?php if ($terms): ?>
      <div class="taxonomy"><?php print $terms; ?></div>
    <?php endif;?>

    <div class="content">
      <?php print $content; ?>
    </div>

    <div class="embed-video">
        <?php if ($node->type == 'story') { ?>
                <video controls="controls" \
                        src="http://artdoeuvre.org/<? print $node->field_video[0]['filepath']; ?>" \
                        type=<?php print $node->field_video[0]['filemime']; ?> \
                        width="400" height="300"\
                        > 
                Upgrade your web browser to play the videos.
                 </video>
           <? }
        ?>
    </div>

    <?php if ($submitted): ?>
      <span class="submitted"><?php print $submitted; ?></span>
    <?php endif; ?>

    <?php if ($links): ?> 
      <div class="links"> <?php print $links; ?></div>
    <?php endif; ?>

  </div> <!-- /node-inner -->
</div> <!-- /node-->
