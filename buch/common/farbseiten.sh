#! /bin/bsh
#
# farbseiten.sh -- Formattierung der Farbseiteninfo für die Druckerei
#
# (c) 2020 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
awk 'BEGIN {
	result = ""
	counter = 0
} 
/^#/ {
	next
}
{
	if (length(result) == 0) {
		result = $1
	} else {
		result = sprintf("%s,%d", result, $1)
	}
	counter++
}
END {
	printf("%s\n", result)
	printf("Anzahl Farbseiten: %d\n", counter)
}' <<EOF
# Kapitel  0
# Kapitel  1
17
20
# Kapitel  2
35
36
37
38
39
41
# Kapitel  3
48
49
51
62
63
66
68
69
71
75
76
# Kapitel  4
88
91
92
99
101
107
117
119
# Kapitel  5
139
140
161
# Kapitel  6
165
186
# Kapitel  7
198
200
201
204
205
215
236
# Kapitel  8
243
246
249
250
256
258
260
261
264
# Kapitel  9
282
# Kapitel 10
# Kapitel 11
301
306
309
312
314
317
319
326
327
328
331
333
335
336
339
342
343
247
# Kapitel 12: Verfolgungskurven
358
363
370
# Kapitel 13: FM
374
375
376
377
383
384
385
386
# Kapitel 14 parzyl
388
392
394
# Kapitel 15 fresnel
398
399
400
401
403
# Kapitel 16 kreismembran
412
419
420
421
# Kapitel 17 sturmliouville
# Kapitel 18 laguerre
439
445
446
447
448
449
450
451
# Kapitel 19 zeta
454
456
457
462
# Kapitel 20 0f1
465
467
469
470
471
472
# Kapitel 21 nav
476
477
478
482
484
485
487
488
489
490
# Kapitel 22 transfer
494
495
496
497
498
500
# Kapitel 23 kra
507
509
# Kapitel 24 kugel
517
519
521
524
534
535
537
545
# Kapitel 25 elliptisch
552
554
555
556
558
559
560
561
562
# Kapitel 26
EOF
