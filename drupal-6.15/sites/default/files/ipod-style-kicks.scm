(define (ipod-style-kicks pattern
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
	(gimp-invert drawable)
	;(gimp-levels drawable 0 10 255 2.93 0 255)
	;(gimp-brightness-contrast drawable 16 16)
	(gimp-threshold drawable 210 255)
	(gimp-image-convert-indexed image 0 3 0 0 0 "")
	(gimp-image-convert-rgb image)
	(gimp-invert drawable)
	(gimp-context-set-background '(23 141 48))
	(gimp-edit-bucket-fill drawable BG-BUCKET-FILL 0 100 15 1 438 200)
	(plug-in-lens-distortion RUN-NONINTERACTIVE image drawable 50 0 0 0 40 0)
	
	(gimp-file-save RUN-NONINTERACTIVE image drawable filename filename)
  	(gimp-image-delete image))
	(set! filelist (cdr filelist)))))

