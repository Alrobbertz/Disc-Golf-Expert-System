(clear)
(reset)

; Initialize Throw Information
(deftemplate throw
	(slot speed (default fast))
	(slot fade  (default 0))
	(slot angle (default flat)))
	
(deftemplate hole
	(slot distance)
	(slot elevation)
	(slot wind_direct)
	(slot wind_across)
	(slot trajectory))
	
; ==========================================
; Trajectory-Based Rules
(defrule throw-hyzer
	?t <- (throw	(speed ?s)
				(fade  ?f)
				(angle ?a))
	?h <- (hole 	(distance ?d)
			    (elevation ?e)
			    (wind_direct ?wd)
			    (wind_across ?wa)
			    (trajectory ?tr))
	(test (> ?tr 0))
=>
	(modify ?t (angle hyzer)))

(defrule throw-flat
	?t <- (throw	(speed ?s)
				(fade  ?f)
				(angle ?a))
	?h <- (hole 	(distance ?d)
			    (elevation ?e)
			    (wind_direct ?wd)
			    (wind_across ?wa)
			    (trajectory ?tr))
	(test (= ?tr 0))
=>
	(modify ?t (angle flat)))

(defrule throw-anhyzer
	?t <- (throw	(speed ?s)
				(fade  ?f)
				(angle ?a))
	?h <- (hole 	(distance ?d)
			    (elevation ?e)
			    (wind_direct ?wd)
			    (wind_across ?wa)
			    (trajectory ?tr))
	(test (< ?tr 0))
=>
	(modify ?t (angle anhyzer)))
	
; ==========================================
; Distance-Based Rules
(defrule throw-slow
	?t <- (throw	(speed ?s)
				(fade  ?f)
				(angle ?a))
	?h <- (hole 	(distance ?d)
			    (elevation ?e)
			    (wind_direct ?wd)
			    (wind_across ?wa))
	(test (< ?d 200))
=>
	(modify ?t (speed slow)))

(defrule throw-meduim
	?t <- (throw	(speed ?s)
				(fade  ?f)
				(angle ?a))
	?h <- (hole 	(distance ?d)
			    (elevation ?e)
			    (wind_direct ?wd)
			    (wind_across ?wa))
	(test (>= ?d 200))
	(test (< ?d 300))
=>
	(modify ?t (speed medium)))

(defrule throw-fast
	?t <- (throw	(speed ?s)
				(fade  ?f)
				(angle ?a))
	?h <- (hole 	(distance ?d)
			    (elevation ?e)
			    (wind_direct ?wd)
			    (wind_across ?wa))
	(test (>= ?d 300))
=>
	(modify ?t (speed fast)))

; ==========================================
; Elevation-Based Rules
(defrule throw-down
	?t <- (throw	(speed ?s)
				(fade  ?f)
				(angle ?a))
	?h <- (hole 	(distance ?d)
			    (elevation ?e)
			    (wind_direct ?wd)
			    (wind_across ?wa))
	(test (< ?e 0))
=> 
	(modify ?t (fade (+ ?f 1)))
	(modify ?h (elevation 0)))
	
(defrule throw-up
	?t <- (throw	(speed ?s)
				(fade  ?f)
				(angle ?a))
	?h <- (hole 	(distance ?d)
			    (elevation ?e)
			    (wind_direct ?wd)
			    (wind_across ?wa))
	(test (> ?e 0))
=> 
	(modify ?t (fade (- ?f 1)))
	(modify ?h (elevation 0)))

; ==========================================
; Direct Wind Rules
(defrule headwind
	?t <- (throw	(speed ?s)
				(fade  ?f)
				(angle ?a))
	?h <- (hole 	(distance ?d)
			    (elevation ?e)
			    (wind_direct ?wd)
			    (wind_across ?wa))
	(test (> ?wd 0))
=> 
	(modify ?t (fade (+ ?f 1)))
	(modify ?h (wind_direct 0)))
	
(defrule tailwind
	?t <- (throw	(speed ?s)
				(fade  ?f)
				(angle ?a))
	?h <- (hole 	(distance ?d)
			    (elevation ?e)
			    (wind_direct ?wd)
			    (wind_across ?wa))
	(test (< ?wd 0))
=> 
	(modify ?t (fade (- ?f 1)))
	(modify ?h (wind_direct 0)))

; ==========================================
; Crosswind Rules
(defrule lr-crosswind
	?t <- (throw	(speed ?s)
				(fade  ?f)
				(angle ?a))
	?h <- (hole 	(distance ?d)
			    (elevation ?e)
			    (wind_direct ?wd)
			    (wind_across ?wa))
	(test (> ?wa 0))
=> 
	(modify ?t (fade (+ ?f 1)))
	(modify ?h (wind_across 0)))
	
(defrule rl-crosswind
	?t <- (throw	(speed ?s)
				(fade  ?f)
				(angle ?a))
	?h <- (hole 	(distance ?d)
			    (elevation ?e)
			    (wind_direct ?wd)
			    (wind_across ?wa))
	(test (< ?wa 0))
=> 
	(modify ?t (fade (- ?f 1)))
	(modify ?h (wind_across 0)))




; ==================================
; ==================================
(assert (throw 
	(speed slow) 
	(fade 0) 
	(angle hyzer)))


; Initialize Environment Information
(assert (hole 
	(distance 900)
	(elevation 0)
	(wind_direct 1)
	(wind_across 1)
	(trajectory -3)))

(watch facts)




