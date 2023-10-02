#lang play
(let ([one (mcons 1 'dummy)]
      [periodic (mcons 4 (mcons 5 'dummy))])
  (begin (set-mcdr! (mcdr periodic) periodic)
         (set-mcdr! one periodic)
         one))