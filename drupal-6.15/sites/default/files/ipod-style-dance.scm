(define (ipod-style-dance pattern
		 radius
		 amount
		 threshold)
	(let* ((filelist (cadr (file-glob pattern 1))))
    (while (not (null? filelist))
           (let* ((filename (car filelist))
                  (image (car (gimp-file-load RUN-NONINTERACTIVE
                                              filename filename)))
                  (drawable (car (gimp-image-get-active-layer image))))
	(plug-in-gauss RUN-NONINTERACTIVE image drawable 10.0 10.0 0)
  	(gimp-levels drawable  0 36 120 0.70 0 255)
	(gimp-threshold drawable 25 255)
	(gimp-image-convert-indexed image 0 3 0 0 0 "")
	(gimp-image-convert-rgb image)
	(gimp-context-set-foreground '(18 64 88))
	(gimp-context-set-background '(231 109 12))
	(gimp-edit-bucket-fill drawable BG-BUCKET-FILL 0 100 15 1 0 0)
	;(gimp-edit-bucket-fill drawable BG-BUCKET-FILL 0 100 15 1 204 510)
	(plug-in-lens-distortion RUN-NONINTERACTIVE image drawable 0 0 0 40 20 -40)
  	
	(gimp-file-save RUN-NONINTERACTIVE image drawable filename filename)
  	(gimp-image-delete image))
	(set! filelist (cdr filelist)))))

